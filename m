Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A324120954
	for <e@80x24.org>; Tue, 28 Nov 2017 16:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbdK1QQu (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 11:16:50 -0500
Received: from forward100p.mail.yandex.net ([77.88.28.100]:42059 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752241AbdK1QQt (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 11:16:49 -0500
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Nov 2017 11:16:48 EST
Received: from mxback2j.mail.yandex.net (mxback2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10b])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id D50515103A24
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 19:09:30 +0300 (MSK)
Received: from web21o.yandex.ru (web21o.yandex.ru [2a02:6b8:0:1a2d::5:121])
        by mxback2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 0Q9vD9QUxD-9UomUdRG;
        Tue, 28 Nov 2017 19:09:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1511885370;
        bh=i2wDdWQXDgJeSj3xajgTdPwoYcPI7HuQJJqqooHwl1k=;
        h=From:To:Subject:Message-Id:Date;
        b=PjyAISECH6HDkZ92Bd9nonHYFK5IRIOerxTGDrKQtAo0k7uJttvbsC91g8+NeMKLq
         1XmEwI5dqen5g6/wDTnMrQTONE2jEcTJiIylL0Sf0aVBFuTwmqxg1nE4yaPMWH4bJW
         2E+6g81VitirJQEtR7PwSZDa0eXwelhQJKnG7OME=
Authentication-Results: mxback2j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web21o.yandex.ru with HTTP;
        Tue, 28 Nov 2017 19:09:30 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     git@vger.kernel.org
Subject: Feature request: Reduce amount of diff in patch
MIME-Version: 1.0
Message-Id: <372261511885370@web21o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 28 Nov 2017 18:09:30 +0200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I get often patches which can be minimized:

@@ -60,11 +64,8 @@ sub _get_filter {
         address    =>  { -like => \[ '?',  "%$search%" ] },
         company    =>  { -like => \[ '?',  "%$search%" ] },
         country_code =>  { '=' => \[ 'UPPER(?)' => $search ] },
-    ]);
 
-    $users =  $users->search( $filter, {
-        prefetch => { Packages => { Ips => { Subnet => { Server => 'Locality' }}}},
-    });
+    ]);
 
 
     return $users;

This patch can be minimized to:

@@ -60,11 +64,8 @@ sub _get_filter {
         address    =>  { -like => \[ '?',  "%$search%" ] },
         company    =>  { -like => \[ '?',  "%$search%" ] },
         country_code =>  { '=' => \[ 'UPPER(?)' => $search ] },
     ]);
 
-    $users =  $users->search( $filter, {
-        prefetch => { Packages => { Ips => { Subnet => { Server => 'Locality' }}}},
-    });

 
     return $users;

May you please fix the git to generate minimized patches?

Thank you
