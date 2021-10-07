Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C26AC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D6F761039
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbhJGSgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 14:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhJGSgN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 14:36:13 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2527C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 11:34:19 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q19so5578376pfl.4
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 11:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=rJWp/JDJpE1Z5Ww82c2tjYswW8qMv5gOOy6jVphlJoA=;
        b=QnfaEC9CcEKmfjUcjeF4p/Nsp8VqQM3UrKy3EJ/HQitdwDY3QFEaOhIAhqLTCga15t
         kDIgoJF+aiYq/rnXsF630gJEyqeb79rZit1x80O4pFq8dN5bYXSfJ7ne2YhjrTShXLf6
         KYoKoKTUMFzIR5OKGVrrEtmcnNk+D+qIedt19ju4lEZdwtBZ58zpoWw25FIier4qPn0L
         9fBqalTh/gxGMX6rRuF6c9kp/JJdf/Su519abQblqkLUj9UIVU/CJMibkYvMnF0PX+mB
         zLdiQM87En0eQ2rKIlEXtJkaHhhVLxCDN0hP1+6OisR9M55cqjPuJUabb3hoAXjSRZmJ
         L5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=rJWp/JDJpE1Z5Ww82c2tjYswW8qMv5gOOy6jVphlJoA=;
        b=HMLSp46rw/a/QbRHlnRm9uv6ofSjEw0EuD+2P5CgtwXKWk68f4bK1q+xeMpRhILpbx
         I4iIELPH5QHLgPxk+GME3Y06OkDpg3ALCt7gMG+fqsJxHnv8cPxkE6Y3mS3tdPd+Mky/
         uI6bLM8dhtCJa6LvkudUp5g+RvzduvSc0mFMrDGDBNh8VqONhE+JV0faZj8MKualdwTK
         84pkkU0YFLUvFK7eNu/JO9jFuAv1jVge023PVlKdw15TxZRttqL7D+Tb5JoL5+hFqXAY
         bwaGkdttPyw5JY5qZGQtftvmNENdm412GMAgu4+sEeJdSAbPqBNNjQ1sh8DvufIXjIGv
         TZpw==
X-Gm-Message-State: AOAM532kINLuOzTJPyLK65lo60orb9NL9ekSe4CjO4qybanIZlzvBP2n
        PPcU38aGnoNs+462SZPLdcp8pR+xCDv+zA==
X-Google-Smtp-Source: ABdhPJx4ZPfWvYGRLMupEk4A0Ok05npl/y5fl+du8SSetuv3togUv+wyp4G488I0qc9ps+YxgiKFQA==
X-Received: by 2002:a63:4e65:: with SMTP id o37mr977714pgl.202.1633631659314;
        Thu, 07 Oct 2021 11:34:19 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf7:7c1c:a2ca:e52a])
        by smtp.gmail.com with ESMTPSA id b13sm9729553pjl.15.2021.10.07.11.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:34:18 -0700 (PDT)
Date:   Thu, 7 Oct 2021 11:34:12 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/7] merge-{ort,recursive}: remove add_submodule_odb()
Message-ID: <YV89pOZh+qj/oplL@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1632242495.git.jonathantanmy@google.com>
 <cover.1632956589.git.jonathantanmy@google.com>
 <e4a1be22c8759d495cf00d71a06227b87d433ecf.1632956589.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4a1be22c8759d495cf00d71a06227b87d433ecf.1632956589.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.09.29 16:06, Jonathan Tan wrote:
> After the parent commit and some of its ancestors, the only place
> commits are being accessed through alternates is in the user-facing
> message formatting code. Fix those, and remove the add_submodule_odb()
> calls.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  merge-ort.c                | 18 ++++-------------
>  merge-recursive.c          | 41 +++++++++++++++++++-------------------
>  strbuf.c                   | 12 ++++++++---
>  strbuf.h                   |  6 ++++--
>  t/t6437-submodule-merge.sh |  3 +++
>  5 files changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/strbuf.c b/strbuf.c
> index c8a5789694..b22e981655 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -1059,15 +1059,21 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
>  	strbuf_setlen(sb, sb->len + len);
>  }
>  
> -void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
> -			      int abbrev_len)
> +void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
> +				   const struct object_id *oid, int abbrev_len)
>  {
>  	int r;
>  	strbuf_grow(sb, GIT_MAX_HEXSZ + 1);
> -	r = find_unique_abbrev_r(sb->buf + sb->len, oid, abbrev_len);
> +	r = repo_find_unique_abbrev_r(repo, sb->buf + sb->len, oid, abbrev_len);
>  	strbuf_setlen(sb, sb->len + r);
>  }
>  
> +void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
> +			      int abbrev_len)
> +{
> +	strbuf_repo_add_unique_abbrev(sb, the_repository, oid, abbrev_len);
> +}
> +

Should strbuf_add_unique_abbrev() be inlined and moved to the header?
