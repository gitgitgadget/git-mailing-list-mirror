From: =?UTF-8?q?Gauthier=20=C3=96stervall?= <gauthier@ostervall.se>
Subject: [PATCH] gitk: Move hard-coded colors to .gitk
Date: Wed, 27 Mar 2013 14:40:51 +0100
Message-ID: <1364391651-5896-1-git-send-email-gauthier@ostervall.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: paulus@samba.org, patthoyts@users.sourceforge.net,
	=?UTF-8?q?Gauthier=20=C3=96stervall?= <gauthier@ostervall.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 14:42:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKqbv-0000km-6W
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 14:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab3C0NlW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Mar 2013 09:41:22 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:55375 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab3C0NlV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 09:41:21 -0400
Received: by mail-la0-f48.google.com with SMTP id fq13so15492079lab.21
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 06:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=PlfEwCfKlS2BSF7Knqc2Q8LU5if8adJpOc4gRVT0E/Q=;
        b=AOyJMDD116QWcsEexAl1JjSLKMXwgk+g8yjLAb3P5c7P0hdZKsquLn5ej+F7MPB2/d
         sSM/r7BUAW2EDHMxxGio8sIZL5+DH8TPyxxqhCPinJIFmOy/Pknq8tbD1RZDH3DItZXZ
         ALSwCNQcNZ8lnffiLd89JieBVMHjkycVGGKBTnyVitoaSNOjZ7TUWErO5nQdZBd04ykG
         F69wRa1N5Soj/padfIMmI0swLdy7xRESsAbzQzaPSBGlDhtl742GPa2KKFXXfSrB9sCG
         iGwESUPJIkX7a2qjfVo1WQcWGAPgwWbi2+fyXm5Tis7ZgqmH+V17uwD8M3sBeJ3y7jAc
         RsMQ==
X-Received: by 10.112.83.67 with SMTP id o3mr10182858lby.7.1364391679000;
        Wed, 27 Mar 2013 06:41:19 -0700 (PDT)
Received: from localhost (mail.bellman.se. [212.247.43.194])
        by mx.google.com with ESMTPS id fz16sm8210325lab.5.2013.03.27.06.41.17
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 06:41:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.msysgit.1
X-Gm-Message-State: ALoCoQmEzEcuE+s3ezlYFs3Q8QowwyWG/pfcCk4aUqzAIaFsLCI6l+J5PNTgidsBYdksqqqVar4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219249>

Colors that are changeable in Preferences gave no sufficient control,
putting colors in the config file allows for easier configuration and
sharing of color schemes.

win32: Make the default foreground color that of window text rather
than button text.

Signed-off-by: Gauthier =C3=96stervall <gauthier@ostervall.se>
---
Screenshot of my current coloring setup using this patch, based on
zenburn:
http://s11.postimg.org/hozbtsfj7/gitk_zenburn.png
And the .gitk used to that end:
https://gist.github.com/fleutot/5253281

 gitk | 149 +++++++++++++++++++++++++++++++++++++++++++++++++----------=
--------
 1 file changed, 110 insertions(+), 39 deletions(-)

diff --git a/gitk b/gitk
index b3706fc..2edaaa8 100755
--- a/gitk
+++ b/gitk
@@ -2026,6 +2026,9 @@ proc makewindow {} {
     global highlight_files gdttype
     global searchstring sstring
     global bgcolor fgcolor bglist fglist diffcolors selectbgcolor
+    global uifgcolor uifgdisabledcolor
+    global filesepbgcolor filesepfgcolor
+    global mergecolors foundbgcolor currentsearchhitbgcolor
     global headctxmenu progresscanv progressitem progresscoords status=
w
     global fprogitem fprogcoord lastprogupdate progupdatepending
     global rprogitem rprogcoord rownumsel numcommits
@@ -2177,10 +2180,10 @@ proc makewindow {} {
 	0x00, 0x38, 0xff, 0x7f, 0xff, 0x7f, 0xff, 0x7f, 0x00, 0x38, 0x00, 0x1=
c,
 	0x00, 0x0e, 0x00, 0x07, 0x80, 0x03, 0xc0, 0x01};
     }
