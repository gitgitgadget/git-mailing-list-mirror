Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A42C54EBD
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 00:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjAJAxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 19:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjAJAxD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 19:53:03 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49DC183A0
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 16:53:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so10623961wmb.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 16:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vahByWRH6KnL+hDT7wSUVhAb2rHUnakDYQPhVdPlyW0=;
        b=AoKqJ0pB4nehVeXwIzMYyrBHPxSsZ4UVlSLLHxIFJGBNUkXi/6ih6bFY1tI9y085d3
         yW+MCIf26aLCZbFMl0ayL0HbiVpLKSHZ+W+HEHxR+PXueU/XSFIewYFtxpxthgFqriEj
         q3a0Z4nFv8iITx0Hzi0eyqCwZKj+10vU0dkfOgiNIyDvRym90sj1rhcwPZoMYUvRsnq5
         Znda1Q1nZBYfXOxwy0LK+tT7/CYvAfW/LUgyaL8s9ObyaMuQfdxlgFZ+KWoaDO0kNqOc
         YkT88ssZYAJUlVHfBwZdA+vAsSygxN+RR3PpmDG6wG8/q9Nv70BNgUtPN/+jUR2FbgtJ
         HVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vahByWRH6KnL+hDT7wSUVhAb2rHUnakDYQPhVdPlyW0=;
        b=UTci9xVBDy4lPcFU1/KdO4YgzNehvyIo+k6y7WuaqJwTOi0mlstsyk9Kmo+/LAsR3/
         dN9pIT0qxQFm70qaQR2BVNwQREvXYJzKNEIyJzXoZ2OxwfrtauFz0m1g46b9r3DAQJiz
         v9/JBsDeZSRn++09n//7X2ShaqkCzEmJax1M61iB6fJmPA8WB5YdtAHDctYcEeHbfJHb
         vrS18/q78GsvQTf+fTNCKiHQC3bleQ8jr0iCLSKiPKbGuGJllaIm/9kwUybISjVowlyn
         cCI90luzMwZy8DeDdIOSPKsbbTlGG/gt0IRtSmgVeHwSAmRxhhGqXdOwQZBQ/u3BXk8d
         /Sqw==
X-Gm-Message-State: AFqh2kruW3lTJU2xqoofyq3jQs/F9ZyD1LrZJOTNZnrBSKRj5MGOnPkM
        +1drf7XW6pbW/wwfz/H2g0QLspcylNzV62Hf
X-Google-Smtp-Source: AMrXdXtlN6hxnqoa6SPhxZYlEYaTVnJ7khoiLTXcTRqeTwW49oGMXFll4eEXeJ9U5/NPEKLs/Hy1Qg==
X-Received: by 2002:a05:600c:4186:b0:3d9:ef38:4045 with SMTP id p6-20020a05600c418600b003d9ef384045mr4401915wmh.14.1673311979908;
        Mon, 09 Jan 2023 16:52:59 -0800 (PST)
Received: from wilber4c.. ([102.85.180.105])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c4f5200b003c71358a42dsm23377412wmq.18.2023.01.09.16.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 16:52:59 -0800 (PST)
From:   Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
To:     git@vger.kernel.org
Cc:     Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 0/1] ref-filter: add new "signature" atom
Date:   Mon,  9 Jan 2023 19:52:50 -0500
Message-Id: <20230110005251.10539-1-nsengiyumvawilberforce@gmail.com>
X-Mailer: git-send-email 2.39.0.138.gb334f1a8b9
In-Reply-To: <pull.1452.git.1672102523902.gitgitgadget@gmail.com>
References: <pull.1452.git.1672102523902.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit duplicates the code for `signature` atom from pretty.c
to ref-filter.c. This feature will help to get rid of current duplicate
implementation of `signature` atom when unifying implementations by
using ref-filter logic everywhere when ref-filter can do everything
pretty is doing.

Add "signature" atom with `grade`, `signer`, `key`,
`fingerprint`, `primarykeyfingerprint`, `trustlevel` as arguments.
This code and its documentation are inspired by how the %GG, %G?,
%GS, %GK, %GF, %GP, and %GT pretty formats were implemented.

Co-authored-by: Hariom Verma <hariom18599@gmail.com>
Co-authored-by: Jaydeep Das <jaydeepjd.8914@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>

Nsengiyumva Wilberforce (1):
  ref-filter: add new "signature" atom

 Documentation/git-for-each-ref.txt |  27 +++++++
 ref-filter.c                       | 101 +++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            | 116 +++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)

Range-diff against v2:
1:  ce51d8e79e = 1:  ce51d8e79e ref-filter: add new "signature" atom
-- 
2.39.0.138.gb334f1a8b9

