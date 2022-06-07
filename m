Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B510CCA482
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387640AbiFHAaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574967AbiFGX0c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:26:32 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA9623099C
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 14:38:11 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id w36-20020a17090a6ba700b001e876698a01so4952764pjj.5
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 14:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ScJPGjCgMYiJYOi0crBKYP9cEXfH+ld91Ad62xrOthc=;
        b=BabdNnwLK/vG9/a4N6WY50NJYmc6B5VeLjmiz5Iu66axpk2mmgCAGGmKSTt/v09NkY
         eBJVIrGSAqSwpb4gbSkOUdK9LDMiCkaxu39GiTNrOEdqoTMvSXp/xEs4KEFKt7Rh7bGb
         2xJI7Bd82iz/K9rF8f807M0dfavM7hnT9/b/F4S9D4gS7X+dzZGD266yRLRvXjuVOMvX
         q7x9djSSkxWzXM2V2pN8gCQUgRTQUjE17b18NhS0t+eLEOaslL8/PHV1C0KJPSwg1O7I
         TR3NR8hxnjVK7qnPqREryRzBvMo+kc/lueKKFdPdhLRLpgwV32A+DbBt5IZS2B0GQL0b
         52gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ScJPGjCgMYiJYOi0crBKYP9cEXfH+ld91Ad62xrOthc=;
        b=5GP6M/lp0TzumRMLlkTsLijyH35Qg+7l0GhYGSRlWNnTINPFjirHJ+vfUY/hPQHnZ9
         2w6Dbw7J6vB93dAfoA+ck1Xnn1y6DsXNlsZ4ByltmdOwTVWWdKrJVPtZ79ja6sZbXARm
         XZ6fM/76+I+efwjs96VkAoN38GjLBF+asfrmsrUGtZt3gUQZXYkzTAaJSuG/3VjpmKwB
         6oeOD/kobOLVZ2jBETr1zz4+KZAZ2Fq/pCusoQSqMZkwaUdiDcoxK7RspvzDTqGZSd++
         ZMpzbhZSs1giDc4m4KsFuB06XDb9b26Gq7t5jGcJEzZt+0CayBW/X/HXM6Jp5tjBoo2f
         XOUQ==
X-Gm-Message-State: AOAM5324udGD5DsxJB0Xbv5tMLovboVegMbBQ9oZOlET9kYHKUeVCErx
        bESk6xXxz/7a45d858ixFwMGtuang1DlsA==
X-Google-Smtp-Source: ABdhPJyEChcoiDcXMGwnnXflVGNrvvSz9+xUY6dSUNuv3ItJTdrGLrohkYS9vMuZLYjfvf5L6/Y4bM8gpNcM8w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:3491:b0:51c:1d3b:b0b0 with SMTP
 id cp17-20020a056a00349100b0051c1d3bb0b0mr11831942pfb.68.1654637887034; Tue,
 07 Jun 2022 14:38:07 -0700 (PDT)
Date:   Tue, 07 Jun 2022 14:37:54 -0700
In-Reply-To: <29053d029f8ec61095a2ad557be38b1d485a158f.1654635432.git.gitgitgadget@gmail.com>
Message-Id: <kl6lh74w6tot.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
 <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com> <29053d029f8ec61095a2ad557be38b1d485a158f.1654635432.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v4 5/5] setup.c: create `discovery.bare`
From:   Glen Choo <chooglen@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/config/discovery.txt b/Documentation/config/discovery.txt
> new file mode 100644
> index 00000000000..fbe93597e7c
> --- /dev/null
> +++ b/Documentation/config/discovery.txt
> @@ -0,0 +1,19 @@
> +discovery.bare::
> +	'(Protected config only)' Specifies whether Git will work with a
> +	bare repository that it found during repository discovery. This
> +	has no effect if the repository is specified directly via the
> +	--git-dir command-line option or the GIT_DIR environment
> +	variable (see linkgit:git[1]).

Ugh, I forgot to update the docs for `discovery.bare`. This should be
reworded to be consistent with `safe.directory` and
`uploadpack.packObjectsHook`, e.g.

   discovery.bare::
   	Specifies whether Git will work with a bare repository that it found
   	during repository discovery. This has no effect if the repository is
   	specified directly via the --git-dir command-line option or the
   	GIT_DIR environment variable (see linkgit:git[1]).

    This config setting is only respected in protected configuration
    (see <<SCOPES>>). This prevents the untrusted repository from
    tampering with this value.
