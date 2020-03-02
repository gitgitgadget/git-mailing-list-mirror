Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502F5C3F2D7
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 20:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2735621556
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 20:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2Xxg/at"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgCBUCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:02:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36788 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgCBUCH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 15:02:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id g83so428778wme.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 12:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nizt8aRM+2ERMtcFmTNEg/faUdfAELRMcF3S6Hexb1s=;
        b=u2Xxg/atvi/Y/vnAZHjZJyKRTLTI644D6esuRyvBJPiCmNLSFkQhyUTRzKjxfJlJHd
         PQGFvjANY6P2Nxqtxr523U1ZoMC6Yc2wTKnulkNLp3ugkR9oFOanwbCdCPi0eR30U3HB
         vCeCmMAXctIaLStsB2vAk/YOASGVk9ouWzA0TCZ8LugwgKYO5mGn++LEjV4kUuZCwr7W
         f3OnKJNWpAt+S+KjvXPVpWDZAj1IZMdfEYiQYM8qeiN3zxgK0CB5fhSHI6HvwX1AY0F8
         9Rh+WSwJzp7kBJrtaTUnGR4cthZ8Mb02agTRzIPYXmVFqwCeGUEimlOetWRehw04yqa8
         pkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nizt8aRM+2ERMtcFmTNEg/faUdfAELRMcF3S6Hexb1s=;
        b=rQtttF4RZxfSVjLUn/NbiQwEmJBTSzcRkTDwNd4AXYwyiKXmJRW7V6SsfGef6Nexjy
         BueiNAiUHoSIBk8n6MoHdgGDLJCyob6kwUKXWObcIu5ZcUfGPvIKuVGqVhW3aYjvuG51
         JzAE5f5+7I2nr0tx8BZbMUuobqUoRqTfQJvIkT6ZVKyf8euxcBOMkhmN6gw9LkcPtv7E
         icSkEvLOwe/676UbkGmIvD+J8fF8eU7cfHlm3iFSFMhCQ21rv4apUizb2D1qV0XN1RsX
         6nAGf24JG5xl96m0l/KwbbmCh98j3YYxzT9cx6rEQUi4T5BGgQEPGMp4Ucnot/q9Nfkm
         jKEw==
X-Gm-Message-State: ANhLgQ2SFYoAIQ+WSneQxVDfES2qKkgq7SKIAC6H7JTeBj8TpnZhr16z
        bdJtNgwKvXEYI06KblLV0Zj3LqWw
X-Google-Smtp-Source: ADFU+vuJ+K9bmEB9wqCg3KITj/2PLCARNLNrou/YrVxeYrbHqtP7XgjXX78KXoIkh/JP5mXUpjBVlQ==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr118147wmb.126.1583179323786;
        Mon, 02 Mar 2020 12:02:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm72277wmm.15.2020.03.02.12.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 12:02:03 -0800 (PST)
Message-Id: <828b4aee19d09218beca6ad1d93006012be99a0a.1583179320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v7.git.1583179320.gitgitgadget@gmail.com>
References: <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
        <pull.548.v7.git.1583179320.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Mar 2020 20:01:58 +0000
Subject: [PATCH v7 2/4] advice: change "setupStreamFailure" to
 "setUpstreamFailure"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

fb6fbffbda (advice: keep config name in camelCase in advice_config[],
2018-05-26) changed the config names to camelCase, but one of the names
wasn't changed correctly. Fix it.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 advice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index fd836332dad..258cc9ba7af 100644
--- a/advice.c
+++ b/advice.c
@@ -80,7 +80,7 @@ static struct {
 	{ "sequencerInUse", &advice_sequencer_in_use },
 	{ "implicitIdentity", &advice_implicit_identity },
 	{ "detachedHead", &advice_detached_head },
-	{ "setupStreamFailure", &advice_set_upstream_failure },
+	{ "setUpstreamFailure", &advice_set_upstream_failure },
 	{ "objectNameWarning", &advice_object_name_warning },
 	{ "amWorkDir", &advice_amworkdir },
 	{ "rmHints", &advice_rm_hints },
-- 
gitgitgadget

