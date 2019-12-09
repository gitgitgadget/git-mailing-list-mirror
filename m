Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DBDC04E30
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229F2207FF
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s01U2OfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfLIQKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:10:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39619 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLIQKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 11:10:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so16806505wrt.6
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 08:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ymnkwB7JOEvPi7Ws+rA1Lp/Cyqkxn5JphfBC72RMmsI=;
        b=s01U2OfSM1M3kxxLoYTRlUuOyBilYg0/qPcR271kZ3j15uLkoVaN2XC5jGdaNdBvm0
         b+Q2wXUTRGJelmMf3Grot3DiL4KUiT2HHOZJrRuJpY+9XeNrKA4blhe1CewaDEba/6M7
         ZWYrpq79tdjwXmrgumI5lvTBaPBjH8KMxGa8rD+upGlimaNZNViMvYBCyRG9bu6S8pQC
         FXRCpPlMCMXFy4rwQTzPR4OB/hFgwwnt7opVgja3+ZNwl1hQGgb4aV9PziranmiQjILU
         BqULLSZ/27VyLr624/AzDSPYnq9XDrjubpVQOHq8I9pmjpKoBqLBX1IJj5ORWnpR8ZdE
         Puaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ymnkwB7JOEvPi7Ws+rA1Lp/Cyqkxn5JphfBC72RMmsI=;
        b=DCCSXBi1peOn5Dndb4V9JL3qItoDVVvSyeo39tbiiQ+CpMZEcAaO3+RlDjYMhAsq5c
         fpOpXZWsKOCKddhK0PP0tq77rGiQPEuBxRS1fkbwQxnoaNjBFN51CtvmCFQUu72JJIrI
         BqCj6PPs+CHPHvuHKVKrmsBWKcfMv2DhsWWjk545Fi9a1qz7TrUjRY5ErXOEjCZcY8Fz
         YD/9uz0ql1/i9OAxT8GA1COT06vQ+NisZv884KC6sbqWoNtN9m5UP59qvL4MvCsAMVyU
         HAgK/jkbRAfk60Rc7tgqTLMN9uOJnWaCx6QRXOMxz1NSGuU6BO1amHX+/g3d/RBK3BNI
         XFuw==
X-Gm-Message-State: APjAAAVJSRtG7uqoMXm/jMA8Rua176qeEegjzGUS3rRIUyJCRBICpcKs
        CZIHUJohGDU7S27ZahVXo3QIXuu5
X-Google-Smtp-Source: APXvYqwIXV1P2fEC+EQJatf2Rk81pBPkhHTSRi2T/e9nLwHL6vsWNFzVPtvFT5Mg+eeAzOZaRRQqQQ==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr3124577wro.216.1575907806998;
        Mon, 09 Dec 2019 08:10:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16sm29709640wru.0.2019.12.09.08.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 08:10:06 -0800 (PST)
Message-Id: <dd492091e329fbc75571dd5d64bfdfd845daec80.1575907804.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
        <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 16:09:58 +0000
Subject: [PATCH v2 2/8] fsmonitor: do not output to stderr for tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The fsmonitor feature allows an external tool such as watchman to
monitor the working directory. The direct test
t7619-status-fsmonitor.sh provides some coverage, but it would be
better to run the entire test suite with watchman enabled. This
would provide more confidence that the feature is working as
intended.

The test t0003-attributes.sh and others would fail when
GIT_TEST_FSMONITOR is pointing at t/t7519/fsmonitor-watchman because
it sends a message over stderr when registering the repo with
watchman for the first time. Remove this stderr message for the
test script to avoid this noise.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7519/fsmonitor-watchman | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index d8e7a1e5ba..06312876aa 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -94,7 +94,6 @@ sub launch_watchman {
 	my $o = $json_pkg->new->utf8->decode($response);
 
 	if ($retry > 0 and $o->{error} and $o->{error} =~ m/unable to resolve root .* directory (.*) is not watched/) {
-		print STDERR "Adding '$git_work_tree' to watchman's watch list.\n";
 		$retry--;
 		qx/watchman watch "$git_work_tree"/;
 		die "Failed to make watchman watch '$git_work_tree'.\n" .
-- 
gitgitgadget

