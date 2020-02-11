Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LONGWORDS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBFFC35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 21:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D85620659
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 21:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Gdmbw+bK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbgBKVZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:25:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:55841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgBKVZX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 16:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581456320;
        bh=8WtFu7jUoWAD5iFe4Wpa3BIPbAAWTkneMiK29KL0sAo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Gdmbw+bK9t0Dxyh9Jdhbwbs/6o4SoitX3ZouDYCaGagsUwZvAQ1KftvSFgDXyBriY
         +H4OYdSy8HS4w0FCOgposab7bpfunlDwghOd1gq5egU/d0xEOdeb+5fsAc2dAGWqjG
         AIqOwVd4YcDAikV+D7U/g4JTIwjbhV8XLyt+R3NA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from oki.localdomain ([77.9.23.22]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnakR-1jkcpp2Ot3-00jcQL; Tue, 11
 Feb 2020 22:25:20 +0100
From:   Stefan Dotterweich <stefandotterweich@gmx.de>
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Stefan Dotterweich <stefandotterweich@gmx.de>
Subject: [PATCH] gitk: add diff lines background colors
Date:   Tue, 11 Feb 2020 22:24:48 +0100
Message-Id: <20200211212448.9288-1-stefandotterweich@gmx.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZQRU/B/N38sLPJdFoSVfSA4EUztlPzf49z9OwN2GjjT9ueWjN1Y
 M/IDOHgqgNdOUI/XLVgQ2/+A9s79HY6AjoxgskYu3Peb6h8ZcWHbo9dAS5V2zBXI4tGG88x
 qJz9n1Vaw60YSADZEMToQEOUMWunO857s0EVVWgLRfY3KiQzmQztracKm8BT190BMb/Z7ND
 2Baa2VLGlwaiAS4aV8z8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LOGwi3Nn8T8=:xam5vln2ZKn+X1sSk/Wl9U
 QEjo94RQbflWd5vgkiVheuV5+6IG9/FIElupQzibe87N/fEQqUmO/LDeCQ/joKVrXx03rFOJj
 +WnuJmgjhBSZaYKMVPsHbkJWA3zYh/K0LTZBIkzIsahgFGdhVzYZKdLGo63YCuYt5yFi+EA7u
 /NBBx0UR0Wzwmern3ILcs0Am+XJmZxmYLVLTc60ax1zm++EcdwdwjCFBhBwcPzM3qPvJnJZUc
 9Th90lprBzp6pl1AuIzYCGIpLFSzUgdRwgrx2j9opEdb8GjVboJPPcTOVJpmnX2By57PekriX
 ogYSVEy9J1RuHD6c3Hwb/nRtPmWzdx+/PwTr1Pnl5BmMgh4ue8OflfDj1jGuRBnk6S+JW1/Aj
 J2K8XklXI7TX2CNJPJlyvVwV+uy0gvFVxgxAofpoYWYJ4uAvl3AxQkiBAigYzQTnTrhSKj934
 Rgt9h5djcYIOCyfCjXyCMrsauGTae4rUzayZ1JI2SMArQf2Mx7PthM1R16XbTRBpEZTu4evbV
 Q+0xLB5ZK6g3vuatKrj+/u4dCw2Jz30CzZTzZy6Ol2gak9DWd4clpPHbppkhWw9v8s64v/YBu
 1XNJpZAiuPibR4TwRHQDXMTM1k3OQFTnYoQ68qb2j7pf/LPGB8kD2pG1wJrYR9Uc5p88jUZ2w
 JTxj5PZZfHO3arhR28FO4e/9lJXz/Ozqis6qNEa8V86w3ZkuasIOuyyJiw+VyRiNbNn1u2yg1
 0nfNB88CA0r/iVD6J1hAjj9bWI0v4idLwTYAD7juNaIJ8SmjJNt2qNzGNR1a8y7SST6SFes2P
 1ujo2WF5Ap0HjM2EOoRtfEOXbonOmvneXLPFUSQD9LUBgsBZzAiigrML99MVVbujom3vK9jJH
 aknsR1RQ+Lhg+9f5Y0lB7HCPvaaTC3JJl6V3lfd609SpALTJDQMMghQQHOVvtHuvN+/wTmp8a
 L4T/hlNXbhQrU7mQwNl3A2qpZfNqGKzK3MGQDl+RMDZ5gbfVGXgp/dvbes8NmgT6vDpoxddLL
 YQWP9jRmAvWxH8dRuvrzlc4kBsql7MYErDyqCz4CgfXkGFrExGTqiP4/kODLF0bEee8Xh/zE6
 tuNT7CTvCRd3CoL6uQPe38rDIqcRfXbdq0CRTLlvd2jmDnYPp/rfFl0ioqhlMtEsXaKT4x+ue
 9DZACVpwbye95I2IAyaEzz9dkWwfaa4C6yDmAWjm4heD1QQ74oI/Yh8colJrmER7NyPG8Np5U
 QVVAK1+HmqxSQCT6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not using colored background for added and removed lines is a missed
opportunity to make diff lines easier to grasp visually.

Use a subtle red/green background by default. Make the font slightly darke=
r
to improve contrast.

Signed-off-by: Stefan Dotterweich <stefandotterweich@gmx.de>
=2D--
The variable diffcolors seems like a fitting place for the two new colors.
However, adding them to that list causes problems if diffcolors saved in
.gitk then contains three instead of five colors. This could be solved by
modifying the variable after loading .gitk. I'm not sure if that would be
the preferred approach or where to implement a special case like that. To
avoid the problem, I introduced a new variable diffbgcolors.

 gitk | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index da84e22..66c237a 100755
=2D-- a/gitk
+++ b/gitk
@@ -2073,7 +2073,7 @@ proc makewindow {} {
     global rowctxmenu fakerowmenu mergemax wrapcomment
     global highlight_files gdttype
     global searchstring sstring
-    global bgcolor fgcolor bglist fglist diffcolors selectbgcolor
+    global bgcolor fgcolor bglist fglist diffcolors diffbgcolors selectbg=
color
     global uifgcolor uifgdisabledcolor
     global filesepbgcolor filesepfgcolor
     global mergecolors foundbgcolor currentsearchhitbgcolor
@@ -2434,7 +2434,9 @@ proc makewindow {} {
     $ctext tag conf filesep -font textfontbold -fore $filesepfgcolor -bac=
k $filesepbgcolor
     $ctext tag conf hunksep -fore [lindex $diffcolors 2]
     $ctext tag conf d0 -fore [lindex $diffcolors 0]
+    $ctext tag conf d0 -back [lindex $diffbgcolors 0]
     $ctext tag conf dresult -fore [lindex $diffcolors 1]
+    $ctext tag conf dresult -back [lindex $diffbgcolors 1]
     $ctext tag conf m0 -fore [lindex $mergecolors 0]
     $ctext tag conf m1 -fore [lindex $mergecolors 1]
     $ctext tag conf m2 -fore [lindex $mergecolors 2]
@@ -11607,6 +11609,7 @@ proc prefspage_general {notebook} {

 proc prefspage_colors {notebook} {
     global NS uicolor bgcolor fgcolor ctext diffcolors selectbgcolor mark=
bgcolor
+    global diffbgcolors

     set page [create_prefs_page $notebook.colors]

@@ -11629,11 +11632,23 @@ proc prefspage_colors {notebook} {
 	-command [list choosecolor diffcolors 0 $page.diffold [mc "diff old line=
s"] \
 		      [list $ctext tag conf d0 -foreground]]
     grid x $page.diffoldbut $page.diffold -sticky w
+    label $page.diffoldbg -padx 40 -relief sunk -background [lindex $diff=
bgcolors 0]
+    ${NS}::button $page.diffoldbgbut -text [mc "Diff: old lines bg"] \
+	-command [list choosecolor diffbgcolors 0 $page.diffoldbg \
+		      [mc "diff old lines bg"] \
+		      [list $ctext tag conf d0 -background]]
+    grid x $page.diffoldbgbut $page.diffoldbg -sticky w
     label $page.diffnew -padx 40 -relief sunk -background [lindex $diffco=
lors 1]
     ${NS}::button $page.diffnewbut -text [mc "Diff: new lines"] \
 	-command [list choosecolor diffcolors 1 $page.diffnew [mc "diff new line=
s"] \
 		      [list $ctext tag conf dresult -foreground]]
     grid x $page.diffnewbut $page.diffnew -sticky w
+    label $page.diffnewbg -padx 40 -relief sunk -background [lindex $diff=
bgcolors 1]
+    ${NS}::button $page.diffnewbgbut -text [mc "Diff: new lines bg"] \
+	-command [list choosecolor diffbgcolors 1 $page.diffnewbg \
+		      [mc "diff new lines bg"] \
+		      [list $ctext tag conf dresult -background]]
+    grid x $page.diffnewbgbut $page.diffnewbg -sticky w
     label $page.hunksep -padx 40 -relief sunk -background [lindex $diffco=
lors 2]
     ${NS}::button $page.hunksepbut -text [mc "Diff: hunk header"] \
 	-command [list choosecolor diffcolors 2 $page.hunksep \
@@ -12377,7 +12392,8 @@ if {[tk windowingsystem] eq "win32"} {
 	set web_browser "xdg-open"
     }
 }
-set diffcolors {red "#00a000" blue}
+set diffcolors {"#c30000" "#009800" blue}
+set diffbgcolors {"#fff3f3" "#f0fff0"}
 set diffcontext 3
 set mergecolors {red blue "#00ff00" purple brown "#009090" magenta "#8080=
00" "#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0" "#f0b070" "#ff7=
0b0"}
 set ignorespace 0
@@ -12448,7 +12464,7 @@ set config_variables {
     remotebgcolor tagbgcolor tagfgcolor tagoutlinecolor reflinecolor
     filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
     linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
-    indexcirclecolor circlecolors linkfgcolor circleoutlinecolor
+    indexcirclecolor circlecolors linkfgcolor circleoutlinecolor diffbgco=
lors
     web_browser
 }
 foreach var $config_variables {
=2D-
2.24.1

