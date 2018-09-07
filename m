Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66BCD1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 03:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbeIGH66 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 03:58:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40232 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeIGH66 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 03:58:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id 207-v6so13049073wme.5
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 20:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eh1Lvy6Bz0MykVtPapppxuw1mxho/2RfSFp0WeSkcsk=;
        b=GQTBCUqNMB254zXTPq2RQg79+aTV57hvJhP/B3L8nuEm+JY3FjOn1g3ayaXYsaHH/y
         9utTZKNA2TW5mbJvmiE2+hDXzxiYr218Yz7rFT7g5kkjLas8A8WDDoak94nj6lsLeGBE
         KZrbeUG+OBcIdIiUlkHMma0JQKsVc8dlGLV1GnmomA25m33Q64pfhKSFM1GsSkJ0cKEK
         Uo7rzbXY9CK9nMnKsM93abOwvBJ4J19Unq/5hDrReR23cb4V0yxYoKO29puskl07le9e
         tZ3j+I6YrWI5RHPjWyzt4MyvFnXVsLqdGf48kugP+UUp8v1I+njlaa0XufMP7g4CGJnR
         ecFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eh1Lvy6Bz0MykVtPapppxuw1mxho/2RfSFp0WeSkcsk=;
        b=O1kZlwkPJgdcCvuqtv9iYRclcEs6x6eqshSIqY+XxV5c0VOraBbDfIGE32SclJfMRS
         zjgQZ0EGxSO/xfj+dMdRrjQbwgSwRDDWQzlurqMcwLb/tgTHlxeCPHFCYZ+IjqgdEAJn
         gHq+2x1ybIJHr/Gf7t49OtkcyxjRmYZVLS7n8mI41VEoTW5Nbq9/MpGmLjupIVuKHGeR
         rydqZXhtHgH8XwdqfCmcRqhPQges6Yi4P3fWWB8ByH6mlXcrtWSmK96D2bMQNjMJpz+G
         d8+dXCGxCyBjC7jmr5l1OWPAFB+n00ZAB0Y22oQsrAWQquDSiVAT2+4gaYgbAOtrwR5t
         mSBQ==
X-Gm-Message-State: APzg51CJOzrKdW1PBtzTAXAdL4HgWEdyWGZxn0AVzLUGmc8GRuCcHNoP
        wDpDEUDxRVDIfAaH89Nq3uXselEU
X-Google-Smtp-Source: ANB0VdYDIwdKGIcuUfSw7Q/Btraf4IPrZRoX486AQ2GHjKTbxrsaMkYUgi1YvwKC8XhVX8MRtc6TvQ==
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr4197964wmm.117.1536290414848;
        Thu, 06 Sep 2018 20:20:14 -0700 (PDT)
Received: from localhost.localdomain (x590e1a0d.dyn.telefonica.de. [89.14.26.13])
        by smtp.gmail.com with ESMTPSA id q5-v6sm8802004wmd.29.2018.09.06.20.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Sep 2018 20:20:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH] travis-ci: work around quarantine error during Perforce install on macOS
Date:   Fri,  7 Sep 2018 05:20:02 +0200
Message-Id: <20180907032002.23366-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2.140.g09cf9e37c9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Homebrew recently enabled the quarantine feature, which breaks a lot
of things [1], including installing Perforce in our macOS build jobs
on Travis CI [2], breaking all those builds in the last couple of
days.

The suggested workaround is to install affected packages using the
'--no-quarantine' option, but adding it to the current command, i.e.
running:

  brew install --no-quarantine caskroom/cask/perforce

doesn't work, because apparently the '--no-quarantine' option is not
propagated when the command gets converted to:

  brew cask install perforce

(unlike other options, e.g. '--verbose', '--force', and '--debug',
which are propagated properly).

So work around the issue by installing Perforce with this command
instead:

  brew cask install --no-quarantine perforce

Note that one option homebrew/cask devs are considering is to roll
back quarantine altogether [3].  We might have to revisit this
workaround if they eventually end up doing that, as that might remove
the '--no-quarantine' options as well.  We'll see.

[1] https://github.com/Homebrew/homebrew-cask/issues/51554
[2] e.g. https://travis-ci.org/git/git/jobs/424552274#L1246
[3] https://github.com/Homebrew/homebrew-cask/issues/51554#issuecomment-418923763

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

I'm not quite sure how to handle this issue.

First: I don't have a Mac, and this "cute" homebrew talk about pouring
bottles and tappping casks in the caskroom makes my brain hurt; so I
was just following instructions without fully understanding what I was
doing.  Nonetheless, this patch apparently makes the macOS build jobs
work again.

OTOH, this is only an auxillary part of Git, so fast-tracking it is
fairly low-risk, and by doing so we might have an all-green CI build
before the 2.19 release.

Finally, if we wait long enough, then this whole issue might just
solve itself, if the homebrew devs revert this quarantine stuff, and
our current 'brew install' command might suddenly work again.

 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 75a9fd2475..ca99044b20 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -30,7 +30,7 @@ osx-clang|osx-gcc)
 	# brew install gnu-time
 	brew install git-lfs gettext
 	brew link --force gettext
-	brew install caskroom/cask/perforce
+	brew cask install --no-quarantine perforce
 	;;
 esac
 
-- 
2.19.0.rc2.140.g09cf9e37c9

