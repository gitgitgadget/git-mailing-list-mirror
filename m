From: Keith Packard <keithp@keithp.com>
Subject: [PATCH] Provide configurable UI font for gitk
Date: Sun, 02 Apr 2006 01:23:34 -0800
Message-ID: <1143969814.2303.71.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EYKT55w+5TEqJn2z4c64"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 11:24:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPyoa-0007eH-Pc
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 11:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWDBJX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 05:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWDBJX6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 05:23:58 -0400
Received: from home.keithp.com ([63.227.221.253]:35084 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S932095AbWDBJX6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 05:23:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id E9EBF130022;
	Sun,  2 Apr 2006 01:23:56 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30610-01-4; Sun, 2 Apr 2006 01:23:56 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id A186C13001F; Sun,  2 Apr 2006 01:23:56 -0800 (PST)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 92E5914001;
	Sun,  2 Apr 2006 01:23:56 -0800 (PST)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 024C16B41E9; Sun,  2 Apr 2006 01:23:34 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18262>


--=-EYKT55w+5TEqJn2z4c64
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This makes the font used in the UI elements of gitk configurable in the
same way the other fonts are. The default fonts used in the Xft build of
tk8.5 are particularily horrific, making this change more important
there.

Signed-off-by: Keith Packard <keithp@neko.keithp.com>


---

 gitk |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

0ec97bb373389b5a55b0579168679b59bede1868
diff --git a/gitk b/gitk
index 03cd475..6319709 100755
--- a/gitk
+++ b/gitk
@@ -337,7 +337,7 @@ proc error_popup msg {
 }
=20
 proc makewindow {rargs} {
-    global canv canv2 canv3 linespc charspc ctext cflist textfont
+    global canv canv2 canv3 linespc charspc ctext cflist textfont
mainfont uifont
     global findtype findtypemenu findloc findstring fstring geometry
     global entries sha1entry sha1string sha1but
     global maincursor textcursor curtextcursor
@@ -345,16 +345,20 @@ proc makewindow {rargs} {
=20
     menu .bar
     .bar add cascade -label "File" -menu .bar.file
+    .bar configure -font $uifont
     menu .bar.file
     .bar.file add command -label "Update" -command [list updatecommits
$rargs]
     .bar.file add command -label "Reread references" -command
rereadrefs
     .bar.file add command -label "Quit" -command doquit
+    .bar.file configure -font $uifont
     menu .bar.edit
     .bar add cascade -label "Edit" -menu .bar.edit
     .bar.edit add command -label "Preferences" -command doprefs
+    .bar.edit configure -font $uifont
     menu .bar.help
     .bar add cascade -label "Help" -menu .bar.help
     .bar.help add command -label "About gitk" -command about
+    .bar.help configure -font $uifont
     . configure -menu .bar
=20
     if {![info exists geometry(canv1)]} {
@@ -401,7 +405,7 @@ proc makewindow {rargs} {
     set entries $sha1entry
     set sha1but .ctop.top.bar.sha1label
     button $sha1but -text "SHA1 ID: " -state disabled -relief flat \
-	-command gotocommit -width 8
+	-command gotocommit -width 8 -font $uifont
     $sha1but conf -disabledforeground [$sha1but cget -foreground]
     pack .ctop.top.bar.sha1label -side left
     entry $sha1entry -width 40 -font $textfont -textvariable sha1string
@@ -431,19 +435,24 @@ proc makewindow {rargs} {
 	-state disabled -width 26
     pack .ctop.top.bar.rightbut -side left -fill y
=20
-    button .ctop.top.bar.findbut -text "Find" -command dofind
+    button .ctop.top.bar.findbut -text "Find" -command dofind -font
$uifont
     pack .ctop.top.bar.findbut -side left
     set findstring {}
     set fstring .ctop.top.bar.findstring
     lappend entries $fstring
-    entry $fstring -width 30 -font $textfont -textvariable findstring
+    entry $fstring -width 30 -font $textfont -textvariable findstring
-font $textfont
     pack $fstring -side left -expand 1 -fill x
     set findtype Exact
     set findtypemenu [tk_optionMenu .ctop.top.bar.findtype \
 			  findtype Exact IgnCase Regexp]
+    .ctop.top.bar.findtype configure -font $uifont
+    .ctop.top.bar.findtype.menu configure -font $uifont
     set findloc "All fields"
     tk_optionMenu .ctop.top.bar.findloc findloc "All fields" Headline \
 	Comments Author Committer Files Pickaxe
+    .ctop.top.bar.findloc configure -font $uifont
+    .ctop.top.bar.findloc.menu configure -font $uifont
+=09
     pack .ctop.top.bar.findloc -side right
     pack .ctop.top.bar.findtype -side right
     # for making sure type=3D=3DExact whenever loc=3D=3DPickaxe
@@ -490,7 +499,7 @@ proc makewindow {rargs} {
     frame .ctop.cdet.right
     set cflist .ctop.cdet.right.cfiles
     listbox $cflist -bg white -selectmode extended -width
$geometry(cflistw) \
-	-yscrollcommand ".ctop.cdet.right.sb set"
+	-yscrollcommand ".ctop.cdet.right.sb set" -font $mainfont
     scrollbar .ctop.cdet.right.sb -command "$cflist yview"
     pack .ctop.cdet.right.sb -side right -fill y
     pack $cflist -side left -fill both -expand 1
@@ -590,7 +599,7 @@ proc click {w} {
 }
=20
 proc savestuff {w} {
-    global canv canv2 canv3 ctext cflist mainfont textfont
+    global canv canv2 canv3 ctext cflist mainfont textfont uifont
     global stuffsaved findmergefiles maxgraphpct
     global maxwidth
=20
@@ -600,6 +609,7 @@ proc savestuff {w} {
 	set f [open "~/.gitk-new" w]
 	puts $f [list set mainfont $mainfont]
 	puts $f [list set textfont $textfont]
+	puts $f [list set uifont $uifont]
 	puts $f [list set findmergefiles $findmergefiles]
 	puts $f [list set maxgraphpct $maxgraphpct]
 	puts $f [list set maxwidth $maxwidth]
@@ -3738,6 +3748,7 @@ if {$tclencoding =3D=3D {}} {
=20
 set mainfont {Helvetica 9}
 set textfont {Courier 9}
+set uifont {Helvetica 9 bold}
 set findmergefiles 0
 set maxgraphpct 50
 set maxwidth 16
--=20
1.3.0.rc1.g9590


--=20
keith.packard@intel.com

--=-EYKT55w+5TEqJn2z4c64
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEL5gWQp8BWwlsTdMRAm8uAJ0dMlm33ckJBUM2Lft5rRwH/Xh1BgCeIiSW
1cjvrDnPSGNiM8jHw17MKvA=
=O4QI
-----END PGP SIGNATURE-----

--=-EYKT55w+5TEqJn2z4c64--
