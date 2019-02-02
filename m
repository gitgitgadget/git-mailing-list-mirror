Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42791F453
	for <e@80x24.org>; Sat,  2 Feb 2019 16:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfBBQed (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 11:34:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40448 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfBBQed (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 11:34:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so10252569wrt.7
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 08:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+QScFysTr22NkpkZMXHfjY/sutiDCApDyhRd4zTx80=;
        b=tPAC2rF3aimBJYKB/7aiP0UIJ93pXJ7K51p4h1MCZMol07yGNGvXiFNju2tNjjTRJo
         BX/2D2nNdJ3cPKMLbHlAsOuOs8/MIcGlv6f8SqIaNMwoNtLMQ17xIk0u3nv1PpqW0vTi
         eRPDKFAVFmmtm8s+Kb46zlozVmemQEU8mcd1gyAHBST1P7ZEqjhH/TcmrB2yLbp7196r
         hymxniHPCi/DCIXPNBWTTZzpMvYM8CHlbf5I7F2pbWzk2hv38LbMzOxvaIzcGi7/ZI7O
         KkJzHXKzl0mmTy2Os2VwvZ2iJR990w/X5OgY3Pmm/+G0YJhtZDPKnTBF4hUvKaZuEuC9
         Lb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+QScFysTr22NkpkZMXHfjY/sutiDCApDyhRd4zTx80=;
        b=hwZNlutSEgK8K+Jb4DSemOe0+lBEzB3vj9dOofmbw+V3CoYTEERziGEgPlFZbYg+85
         eNpagVN3VpMczO4MRyU0RtnoL9AABIHaSfCzYOrMWWLhUwxInjrhsSujwXImt2HvPnvz
         wbbCCHjUiEzO2q6qH41X20z5VtV4tKLnhHDtIW0EDVUYadac1LRgPC4Fs4Sgkm5FIuKD
         3RoDPxGvhdGzJh734clX16blxksARUgJQjw8iwzEZhuwtQYtfyn+hEgQnC7ETpkX6tbB
         vJLkeX8CYiD87K3ZB/zGCSmOFfnz7MUYTHhJqB5Uoo/GCaacZ4tNwKQlYtZYeg50JbJS
         iIrg==
X-Gm-Message-State: AJcUukfdPGCA2vcKSZ36roHMjIRU2bZJyk3s6pnC2AjPvOhpEWd+UpgZ
        KVpDFh0A9rtc6DEqq4OnTsk=
X-Google-Smtp-Source: ALg8bN7EdMd4qHYpJ2BbH4ppge0qyan6278+UP/gwZnlRlwhZi/Jzc4efScM6vf1sdEyef8R3PnA4w==
X-Received: by 2002:a5d:480d:: with SMTP id l13mr45611501wrq.175.1549125271529;
        Sat, 02 Feb 2019 08:34:31 -0800 (PST)
Received: from localhost.localdomain (x4db49fd1.dyn.telefonica.de. [77.180.159.209])
        by smtp.gmail.com with ESMTPSA id i186sm9567477wmd.19.2019.02.02.08.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Feb 2019 08:34:30 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] travis-ci: make the OSX build jobs' 'brew update' more quiet
Date:   Sat,  2 Feb 2019 17:34:21 +0100
Message-Id: <20190202163421.19686-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.642.gc55a771460
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before installing the necessary dependencies, our OSX build jobs run
'brew update --quiet'.  This is problematic for two reasons:

  - This '--quiet' flag apparently broke overnight, resulting in
    errored builds:

      +brew update --quiet
      ==> Downloading https://homebrew.bintray.com/bottles-portable-ruby/portable-ruby-2.3.7.mavericks.bottle.tar.gz
      ######################################################################## 100.0%
      ==> Pouring portable-ruby-2.3.7.mavericks.bottle.tar.gz
      Usage: brew update_report [--preinstall]
      The Ruby implementation of brew update. Never called manually.
              --preinstall                 Run in 'auto-update' mode (faster, less
                                           output).
          -f, --force                      Override warnings and enable potentially
                                           unsafe operations.
          -d, --debug                      Display any debugging information.
          -v, --verbose                    Make some output more verbose.
          -h, --help                       Show this message.
      Error: invalid option: --quiet
      The command "ci/install-dependencies.sh" failed and exited with 1 during .

    I belive that this breakage will be noticed and fixed soon-ish, so
    we could probably just wait a bit for this issue to solve itself,
    but:

  - 'brew update --quiet' wasn't really quiet in the first place, as
    it listed over about 2000 lines worth of available packages that
    we absolutely don't care about, see e.g. one of the latest
    'master' builds:

      https://travis-ci.org/git/git/jobs/486134962#L113

So drop this '--quiet' option and redirect 'brew update's standard
output to /dev/null to make it really quiet, thereby making the OSX
builds work again despite the above mentioned breakage.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Notes:
    There is no conflict with Dscho's Azure Pipelines patch series; the
    patch contexts overlap a bit, but the auto-merging results look good
    to me.

 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 06c3546e1e..5968efdbbe 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -34,7 +34,7 @@ linux-clang|linux-gcc)
 	popd
 	;;
 osx-clang|osx-gcc)
-	brew update --quiet
+	brew update >/dev/null
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
 	brew install git-lfs gettext
-- 
2.20.1.642.gc55a771460