-    image create bitmap bm-left -data $bm_left_data
-    image create bitmap bm-left-gray -data $bm_left_data -foreground "=
#999"
-    image create bitmap bm-right -data $bm_right_data
-    image create bitmap bm-right-gray -data $bm_right_data -foreground=
 "#999"
+    image create bitmap bm-left -data $bm_left_data -foreground $uifgc=
olor
+    image create bitmap bm-left-gray -data $bm_left_data -foreground $=
uifgdisabledcolor
+    image create bitmap bm-right -data $bm_right_data -foreground $uif=
gcolor
+    image create bitmap bm-right-gray -data $bm_right_data -foreground=
 $uifgdisabledcolor
=20
     ${NS}::button .tf.bar.leftbut -command goback -state disabled -wid=
th 26
     if {$use_ttk} {
@@ -2349,32 +2352,32 @@ proc makewindow {} {
     lappend fglist $ctext
=20
     $ctext tag conf comment -wrap $wrapcomment
-    $ctext tag conf filesep -font textfontbold -back "#aaaaaa"
+    $ctext tag conf filesep -font textfontbold -fore $filesepfgcolor -=
back $filesepbgcolor
     $ctext tag conf hunksep -fore [lindex $diffcolors 2]
     $ctext tag conf d0 -fore [lindex $diffcolors 0]
     $ctext tag conf dresult -fore [lindex $diffcolors 1]
-    $ctext tag conf m0 -fore red
-    $ctext tag conf m1 -fore blue
-    $ctext tag conf m2 -fore green
-    $ctext tag conf m3 -fore purple
-    $ctext tag conf m4 -fore brown
-    $ctext tag conf m5 -fore "#009090"
-    $ctext tag conf m6 -fore magenta
-    $ctext tag conf m7 -fore "#808000"
-    $ctext tag conf m8 -fore "#009000"
-    $ctext tag conf m9 -fore "#ff0080"
-    $ctext tag conf m10 -fore cyan
-    $ctext tag conf m11 -fore "#b07070"
-    $ctext tag conf m12 -fore "#70b0f0"
-    $ctext tag conf m13 -fore "#70f0b0"
-    $ctext tag conf m14 -fore "#f0b070"
-    $ctext tag conf m15 -fore "#ff70b0"
+    $ctext tag conf m0 -fore [lindex $mergecolors 0]
+    $ctext tag conf m1 -fore [lindex $mergecolors 1]
+    $ctext tag conf m2 -fore [lindex $mergecolors 2]
+    $ctext tag conf m3 -fore [lindex $mergecolors 3]
+    $ctext tag conf m4 -fore [lindex $mergecolors 4]
+    $ctext tag conf m5 -fore [lindex $mergecolors 5]
+    $ctext tag conf m6 -fore [lindex $mergecolors 6]
+    $ctext tag conf m7 -fore [lindex $mergecolors 7]
+    $ctext tag conf m8 -fore [lindex $mergecolors 8]
+    $ctext tag conf m9 -fore [lindex $mergecolors 9]
+    $ctext tag conf m10 -fore [lindex $mergecolors 10]
+    $ctext tag conf m11 -fore [lindex $mergecolors 11]
+    $ctext tag conf m12 -fore [lindex $mergecolors 12]
+    $ctext tag conf m13 -fore [lindex $mergecolors 13]
+    $ctext tag conf m14 -fore [lindex $mergecolors 14]
+    $ctext tag conf m15 -fore [lindex $mergecolors 15]
     $ctext tag conf mmax -fore darkgrey
     set mergemax 16
     $ctext tag conf mresult -font textfontbold
     $ctext tag conf msep -font textfontbold
-    $ctext tag conf found -back yellow
-    $ctext tag conf currentsearchhit -back orange
+    $ctext tag conf found -back $foundbgcolor
+    $ctext tag conf currentsearchhit -back $currentsearchhitbgcolor
     $ctext tag conf wwrap -wrap word
=20
     .pwbottom add .bleft
@@ -2721,6 +2724,14 @@ proc savestuff {w} {
     global viewname viewfiles viewargs viewargscmd viewperm nextviewnu=
m
     global cmitmode wrapcomment datetimeformat limitdiffs
     global colors uicolor bgcolor fgcolor diffcolors diffcontext selec=
tbgcolor
+    global uifgcolor uifgdisabledcolor
+    global headbgcolor headfgcolor headoutlinecolor remotebgcolor
+    global tagbgcolor tagfgcolor tagoutlinecolor
+    global reflinecolor filesepbgcolor filesepfgcolor
+    global mergecolors foundbgcolor currentsearchhitbgcolor
+    global linehoverbgcolor linehoverfgcolor linehoveroutlinecolor cir=
clecolors
+    global mainheadcirclecolor workingfilescirclecolor indexcirclecolo=
r
+    global linkfgcolor circleoutlinecolor
     global autoselect autosellen extdifftool perfile_attrs markbgcolor=
 use_ttk
     global hideremotes want_ttk maxrefs
=20
@@ -2753,13 +2764,37 @@ proc savestuff {w} {
 	puts $f [list set want_ttk $want_ttk]
 	puts $f [list set bgcolor $bgcolor]
 	puts $f [list set fgcolor $fgcolor]
+	puts $f [list set uifgcolor $uifgcolor]
+	puts $f [list set uifgdisabledcolor $uifgdisabledcolor]
 	puts $f [list set colors $colors]
 	puts $f [list set diffcolors $diffcolors]
+	puts $f [list set mergecolors $mergecolors]
 	puts $f [list set markbgcolor $markbgcolor]
 	puts $f [list set diffcontext $diffcontext]
 	puts $f [list set selectbgcolor $selectbgcolor]
+	puts $f [list set foundbgcolor $foundbgcolor]
+	puts $f [list set currentsearchhitbgcolor $currentsearchhitbgcolor]
 	puts $f [list set extdifftool $extdifftool]
 	puts $f [list set perfile_attrs $perfile_attrs]
+	puts $f [list set headbgcolor $headbgcolor]
+	puts $f [list set headfgcolor $headfgcolor]
+	puts $f [list set headoutlinecolor $headoutlinecolor]
+	puts $f [list set remotebgcolor $remotebgcolor]
+	puts $f [list set tagbgcolor $tagbgcolor]
+	puts $f [list set tagfgcolor $tagfgcolor]
+	puts $f [list set tagoutlinecolor $tagoutlinecolor]
+	puts $f [list set reflinecolor $reflinecolor]
+	puts $f [list set filesepbgcolor $filesepbgcolor]
+	puts $f [list set filesepfgcolor $filesepfgcolor]
+	puts $f [list set linehoverbgcolor $linehoverbgcolor]
+	puts $f [list set linehoverfgcolor $linehoverfgcolor]
+	puts $f [list set linehoveroutlinecolor $linehoveroutlinecolor]
+	puts $f [list set mainheadcirclecolor $mainheadcirclecolor]
+	puts $f [list set workingfilescirclecolor $workingfilescirclecolor]
+	puts $f [list set indexcirclecolor $indexcirclecolor]
+	puts $f [list set circlecolors $circlecolors]
+	puts $f [list set linkfgcolor $linkfgcolor]
+	puts $f [list set circleoutlinecolor $circleoutlinecolor]
=20
 	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(state) [wm state .]"
@@ -5925,15 +5960,17 @@ proc drawcmittext {id row col} {
     global linehtag linentag linedtag selectedline
     global canvxmax boldids boldnameids fgcolor markedid
     global mainheadid nullid nullid2 circleitem circlecolors ctxbut
+    global mainheadcirclecolor workingfilescirclecolor indexcirclecolo=
r
+    global circleoutlinecolor
=20
     # listed is 0 for boundary, 1 for normal, 2 for negative, 3 for le=
ft, 4 for right
     set listed $cmitlisted($curview,$id)
     if {$id eq $nullid} {
-	set ofill red
+	set ofill $workingfilescirclecolor
     } elseif {$id eq $nullid2} {
-	set ofill green
+	set ofill $indexcirclecolor
     } elseif {$id eq $mainheadid} {
-	set ofill yellow
+	set ofill $mainheadcirclecolor
     } else {
 	set ofill [lindex $circlecolors $listed]
     }
@@ -5943,21 +5980,21 @@ proc drawcmittext {id row col} {
     if {$listed <=3D 2} {
 	set t [$canv create oval [expr {$x - $orad}] [expr {$y - $orad}] \
 		   [expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
-		   -fill $ofill -outline $fgcolor -width 1 -tags circle]
+		   -fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
     } elseif {$listed =3D=3D 3} {
 	# triangle pointing left for left-side commits
 	set t [$canv create polygon \
 		   [expr {$x - $orad}] $y \
 		   [expr {$x + $orad - 1}] [expr {$y - $orad}] \
 		   [expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
-		   -fill $ofill -outline $fgcolor -width 1 -tags circle]
+		   -fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
     } else {
 	# triangle pointing right for right-side commits
 	set t [$canv create polygon \
 		   [expr {$x + $orad - 1}] $y \
 		   [expr {$x - $orad}] [expr {$y - $orad}] \
 		   [expr {$x - $orad}] [expr {$y + $orad - 1}] \
-		   -fill $ofill -outline $fgcolor -width 1 -tags circle]
+		   -fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
     }
     set circleitem($row) $t
     $canv raise $t
@@ -6345,6 +6382,9 @@ proc drawtags {id x xt y1} {
     global idtags idheads idotherrefs mainhead
     global linespc lthickness
     global canv rowtextx curview fgcolor bgcolor ctxbut
+    global headbgcolor headfgcolor headoutlinecolor remotebgcolor
+    global tagbgcolor tagfgcolor tagoutlinecolor
+    global reflinecolor
=20
     set marks {}
     set ntags 0
@@ -6382,7 +6422,7 @@ proc drawtags {id x xt y1} {
 	set xt [expr {$xt + $delta + $wid + $lthickness + $linespc}]
     }
     set t [$canv create line $x $y1 [lindex $xvals end] $y1 \
-	       -width $lthickness -fill black -tags tag.$id]
+	       -width $lthickness -fill $reflinecolor -tags tag.$id]
     $canv lower $t
     foreach tag $marks x $xvals wid $wvals {
 	set tag_quoted [string map {% %%} $tag]
@@ -6393,13 +6433,14 @@ proc drawtags {id x xt y1} {
 	    # draw a tag
 	    set t [$canv create polygon $x [expr {$yt + $delta}] $xl $yt \
 		       $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
-		       -width 1 -outline black -fill yellow -tags tag.$id]
+		       -width 1 -outline $tagoutlinecolor -fill $tagbgcolor \
+		       -tags tag.$id]
 	    $canv bind $t <1> [list showtag $tag_quoted 1]
 	    set rowtextx([rowofcommit $id]) [expr {$xr + $linespc}]
 	} else {
 	    # draw a head or other ref
 	    if {[incr nheads -1] >=3D 0} {
-		set col green
+		set col $headbgcolor
 		if {$tag eq $mainhead} {
 		    set font mainfontbold
 		}
@@ -6415,10 +6456,10 @@ proc drawtags {id x xt y1} {
 		set yti [expr {$yt + 1}]
 		set xri [expr {$x + $rwid}]
 		$canv create polygon $xi $yti $xri $yti $xri $yb $xi $yb \
-			-width 0 -fill "#ffddaa" -tags tag.$id
+			-width 0 -fill $remotebgcolor -tags tag.$id
 	    }
 	}
-	set t [$canv create text $xl $y1 -anchor w -text $tag -fill $fgcolor =
\
+	set t [$canv create text $xl $y1 -anchor w -text $tag -fill $headfgco=
lor \
 		   -font $font -tags [list tag.$id text]]
 	if {$ntags >=3D 0} {
 	    $canv bind $t <1> [list showtag $tag_quoted 1]
@@ -6799,6 +6840,7 @@ proc appendwithlinks {text tags} {
=20
 proc setlink {id lk} {
     global curview ctext pendinglinks
+    global linkfgcolor
=20
     if {[string range $id 0 1] eq "-g"} {
       set id [string range $id 2 end]
@@ -6816,7 +6858,7 @@ proc setlink {id lk} {
 	set known [commitinview $id $curview]
     }
     if {$known} {
-	$ctext tag conf $lk -foreground blue -underline 1
+	$ctext tag conf $lk -foreground $linkfgcolor -underline 1
 	$ctext tag bind $lk <1> [list selbyid $id]
 	$ctext tag bind $lk <Enter> {linkcursor %W 1}
 	$ctext tag bind $lk <Leave> {linkcursor %W -1}
@@ -8459,6 +8501,8 @@ proc lineleave {id} {
 proc linehover {} {
     global hoverx hovery hoverid hovertimer
     global canv linespc lthickness
+    global linehoverbgcolor linehoverfgcolor linehoveroutlinecolor
+
     global commitinfo
=20
     set text [lindex $commitinfo($hoverid) 0]
@@ -8472,10 +8516,11 @@ proc linehover {} {
     set x1 [expr {$x + [font measure mainfont $text] + 2 * $lthickness=
}]
     set y1 [expr {$y + $linespc + 2 * $lthickness}]
     set t [$canv create rectangle $x0 $y0 $x1 $y1 \
-	       -fill \#ffff80 -outline black -width 1 -tags hover]
+	       -fill $linehoverbgcolor -outline $linehoveroutlinecolor \
+	       -width 1 -tags hover]
     $canv raise $t
     set t [$canv create text $x $y -anchor nw -text $text -tags hover =
\
-	       -font mainfont]
+	       -font mainfont -fill $linehoverfgcolor]
     $canv raise $t
 }
=20
@@ -9039,12 +9084,13 @@ proc domktag {} {
 proc redrawtags {id} {
     global canv linehtag idpos currentid curview cmitlisted markedid
     global canvxmax iddrawn circleitem mainheadid circlecolors
+    global mainheadcirclecolor
=20
     if {![commitinview $id $curview]} return
     if {![info exists iddrawn($id)]} return
     set row [rowofcommit $id]
     if {$id eq $mainheadid} {
-	set ofill yellow
+	set ofill $mainheadcirclecolor
     } else {
 	set ofill [lindex $circlecolors $cmitlisted($curview,$id)]
     }
@@ -11728,22 +11774,47 @@ if {[tk windowingsystem] eq "aqua"} {
 set colors {green red blue magenta darkgrey brown orange}
 if {[tk windowingsystem] eq "win32"} {
     set uicolor SystemButtonFace
+    set uifgcolor SystemButtonText
+    set uifgdisabledcolor SystemDisabledText
     set bgcolor SystemWindow
-    set fgcolor SystemButtonText
+    set fgcolor SystemWindowText
     set selectbgcolor SystemHighlight
 } else {
     set uicolor grey85
+    set uifgcolor black
+    set uifgdisabledcolor "#999"
     set bgcolor white
     set fgcolor black
     set selectbgcolor gray85
 }
 set diffcolors {red "#00a000" blue}
 set diffcontext 3
+set mergecolors {red blue green purple brown "#009090" magenta "#80800=
0" "#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0" "#f0b070" "#f=
f70b0"}
 set ignorespace 0
 set worddiff ""
 set markbgcolor "#e0e0ff"
=20
+set headbgcolor green
+set headfgcolor black
+set headoutlinecolor black
+set remotebgcolor #ffddaa
+set tagbgcolor yellow
+set tagfgcolor black
+set tagoutlinecolor black
+set reflinecolor black
+set filesepbgcolor #aaaaaa
+set filesepfgcolor #6a6a6a
+set linehoverbgcolor #ffff80
+set linehoverfgcolor black
+set linehoveroutlinecolor black
+set mainheadcirclecolor yellow
+set workingfilescirclecolor red
+set indexcirclecolor green
 set circlecolors {white blue gray blue blue}
+set linkfgcolor blue
+set circleoutlinecolor $fgcolor
+set foundbgcolor yellow
+set currentsearchhitbgcolor orange
=20
 # button for popping up context menus
 if {[tk windowingsystem] eq "aqua"} {
--=20
1.8.1.msysgit.1
