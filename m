Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9DCC433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKERNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKERNd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:13:33 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C24AFD03
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:13:32 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q1so6915157pgl.11
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nwKx6v19x1R3DrIp5z16/28zIjqHwAxQLb926zwJRPg=;
        b=WHGD6Y++3a2HxuM3ZAQyK/VZyXDWJxKpli9q2kjEW4pg+1+xYfcuQq7U+dN0/DIHMV
         O1s0QMEOjetUgrlzFD30EQX6g+Xjd2TkTYr6Rq2CprOIpBKSZEpBRuWR/PrKe3oclBIY
         PRL7AcOWulcNItDfoKQ5zLRqbgsBE6no0GgXhH8EKnKlDdowtn9pfuheD4eTYF8UBX6u
         PQds8CVacgZFqZ0G94v5ypcczVeUgql0jqcgdw1zrkxvwsqFTHyHOgC1B67IhvjyPOpD
         2Epk++9Hj3YmRpe+cgO0SFdDt+BnAH/82/vs1WvZUWizB0DGwHHfmhRg4wSTLrGlBZUR
         pF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwKx6v19x1R3DrIp5z16/28zIjqHwAxQLb926zwJRPg=;
        b=712q9J2uajl7re2GYDJX7Bl/j4DGKMc065UXAIgJkwEkNdaTtaEZHi/7W37EYviYAN
         XyCkOnx/ixd2B1NqysaAuFBG1+cGLviCWnJC3r3UQVU1UqNKHmYWm1F2nnhU6VNSUwYt
         K2Em24vFd0VWwIr7VmC0b+L0BKklZL/RWS2DnxM4vdnH19/CPLoQ+UW2dL0s3oH/u1/f
         yx7snvsulL2qQ4SyJYS1OKLcQdX9IR5gy0ydxkfstGv3GDeVGQN+JW+Uy8E7MGG5RECf
         CwA71DHlzhBBFFK3o1B/KdET/4oeeKzyQjdDfYUijy62REIv+Hsn42HiHaqgaCqsH/P+
         UeBw==
X-Gm-Message-State: ACrzQf2a98wMhiCr9dVgSA9EEBvpM2PU7uRyGxVpAJDM0hvhxmpxRqcT
        Rt/4wkGbzC0QDd8JOztlEqY/8Ukw/wA=
X-Google-Smtp-Source: AMsMyM7SchgfkSEg9LxdC6GAQczE+dXeLXG62Y4O8+zfCZVFKlvD3Oz9WOxBhZBF83uwZuvOYXJLHg==
X-Received: by 2002:a62:1e04:0:b0:56d:a2cf:e7fb with SMTP id e4-20020a621e04000000b0056da2cfe7fbmr28418924pfe.48.1667668411260;
        Sat, 05 Nov 2022 10:13:31 -0700 (PDT)
Received: from localhost ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id g18-20020aa796b2000000b005622f99579esm1512147pfk.160.2022.11.05.10.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:13:30 -0700 (PDT)
Date:   Sun, 6 Nov 2022 00:13:28 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 2/3] bisect--helper: move all subcommands into their
 own functions
Message-ID: <Y2aZuBxuXvMSt2Rc@danh.dev>
References: <cover.1667561761.git.congdanhqx@gmail.com>
 <cover.1667667058.git.congdanhqx@gmail.com>
 <9d8a3cdd7a9472df01f67eb11ebac02a143d270b.1667667058.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d8a3cdd7a9472df01f67eb11ebac02a143d270b.1667667058.git.congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-06 00:03:35+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> In a later change, we will use OPT_SUBCOMMAND to parse sub-commands to
> avoid consuming non-option opts.
> 
> Since OPT_SUBCOMMAND needs a function pointer to operate,
> let's move it now.
> 
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  builtin/bisect--helper.c | 155 ++++++++++++++++++++++++++++++---------
>  1 file changed, 121 insertions(+), 34 deletions(-)
> 
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 5ec2e67f59..292c6fd1dd 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -1279,6 +1279,117 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
>  	return res;
>  }
>  
> +static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED)
> +{
> +	if (argc > 1)
> +		return error(_("--bisect-reset requires either no argument or a commit"));
> +	return bisect_reset(argc ? argv[0] : NULL);
> +}
> +
> +static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED)
> +{
> +	int res;
> +	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };

Note to self: I need to change this to

	struct bisect_terms terms = { 0 };

in the next revisions.


-- 
Danh
