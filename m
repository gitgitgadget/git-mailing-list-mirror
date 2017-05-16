Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B9E201A7
	for <e@80x24.org>; Tue, 16 May 2017 05:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbdEPFBd (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 01:01:33 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36700 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbdEPFBc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 01:01:32 -0400
Received: by mail-pg0-f65.google.com with SMTP id h64so15153358pge.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 22:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V+j9593CXhJiIePqDw8x/E8r4GL+b7b2IE5Spu97UAI=;
        b=twfkOA9yVItTZ4yPht4E95rsRCcYQsOfF9zlTlTrTENh11X1ji5KrX9gdE9xG32p9B
         hryXdCrExZJa+RLNrzOQ55e0rI5X/HgGTV4owKIEUUo/uBZpVLGXvy1/Tl94mjFXYwj+
         x1wRBlnH5V4PQnLVn/dw5iCF95e1y3LnI+3RFzL1l68D9BolHvz9t3HAuF59SVnjLE7C
         j+w56umbA4boHyQ4kKp8UNv+jAGOfg3Yu/DKWYVQfv3Rk3XbIIMiyYqKDIb4bSTE7fej
         fzpgW0qjxZkS9JtRDS4x3MaOIrM1ZtWtrVYQE6UUeqWGiJKp+nD4vylf0wdUqWKnMGoj
         u8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V+j9593CXhJiIePqDw8x/E8r4GL+b7b2IE5Spu97UAI=;
        b=LMVDlud8e6OzcZm8FsFNvF232d4VMyOGItozsgRCV1XJUw9/Okf6DRng+FUq1rnz53
         wp/4H9nQ73L0ghuy2AdpudnYjt929vdY8CMd9a33BtnZAwryWcW/ID4m1ZaAiI0/pQC2
         IhanHUmmqv/kVfFZHXjaOaBhjlhPRfoXFjWre8h+8BT5/9a9wF7xM1STC66DkXGTr8Zm
         y4sRhHc2mJSWmBu9nhzs+uircHK+4YxKHv9NdayGVR/qQyplvbfzshYKrnKCYmWeXFza
         8/yCJcivK2eyazj76msqLHjoOJ2YtKTnpFKRCp7GwEs424gZ4pqCN5GH+vRFCHO0cFjg
         Wxxg==
X-Gm-Message-State: AODbwcDp/yO4FvgNueb9iAwuUSh7d5tLkA9lUQU4rF4H1+bhKttf/xQe
        J95rimdMdBYfkg==
X-Received: by 10.99.39.194 with SMTP id n185mr10035839pgn.15.1494910891602;
        Mon, 15 May 2017 22:01:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id m25sm10260659pfk.15.2017.05.15.22.01.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 22:01:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: Re: [PATCH v1 1/5] dir: make lookup_untracked() available outside of dir.c
References: <20170515191347.1892-1-benpeart@microsoft.com>
        <20170515191347.1892-2-benpeart@microsoft.com>
Date:   Tue, 16 May 2017 14:01:30 +0900
In-Reply-To: <20170515191347.1892-2-benpeart@microsoft.com> (Ben Peart's
        message of "Mon, 15 May 2017 15:13:43 -0400")
Message-ID: <xmqqwp9h1jkl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Remove the static qualifier from lookup_untracked() and make it
> available to other modules by exporting it from dir.h.

Surely that is what you did in this patch, but leaves readers in
suspense wondering why this helper needs to be available to others
in the first place ;-)  Let's read on.

>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  dir.c | 2 +-
>  dir.h | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index f451bfa48c..1b5558fdf9 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -660,7 +660,7 @@ static void trim_trailing_spaces(char *buf)
>   *
>   * If "name" has the trailing slash, it'll be excluded in the search.
>   */
> -static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
> +struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
>  						    struct untracked_cache_dir *dir,
>  						    const char *name, int len)
>  {
> diff --git a/dir.h b/dir.h
> index bf23a470af..9e387551bd 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -339,4 +339,7 @@ extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git
>  extern void relocate_gitdir(const char *path,
>  			    const char *old_git_dir,
>  			    const char *new_git_dir);
> +struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
> +					     struct untracked_cache_dir *dir,
> +					     const char *name, int len);
>  #endif
