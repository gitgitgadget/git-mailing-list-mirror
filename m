Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCE1B1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 19:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbeHHWLp (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 18:11:45 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:40435 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbeHHWLp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 18:11:45 -0400
Received: by mail-ua0-f202.google.com with SMTP id y3-v6so2630548uao.7
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=scEofI9uYMrFW/NT5iCWhHldpBV9VEnEJnAZewc6QBI=;
        b=F6PIJciefsfRWljNm+qUjUoK+kPJRbUwat41P4CTC9ucjxmldBcdC3cMwlNnAmmq+y
         wVcoXI03M6oe67o6giFcXhE+37LMRmNGLFe34tCMyXpwrkjvop75fmrsFntANHYnA7pP
         wGoNQ1399+/VmIIUgdJ3282/ZxazKQuI48fbFnrPI6vuRn9bnvRiw/V5SxsmSVG7NXVH
         zaU89SVd1umZW6keMo6DCkUbUIAWZyPoCfr+SlQfkqaGTzLdCvjh7bXXIx9JVZxLi93A
         cBrIMozB+ldVYhz399vLXjdCy3BIUmz1hr0sKj+TskFtu5j8/2pLDH/jTbD5NP5KZQXd
         lUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=scEofI9uYMrFW/NT5iCWhHldpBV9VEnEJnAZewc6QBI=;
        b=Ka7uaqEsxNuPvGmpCU/8JFIyKAXh6ACRxLUuZnxfRz9ll05m6vMTQbIO/XFMP7V5V2
         TVxRTdeG5Hid5X2jXd1+lFxRKhFKSko8VN4A2VncdSv1NIT1gOqxkEWZmKZvy491d996
         D4dGqWX2M774g4QFJxIWvGoKCPxcz5ut13ZS0ar601u4l66j1DUsjv9PANPnc0AIcVLU
         2R1/888OcROCppwcHBt/OsZMlweg6lm5V6zykSZ0unsUlIJ0IjinGu3XZnGbPtZvtqce
         9UnFBX5gn99TLAcjWQNryJodmPbMGzR8a2Wbo7583kFeviK90kq249E6AJ01nKuA32YJ
         nfkQ==
X-Gm-Message-State: AOUpUlFA/QTkdnakeJSY7NufbOcKr2kWPnSBleeLDJoBfut9LCcai55J
        W9C+7QJKg7ioQzw0HLc+qwv4M1i+oy2E
X-Google-Smtp-Source: AA+uWPw/7ObCziznsupwQKjWb1vfiUyKoHzOJujVhoNbrrTni/WSFeI4wbeWBfdxr0PcrnaaDr91dNjOGuoI
X-Received: by 2002:a1f:2413:: with SMTP id k19-v6mr2295261vkk.4.1533757832921;
 Wed, 08 Aug 2018 12:50:32 -0700 (PDT)
Date:   Wed,  8 Aug 2018 12:50:18 -0700
In-Reply-To: <20180808195020.37374-1-sbeller@google.com>
Message-Id: <20180808195020.37374-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180808195020.37374-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 1/3] t1300: document current behavior of setting options
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This documents current behavior of the config machinery, when changing
the value of some settings. This patch just serves to provide a baseline
for the follow up that will fix some issues with the current behavior.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t1300-config.sh | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e43982a9c1f..c15c19bf78d 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1188,6 +1188,92 @@ test_expect_success 'last one wins: three level vars' '
 	test_cmp expect actual
 '
 
+test_expect_success 'old-fashioned settings are case insensitive' '
+	test_when_finished "rm -f testConfig testConfig_expect testConfig_actual" &&
+
+	cat >testConfig_actual <<-EOF &&
+		[V.A]
+		r = value1
+	EOF
+	q_to_tab >testConfig_expect <<-EOF &&
+		[V.A]
+		Qr = value2
+	EOF
+	git config -f testConfig_actual "v.a.r" value2 &&
+	test_cmp testConfig_expect testConfig_actual &&
+
+	cat >testConfig_actual <<-EOF &&
+		[V.A]
+		r = value1
+	EOF
+	q_to_tab >testConfig_expect <<-EOF &&
+		[V.A]
+		QR = value2
+	EOF
+	git config -f testConfig_actual "V.a.R" value2 &&
+	test_cmp testConfig_expect testConfig_actual &&
+
+	cat >testConfig_actual <<-EOF &&
+		[V.A]
+		r = value1
+	EOF
+	q_to_tab >testConfig_expect <<-EOF &&
+		[V.A]
+		r = value1
+		Qr = value2
+	EOF
+	git config -f testConfig_actual "V.A.r" value2 &&
+	test_cmp testConfig_expect testConfig_actual &&
+
+	cat >testConfig_actual <<-EOF &&
+		[V.A]
+		r = value1
+	EOF
+	q_to_tab >testConfig_expect <<-EOF &&
+		[V.A]
+		r = value1
+		Qr = value2
+	EOF
+	git config -f testConfig_actual "v.A.r" value2 &&
+	test_cmp testConfig_expect testConfig_actual
+'
+
+test_expect_success 'setting different case sensitive subsections ' '
+	test_when_finished "rm -f testConfig testConfig_expect testConfig_actual" &&
+
+	cat >testConfig_actual <<-EOF &&
+		[V "A"]
+		R = v1
+		[K "E"]
+		Y = v1
+		[a "b"]
+		c = v1
+		[d "e"]
+		f = v1
+	EOF
+	q_to_tab >testConfig_expect <<-EOF &&
+		[V "A"]
+		Qr = v2
+		[K "E"]
+		Qy = v2
+		[a "b"]
+		Qc = v2
+		[d "e"]
+		f = v1
+		Qf = v2
+	EOF
+	# exact match
+	git config -f testConfig_actual a.b.c v2 &&
+	# match section and subsection, key is cased differently.
+	git config -f testConfig_actual K.E.y v2 &&
+	# section and key are matched case insensitive, but subsection needs
+	# to match; When writing out new values only the key is adjusted
+	git config -f testConfig_actual v.A.r v2 &&
+	# subsection is not matched:
+	git config -f testConfig_actual d.E.f v2 &&
+	test_cmp testConfig_expect testConfig_actual
+'
+
 for VAR in a .a a. a.0b a."b c". a."b c".0d
 do
 	test_expect_success "git -c $VAR=VAL rejects invalid '$VAR'" '
-- 
2.18.0.597.ga71716f1ad-goog

