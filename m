Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ABFC10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 14:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F7E20773
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 14:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJUBM7MC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgCROWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:22:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34065 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCROWA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 10:22:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id a23so11267586plm.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcRGW1Kj3r8w02vcs2uaPr3kkYyYz96D2LaVOa/vwmc=;
        b=VJUBM7MCYLESpNa4fLq/v3vvcEBBe3njJo3WgQkqUDYffEB42AM5Mcccct1mkRlD0Z
         dOexs9qI8O4JlMrTWuCld4rjvFIK5IZD0DmajWF9opKWIgGX1nPv+9Ab7qOAlFpyffKV
         wHUIBcNI1Giw68Qtap5Cre2nT4KioE1cX58uIa9qi+9yTV4IOaAv4EjNzDTHwyAVqCCK
         xlwq4FAa4pCOCsXc14siAyCZans6GRgbbdiwb7s9XLt7VMyHCEefAvWFm5/T2PIQEDB3
         bvGTAL3oZe55UEgjfl+sdOyeLSR8eSo09Bco9jDEOKxIu+8PO0z28hyn6G/KH0POjYSw
         gBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcRGW1Kj3r8w02vcs2uaPr3kkYyYz96D2LaVOa/vwmc=;
        b=TcAIUcDCSsecSTQH0dqQmoE6b3CPSaKXR0seZpBnk2kq5RxZTN6JSQ4jnNXJ9qMRND
         ipZcFv2VsZvQ5UicTSVqrjo2bcnn7f3sASPMeif8+qNrPMbagcjh1kWWsLuEKUWYunly
         /gZkBX/gOBEgtR1bYeqnJSXGg5DaOx2rWUbh94ebMjGnXPaP/JJydQ+ez1xQfH47Ez2K
         GL2WsmsA9y9lBQdwLQWpOyLd73Vxt8xp6m9dSXvY1iV8vaAYoHmTycHGciLsqw+23bzy
         YvAe3pY8eU2NTVlJosc2Yn2hqz3AG1NZkO6qr+icZFSHBDkFD+kBreIDdfglUmvAoNUU
         Vqaw==
X-Gm-Message-State: ANhLgQ3zm54wdjf+Ixo2gK4UHOcHReFiaB/80gtWp4xYBotVoMRWT/4e
        ND6ZM6ICbPuVsq9sWeumg+qN66fhnPtEqg==
X-Google-Smtp-Source: ADFU+vsw3PMJ+/qopgGxAh6nPn4u0LHCgePIgHNdPyxxcMiI99qMY2fN07VL/Yi4Ze4I9jZZG4ttxQ==
X-Received: by 2002:a17:902:b096:: with SMTP id p22mr4097194plr.262.1584541318703;
        Wed, 18 Mar 2020 07:21:58 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id q123sm4004948pfb.54.2020.03.18.07.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 07:21:57 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v2 0/1] submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
Date:   Wed, 18 Mar 2020 19:50:23 +0530
Message-Id: <20200318142024.16681-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318095842.27679-1-shouryashukla.oo@gmail.com>
References: <20200318095842.27679-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subcommands in 'submodule--helper.c' which give a callback to other functions
have structures and macros named in the format: 'subcommand_cb' and 'SUBCOMMAND_CB_INIT'
respectively.

The subcommand 'foreach' did not follow this convention and therefore had the naming of
the form: 'struct foreach_cb' and 'CB_FOREACH_INIT'. Rename these to: 'struct foreach_cb'
and 'FOREACH_CB_INIT' respectively.


Changes in v2:
	Reworded the commit message. The last statement was wrong.
	Changed it from: 
	"Rename the aforementioned structures and macros:
	'struct foreach_cb' to 'struct cb_foreach' and 'CB_FOREACH_INIT'
	to 'FOREACH_CB_INIT'."
	;to:
	"Rename the aforementioned structures and macros:
	'struct cb_foreach' to 'struct foreach_cb' and 'CB_FOREACH_INIT'
	to 'FOREACH_CB_INIT'."


Shourya Shukla (1):
  submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'

 builtin/submodule--helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.20.1

