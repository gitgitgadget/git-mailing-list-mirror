Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2EDC433F5
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 14:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiDWOaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 10:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbiDWO3U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 10:29:20 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3033EC8
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 07:26:21 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso7499412otf.12
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJfeCFNmMlewxZOpySspiG6Y1Syj1HVfkWGU5rRdLm0=;
        b=Bu8T0hNyWGid5zHiukrIKIKxIjUIKS1/Wuc5dnrUuV3WIJ3azlsnbZwke1CGP7zq0o
         I7tG2IssbjsOxjOvN2x+4Bj8smGvN/JZOWIw5KOQntz0mVJ2zv1Pa1wjUiID+Bj4j867
         aYm7At7iKWVvcq7lM5FUXUDLR03j3VCKA1j+PpplQA04Zv2ng+YP1LT48qpxgsrNIR76
         KnKaKFI2AqAFow5z0i5K6/dH1lMBsLC4XUaG5XxWfin9nQTraRD6Uk6xYGm4wmJffN4/
         AJ6eFs0E3ezBTgVu/P7YTuZQgE4WCxespE24rZB6C05E8Cu5Z1UBmUCyrxBPtHkdETOp
         r0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJfeCFNmMlewxZOpySspiG6Y1Syj1HVfkWGU5rRdLm0=;
        b=dlAvk1pVP/SEOfu6k7Scl+Ee6oL7CxD146xe3y+HBUi+0ruEmF7p1BozarkTNx2dmP
         ELAJiHBCA/yZIT5euMCCG0ElxWKd0k/wQGldqatr0WYETJcCFTHuYHCSo44u0Zamdque
         HJK9AhVUhg2JgD81qyOWh+JarcS1mlH9vWJi1Rrfy4F45lchzihoK6Zn/hdAXiSIXLSg
         ECQ/akEKvNygy4DU/DYHCIB3GkHS96zXr1M2GEntkbrfXP3GQSlFFVmWrY2xYaj8ZZAL
         5gRWFdsgTNq8i3AUUaaiS5jPQJEVJPdDXet8iGo6q5Ch3IGK+NjYdQ5TF1GFFUPXDxj4
         NynQ==
X-Gm-Message-State: AOAM533lcSY3zpyxcfBEN1DGqISL/megd0XBHxvvD5Ct++fUUJoEKWmA
        ogmJirlo/sGI9ODURsLJtmQhqZTa368=
X-Google-Smtp-Source: ABdhPJw31xtieQefLUNyq0c5SGPFsrE8XBSO2n0ZO9of076lJxfYyre1vgBCyfW+Lgwk6X7rmY3acQ==
X-Received: by 2002:a9d:1991:0:b0:5cd:b2a1:5c50 with SMTP id k17-20020a9d1991000000b005cdb2a15c50mr3683024otk.217.1650723980405;
        Sat, 23 Apr 2022 07:26:20 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s4-20020a0568301e0400b006015bafee43sm1869993otr.46.2022.04.23.07.26.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Apr 2022 07:26:20 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 2/4] ci: avoid brew for installing perforce
Date:   Sat, 23 Apr 2022 07:25:57 -0700
Message-Id: <20220423142559.32507-3-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <20220423142559.32507-1-carenas@gmail.com>
References: <20220422013911.7646-1-carenas@gmail.com>
 <20220423142559.32507-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perfoce's cask in brew is meant[1] to be used only by humans, so replace
its use from the CI with a scripted binary download which is less likely
to fail, as it is done in Linux.

Kept the logic together so it will be less likely to break when moved
around as on the fly code changes in this area are settled, at which
point it will also feasable to ammend it to avoid some of the hardcoded
values by using similar variables to the ones Linux does.

In that same line, a POSIX sh syntax is used instead of the similar one
used in Linux in preparation for an unrelated future change that might
change the shell currently configured for it.

This change reintroduces the risk that the installed binaries might not
work because of being quarantined that was fixed with 5ed9fc3fc86 (ci:
prevent `perforce` from being quarantined, 2020-02-27) but fixing that
now was also punted for simplicity and since the affected cloud provider
is scheduled to be retired with an on the fly change, but should be
addressed if that other change is not integrated further.

The discussion on the need to keep 2 radically different versions of
the binaries to be tested with Linux vs macOS or how to upgrade to
newer versions now that brew won't do that automatically for us has
been punted for now as well.  On that line the now obsolete comment
about it in lib.sh was originally being updated by this change but
created conflicts as it is moved around by other on the fly changes,
so will be addressed independently as well.

[1] https://github.com/Homebrew/homebrew-cask/pull/122347#discussion_r856026584

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 ci/install-dependencies.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 41e9290fbdd..9da03350d09 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -37,13 +37,14 @@ macos-latest)
 	test -z "$BREW_INSTALL_PACKAGES" ||
 	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
-	brew install --cask --no-quarantine perforce || {
-		# Update the definitions and try again
-		cask_repo="$(brew --repository)"/Library/Taps/homebrew/homebrew-cask &&
-		git -C "$cask_repo" pull --no-stat --ff-only &&
-		brew install --cask --no-quarantine perforce
-	} ||
-	brew install homebrew/cask/perforce
+	mkdir -p $HOME/bin
+	(
+		cd $HOME/bin
+		wget -q "https://cdist2.perforce.com/perforce/r21.2/bin.macosx1015x86_64/helix-core-server.tgz" &&
+		tar -xf helix-core-server.tgz
+	)
+	PATH="$PATH:${HOME}/bin"
+	export PATH
 
 	if test -n "$CC_PACKAGE"
 	then
-- 
2.36.0.266.g59f845bde02

