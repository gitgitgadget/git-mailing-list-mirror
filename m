Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E61EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 10:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjGHK4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 06:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGHK40 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 06:56:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51371994
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 03:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1688813784; x=1689418584; i=georgmueller@gmx.net;
 bh=q60/u+I/pOWM4O2tlM5iUkHt4LKiMEjFtM8gLwheHF0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=l8dnv25SRcHa/A0Rvrjuwycqu5spl1hh8qTJR4sR2maSGdTMkB8AaNF/DWEsMbdZs+iyC9x
 ueG5kMWs3VUFZ1Lgq0cm58WfnozpfnzBjqyeVQ1tvXCrrCzPp6UbtwQ4wCxNN6oBEo0rQaO07
 V2HV82AlUfT1Cf/SJAmgcXXcxp99ueh9eZ8KkydmvSCDRnj4Dv9EHyDEyU1eMLGXnv4HTBm3w
 OMM9XSOBJk6FKBLOL48dPoDJOQsfEs33srj1O81SMpTmTc0/SeEZhZpo+cCkw334UWqiz8UXD
 9D9NNX9lIcUv/UAhkxhC5XBoTqw2NeLAa/vIvKpLuHXpuS9N40zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nb-georg.home ([109.104.37.175]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfUo-1q78KV3bB2-00B7li; Sat, 08
 Jul 2023 12:56:23 +0200
From:   =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [PATCH 2/2] gitk: keep author and date colums to a minimal width on resize
Date:   Sat,  8 Jul 2023 12:55:44 +0200
Message-ID: <20230708105546.2945446-4-georgmueller@gmx.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708105546.2945446-2-georgmueller@gmx.net>
References: <20230708105546.2945446-2-georgmueller@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x3NXQUQ+ywN/nZRF9Sf4RTtvpjWSjDbvUXhe81XSX6nRF49V2+u
 LYfFHFoGFZPQ0jiumQGDi83UQ1ubGTm3gNsackqNUuassHvScv88+bF5jjN+fUP2q+9Piiy
 Z1vr65QTl8RygMOY6Qcxw/H7FyTWlUzT3VqH5BoVKpD5xp7V9Z1bEWI4BkxztxoBDLoYnYW
 W3Yl13RPBvsodXF/J898Q==
UI-OutboundReport: notjunk:1;M01:P0:Bz8J+B+8S3o=;apLmIVq7UL4gwahhI0ZaqtPpBk7
 q+9ox4j8ZhZBfY/pw/0KFuWJhoLtmyZdPUVAxobKQ4rEhFAi19SOp0aWYrCBLCN0x8rMs65Ut
 Zow/a38IPE1fkCsfoixdd55yLBruxv9mjWUXmDWZneI98GbBpzajENhSmnnqSJMDMTKIgLgC8
 LjKjFHPszMPu7hTlc9r/Im8lwilEcZlVGXTkrWC2Q0vV1td23/EYSpaA/XMADwGKCmSkFdpKk
 VhJtynhY1WQxHyjX2yHLPBDGwrkrywbk8iOuVtdkGxkyTjT7b8VvBdu8h4zZ0hjsTBJAR2HcM
 +4d1Y1Sd40fGM1G2dzWx0cgxyXhiNtGUkBv7+h+DG8Oq/sO8hnXHyi7uu22rLVKKeHjPVIGDh
 oGcgA8692FjukGjD7kDtA63k+K8W5b1b3go4EZ44IkDuhjFmq0wj7At1mUZ0lpfM5hDrT7Vyv
 psuirbF3+/cCMDrZx6TQ+CqC2Kfq5VKe/AtcO35sJe2wAoUs862aRmOjEDGtmLAnGLkyNAVR2
 cV0fwLn7ezY5JtseRqQuZVmIIHWO5hLeVBDW1VJZF1H2ISji3YmmLHeduavOceGkHFhGyMpl5
 vnUi0t2VlhH2SX41I6PfXb/OxH4//Q8tLFumn0fPdXAYmDeSIUBEo1bY9HSF6wUbiCOuaEyZc
 lyvBpoPMk5k/QMohKg5t+mN7Q9OywPUfkhH8azj78c8pb94LTBSsTlFImlo9OYAXG+D5/K8LY
 YuZPBAcs8WUTtJJP6Yf+1E7yiWKfOVttm8z+Jlz8hFkIuInya3EGFi7q9F33F8l/Po0Rc+DFg
 n81UYX7zEG7yZiDRxHYjOau8V9hZsE3W96a53tMQleymy519WsOK5tGRZQ45ID8VYlXFdLCpz
 8VCoaxgckc191YM3eKdiExV8VfydHJVWK3weRLDMB1jBm5VrF9q7c/dUTlN4hsWJCTmSqa9TF
 S5tpmXQIVLNT+GrWGFcJBWX85oA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
=2D--
 gitk-git/gitk | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 0f229aadd7..819e059599 100755
=2D-- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2973,7 +2973,7 @@ proc savestuff {w} {
 }

 proc resizeclistpanes {win w} {
-    global oldwidth oldsash use_ttk
+    global oldwidth oldsash use_ttk charspc
     if {[info exists oldwidth($win)]} {
         if {[info exists oldsash($win)]} {
             set s0 [lindex $oldsash($win) 0]
@@ -3007,7 +3007,16 @@ proc resizeclistpanes {win w} {
                     set sash0 [expr {$sash1 - 20}]
                 }
             }
+            if {$w > 150 * $charspc} {
+                if {$sash1 + (20 * $charspc) > $w} {
+                    set sash1 [expr {$w - (20 * $charspc)}]
+                }
+                if {$sash0 + (30 * $charspc) > $sash1} {
+                    set sash0 [expr {$sash1 - (30 * $charspc)}]
+                }
+            }
         }
+
         if {$use_ttk} {
             $win sashpos 0 $sash0
             $win sashpos 1 $sash1
@@ -3023,7 +3032,7 @@ proc resizeclistpanes {win w} {
 }

 proc resizecdetpanes {win w} {
-    global oldwidth oldsash use_ttk
+    global oldwidth oldsash use_ttk charspc
     if {[info exists oldwidth($win)]} {
         if {[info exists oldsash($win)]} {
             set s0 $oldsash($win)
@@ -3046,6 +3055,11 @@ proc resizecdetpanes {win w} {
             if {$sash0 > $w - 15} {
                 set sash0 [expr {$w - 15}]
             }
+            if {$w > 150 * $charspc} {
+                if {$sash0 + (30 * $charspc) > $w} {
+                    set sash0 [expr {$w - (30 * $charspc)}]
+                }
+            }
         }
         if {$use_ttk} {
             $win sashpos 0 $sash0
=2D-
2.41.0

