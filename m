Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98635C4BA2D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 13:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0B721556
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 13:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmNQdgCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgB0NXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:23:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38955 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbgB0NXS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 08:23:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id m13so3228439edb.6
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 05:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+ALkhmx9PbPWta5lAxlkaCU266Jj0kFtCZlFEDIWAoo=;
        b=rmNQdgCWvVZTXS6zudt9zsETm48E2joWvOYLxtVntXeIipkjhKn0R9cDWNB9sp30b3
         FrefAqKkfYspTEMqmFz8+UvU6fLaS7kamZkVqiQslq64mcs9RelY4bqnWQmEEa2NwRc3
         GJeOlKkR0d652Agj0FhZfavPB9SJwwPrlH0YmOVO9yKdK/BtX+Q/pFpOVDc02SATi1uR
         yCS/P50xe/vxbfxsYS4v0wi5VE/1C6G+6hLe8VKjJF+8cNYHNsAAhc06yyCPwWneHPYV
         A0ETrvPSAotDvfZsagEr/hJiJ1neaU2rK1p9o70Pi4soVzSYHf8cVcyUIEU1Sya5LrYv
         DuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+ALkhmx9PbPWta5lAxlkaCU266Jj0kFtCZlFEDIWAoo=;
        b=YEmuGeNvn+a/qrOOevti9jOnHALPSipcElK9sQckRVVlQV8fhE2pyU6DV+faNuY3nQ
         bCTX/FTz8MNRxJPp8QW9+IMhFrD/zMcRF4aWFMEs9sJshXTtLqh4HJ+vz2UsY/MoFkPn
         4CP4jMnlpsZZDKUaR6+mwtvtgFKlpZK3OR0GN5FYIdOKfQHocOE19iXS2IPeFOA/iRkn
         xFE92DAclHuVbTMjNI9YPUENbXTmY2AYe8Gu20KiOlpd6TsyDI+J7H2H2QzvMVMQliBr
         TMZOzPg7znFzRf8C/srnXYPYjobNCxNNaxfweEAiXyUtHxZzVBs/hgZjJMdKAg/kituo
         ZW6g==
X-Gm-Message-State: APjAAAWMS3qUslBUykD0K2qC8dNE75O++CkGb4myUAGyXpv+sc3hv87X
        XdDLBAK2jSzWU+oFOHOcoNdYXerU
X-Google-Smtp-Source: APXvYqxkcdpqz6MLpob4OCJkUobzxkTpCgeNxbDyXLk2YMZUi94uHglJneG9wWQP/d6TxTVjHRKKxA==
X-Received: by 2002:a50:9f8b:: with SMTP id c11mr4163532edf.165.1582809796593;
        Thu, 27 Feb 2020 05:23:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm348716edm.82.2020.02.27.05.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:23:16 -0800 (PST)
Message-Id: <5e5fcf3b76b58cb71546f8a2e61c934f64afca98.1582809793.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.714.v2.git.git.1582809793.gitgitgadget@gmail.com>
References: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>
        <pull.714.v2.git.git.1582809793.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 13:23:12 +0000
Subject: [PATCH v2 2/3] ci: prevent `perforce` from being quarantined
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ed Maste <emaste@freebsd.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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

