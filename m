Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC86C4BA28
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05AF21556
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMw4FyaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgBZUJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:09:41 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33307 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgBZUJk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:09:40 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so378446edq.0
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 12:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+ALkhmx9PbPWta5lAxlkaCU266Jj0kFtCZlFEDIWAoo=;
        b=bMw4FyaYOSKz1NqGpRBQncRvfYT9Hlm/+/2oV2UY0ohnad8FeM2/ZcpwsNpHUJ0iVB
         id5v/1dptFl+RfWYgcfWMfXzRDs9MFvDoBnZpRbjJm+WCRxxii9V8yWcsUFTAhgG+MoG
         cVz3Bj8QQTXuO5WtMlovsiGz64f1IwTkzsYC8VzBS33vDXXQlMbihN89A8dvGdZsFMMX
         r2fSNrjpoVTiLHkR+olIfaFKyN73H+Gk/6XZZEzEvjz4gt7v3Mn0adc8dGenApQdAyX2
         Uw/MfWSNtYHbRlq+7E/owOnKFQEQTMpDmeZO0VZ2mdL0W0I5tGA3LyJdxJ3aEECDEkOE
         6mCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+ALkhmx9PbPWta5lAxlkaCU266Jj0kFtCZlFEDIWAoo=;
        b=MMHZnarqrekbeuJOvbht1piizQee9TXljWbfI/kO9HWHuPVgYiG5+SfDbEg3C+66HN
         qjRQoMMUUs+42K9uoU7NHrDoY9TiuwurYxM1+oNY3dJC5URf4sFftFZaBPKIJx1q6Ueq
         0LnI/kQcEuwPCdCtCsiaxqP9yU/VWoEggazAyVFY5W/y4O9+kfb/1bNEbanS3cc98FSF
         sWoVlyowYU299aQrd0s9Gkaihq1UGP8p9N3qAuf8MIROgqqc5c71pgXedrHxlKuosJkP
         cBSGZNW1Tp0+XPRAkUQ6geSuUBVSLK8MFqCGRIwLT0ynnzrpFNdkAeJWQlCEeVQ+kZ38
         M7lQ==
X-Gm-Message-State: APjAAAWFNBRppotxc4NkOXSImYiWMIlej0JDZr+Aq4pbrHfhla+v4Fw5
        QpuTE7zib+JasYI2vmjUsqAUAoKD
X-Google-Smtp-Source: APXvYqwA7jyGpMFr7aSE/u989DL9loPzlJ2Cx23YK73WM2heEBCesvD+gK4tZNCp1rRc0CrSuMEXcg==
X-Received: by 2002:aa7:ce13:: with SMTP id d19mr117430edv.296.1582747778173;
        Wed, 26 Feb 2020 12:09:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs4sm203960edb.16.2020.02.26.12.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 12:09:37 -0800 (PST)
Message-Id: <8739f8bac0f1c0a97ac16255807514bf7eba0020.1582747775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>
References: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 20:09:34 +0000
Subject: [PATCH 2/3] ci: prevent `perforce` from being quarantined
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The most recent Azure Pipelines macOS agents enable what Apple calls
"System Integrity Protection". This makes `p4d -V` hang: there is some
sort of GUI dialog waiting for the user to acknowledge that the copied
binaries are legit and may be executed, but on build agents, there is no
user who could acknowledge that.

Let's ask Homebrew specifically to _not_ quarantine the Perforce
binaries.

Helped-by: Aleksandr Chebotov
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/install-dependencies.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index cd59855d73d..497fd32ca83 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -40,11 +40,11 @@ osx-clang|osx-gcc)
 	test -z "$BREW_INSTALL_PACKAGES" ||
 	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
-	brew cask install perforce || {
+	brew cask install --no-quarantine perforce || {
 		# Update the definitions and try again
 		cask_repo="$(brew --repository)"/Library/Taps/homebrew/homebrew-cask &&
 		git -C "$cask_repo" pull --no-stat &&
-		brew cask install perforce
+		brew cask install --no-quarantine perforce
 	} ||
 	brew install caskroom/cask/perforce
 	case "$jobname" in
-- 
gitgitgadget

