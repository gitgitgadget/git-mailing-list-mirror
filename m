Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9B1C33C99
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 00:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85727206F0
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 00:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKfbO1gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgAHAbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:31:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38726 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgAHAbk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 19:31:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so733689wmc.3
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 16:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BsSGqbc6dUBX1zIawc0eVUvO9JBz/IryDV77aXixmy8=;
        b=VKfbO1gjMX7kx6wAybsDEtdy/aI5O9EUwgcOfQbk7SBZCNS9zdZNmxzYCA/byNgrYA
         pNGJGMYnlxqbXtX2O/JwlaGDDASF8ejCH4OjsJTXBJq6KBSDZeby/uSJWry7w/pT+xQW
         FXrVu12TB6HHfVIuTu56NIC67V1LCurii8fV+Ra45sg9l6M5iTtAGHE6nEiplnSigj1j
         q3GbF9irZktB1ZTUDRLbO++KRtIJY47YI+LUYxJovf7ge6CH4XpGBspekLp2WdjxSRRS
         Zy8tAzKR0vg69J5gAETe97w4kuAPvARMatAlHT7Mw0b5KnJWWUSSpHRHH5CSvc/Vfd7N
         lfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BsSGqbc6dUBX1zIawc0eVUvO9JBz/IryDV77aXixmy8=;
        b=WWuaRpO72HCMUhVEBxG557yvnFdVX7LRg1IyExI32sEHKGqOv4GAJGf678lvHnvJQK
         qI23aEyIZAcwR/x78oIh0c68nwotKqLbjeQyN5jqxwm9+HxacNc76uoXrfn5+zf313TL
         IYu6kqq7Qi+6pbVq4F0uB3ErMcqlTMJwzfjReHnTAou+zSlyRQVbItJHGXCIx+z2KbcQ
         g1swbNLaZzUi6BtPIfYfKzqyWX6XaPAwWllXrEoTjDMQc/F12yufd8gUZIH0WXw6QuT2
         gcKRR/me6+5WPYPRJOoBocjo8cveuE3VhH/GnMpaSxu31aXlByaqrNMf6HR7+/GSwJVW
         lg+g==
X-Gm-Message-State: APjAAAVX0R2Anmpu5nXRzUWIugaaBiHAWucpWxEHsBMoVlxSUkkxEe2K
        reckrXUBfh9Nvx/2mE025ZxhoU/A
X-Google-Smtp-Source: APXvYqxtqd7MPTgbrJaW2st487TrqN74CnzAP2guSkTSFOnBcHMan7r/G+1Aihd4E2I7UrnALygWQA==
X-Received: by 2002:a05:600c:2c7:: with SMTP id 7mr795903wmn.87.1578443498621;
        Tue, 07 Jan 2020 16:31:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2sm1872090wrw.76.2020.01.07.16.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:31:38 -0800 (PST)
Message-Id: <0c75cd8f9727b10af6f6a804177e551ba0217abf.1578443496.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.515.v2.git.1578443496.gitgitgadget@gmail.com>
References: <pull.515.git.1578391553.gitgitgadget@gmail.com>
        <pull.515.v2.git.1578443496.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Jan 2020 00:31:36 +0000
Subject: [PATCH v2 1/1] doc/gitcore-tutorial: fix prose to match example
 command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

In 328c6cb853 (doc: promote "git switch", 2019-03-29), an example
was changed to use "git switch" rather than "git checkout" but an
instance of "git checkout" in the explanatory text preceding the
example was overlooked. Fix this oversight.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/gitcore-tutorial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index f880d21dfb..c0b95256cc 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -751,7 +751,7 @@ to it.
 ================================================
 If you make the decision to start your new branch at some
 other point in the history than the current `HEAD`, you can do so by
-just telling 'git checkout' what the base of the checkout would be.
+just telling 'git switch' what the base of the checkout would be.
 In other words, if you have an earlier tag or branch, you'd just do
 
 ------------
-- 
gitgitgadget
