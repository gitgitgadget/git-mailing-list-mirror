Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED38DC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 22:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68EF60720
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 22:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbhGMWjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 18:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbhGMWjc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 18:39:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEFFC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 15:36:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c15so159743pls.13
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 15:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vFDTpBQvHM3JhR9uEbO5LRa+49xBaydf2Co7UqLFie4=;
        b=R9CtvXiCz5dHFBJDNJnO6pu9bnA1LgBlSjbZQQsVA0bePSzKHj1W7sRe0Hk6Fkl/Fr
         zTa/UVQ7Lq9mIXNXhzmLtt7eWm5LNAzJBL6u5Ib8I+LKxugBA22JuZfnD70YqWP/4CrF
         LmRDWgCMrSiCQDYsYqKqueQdBIMyXabNes0KhmDywaNBOzVpWwK8w7nf3R+W1u1gS6gt
         TpRE5A+NoXZ8jlsXj22Mv9yzC7M1K+CHq+aROnEqjpJI41U43LOfxi8RoGJ9Sy3QC12X
         pIz6efgvi5D+0WHQ0XgaROeshTGQJSugh48/n6a/jXiE5hkdgAI9Gxa9+7Mxg0hzcHAo
         BkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vFDTpBQvHM3JhR9uEbO5LRa+49xBaydf2Co7UqLFie4=;
        b=rt4wWaLjoJxpZ0GkhPDnrL4RXuZUScRAU964VYR8/Qjux5ywJVLWCB+zzu9lXLS/XC
         zgoHep/rwNlebxOMeA87UpK7uH/CcYG2i1kht5/VXjjL+MYOF25ELJQpRAjCMzx4ZZ96
         +tALZ+qNCcqkZPft2ldW9nOieRMp78ScbuuxL1bkEPQajiBrC24/YOttsUpWBT/0jXGk
         E6kMVoAXHwJhCb0msg56QMMZkpeRhq4EwEsoVQGPLLpxgpKUVpfSk1ysyVLc3yCEEAi+
         Y8Yt87qWs6UglUWWCI1UQ/ARKctTJK/O9PSYN9yUOe4lRWYNCfE5vWl4+nLEvVskCNCd
         69Dg==
X-Gm-Message-State: AOAM530QmJ/ng0Qhu3XVHCa6ztvUPKQXlvcueD4f1O1iizCbBTP2oCQt
        FdfdDkQ5fwWGxwS3T7EGSx8K6Q==
X-Google-Smtp-Source: ABdhPJyanRzTjymdMZIcMwGK31nwsC0koB5t/Xlky4wUVxO8w+ptfwsoAWJn2uKC9YGSKd7M0vK7qg==
X-Received: by 2002:a17:902:e807:b029:12b:43ce:18dc with SMTP id u7-20020a170902e807b029012b43ce18dcmr1068912plg.70.1626215801115;
        Tue, 13 Jul 2021 15:36:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:df8b:593d:91b7:a693])
        by smtp.gmail.com with ESMTPSA id g141sm177338pfb.210.2021.07.13.15.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 15:36:40 -0700 (PDT)
Date:   Tue, 13 Jul 2021 15:36:35 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] fetch: die on invalid --negotiation-tip hash
Message-ID: <YO4Vc58rl2Ble31u@google.com>
References: <cover.1624486920.git.jonathantanmy@google.com>
 <8df607f4cfb3064200bf4effc91726c92804e637.1624486920.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8df607f4cfb3064200bf4effc91726c92804e637.1624486920.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 03:30:53PM -0700, Jonathan Tan wrote:
> 
> If a full hexadecimal hash is given as a --negotiation-tip to "git
> fetch", and that hash does not correspond to an object, "git fetch" will
> segfault if --negotiate-only is given and will silently ignore that hash
> otherwise. Make these cases fatal errors, just like the case when an
> invalid ref name or abbreviated hash is given.
> 
> While at it, mark the error messages as translatable.
I don't usually like this kind of "while we're at it" change, but in
this case it's very very small, so it doesn't bother me much.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/fetch.c  | 4 +++-
>  t/t5510-fetch.sh | 9 +++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 9191620e50..2c50465cff 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1428,7 +1428,9 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
>  		if (!has_glob_specials(s)) {
>  			struct object_id oid;
>  			if (get_oid(s, &oid))
> -				die("%s is not a valid object", s);
> +				die(_("%s is not a valid object"), s);
> +			if (!has_object(the_repository, &oid, 0))
> +				die(_("%s is not a valid object"), s);
Any reason not to consolidate these, e.g. if (get_oid || !has_object)?
Then we wouldn't dup the err string.

>  			oid_array_append(oids, &oid);
>  			continue;
>  		}
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index e83b2a6506..5fc5750d8d 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1214,6 +1214,15 @@ test_expect_success '--negotiation-tip understands abbreviated SHA-1' '
>  	check_negotiation_tip
>  '
>  
> +test_expect_success '--negotiation-tip rejects missing OIDs' '
> +	setup_negotiation_tip server server 0 &&
> +	test_must_fail git -C client fetch \
> +		--negotiation-tip=alpha_1 \
This one's okay...

> +		--negotiation-tip=$(test_oid zero) \
...and this one's junk. Ok.

> +		origin alpha_s beta_s 2>err &&
> +	test_i18ngrep "is not a valid object" err
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
>  
> -- 
> 2.32.0.288.g62a8d224e6-goog

Other than the little nit, this seems OK to me.

 - Emily
