Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0EDC433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 02:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9481061A42
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 02:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhCZCof (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 22:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhCZCoS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 22:44:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A8C06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 19:44:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v4so4173044wrp.13
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 19:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lc/JyTXJJMLuGgKILtCQRGF+CRBcOASMgVsIm7HwuJc=;
        b=V6ggUNtmECZtIPYxyUNq2EUy+ugHBS657y4ivNON/9OQoxnc2Uj7dP/GmGaSN0BPXr
         qvSW5BL3iIY/QSxpghlMac6t9Ql3oZTFhAgzyNp22U5RARzXPn3AjIG1ZDnyOLDh8oTD
         SA9n1BgGDKOML4w8rG3DG3xzj6VweEUWeCJvOdIvW4koupIz1SWFL9EupZaTSFTP8Fv3
         t0Km3Hai3W6IQq3kdsEmQjAS2JxEbnnP8seR7BRoV0IhoafB1qNb0wGVnwXvB/kS2Txt
         PfKLoBl1B68TT3KECHh02R5a/ZA1mNx0KaA7f9OdrxxibBIRgGB2PVlQqIadPNGhnjcp
         3E+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lc/JyTXJJMLuGgKILtCQRGF+CRBcOASMgVsIm7HwuJc=;
        b=Al2aczC3ANG1eGkJ+QozMTB5YiUiYyDWcYfWQlKCyIZjnlYydfZIO9wzEPCs8i4e4U
         fwhM4kGwWnx3zNDpWVMYIcp6jNPAizC+WcYm8xkAauDptCns39QQ7wk96clFjBX9sOtW
         seKc4X+9P93LHMB0LLCm/w98GnaYZ46rpqRT0q0zyrkQ7HUzE4Zz49uyRWl1+/+IWYIa
         y/FPl7JKxT1bDtkXskvgGhjtPYDcUjvRFco93GBOC+QX2ksYVEf7g8NHEykXctKulnT7
         fka4jp+oHbM5RoWfEIHA8oZSI2wZzY0W1xgIF6ogGKiGpEnqhHtT8Qj1omLsRJV81ECa
         gepA==
X-Gm-Message-State: AOAM530gIYMVn0nPbvdv9dYnrHtDZ98qimBNgVr9OC3QmfeiaTfhEsGw
        UhvmkRTLhZkTWNXzY3adw5xccMFOx6gJtW58OaM=
X-Google-Smtp-Source: ABdhPJxeJCn8ITNy6y0rIr4peIdBVOqSP13QHxYGly0tPo0VObGq87DA02BIsmKBQNHDxPeS1kJlFQ==
X-Received: by 2002:adf:a40e:: with SMTP id d14mr11596860wra.44.1616726656039;
        Thu, 25 Mar 2021 19:44:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id m2sm6748579wmp.1.2021.03.25.19.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 19:44:15 -0700 (PDT)
From:   "=?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?=" 
        <stdedos@gmail.com>
X-Google-Original-From: =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= <stdedos+git@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= 
        <stdedos+git@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: [RFC PATCH v1 0/1] pathspec: warn: long and short forms are incompatible
Date:   Fri, 26 Mar 2021 04:44:10 +0200
Message-Id: <20210326024411.28615-1-stdedos+git@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <xmqqft1iquka.fsf@gitster.g>
References: <xmqqft1iquka.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>

The second of the two issues identified in this thread.

Both patches work as expected.

There is a short solution, which is mostly okay.
It does not compile with -Werror, but:
It avoids malloc/free, and keeps the logic/sloc low.

All of this could be my lack of C experience.

Stavros Ntentos (1):
  pathspec: warn: long and short forms are incompatible

 pathspec.c                  | 30 ++++++++++++++++++++++++++++++
 pathspec.h                  |  1 +
 t/t6132-pathspec-exclude.sh | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

--
2.31.0

