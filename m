Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21D41F404
	for <e@80x24.org>; Mon,  3 Sep 2018 23:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeIDDsG (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 23:48:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44058 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbeIDDsG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Sep 2018 23:48:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8044360756;
        Mon,  3 Sep 2018 23:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536017142;
        bh=Y2NrRKJEQKltaHb7O82w75UnZtrHvW4M8xwPHQly+uM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Rj4E85dOL7c+fVTxiXTKhDJ3VNiPaz32eJjUjMopIENpUN5vRLh/W+LBWsNqZ+VPh
         5WoIn3ZJ5AHTKBWomwdRUqcbhGWoeKk2FDKhgXnBR3iQApvAeUhUHO+vjQE+83jdGg
         hw85SyVTc3Jzc1edjDmFYtrTE7T/we9LGBiF1xkQqSn5I8jQEKK7WDOwZPdl2yL/KR
         MSV9Tejz3eTPBUfDwhqWBPz5+3vlJaEhtHnOXb0XkdfmfMsjefiUyZJfkfunQ668b0
         ssnRKvQ31/l+0/yHsPsIs92nGrpZ9lxzZ5ld/A2kHEgaK6LDJ3Ga0Y0N1tn/t6iQ2W
         WrGk6p1JFM6tj33b/fO9njGQ9FgtfZiq3m+F23out04cDucwGJzzD1GKON44cwD3/Z
         QZ5S3Ymv4mrOrLUHQhKNE1/qa6cswgYjKawt0oPXWfme9qLP3dSfoXD9/9EnQGkGWP
         Fl0u7pxmKdoFHShOvM8pFOg2RT4xJ5AzWMkh5Fjv2G4HCX0wql0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 08/12] t1400: switch hard-coded object ID to variable
Date:   Mon,  3 Sep 2018 23:25:11 +0000
Message-Id: <20180903232515.336397-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180903232515.336397-1-sandals@crustytoothpaste.net>
References: <20180903232515.336397-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch a hard-coded all-zeros object ID to use a variable instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1400-update-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7c8df20955..6072650686 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -346,7 +346,7 @@ test_expect_success "verifying $m's log (logged by config)" '
 
 git update-ref $m $D
 cat >.git/logs/$m <<EOF
-0000000000000000000000000000000000000000 $C $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
+$Z $C $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
 $C $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150350 -0500
 $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 -0500
 $F $Z $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
