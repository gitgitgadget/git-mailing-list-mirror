Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473BCC33C9E
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 14:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF4520731
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 14:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfLfUGI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgAFOuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:50:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56254 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgAFOuR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 09:50:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so15219393wmj.5
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 06:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xhTwikvtZHRWQsG2cYEFjqDCuiscC4LgmU/OsixccWw=;
        b=sfLfUGI2EakTjOQsY2vAgrFSBRK28QEurS9TjklgR9mMO5rTeAExRn5967hRfFCTt+
         vLSvaps++PN+q2Tq7Z+5UArKXAAvSzbq7bW9+3CWurKei4UtBKEBi3GUuaAJupfVK5U6
         ftXieIGOq/1FfDTb+7fFrBAx9nmGwMJ4CLhYpqniC8Jcm8/+G2bxONK5X7QkrlOHs6/t
         DSwbUi3l7IMwY+4J4wJjU0LO6H/KD4PIj6LdPRh1oXt2IaUx0P21ddPoJ32rCgliakri
         qsTIWmpVWiFZdlR/kEnZqAFVCYm07fYfXT02PaIWEsDfJT5zSZGIAt9gMWIgq5JzYzxP
         FMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xhTwikvtZHRWQsG2cYEFjqDCuiscC4LgmU/OsixccWw=;
        b=Pml9gZTPDHg9QnhguR/z00rAmG6KuCCAJCkAvKiaGcT3naw+g9BoUwCxnIc6o1maYS
         DOe126LhgxAPvpxOzGC6F9E/Mnif8EW4GrEOrv/7j1673KtbUtyo1fNCUPuvGVCIdbmH
         xWR8Df0W5RWRWGBEaFYVA0lxpZ5KG3cphEoj2lcTmE0PJ/7i9Z3pt5fk9ykNukTqSl58
         HVWn2yiwMw02izhwwqon+LVBQdmP7a9vgjjunhU+C9/vqYPm6uXenUo8n3b/kz96zRBu
         pdAOOPUuURJweCi0GWWi/7Qaz7cBxac/TerOzmzgxHdAjEw6Cgd1WuZbOFGiYDFFSK5r
         iqkg==
X-Gm-Message-State: APjAAAXsrurSvdmbdPMlEIbG2vr1uwcUTO4WwD2H2fPLJut3WXwIn8hc
        mOaaxfS0X7HY5maAB14aFDs2YBd8
X-Google-Smtp-Source: APXvYqyNnU+pPzlz0+t5pVvrlxh38ufincuVoo80u5USTh/QWbJdqpDUcL7TyTJY1+i+jmn52QFn9w==
X-Received: by 2002:a05:600c:1003:: with SMTP id c3mr34244189wmc.120.1578322215368;
        Mon, 06 Jan 2020 06:50:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm71410412wrq.22.2020.01.06.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 06:50:14 -0800 (PST)
Message-Id: <b032358ca97df3bd5605ff356196f82a1f16a320.1578322213.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.688.git.git.1578322213.gitgitgadget@gmail.com>
References: <pull.688.git.git.1578322213.gitgitgadget@gmail.com>
From:   "elonderin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jan 2020 14:50:13 +0000
Subject: [PATCH 1/1] doc: submodule: fix typo for command absorbgitdirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     thomas menzel <github@tomsit.de>,
        Junio C Hamano <gitster@pobox.com>,
        elonderin <8225602+elonderin@users.noreply.github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: elonderin <8225602+elonderin@users.noreply.github.com>

The sentence wants to talk about the superproject's possesive, not plural form.

Signed-off-by: thomas menzel dev@tomsit.de
---
 Documentation/git-submodule.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 22425cbc76..5232407f68 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -248,7 +248,7 @@ registered submodules, and sync any nested submodules within.
 
 absorbgitdirs::
 	If a git directory of a submodule is inside the submodule,
-	move the git directory of the submodule into its superprojects
+	move the git directory of the submodule into its superproject's
 	`$GIT_DIR/modules` path and then connect the git directory and
 	its working directory by setting the `core.worktree` and adding
 	a .git file pointing to the git directory embedded in the
-- 
gitgitgadget
