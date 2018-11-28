Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC3A1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 20:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbeK2H21 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 02:28:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34339 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeK2H21 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 02:28:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so27679105wrw.1
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 12:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7INRh/sw7wkXkytHWNkHz8LExyQxeMHIH1nu6Vl9HE=;
        b=cX9+A2bTIoIQ8vpsabUEyixrgC7FpsmRzGzko+7s6olHYT31bLPQj87X8hHBWKalvF
         NJ31U2IFJvRjKyXTjdbJFXY7ykgOtD3z4Suysmcd7j4LgnavV4bqfekt7WfXBojmSqLx
         GwD+FmCKsSfqOnDRoJrUxndtmYC59RWFMwSaU3ZhDoLeCagoCJg1SVE2c1bUGOF0lbbF
         iUtcMG1bYF5fRiKrMbvzZdcT1U19pR9d3sArls2gH/JSC/qKjdxnCSlnywR2Ga6ynekU
         nUURrX81nE5n8vqjN8UDKYn9OXD9ttLA7xfN36m6CI9y1ae7IqNkq1II5ucVK/rrbTjL
         IRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7INRh/sw7wkXkytHWNkHz8LExyQxeMHIH1nu6Vl9HE=;
        b=tQifTvpgD71mRDT9ZLt3FJ91mu8WiC0hvMBO3gAa/JrewfbC9p+f+HJGsf4mAuLNR9
         U6ZMudyQdUDGm9yNBR4XQmYOFm7VF4WIfrdPxEYYsZisCyA3k4OYkQh+5L2rYXJORedY
         gjNdD51yFI2CSLpXWtDR1S1urb2oHgy4mp7BrVhFEhUaGAS8RU0ME0p80W/1UGGiFUqY
         jaocdPB5eRCXmFbiZ4fIImx9tQHOh7T2SsD9DqgbpVGQ1KtpwfTbvGZOHDvQIzbC83qz
         PqJVcNumQX5ziFQ+f3ms6On4vV+F56WIRSHV/eobY6EoDyf5Pd7egBBsSOYZzEytxd7F
         tgAw==
X-Gm-Message-State: AA+aEWZ/eB+J3XnJKLryf64GOj0PxdMCe/OHpryfaO0glo9ExhHQbqhs
        /W5JqXr0oyrTMNBn9cPp7U67MHiE
X-Google-Smtp-Source: AFSGD/XMf87ohDv4u3wgtlcx84EMOLnR6Jo3GfAaeaYhAAeGx0ARsELvbUmoe/6cP6hiNqmmMbWoVA==
X-Received: by 2002:a5d:684b:: with SMTP id o11mr30834319wrw.316.1543436338382;
        Wed, 28 Nov 2018 12:18:58 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 5sm4648896wmw.8.2018.11.28.12.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 12:18:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] format-patch: add test for --range-diff diff output
Date:   Wed, 28 Nov 2018 21:18:51 +0100
Message-Id: <20181128201852.9782-2-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3
In-Reply-To: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com>
References: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in 43dafc4172 ("format-patch: don't include --stat with
--range-diff output", 2018-11-22) the diff options provided on the
command-line currently affect both the range-diff and the patch
output, but there was no test for checking this with output where we'd
show a patch diff. Let's add one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3206-range-diff.sh | 60 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 90def330bd..bc5facc1cd 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -267,4 +267,64 @@ test_expect_success 'format-patch --range-diff as commentary' '
 	test_i18ngrep "^Range-diff:$" actual
 '
 
+test_expect_success 'format-patch with <common diff option>' '
+	# No diff options
+	git format-patch --cover-letter --stdout --range-diff=topic~..topic \
+		changed~..changed >actual.raw &&
+	sed -ne "/^1:/,/^--/p" <actual.raw >actual.range-diff &&
+	sed -e "s|:$||" >expect <<-\EOF &&
+	1:  a63e992 ! 1:  d966c5c s/12/B/
+	    @@ -8,7 +8,7 @@
+	     @@
+	      9
+	      10
+	    - B
+	    + BB
+	     -12
+	     +B
+	      13
+	-- :
+	EOF
+	test_cmp expect actual.range-diff &&
+	sed -ne "/^--- /,/^--/p" <actual.raw >actual.diff &&
+	sed -e "s|:$||" >expect <<-\EOF &&
+	--- a/file
+	+++ b/file
+	@@ -9,7 +9,7 @@ A
+	 9
+	 10
+	 BB
+	-12
+	+B
+	 13
+	 14
+	 15
+	-- :
+	EOF
+	test_cmp expect actual.diff &&
+
+	# -U0
+	git format-patch --cover-letter --stdout -U0 \
+		--range-diff=topic~..topic changed~..changed >actual.raw &&
+	sed -ne "/^1:/,/^--/p" <actual.raw >actual.range-diff &&
+	sed -e "s|:$||" >expect <<-\EOF &&
+	1:  a63e992 ! 1:  d966c5c s/12/B/
+	    @@ -11 +11 @@
+	    - B
+	    + BB
+	-- :
+	EOF
+	test_cmp expect actual.range-diff &&
+	sed -ne "/^--- /,/^--/p" <actual.raw >actual.diff &&
+	sed -e "s|:$||" >expect <<-\EOF &&
+	--- a/file
+	+++ b/file
+	@@ -12 +12 @@ BB
+	-12
+	+B
+	-- :
+	EOF
+	test_cmp expect actual.diff
+'
+
 test_done
-- 
2.20.0.rc1.387.gf8505762e3

