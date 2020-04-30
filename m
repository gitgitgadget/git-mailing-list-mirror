Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8487AC83003
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 03:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CED72082E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 03:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dllN4Cm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgD3D0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbgD3D0O (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 23:26:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3359C035494
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 20:26:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f7so2204593pfa.9
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 20:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rt2ZY+6iYYv8vzcXpCNvmwsIzwtFBU0SFKLTH3Pv4hE=;
        b=dllN4Cm4jVMcsxlzodbAADg+Xn/qPo10DC9iZ9710MFEoAdsQLcPIAhPwBvUo/yqG2
         uNC7rbCcSCxbEdOtg/May5ivwwtDpHqm74K51UlOhUkSABN7Zd2FCMqehkWSKoy/s+B7
         qrLt3AOr2w+e/2OgIE4j/wvov13R5Bc2HclRfrnBiGMFTZ+yecPY/rVJt5fwmqEvpqxu
         pt2RJe8JOGuhHGZv2NbJgM803aFR7CtofzNUZUC475VbRCMffkn+p1lJAtxmDzfts6q7
         Q13mEA/E/e0k7Qo9kBAk3P0nxmL6zfNFSG29FeNMRABXA7MtCIkG6hzJR8wbi49ZyQkB
         O5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rt2ZY+6iYYv8vzcXpCNvmwsIzwtFBU0SFKLTH3Pv4hE=;
        b=T/4/4FA5TPxLitAp6SdXOnhti3rv+vLrG5i23EBKi4tY+73nPlsqyKYm8s8B0zUVlk
         JT+C83ppzUCqckD4vHAZeFgJfOHNDTOvObTQGvSag03QYR+4iiLKjhlt8gTGVa2Pf7DW
         H1+kY5TFHbH9a5P1jJrxx4rISUw+85CkFFJETlUiLxr40oWVU+isUkyAT3bbQ0/EYShP
         IOze+ZCsGiAnNiv7YLpcU1xHljAE4lhY6FwbjSivtlyP4o1ve5DBXhYDziWzuSEeDegj
         xH7OKngO91wSmJvarMnsMQ+NX0HjWW7KtBpElK+a1iuXYqDnA1r5PvAbDNkAasrsH5tr
         6R+Q==
X-Gm-Message-State: AGi0PuZ6HMVbsYMWb3UdpT+lgTuURs+PSnQgBuYfpzDyWZqXRdVZJ48S
        KxcttZgd4fiMajZdk6dPXIQ=
X-Google-Smtp-Source: APiQypLaJ4V43rAW0adwigHFIqCpT3f9y/eh8eIq1Hvb8SCeqwYmuLuZjP1siMy+wF8Gfpw0pYGlig==
X-Received: by 2002:aa7:990f:: with SMTP id z15mr1535474pff.132.1588217174250;
        Wed, 29 Apr 2020 20:26:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id a138sm2202006pfd.32.2020.04.29.20.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 20:26:13 -0700 (PDT)
Date:   Wed, 29 Apr 2020 20:26:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH 1/5] commit: make 'commit_graft_pos' non-static
Message-ID: <20200430032611.GF115238@google.com>
References: <cover.1588199705.git.me@ttaylorr.com>
 <8ac4c63735f2e48dc83e9f31c9fbbbfb47d7e79d.1588199705.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ac4c63735f2e48dc83e9f31c9fbbbfb47d7e79d.1588199705.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Taylor Blau wrote:


>            [...] by making 'commit_graft_pos' non-static so that it can
> be called from both 'commit.c' and 'shallow.c'.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  commit.c | 2 +-
>  commit.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/commit.h b/commit.h
> index ab91d21131..eb42e8b6d2 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -236,6 +236,7 @@ struct commit_graft {
>  typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
>  
>  struct commit_graft *read_graft_line(struct strbuf *line);
> +int commit_graft_pos(struct repository *r, const unsigned char *sha1);

Now that this function isn't file-local, its name becomes more
significant.  What array does this represent a position in?  What does
it return if the graft isn't found?  From a call site it's not
necessarily obvious.

Ideas:

- could include a comment saying that it's an index into
  r->parsed_objects->grafts

- I'm usually loathe to suggest unnecessary duplication of code, but
  it might make sense to duplicate the function into shallow.c.  Or
  even to inline it there (in the single call site, that ends up
  being pretty readable).

Thoughts?

Thanks,
Jonathan
