Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFD01F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 12:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbdB0Mju (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 07:39:50 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35535 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbdB0Miq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 07:38:46 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so13210030wmu.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 04:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ww2fvHd/1inAQWw5Sk1Yno5fdVjHhF13k/sdu97jqwA=;
        b=POobJAswLGNMOpcm8A3RrrH2VpOcdyalKWu//FXYyIorks5ofWQUekaLOjNfMSh/r6
         7O27/rLWWdZ9ECa6Zfp/aRnJMNkAvTKbiBJOjs/WrWekJ9oq04oEJWitSgz98z1uHIMj
         AEL4waW5c403+zG5sLUH35Yfs/6CRHqcX9Eti7u6oD0PT6nW8MD9a0O7n0nNDSNvqAJ/
         vF2pX2mZHNmPRqJSVL16enFiisvUVlJAFN2jd277wnVdfVDkjUhmdb457A+kDHFOblbA
         2zhh3bNaThvEhcJb5zke0PSgZiCSB5lPsJgSW9eYjyThlRpM9AqXFqsnraHBExjalzBW
         un5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ww2fvHd/1inAQWw5Sk1Yno5fdVjHhF13k/sdu97jqwA=;
        b=XXRYB9b56xPLHKgDk5QvbTKhoHbFeLNLocDYdVoNnKPhwGJlqkm5K5de7HAHPKM8QC
         7dzevMV4J5z7GQFpNt9b+I5OjOrZaCbX4yJX3im7UQ+UWN97HuUp9lo3dBHO9dd7IUbu
         mEe0tzXtU4VH8BlBryO8MM6hJqDosvYCl2ctYTQ43Cglnmko2t29ruYJpk8H1tFkj3cC
         OvbdoAKmLVV4/IcXEJR9yTEziGSRLjxzSHraw7l/ffE4swlrGS7ZSzhM9ElNd/jR3dm9
         rnVaTe4dJ0iM/kiM016T0BAHRttLC3CRY7MKwz+LuU30rg5wr2NUU7YZ5Ecf9Na3l6Hm
         WCpA==
X-Gm-Message-State: AMke39njq3SNkYKXI3/6619afgEv8vDV/FoN/aN8tTkKvSs8zfE+wemErXNzBSe9qt2BkQ==
X-Received: by 10.28.6.210 with SMTP id 201mr13992535wmg.85.1488199054272;
        Mon, 27 Feb 2017 04:37:34 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 136sm14121714wms.32.2017.02.27.04.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 04:37:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] gitweb tests: Skip tests when we don't have Time::HiRes
Date:   Mon, 27 Feb 2017 12:37:20 +0000
Message-Id: <20170227123720.8493-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the gitweb tests to skip when we can't load the Time::HiRes
module.

This module has bee in perl core since v5.8, which is the oldest
version we support, however CentOS (and perhaps some other
distributions) carve it into its own non-core-perl package that's not
installed along with /usr/bin/perl by default. Without this we'll hard
fail the gitweb tests when trying to load the module.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/gitweb-lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index d5dab5a94f..116c3890e6 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -114,4 +114,9 @@ perl -MCGI -MCGI::Util -MCGI::Carp -e 0 >/dev/null 2>&1 || {
 	test_done
 }
 
+perl -mTime::HiRes -e 0  >/dev/null 2>&1 || {
+	skip_all='skipping gitweb tests, Time::HiRes module unusable'
+	test_done
+}
+
 gitweb_init
-- 
2.11.0

