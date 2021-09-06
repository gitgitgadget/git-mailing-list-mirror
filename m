Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500DCC433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 22:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 109376108D
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 22:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhIFWHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 18:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhIFWHc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 18:07:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6DFC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 15:06:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id e21so15740209ejz.12
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=MFEM7VT+Tn63uNGK2BkAdNo3BAFUgyHBbEL/QeiI3XU=;
        b=aDg4k8YbgzIdgGyJo979s8mVrxv/aYjNsRsRNENgs7XhjTc9HzcRwmLSv9xun1y0Yn
         m9b/Wi1sw6yU8WGWksYa2lzRCLB5Z3C2H3d9JzMQJlZ/epl6AiQ8A2jpcQwuyKzLCDfy
         AQ/g0qUmcOd4XrjjzgjLt1J+Q2Is2EoUuLhI9v+f9C3rU4lvRBacxHHMP/sc/gYwI9n2
         fDJY6NThuCNYYSApj/hT65S2hRAyWoahW2Qfk1t8PTvSchcCTrruztxutBCKaq5XXUII
         2UIg4toa9NqXSMFfZGc8ZqgjGPmqpFKHOEPy7/iLaIjlu5TH0aG6ZesYWPN5evMdwxGw
         PN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=MFEM7VT+Tn63uNGK2BkAdNo3BAFUgyHBbEL/QeiI3XU=;
        b=BhsgI/pgQI1t1cJpZgcU7Rh5ppB3x5DDRCEsIZIRZ3Ytl5GSsHQGE+9kaQBIXOdq3g
         vRREhmSW3OtDrhipUkuHvJYJwrWHlQpsdRbGhg6jrwdxxjyBz+CkNcdTeHBcpvmzzF8J
         IN0wnxrj0Qh5DCTPVaL4XOcs4DTIMC7aERnMuoXJyM5TopA66pYJGQIyp0k6NZIZzk/a
         42C0XZMRjdP6FrkOCIF96TIs5bGJ+W6enUmSy3gDQqiFUnbU3eGLG9iyUfnRHOhfgdgn
         WWoQXhi2y5VMVt6aayNKx7ALKbDOGZJtjPg5zlkq893Kh5YKDp2qOR/zf3XvPZ5+jaMK
         aMig==
X-Gm-Message-State: AOAM530JJ6GuyyZofbOnfB9dhP7FWvdTLZdzWE1Sn0F8lR1tavxeA1bm
        oGj9yorfLzUDAzcicz68ErI=
X-Google-Smtp-Source: ABdhPJwr0fIcrcjYfRHMk/EcsWjnCAyllYPUw6GMcp9lblpM1l1MVLXVe/KEzFpVHiHxb3GGxx49NQ==
X-Received: by 2002:a17:907:2d8b:: with SMTP id gt11mr15489283ejc.432.1630965985287;
        Mon, 06 Sep 2021 15:06:25 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c28sm4594397ejc.102.2021.09.06.15.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 15:06:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, lilinchao@oschina.cn,
        Elijah Newren <newren@gmail.com>, jerry@skydio.com
Subject: Re: [PATCH v2] apply: resolve trivial merge without hitting
 ll-merge with "--3way"
Date:   Mon, 06 Sep 2021 23:59:42 +0200
References: <xmqqczr26i9f.fsf@gitster.g>
 <20210905190657.2906699-1-gitster@pobox.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210905190657.2906699-1-gitster@pobox.com>
Message-ID: <87pmtlnyu7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 05 2021, Junio C Hamano wrote:

> +	if (!image->buf || type != OBJ_BLOB)
> +		die("unable to read blob object %s", oid_to_hex(result_id));

This die() message seems to only be applicable to the first condition
here, shouldn't this be:

    if (!image->buf)
        die(_("unable to read blob object %s"), oid_to_hex(result_id));
    if (type != OBJ_BLOB)
        die(_("object %s is %s, expected blob"), oid_to_hex(result_id), type_name(type));

Also as shown there, missing _() for marking the translation.

> [...]
> +test_expect_success 'apply binary file patch' '
> +	git reset --hard main &&

Partly this is cleaning up a mess after an existing test, but here
there's no reason we can't use test_when_finished() for all the new
tests to make them clean up after themselves:

diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index cc3aa3314a3..c3c9b52e30d 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -232,6 +232,8 @@ test_expect_success 'apply with --3way --cached and conflicts' '
 
 test_expect_success 'apply binary file patch' '
 	git reset --hard main &&
+	test_when_finished "git reset --hard main" &&
+
 	cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
 	git add bin.png &&
 	git commit -m "add binary file" &&
@@ -246,7 +248,8 @@ test_expect_success 'apply binary file patch' '
 '
 
 test_expect_success 'apply binary file patch with 3way' '
-	git reset --hard main &&
+	test_when_finished "git reset --hard main" &&
+
 	cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
 	git add bin.png &&
 	git commit -m "add binary file" &&
@@ -261,7 +264,8 @@ test_expect_success 'apply binary file patch with 3way' '
 '
 
 test_expect_success 'apply full-index patch with 3way' '
-	git reset --hard main &&
+	test_when_finished "git reset --hard main" &&
+
 	cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
 	git add bin.png &&
 	git commit -m "add binary file" &&
