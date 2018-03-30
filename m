Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E278E1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 17:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeC3RKV (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 13:10:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38868 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeC3RKU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 13:10:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id l16so17754491wmh.3
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TYCGDtpRY40UgJzr5EftwSKRQSHif7rLZLKMkkk8EjI=;
        b=E590wBbc8Bo3Fov8xzRdXfZmIcY1Ajba5EbVKDYNtNA1vMvRIIwTs4NSOFI1JhbWpx
         vb0xQfRgt8ZgcHPRrAC3PXhuDRUFSa8KBHAcTkZ621LRYa3tb9U1dbhPopMqDX/uvwSU
         7jNXqxTMXCiiDh6oWO0lFdGHYvUVLQP+7oBwDDOaYHBe8ykA+tevpcPCN4Z+THVWgXNM
         +WL6B76OhnPUd/cxBdHeFsqZtkzdUAd0CLYMIk0kVvYVIY8bllN0mYPYNGSvCqEF/23R
         6QSDGicKREfBM/1+nATscS2eycXJzAEbjm2WRaw1FyesLGtHM1ge+SHEE6vPLIk8Pohm
         ECwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TYCGDtpRY40UgJzr5EftwSKRQSHif7rLZLKMkkk8EjI=;
        b=KugZf7udHEtr7+K6XRvxuSwUgGqgj0QTYELrfoL0EBI7ZcIuIMi0e5r3udd5FbGgPc
         eLbwSWhdtt8u61NWyyVtadfIvhipahdIzgHo7AE3Ye8usHfz7YG8TInTC57JNS+faAc7
         1/FmXJrLdn0LqOhXsEaeGeGv3x/Y4iX972WF82v0OV9eeYEryrseo/bzKotzrMXjjgua
         Vb1Zfrvd4Ba9HAGa8BnLzVdbvJEViCFFhSZFM23hEgv915TgY+DmicX5K9OkVp25wLEh
         kEeNTEKDgeZGILBflv/NZ/LwRuhwSvAjhGMf6zlQSS6pFTXxbQtEg9UMBSOGf0j8qF/V
         8zpQ==
X-Gm-Message-State: AElRT7F1RmtVW3XaHzDgTCgZCOj8N7Uk08HfrgjZBEjHw/0nqjtYO1pR
        nlGgLgk4yD1GikMU7bdTuuI=
X-Google-Smtp-Source: AIpwx48Iy0TAMNRpFza02bW9uXQsHO7BpBHh9laqZaXJHxdpNpv4EGClw+tlTWpjJ3KA+C3Gbg6YmA==
X-Received: by 10.28.112.8 with SMTP id l8mr2721369wmc.47.1522429819161;
        Fri, 30 Mar 2018 10:10:19 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p4sm12202824wrf.27.2018.03.30.10.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 10:10:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] setup.c: reset candidate->work_tree after freeing it
References: <20180330070744.22466-1-pclouds@gmail.com>
Date:   Fri, 30 Mar 2018 10:10:16 -0700
In-Reply-To: <20180330070744.22466-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 30 Mar 2018 09:07:44 +0200")
Message-ID: <xmqq7ept4hhj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Dangling pointers are usually bad news. Reset it back to NULL.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

Before abade65b ("setup: expose enumerated repo info", 2017-11-12),
candidate was an on-stack variable local to this function, so there
was no need to do anything before returning.  After that commit, we
pass &repo_fmt down the codepath so theoretically the caller could
peek into repo_fmt.work_tree after this codepath, which may be bad.
But if candidate->work_tree were not NULL at this point, that would
mean that such a caller that peeks is getting a WRONG information,
no?  It thinks there were no core.worktree set but in reality there
was the configuration set in the repository, no?

Which fields in candidate are safe to peek by the caller?  How can a
caller tell?

It seems that setup_git_directory_gently() uses repo_fmt when
calling various variants of setup_*_git_dir() and then uses the
repo_fmt.hash_algo field later.

If we want to keep fields of repo_fmt alive and valid after
check_repository_format_gently() and callers of it like
setup_*_git_dir() returns, then perhaps the right fix is not to free
candidate->work_tree here, and instead give an interface to clean up
repository_format instance, so that the ultimate caller like
setup_git_directory_gently() can safely peek into any fields in it
and then clean it up after it is done?

>  setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/setup.c b/setup.c
> index 7287779642..d193bee192 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -482,7 +482,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
>  			inside_work_tree = -1;
>  		}
>  	} else {
> -		free(candidate->work_tree);
> +		FREE_AND_NULL(candidate->work_tree);
>  	}
>  
>  	return 0;
