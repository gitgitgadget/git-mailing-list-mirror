Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822DA1F404
	for <e@80x24.org>; Sat, 31 Mar 2018 18:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753115AbeCaSFV (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 14:05:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34000 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752992AbeCaSFU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 14:05:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id w2so932550wmw.1
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6UhMwaDQyBiBHgLaUfa+iGZTuApwp2ayphDUzxCvHo=;
        b=m3j7kHL/Ea46FOwGbkw4T7fMGYIowDEwrs4ERhYwUh5ER/I4ycMWV9G4+9rYIjAnQL
         FKqn54O/F0yzIx/xykqRcj9qJitFHaawog4tBA2ndTSSqeWXog8vbQm4eoaD+npEcjIW
         uj5kmdKskz7B7YuJ+8LUiRDA256iSGDghRCE/M2q1y4vwvPsRNVI+1no92Q72A1m1aT4
         T97oIK1PUmUlo6RZXo6RWa4y0sh2glDxLojWIQktMZr1tTW0IzPn+CHnPLZnEYXM8rrg
         GOAkmCPNgyH9Cf6NDg2CjPMHh5t1B70lunlVqxsi/OK8T5ZJCvoAKqhXF2N5xhF6shEv
         IEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=z6UhMwaDQyBiBHgLaUfa+iGZTuApwp2ayphDUzxCvHo=;
        b=p3+StHQKmLG/qQAYhiN30fDH1600MIvKUeohvLoAZ03M6KNT9GfhfCq/0rXQ2J24R+
         uD8XLfMLPNRGNRaZxBXlBb3Axz36aT1STZ6cZ/10CwP+6M9qrf/ckUkSE3x0cO6PKuwE
         7sPkRau2Oyg22h0vDp+FfT5IL4guGx+UH2BEiRMz1BdEBDn/NXBaizZk92I8fNDfTjs1
         XhuLJnbex4l3Q+G1Pz5FsZJ3Q7HANjVH6HgPq2DBuxLNU+hNTj7i4FzMuDUMf3tfJMBh
         ydnJuOmn3I04IWqbFDdvCWXZ5MAdircD4r6n+o98XUEV1sCkw2pdSNhDZuDfvhSVtlXC
         KyAg==
X-Gm-Message-State: AElRT7HVDGiEjKzmO/L4SLOPN76XCm1sUWtBQITDMeEkTW5akcLvws0J
        MgcboC9lQgRvTWoQXHIR+c1fsv2L
X-Google-Smtp-Source: AIpwx4/GkMOwN2lx9oTBC95F3R3oT0BiObO5CBHaqmGfpsnlQFmJ/Ve2lG9DA3G/RdpA815Mxp/DXA==
X-Received: by 10.28.126.69 with SMTP id z66mr5110927wmc.56.1522519519281;
        Sat, 31 Mar 2018 11:05:19 -0700 (PDT)
Received: from darkstar.home ([2a00:23c1:ed80:4001:2f9f:42eb:2064:5ffa])
        by smtp.gmail.com with ESMTPSA id b13sm6743011wmi.42.2018.03.31.11.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 11:05:18 -0700 (PDT)
From:   Michal Nazarewicz <mina86@mina86.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     =?UTF-8?q?Micha=C5=82=20Nazarewicz?= <mina86@mina86.com>
Subject: [PATCH] send-email: report host and port separately when calling git credential
Date:   Sat, 31 Mar 2018 19:05:14 +0100
Message-Id: <20180331180514.14628-1-mina86@mina86.com>
X-Mailer: git-send-email 2.17.0.rc2.5.gf079eae27
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git-send-email uses git-credential to get SMTP password, it will
communicate SMTP host and port (if both are provided) as a single entry
‘host=<host>:<port>’.  This trips the ‘git-credential-store’ helper
which expects those values as separate keys (‘host’ and ‘port’).

Send the values as separate pieces of information so things work
smoothly.

Signed-off-by: Michał Nazarewicz <mina86@mina86.com>
---
 git-send-email.perl | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2fa7818ca..2a9f89a58 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1229,14 +1229,6 @@ sub maildomain {
 	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
 }
 
-sub smtp_host_string {
-	if (defined $smtp_server_port) {
-		return "$smtp_server:$smtp_server_port";
-	} else {
-		return $smtp_server;
-	}
-}
-
 # Returns 1 if authentication succeeded or was not necessary
 # (smtp_user was not specified), and 0 otherwise.
 
@@ -1263,7 +1255,8 @@ sub smtp_auth_maybe {
 	# reject credentials.
 	$auth = Git::credential({
 		'protocol' => 'smtp',
-		'host' => smtp_host_string(),
+		'host' => $smtp_server,
+		'port' => $smtp_server_port,
 		'username' => $smtp_authuser,
 		# if there's no password, "git credential fill" will
 		# give us one, otherwise it'll just pass this one.
-- 
2.16.2

