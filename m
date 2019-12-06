Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD017C2D0C0
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A411B2464E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbFYRGXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLFNIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:08:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43912 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfLFNIb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 08:08:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so7654453wre.10
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 05:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2FmewC98EFcV+WnDki6MmC2bm/34VnAVJLh13ciP2rE=;
        b=NbFYRGXkbfoTjf6DxOOQDR196hav6Mu6dmO9/DmmZPAX2Z9frqf52cBfU/3fcZR+KJ
         aMZBmWTdFAnw0Re/yHIyO6CMS+Z7GmJpnPjIugcUQ/i8/Fq16WBTYRpuYX9lksL0AbPM
         LvJ6bfrB6xWjVQ7Dfc2axC3Snxbz+/icqJaqk3+o/iCxpuSqaI5eTRvhOJdi6jK5NN9v
         qgHDdwmNXAcGDAFO3QGor1RQ894nww4HwcWeAv4jdZGk/h9CBLftCouV7Zbl+Af2oUEV
         +n71StDCEEj5QdPyx91ju2ck/OhMam88bxKtiq00H0hxDTuSBSXY+ifLy0zelDDXTnDn
         ORNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2FmewC98EFcV+WnDki6MmC2bm/34VnAVJLh13ciP2rE=;
        b=HpPjfnjbRqioukCGqmdLFQCxDbzZsRAnnyOmStbw8SHfGud1LPUPJA/0KpESOUwhiJ
         uBXVn3B2HxIX3iMt8hjkD35yAmZimceHl4ul39Y3JWzwsf6uAVIqM8q6svTYrj88ZzHw
         kz/9dyGra+CAvm5Pn/g4wybrdZkI4Sk+n0w2uisqXQthuIrnQ5Sm7WkQrwKmNOVZDtIf
         a8lGPhYJuK/12GK5G3oRyRop9PkBWd4BENPImXC3pORKthohCxdSteLlhUrZxFIQUrFo
         TelhFz3AbHiMBJQUaYAs2Pm8F8tws1Q6MTUBv54ahAH826ze0czbu706O7/KJ9F9VOI2
         OPhQ==
X-Gm-Message-State: APjAAAX6FHPT9ZYGTghD+vCTB7fn/TlSakdph3G2ObCDdtmmxum+8a6E
        Ft2C2ouLAUk482MlBa16Js80cyFh
X-Google-Smtp-Source: APXvYqw76J9TmhZMWu2zLkxVIXX78+/Z1KqLO0dIAYirF/k30dy8lpyxFD0h1LoUhK03xKuqrVhOCQ==
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr15301076wra.36.1575637709883;
        Fri, 06 Dec 2019 05:08:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y20sm3209443wmi.25.2019.12.06.05.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 05:08:29 -0800 (PST)
Message-Id: <2219b37fd58dea0d503777177ea79f68ea892dc7.1575637705.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.172.git.1575637705.gitgitgadget@gmail.com>
References: <pull.172.git.1575637705.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Dec 2019 13:08:22 +0000
Subject: [PATCH 4/7] t3701: verify the shown messages when nothing can be
 added
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for re-implementing `git add -p` in pure C (where we will
purposefully keep the implementation of `git add -p` separate from the
implementation of `git add -i`), let's verify that the user is told the
same things as in the Perl version when the diff file is either empty or
contains only entries about binary files.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3701-add-interactive.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index c90aaa25b0..797610e96d 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -291,6 +291,17 @@ test_expect_success 'different prompts for mode change/deleted' '
 	test_cmp expect actual.filtered
 '
 
+test_expect_success 'correct message when there is nothing to do' '
+	git reset --hard &&
+	git add -p 2>err &&
+	test_i18ngrep "No changes" err &&
+	printf "\\0123" >binary &&
+	git add binary &&
+	printf "\\0abc" >binary &&
+	git add -p 2>err &&
+	test_i18ngrep "Only binary files changed" err
+'
+
 test_expect_success 'setup again' '
 	git reset --hard &&
 	test_chmod +x file &&
-- 
gitgitgadget

