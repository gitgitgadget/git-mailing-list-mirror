From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 2/2] gitk: Markup many strings for translation.
Date: Fri, 27 Jul 2007 17:03:00 +0200
Message-ID: <20070727170300.t01ku4u2sg04sgsk@webmail.tu-harburg.de>
References: <20070727165318.e96b1yxxwsooo884@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 17:03:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IERLX-0005ln-Rd
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 17:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761912AbXG0PDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 27 Jul 2007 11:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761302AbXG0PDJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 11:03:09 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:33687 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761631AbXG0PDG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jul 2007 11:03:06 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6RF32Rh013468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 27 Jul 2007 17:03:02 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6RF31dk003200;
	Fri, 27 Jul 2007 17:03:01 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id 9D885E50349; Fri, 27 Jul 2007 17:03:01 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Fri, 27 Jul 2007
	17:03:00 +0200
In-Reply-To: <20070727165318.e96b1yxxwsooo884@webmail.tu-harburg.de>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53931>

Similar to the discussion in git-gui, all user-visible strings are =20
passed through the [mc ...] procedure to have them translated by msgcat=
=2E

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
@Paul: Are you interested in applying this? If yes, I'd happily =20
provide the Makefile rules for string extraction and translation =20
catalog updates, but I'd like to hear a proposal or decision on where =20
to place them. Should the po files for translation go into the po/ =20
subdirectory? And then a proposal/decision of where to install the =20
compiled .msg catalogs will be necessary.

In case anyone comes up with the idea of using a single translation =20
catalog for both gitk and git-gui: This is very well possible and =20
potentially makes the translator's workflow easier. Only in terms of =20
message saving there will be almost no benefit: Gitk has approx. 130 =20
messages, git-gui approx. 260, and exactly 8 (in words: eight) of them =
=20
are identical between both programs.

  gitk |  358 =20
+++++++++++++++++++++++++++++++++---------------------------------
  1 files changed, 179 insertions(+), 179 deletions(-)

diff --git a/gitk b/gitk
index c01acfb..de131a6 100755
--- a/gitk
+++ b/gitk
@@ -128,7 +128,7 @@ proc getcommits {} {
      set phase getcommits
      initlayout
      start_rev_list $curview
-    show_status "Reading commits..."
+    show_status [mc "Reading commits..."]
  }

  proc getcommitlines {fd view}  {
@@ -273,7 +273,7 @@ proc chewcommits {view} {
  		#set ms [expr {[clock clicks -milliseconds] - $startmsecs}]
  		#puts "overall $ms ms for $numcommits commits"
  	    } else {
-		show_status "No commits selected"
+		show_status [mc "No commits selected"]
  	    }
  	    notbusy layout
  	    set phase {}
@@ -378,7 +378,7 @@ proc getcommit {id} {
      } else {
  	readcommit $id
  	if {![info exists commitinfo($id)]} {
-	    set commitinfo($id) {"No commit information available"}
+	    set commitinfo($id) {[mc "No commit information available"]}
  	}
      }
      return 1
@@ -464,7 +464,7 @@ proc removehead {id name} {
  proc show_error {w top msg} {
      message $w.m -text $msg -justify center -aspect 400
      pack $w.m -side top -fill x -padx 20 -pady 20
-    button $w.ok -text OK -command "destroy $top"
+    button $w.ok -text [mc OK] -command "destroy $top"
      pack $w.ok -side bottom -fill x
      bind $top <Visibility> "grab $top; focus $top"
      bind $top <Key-Return> "destroy $top"
@@ -486,9 +486,9 @@ proc confirm_popup msg {
      wm transient $w .
      message $w.m -text $msg -justify center -aspect 400
      pack $w.m -side top -fill x -padx 20 -pady 20
-    button $w.ok -text OK -command "set confirm_ok 1; destroy $w"
+    button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
      pack $w.ok -side left -fill x
-    button $w.cancel -text Cancel -command "destroy $w"
+    button $w.cancel -text [mc Cancel] -command "destroy $w"
      pack $w.cancel -side right -fill x
      bind $w <Visibility> "grab $w; focus $w"
      tkwait window $w
@@ -508,32 +508,32 @@ proc makewindow {} {
      global headctxmenu

      menu .bar
-    .bar add cascade -label "File" -menu .bar.file
+    .bar add cascade -label [mc "File"] -menu .bar.file
      .bar configure -font $uifont
      menu .bar.file
-    .bar.file add command -label "Update" -command updatecommits
-    .bar.file add command -label "Reread references" -command rereadre=
fs
-    .bar.file add command -label "Quit" -command doquit
+    .bar.file add command -label [mc "Update"] -command updatecommits
+    .bar.file add command -label [mc "Reread references"] -command rer=
eadrefs
+    .bar.file add command -label [mc "Quit"] -command doquit
      .bar.file configure -font $uifont
      menu .bar.edit
-    .bar add cascade -label "Edit" -menu .bar.edit
-    .bar.edit add command -label "Preferences" -command doprefs
+    .bar add cascade -label [mc "Edit"] -menu .bar.edit
+    .bar.edit add command -label [mc "Preferences"] -command doprefs
      .bar.edit configure -font $uifont

      menu .bar.view -font $uifont
-    .bar add cascade -label "View" -menu .bar.view
-    .bar.view add command -label "New view..." -command {newview 0}
-    .bar.view add command -label "Edit view..." -command editview \
+    .bar add cascade -label [mc "View"] -menu .bar.view
+    .bar.view add command -label [mc "New view..."] -command {newview =
0}
+    .bar.view add command -label [mc "Edit view..."] -command editview=
 \
  	-state disabled
-    .bar.view add command -label "Delete view" -command delview =20
-state disabled
+    .bar.view add command -label [mc "Delete view"] -command delview =20
-state disabled
      .bar.view add separator
-    .bar.view add radiobutton -label "All files" -command {showview 0}=
 \
+    .bar.view add radiobutton -label [mc "All files"] -command {showvi=
ew 0} \
  	-variable selectedview -value 0

      menu .bar.help
-    .bar add cascade -label "Help" -menu .bar.help
-    .bar.help add command -label "About gitk" -command about
-    .bar.help add command -label "Key bindings" -command keys
+    .bar add cascade -label [mc "Help"] -menu .bar.help
+    .bar.help add command -label [mc "About gitk"] -command about
+    .bar.help add command -label [mc "Key bindings"] -command keys
      .bar.help configure -font $uifont
      . configure -menu .bar

@@ -590,7 +590,7 @@ proc makewindow {} {
      set sha1entry .tf.bar.sha1
      set entries $sha1entry
      set sha1but .tf.bar.sha1label
-    button $sha1but -text "SHA1 ID: " -state disabled -relief flat \
+    button $sha1but -text [mc "SHA1 ID: "] -state disabled -relief fla=
t \
  	-command gotocommit -width 8 -font $uifont
      $sha1but conf -disabledforeground [$sha1but cget -foreground]
      pack .tf.bar.sha1label -side left
@@ -621,7 +621,7 @@ proc makewindow {} {
  	-state disabled -width 26
      pack .tf.bar.rightbut -side left -fill y

-    button .tf.bar.findbut -text "Find" -command dofind -font $uifont
+    button .tf.bar.findbut -text [mc "Find"] -command dofind -font $ui=
font
      pack .tf.bar.findbut -side left
      set findstring {}
      set fstring .tf.bar.findstring
@@ -631,13 +631,13 @@ proc makewindow {} {
      pack $fstring -side left -expand 1 -fill x -in .tf.bar
      set findtype Exact
      set findtypemenu [tk_optionMenu .tf.bar.findtype \
-		      findtype Exact IgnCase Regexp]
+			  findtype [mc Exact] [mc IgnCase] [mc Regexp]]
      trace add variable findtype write find_change
      .tf.bar.findtype configure -font $uifont
      .tf.bar.findtype.menu configure -font $uifont
-    set findloc "All fields"
-    tk_optionMenu .tf.bar.findloc findloc "All fields" Headline \
-	Comments Author Committer
+    set findloc [mc "All fields"]
+    tk_optionMenu .tf.bar.findloc findloc [mc "All fields"] [mc Headli=
ne] \
+	[mc Comments] [mc Author] [mc Committer]
      trace add variable findloc write find_change
      .tf.bar.findloc configure -font $uifont
      .tf.bar.findloc.menu configure -font $uifont
@@ -645,12 +645,12 @@ proc makewindow {} {
      pack .tf.bar.findtype -side right

      # build up the bottom bar of upper window
-    label .tf.lbar.flabel -text "Highlight:  Commits " \
+    label .tf.lbar.flabel -text [mc "Highlight:  Commits "] \
      -font $uifont
      pack .tf.lbar.flabel -side left -fill y
-    set gdttype "touching paths:"
-    set gm [tk_optionMenu .tf.lbar.gdttype gdttype "touching paths:" \
-	"adding/removing string:"]
+    set gdttype [mc "touching paths:"]
+    set gm [tk_optionMenu .tf.lbar.gdttype gdttype [mc "touching paths=
:"] \
+	[mc "adding/removing string:"]]
      trace add variable gdttype write hfiles_change
      $gm conf -font $uifont
      .tf.lbar.gdttype conf -font $uifont
@@ -660,19 +660,19 @@ proc makewindow {} {
      trace add variable highlight_files write hfiles_change
      lappend entries .tf.lbar.fent
      pack .tf.lbar.fent -side left -fill x -expand 1
-    label .tf.lbar.vlabel -text " OR in view" -font $uifont
+    label .tf.lbar.vlabel -text [mc " OR in view"] -font $uifont
      pack .tf.lbar.vlabel -side left -fill y
      global viewhlmenu selectedhlview
-    set viewhlmenu [tk_optionMenu .tf.lbar.vhl selectedhlview None]
+    set viewhlmenu [tk_optionMenu .tf.lbar.vhl selectedhlview [mc None=
]]
      $viewhlmenu entryconf None -command delvhighlight
      $viewhlmenu conf -font $uifont
      .tf.lbar.vhl conf -font $uifont
      pack .tf.lbar.vhl -side left -fill y
-    label .tf.lbar.rlabel -text " OR " -font $uifont
+    label .tf.lbar.rlabel -text [mc " OR "] -font $uifont
      pack .tf.lbar.rlabel -side left -fill y
      global highlight_related
-    set m [tk_optionMenu .tf.lbar.relm highlight_related None \
-	"Descendent" "Not descendent" "Ancestor" "Not ancestor"]
+    set m [tk_optionMenu .tf.lbar.relm highlight_related [mc None] \
+	[mc "Descendent"] [mc "Not descendent"] [mc "Ancestor"] [mc "Not ance=
stor"]]
      $m conf -font $uifont
      .tf.lbar.relm conf -font $uifont
      trace add variable highlight_related write vrel_change
@@ -700,7 +700,7 @@ proc makewindow {} {
      frame .bleft.top
      frame .bleft.mid

-    button .bleft.top.search -text "Search" -command dosearch \
+    button .bleft.top.search -text [mc "Search"] -command dosearch \
  	-font $uifont
      pack .bleft.top.search -side left -padx 5
      set sstring .bleft.top.sstring
@@ -708,11 +708,11 @@ proc makewindow {} {
      lappend entries $sstring
      trace add variable searchstring write incrsearch
      pack $sstring -side left -expand 1 -fill x
-    radiobutton .bleft.mid.diff -text "Diff" \
+    radiobutton .bleft.mid.diff -text [mc "Diff"] \
  	-command changediffdisp -variable diffelide -value {0 0}
-    radiobutton .bleft.mid.old -text "Old version" \
+    radiobutton .bleft.mid.old -text [mc "Old version"] \
  	-command changediffdisp -variable diffelide -value {0 1}
-    radiobutton .bleft.mid.new -text "New version" \
+    radiobutton .bleft.mid.new -text [mc "New version"] \
  	-command changediffdisp -variable diffelide -value {1 0}
      pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
      set ctext .bleft.ctext
@@ -761,10 +761,10 @@ proc makewindow {} {
      # lower right
      frame .bright
      frame .bright.mode
-    radiobutton .bright.mode.patch -text "Patch" \
+    radiobutton .bright.mode.patch -text [mc "Patch"] \
  	-command reselectline -variable cmitmode -value "patch"
      .bright.mode.patch configure -font $uifont
-    radiobutton .bright.mode.tree -text "Tree" \
+    radiobutton .bright.mode.tree -text [mc "Tree"] \
  	-command reselectline -variable cmitmode -value "tree"
      .bright.mode.tree configure -font $uifont
      grid .bright.mode.patch .bright.mode.tree -sticky ew
@@ -863,35 +863,35 @@ proc makewindow {} {

      set rowctxmenu .rowctxmenu
      menu $rowctxmenu -tearoff 0
-    $rowctxmenu add command -label "Diff this -> selected" \
+    $rowctxmenu add command -label [mc "Diff this -> selected"] \
  	-command {diffvssel 0}
-    $rowctxmenu add command -label "Diff selected -> this" \
+    $rowctxmenu add command -label [mc "Diff selected -> this"] \
  	-command {diffvssel 1}
-    $rowctxmenu add command -label "Make patch" -command mkpatch
-    $rowctxmenu add command -label "Create tag" -command mktag
-    $rowctxmenu add command -label "Write commit to file" -command =20
writecommit
-    $rowctxmenu add command -label "Create new branch" -command mkbran=
ch
-    $rowctxmenu add command -label "Cherry-pick this commit" \
+    $rowctxmenu add command -label [mc "Make patch"] -command mkpatch
+    $rowctxmenu add command -label [mc "Create tag"] -command mktag
+    $rowctxmenu add command -label [mc "Write commit to file"] =20
-command writecommit
+    $rowctxmenu add command -label [mc "Create new branch"] -command m=
kbranch
+    $rowctxmenu add command -label [mc "Cherry-pick this commit"] \
  	-command cherrypick
-    $rowctxmenu add command -label "Reset HEAD branch to here" \
+    $rowctxmenu add command -label [mc "Reset HEAD branch to here"] \
  	-command resethead

      set fakerowmenu .fakerowmenu
      menu $fakerowmenu -tearoff 0
-    $fakerowmenu add command -label "Diff this -> selected" \
+    $fakerowmenu add command -label [mc "Diff this -> selected"] \
  	-command {diffvssel 0}
-    $fakerowmenu add command -label "Diff selected -> this" \
+    $fakerowmenu add command -label [mc "Diff selected -> this"] \
  	-command {diffvssel 1}
-    $fakerowmenu add command -label "Make patch" -command mkpatch
-#    $fakerowmenu add command -label "Commit" -command {mkcommit 0}
-#    $fakerowmenu add command -label "Commit all" -command {mkcommit 1=
}
-#    $fakerowmenu add command -label "Revert local changes" -command =20
revertlocal
+    $fakerowmenu add command -label [mc "Make patch"] -command mkpatch
+#    $fakerowmenu add command -label [mc "Commit"] -command {mkcommit =
0}
+#    $fakerowmenu add command -label [mc "Commit all"] -command {mkcom=
mit 1}
+#    $fakerowmenu add command -label [mc "Revert local changes"] =20
-command revertlocal

      set headctxmenu .headctxmenu
      menu $headctxmenu -tearoff 0
-    $headctxmenu add command -label "Check out this branch" \
+    $headctxmenu add command -label [mc "Check out this branch"] \
  	-command cobranch
-    $headctxmenu add command -label "Remove this branch" \
+    $headctxmenu add command -label [mc "Remove this branch"] \
  	-command rmbranch
  }

@@ -1063,17 +1063,17 @@ proc about {} {
  	return
      }
      toplevel $w
-    wm title $w "About gitk"
-    message $w.m -text {
+    wm title $w [mc "About gitk"]
+    message $w.m -text [mc "
  Gitk - a commit viewer for git

  Copyright =A9 2005-2006 Paul Mackerras

-Use and redistribute under the terms of the GNU General Public License=
} \
+Use and redistribute under the terms of the GNU General Public License=
"] \
  	    -justify center -aspect 400 -border 2 -bg white -relief groove
      pack $w.m -side top -fill x -padx 2 -pady 2
      $w.m configure -font $uifont
-    button $w.ok -text Close -command "destroy $w" -default active
+    button $w.ok -text [mc Close] -command "destroy $w" -default activ=
e
      pack $w.ok -side bottom
      $w.ok configure -font $uifont
      bind $w <Visibility> "focus $w.ok"
@@ -1089,8 +1089,8 @@ proc keys {} {
  	return
      }
      toplevel $w
-    wm title $w "Gitk key bindings"
-    message $w.m -text {
+    wm title $w [mc "Gitk key bindings"]
+    message $w.m -text [mc "
  Gitk key bindings:

  <Ctrl-Q>		Quit
@@ -1128,11 +1128,11 @@ f		Scroll diff view to next file
  <Ctrl-KP->	Decrease font size
  <Ctrl-minus>	Decrease font size
  <F5>		Update
-} \
+] \
  	    -justify left -bg white -border 2 -relief groove
      pack $w.m -side top -fill both -padx 2 -pady 2
      $w.m configure -font $uifont
-    button $w.ok -text Close -command "destroy $w" -default active
+    button $w.ok -text [mc Close] -command "destroy $w" -default activ=
e
      pack $w.ok -side bottom
      $w.ok configure -font $uifont
      bind $w <Visibility> "focus $w.ok"
@@ -1580,7 +1580,7 @@ proc newview {ishighlight} {
      set newviewname($nextviewnum) "View $nextviewnum"
      set newviewperm($nextviewnum) 0
      set newviewargs($nextviewnum) [shellarglist $revtreeargs]
-    vieweditor $top $nextviewnum "Gitk view definition"
+    vieweditor $top $nextviewnum [mc "Gitk view definition"]
  }

  proc editview {} {
@@ -1605,20 +1605,20 @@ proc vieweditor {top n title} {

      toplevel $top
      wm title $top $title
-    label $top.nl -text "Name" -font $uifont
+    label $top.nl -text [mc "Name"] -font $uifont
      entry $top.name -width 20 -textvariable newviewname($n) -font $ui=
font
      grid $top.nl $top.name -sticky w -pady 5
-    checkbutton $top.perm -text "Remember this view" -variable =20
newviewperm($n) \
+    checkbutton $top.perm -text [mc "Remember this view"] -variable =20
newviewperm($n) \
  	-font $uifont
      grid $top.perm - -pady 5 -sticky w
      message $top.al -aspect 1000 -font $uifont \
-	-text "Commits to include (arguments to git rev-list):"
+	-text [mc "Commits to include (arguments to git rev-list):"]
      grid $top.al - -sticky w -pady 5
      entry $top.args -width 50 -textvariable newviewargs($n) \
  	-background white -font $uifont
      grid $top.args - -sticky ew -padx 5
      message $top.l -aspect 1000 -font $uifont \
-	-text "Enter files and directories to include, one per line:"
+	-text [mc "Enter files and directories to include, one per line:"]
      grid $top.l - -sticky w
      text $top.t -width 40 -height 10 -background white -font $uifont
      if {[info exists viewfiles($n)]} {
@@ -1631,9 +1631,9 @@ proc vieweditor {top n title} {
      }
      grid $top.t - -sticky ew -padx 5
      frame $top.buts
-    button $top.buts.ok -text "OK" -command [list newviewok $top $n] \
+    button $top.buts.ok -text [mc "OK"] -command [list newviewok $top =
$n] \
  	-font $uifont
-    button $top.buts.can -text "Cancel" -command [list destroy $top] \
+    button $top.buts.can -text [mc "Cancel"] -command [list destroy $t=
op] \
  	-font $uifont
      grid $top.buts.ok $top.buts.can
      grid columnconfigure $top.buts 0 -weight 1 -uniform a
@@ -1880,11 +1880,11 @@ proc showview {n} {
      }
      if {$phase ne {}} {
  	if {$phase eq "getcommits"} {
-	    show_status "Reading commits..."
+	    show_status [mc "Reading commits..."]
  	}
  	run chewcommits $n
      } elseif {$numcommits =3D=3D 0} {
-	show_status "No commits selected"
+	show_status [mc "No commits selected"]
      }
  }

@@ -2176,9 +2176,9 @@ proc askfindhighlight {row id} {
      set isbold 0
      set fldtypes {Headline Author Date Committer CDate Comments}
      foreach f $info ty $fldtypes {
-	if {($findloc eq "All fields" || $findloc eq $ty) &&
+	if {($findloc eq [mc "All fields"] || $findloc eq $ty) &&
  	    [doesmatch $f]} {
-	    if {$ty eq "Author"} {
+	    if {$ty eq [mc "Author"]} {
  		set isbold 2
  		break
  	    }
@@ -2221,7 +2221,7 @@ proc vrel_change {name ix op} {
      global highlight_related

      rhighlight_none
-    if {$highlight_related ne "None"} {
+    if {$highlight_related ne [mc "None"]} {
  	run drawvisible
      }
  }
@@ -2235,7 +2235,7 @@ proc rhighlight_sel {a} {
      set desc_todo [list $a]
      catch {unset ancestor}
      set anc_todo [list $a]
-    if {$highlight_related ne "None"} {
+    if {$highlight_related ne [mc "None"]} {
  	rhighlight_none
  	run drawvisible
      }
@@ -2318,20 +2318,20 @@ proc askrelhighlight {row id} {

      if {![info exists selectedline]} return
      set isbold 0
-    if {$highlight_related eq "Descendent" ||
-	$highlight_related eq "Not descendent"} {
+    if {$highlight_related eq [mc "Descendent"] ||
+	$highlight_related eq [mc "Not descendent"]} {
  	if {![info exists descendent($id)]} {
  	    is_descendent $id
  	}
-	if {$descendent($id) =3D=3D ($highlight_related eq "Descendent")} {
+	if {$descendent($id) =3D=3D ($highlight_related eq [mc "Descendent"])=
} {
  	    set isbold 1
  	}
-    } elseif {$highlight_related eq "Ancestor" ||
-	      $highlight_related eq "Not ancestor"} {
+    } elseif {$highlight_related eq [mc "Ancestor"] ||
+	      $highlight_related eq [mc "Not ancestor"]} {
  	if {![info exists ancestor($id)]} {
  	    is_ancestor $id
  	}
-	if {$ancestor($id) =3D=3D ($highlight_related eq "Ancestor")} {
+	if {$ancestor($id) =3D=3D ($highlight_related eq [mc "Ancestor"])} {
  	    set isbold 1
  	}
      }
@@ -2369,7 +2369,7 @@ proc next_hlcont {} {
  	    }
  	    if {$nhighlights($row) > 0} break
  	}
-	if {$highlight_related ne "None"} {
+	if {$highlight_related ne [mc "None"]} {
  	    if {![info exists rhighlights($row)]} {
  		askrelhighlight $row $id
  	    }
@@ -2406,7 +2406,7 @@ proc next_highlight {dirn} {

      if {![info exists selectedline]} return
      if {!([info exists hlview] || $findstring ne {} ||
-	  $highlight_related ne "None" || [info exists filehighlight])} retur=
n
+	  $highlight_related ne [mc "None"] || [info exists filehighlight])} =
return
      set fhl_row [expr {$selectedline + $dirn}]
      set fhl_dirn $dirn
      next_hlcont
@@ -2738,7 +2738,7 @@ proc readdiffindex {fd serial} {
      if {$serial =3D=3D $lserial && $localrow =3D=3D -1} {
  	# add the line for the local diff to the graph
  	set localrow $commitrow($curview,$mainheadid)
-	set hl "Local uncommitted changes"
+	set hl [mc "Local uncommitted changes"]
  	set commitinfo($nullid) [list  $hl {} {} {} {} "    $hl\n"]
  	set commitdata($nullid) "\n    $hl\n"
  	insertrow $localrow $nullid
@@ -2867,7 +2867,7 @@ proc addextraid {id row} {
      set commitrow($curview,$id) $row
      readcommit $id
      if {![info exists commitinfo($id)]} {
-	set commitinfo($id) {"No commit information available"}
+	set commitinfo($id) {[mc "No commit information available"]}
      }
      if {![info exists children($curview,$id)]} {
  	set children($curview,$id) {}
@@ -3441,7 +3441,7 @@ proc drawcmitrow {row} {
      if {$findstring ne {} && ![info exists nhighlights($row)]} {
  	askfindhighlight $row $id
      }
-    if {$highlight_related ne "None" && ![info exists rhighlights($row=
)]} {
+    if {$highlight_related ne [mc "None"] && ![info exists =20
rhighlights($row)]} {
  	askrelhighlight $row $id
      }
      if {[info exists iddrawn($id)]} return
@@ -3937,11 +3937,11 @@ proc notbusy {what} {

  proc findmatches {f} {
      global findtype findstring
-    if {$findtype =3D=3D "Regexp"} {
+    if {$findtype =3D=3D [mc "Regexp"]} {
  	set matches [regexp -indices -all -inline $findstring $f]
      } else {
  	set fs $findstring
-	if {$findtype =3D=3D "IgnCase"} {
+	if {$findtype =3D=3D [mc "IgnCase"]} {
  	    set f [string tolower $f]
  	    set fs [string tolower $fs]
  	}
@@ -4032,7 +4032,7 @@ proc findmore {} {
  	}
  	set info $commitinfo($id)
  	foreach f $info ty $fldtypes {
-	    if {($findloc eq "All fields" || $findloc eq $ty) &&
+	    if {($findloc eq [mc "All fields"] || $findloc eq $ty) &&
  		[doesmatch $f]} {
  		set markingmatches 1
  		findselectline $l
@@ -4078,7 +4078,7 @@ proc findmorerev {} {
  	}
  	set info $commitinfo($id)
  	foreach f $info ty $fldtypes {
-	    if {($findloc eq "All fields" || $findloc eq $ty) &&
+	    if {($findloc eq [mc "All fields"] || $findloc eq $ty) &&
  		[doesmatch $f]} {
  		set markingmatches 1
  		findselectline $l
@@ -4100,7 +4100,7 @@ proc findmorerev {} {
  proc findselectline {l} {
      global findloc commentend ctext
      selectline $l 1
-    if {$findloc =3D=3D "All fields" || $findloc =3D=3D "Comments"} {
+    if {$findloc =3D=3D [mc "All fields"] || $findloc =3D=3D [mc "Comm=
ents"]} {
  	# highlight the matches in the comments
  	set f [$ctext get 1.0 $commentend]
  	set matches [findmatches $f]
@@ -4388,11 +4388,11 @@ proc selectline {l isnew} {
      set linknum 0
      set info $commitinfo($id)
      set date [formatdate [lindex $info 2]]
-    $ctext insert end "Author: [lindex $info 1]  $date\n"
+    $ctext insert end "[mc "Author:"] [lindex $info 1]  $date\n"
      set date [formatdate [lindex $info 4]]
-    $ctext insert end "Committer: [lindex $info 3]  $date\n"
+    $ctext insert end "[mc "Committer:"] [lindex $info 3]  $date\n"
      if {[info exists idtags($id)]} {
-	$ctext insert end "Tags:"
+	$ctext insert end [mc "Tags:"]
  	foreach tag $idtags($id) {
  	    $ctext insert end " $tag"
  	}
@@ -4409,18 +4409,18 @@ proc selectline {l isnew} {
  	    } else {
  		set tag m$np
  	    }
-	    $ctext insert end "Parent: " $tag
+	    $ctext insert end "[mc "Parent:"] " $tag
  	    appendwithlinks [commit_descriptor $p] {}
  	    incr np
  	}
      } else {
  	foreach p $olds {
-	    append headers "Parent: [commit_descriptor $p]"
+	    append headers "[mc "Parent:"] [commit_descriptor $p]"
  	}
      }

      foreach c $children($curview,$id) {
-	append headers "Child:  [commit_descriptor $c]"
+	append headers "[mc "Child:"]  [commit_descriptor $c]"
      }

      # make anything that looks like a SHA1 ID be a clickable link
@@ -4429,13 +4429,13 @@ proc selectline {l isnew} {
  	if {![info exists allcommits]} {
  	    getallcommits
  	}
-	$ctext insert end "Branch: "
+	$ctext insert end "[mc "Branch:"] "
  	$ctext mark set branch "end -1c"
  	$ctext mark gravity branch left
-	$ctext insert end "\nFollows: "
+	$ctext insert end "\n[mc "Follows:"] "
  	$ctext mark set follows "end -1c"
  	$ctext mark gravity follows left
-	$ctext insert end "\nPrecedes: "
+	$ctext insert end "\n[mc "Precedes:"] "
  	$ctext mark set precedes "end -1c"
  	$ctext mark gravity precedes left
  	$ctext insert end "\n"
@@ -4452,7 +4452,7 @@ proc selectline {l isnew} {
      $ctext conf -state disabled
      set commentend [$ctext index "end - 1c"]

-    init_flist "Comments"
+    init_flist [mc "Comments"]
      if {$cmitmode eq "tree"} {
  	gettree $id
      } elseif {[llength $olds] <=3D 1} {
@@ -5238,9 +5238,9 @@ proc sha1change {n1 n2 op} {
      }
      if {[$sha1but cget -state] =3D=3D $state} return
      if {$state =3D=3D "normal"} {
-	$sha1but conf -state normal -relief raised -text "Goto: "
+	$sha1but conf -state normal -relief raised -text "[mc "Goto:"] "
      } else {
-	$sha1but conf -state disabled -relief flat -text "SHA1 ID: "
+	$sha1but conf -state disabled -relief flat -text "[mc "SHA1 ID:"] "
      }
  }

@@ -5265,7 +5265,7 @@ proc gotocommit {} {
  	    }
  	    if {$matches ne {}} {
  		if {[llength $matches] > 1} {
-		    error_popup "Short SHA1 id $id is ambiguous"
+		    error_popup [mc "Short SHA1 id %s is ambiguous" $id]
  		    return
  		}
  		set id [lindex $matches 0]
@@ -5413,17 +5413,17 @@ proc lineclick {x y id isnew} {
      $ctext tag conf link -foreground blue -underline 1
      $ctext tag bind link <Enter> { %W configure -cursor hand2 }
      $ctext tag bind link <Leave> { %W configure -cursor $curtextcurso=
r }
-    $ctext insert end "Parent:\t"
+    $ctext insert end "[mc "Parent:"]\t"
      $ctext insert end $id [list link link0]
      $ctext tag bind link0 <1> [list selbyid $id]
      set info $commitinfo($id)
      $ctext insert end "\n\t[lindex $info 0]\n"
-    $ctext insert end "\tAuthor:\t[lindex $info 1]\n"
+    $ctext insert end "\t[mc "Author:"]\t[lindex $info 1]\n"
      set date [formatdate [lindex $info 2]]
-    $ctext insert end "\tDate:\t$date\n"
+    $ctext insert end "\t[mc "Date:"]\t$date\n"
      set kids $children($curview,$id)
      if {$kids ne {}} {
-	$ctext insert end "\nChildren:"
+	$ctext insert end "\n[mc "Children:"]"
  	set i 0
  	foreach child $kids {
  	    incr i
@@ -5433,9 +5433,9 @@ proc lineclick {x y id isnew} {
  	    $ctext insert end $child [list link link$i]
  	    $ctext tag bind link$i <1> [list selbyid $child]
  	    $ctext insert end "\n\t[lindex $info 0]"
-	    $ctext insert end "\n\tAuthor:\t[lindex $info 1]"
+	    $ctext insert end "\n\t[mc "Author:"]\t[lindex $info 1]"
  	    set date [formatdate [lindex $info 2]]
-	    $ctext insert end "\n\tDate:\t$date\n"
+	    $ctext insert end "\n\t[mc "Date:"]\t$date\n"
  	}
      }
      $ctext conf -state disabled
@@ -5479,13 +5479,13 @@ proc rowmenu {x y id} {
      }
      if {$id ne $nullid} {
  	set menu $rowctxmenu
-	$menu entryconfigure 7 -label "Reset $mainhead branch to here"
+	$menu entryconfigure 7 -label [mc "Reset %s branch to here" $mainhead=
]
      } else {
  	set menu $fakerowmenu
      }
-    $menu entryconfigure "Diff this*" -state $state
-    $menu entryconfigure "Diff selected*" -state $state
-    $menu entryconfigure "Make patch" -state $state
+    $menu entryconfigure [mc "Diff this*"] -state $state
+    $menu entryconfigure [mc "Diff selected*"] -state $state
+    $menu entryconfigure [mc "Make patch"] -state $state
      tk_popup $menu $x $y
  }

@@ -5510,8 +5510,8 @@ proc doseldiff {oldid newid} {

      $ctext conf -state normal
      clear_ctext
-    init_flist "Top"
-    $ctext insert end "From "
+    init_flist [mc "Top"]
+    $ctext insert end [mc "From "]
      $ctext tag conf link -foreground blue -underline 1
      $ctext tag bind link <Enter> { %W configure -cursor hand2 }
      $ctext tag bind link <Leave> { %W configure -cursor $curtextcurso=
r }
@@ -5519,7 +5519,7 @@ proc doseldiff {oldid newid} {
      $ctext insert end $oldid [list link link0]
      $ctext insert end "\n     "
      $ctext insert end [lindex $commitinfo($oldid) 0]
-    $ctext insert end "\n\nTo   "
+    $ctext insert end "\n\n[mc "To"]   "
      $ctext tag bind link1 <1> [list selbyid $newid]
      $ctext insert end $newid [list link link1]
      $ctext insert end "\n     "
@@ -5542,9 +5542,9 @@ proc mkpatch {} {
      set patchtop $top
      catch {destroy $top}
      toplevel $top
-    label $top.title -text "Generate patch"
+    label $top.title -text [mc "Generate patch"]
      grid $top.title - -pady 10
-    label $top.from -text "From:"
+    label $top.from -text [mc "From:"]
      entry $top.fromsha1 -width 40 -relief flat
      $top.fromsha1 insert 0 $oldid
      $top.fromsha1 conf -state readonly
@@ -5553,7 +5553,7 @@ proc mkpatch {} {
      $top.fromhead insert 0 $oldhead
      $top.fromhead conf -state readonly
      grid x $top.fromhead -sticky w
-    label $top.to -text "To:"
+    label $top.to -text [mc "To:"]
      entry $top.tosha1 -width 40 -relief flat
      $top.tosha1 insert 0 $newid
      $top.tosha1 conf -state readonly
@@ -5562,16 +5562,16 @@ proc mkpatch {} {
      $top.tohead insert 0 $newhead
      $top.tohead conf -state readonly
      grid x $top.tohead -sticky w
-    button $top.rev -text "Reverse" -command mkpatchrev -padx 5
+    button $top.rev -text [mc "Reverse"] -command mkpatchrev -padx 5
      grid $top.rev x -pady 10
-    label $top.flab -text "Output file:"
+    label $top.flab -text [mc "Output file:"]
      entry $top.fname -width 60
      $top.fname insert 0 [file normalize "patch$patchnum.patch"]
      incr patchnum
      grid $top.flab $top.fname -sticky w
      frame $top.buts
-    button $top.buts.gen -text "Generate" -command mkpatchgo
-    button $top.buts.can -text "Cancel" -command mkpatchcan
+    button $top.buts.gen -text [mc "Generate"] -command mkpatchgo
+    button $top.buts.can -text [mc "Cancel"] -command mkpatchcan
      grid $top.buts.gen $top.buts.can
      grid columnconfigure $top.buts 0 -weight 1 -uniform a
      grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -5630,9 +5630,9 @@ proc mktag {} {
      set mktagtop $top
      catch {destroy $top}
      toplevel $top
-    label $top.title -text "Create tag"
+    label $top.title -text [mc "Create tag"]
      grid $top.title - -pady 10
-    label $top.id -text "ID:"
+    label $top.id -text [mc "ID:"]
      entry $top.sha1 -width 40 -relief flat
      $top.sha1 insert 0 $rowmenuid
      $top.sha1 conf -state readonly
@@ -5641,12 +5641,12 @@ proc mktag {} {
      $top.head insert 0 [lindex $commitinfo($rowmenuid) 0]
      $top.head conf -state readonly
      grid x $top.head -sticky w
-    label $top.tlab -text "Tag name:"
+    label $top.tlab -text [mc "Tag name:"]
      entry $top.tag -width 60
      grid $top.tlab $top.tag -sticky w
      frame $top.buts
-    button $top.buts.gen -text "Create" -command mktaggo
-    button $top.buts.can -text "Cancel" -command mktagcan
+    button $top.buts.gen -text [mc "Create"] -command mktaggo
+    button $top.buts.can -text [mc "Cancel"] -command mktagcan
      grid $top.buts.gen $top.buts.can
      grid columnconfigure $top.buts 0 -weight 1 -uniform a
      grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -5660,11 +5660,11 @@ proc domktag {} {
      set id [$mktagtop.sha1 get]
      set tag [$mktagtop.tag get]
      if {$tag =3D=3D {}} {
-	error_popup "No tag name specified"
+	error_popup [mc "No tag name specified"]
  	return
      }
      if {[info exists tagids($tag)]} {
-	error_popup "Tag \"$tag\" already exists"
+	error_popup [mc "Tag \"%s\" already exists" $tag]
  	return
      }
      if {[catch {
@@ -5725,9 +5725,9 @@ proc writecommit {} {
      set wrcomtop $top
      catch {destroy $top}
      toplevel $top
-    label $top.title -text "Write commit to file"
+    label $top.title -text [mc "Write commit to file"]
      grid $top.title - -pady 10
-    label $top.id -text "ID:"
+    label $top.id -text [mc "ID:"]
      entry $top.sha1 -width 40 -relief flat
      $top.sha1 insert 0 $rowmenuid
      $top.sha1 conf -state readonly
@@ -5736,16 +5736,16 @@ proc writecommit {} {
      $top.head insert 0 [lindex $commitinfo($rowmenuid) 0]
      $top.head conf -state readonly
      grid x $top.head -sticky w
-    label $top.clab -text "Command:"
+    label $top.clab -text [mc "Command:"]
      entry $top.cmd -width 60 -textvariable wrcomcmd
      grid $top.clab $top.cmd -sticky w -pady 10
-    label $top.flab -text "Output file:"
+    label $top.flab -text [mc "Output file:"]
      entry $top.fname -width 60
      $top.fname insert 0 [file normalize "commit-[string range =20
$rowmenuid 0 6]"]
      grid $top.flab $top.fname -sticky w
      frame $top.buts
-    button $top.buts.gen -text "Write" -command wrcomgo
-    button $top.buts.can -text "Cancel" -command wrcomcan
+    button $top.buts.gen -text [mc "Write"] -command wrcomgo
+    button $top.buts.can -text [mc "Cancel"] -command wrcomcan
      grid $top.buts.gen $top.buts.can
      grid columnconfigure $top.buts 0 -weight 1 -uniform a
      grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -5779,19 +5779,19 @@ proc mkbranch {} {
      set top .makebranch
      catch {destroy $top}
      toplevel $top
-    label $top.title -text "Create new branch"
+    label $top.title -text [mc "Create new branch"]
      grid $top.title - -pady 10
-    label $top.id -text "ID:"
+    label $top.id -text [mc "ID:"]
      entry $top.sha1 -width 40 -relief flat
      $top.sha1 insert 0 $rowmenuid
      $top.sha1 conf -state readonly
      grid $top.id $top.sha1 -sticky w
-    label $top.nlab -text "Name:"
+    label $top.nlab -text [mc "Name:"]
      entry $top.name -width 40
      grid $top.nlab $top.name -sticky w
      frame $top.buts
-    button $top.buts.go -text "Create" -command [list mkbrgo $top]
-    button $top.buts.can -text "Cancel" -command "catch {destroy $top}=
"
+    button $top.buts.go -text [mc "Create"] -command [list mkbrgo $top=
]
+    button $top.buts.can -text [mc "Cancel"] -command "catch {destroy =
$top}"
      grid $top.buts.go $top.buts.can
      grid columnconfigure $top.buts 0 -weight 1 -uniform a
      grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -5805,7 +5805,7 @@ proc mkbrgo {top} {
      set name [$top.name get]
      set id [$top.sha1 get]
      if {$name eq {}} {
-	error_popup "Please specify a name for the new branch"
+	error_popup [mc "Please specify a name for the new branch"]
  	return
      }
      catch {destroy $top}
@@ -5849,7 +5849,7 @@ proc cherrypick {} {
      set newhead [exec git rev-parse HEAD]
      if {$newhead eq $oldhead} {
  	notbusy cherrypick
-	error_popup "No changes committed"
+	error_popup [mc "No changes committed"]
  	return
      }
      addnewchild $newhead $oldhead
@@ -5873,28 +5873,28 @@ proc resethead {} {
      set w ".confirmreset"
      toplevel $w
      wm transient $w .
-    wm title $w "Confirm reset"
+    wm title $w [mc "Confirm reset"]
      message $w.m -text \
-	"Reset branch $mainhead to [string range $rowmenuid 0 7]?" \
+	[mc "Reset branch %s to %s?" $mainhead [string range $rowmenuid 0 7]]=
 \
  	-justify center -aspect 1000
      pack $w.m -side top -fill x -padx 20 -pady 20
      frame $w.f -relief sunken -border 2
-    message $w.f.rt -text "Reset type:" -aspect 1000
+    message $w.f.rt -text [mc "Reset type:"] -aspect 1000
      grid $w.f.rt -sticky w
      set resettype mixed
      radiobutton $w.f.soft -value soft -variable resettype -justify le=
ft \
-	-text "Soft: Leave working tree and index untouched"
+	-text [mc "Soft: Leave working tree and index untouched"]
      grid $w.f.soft -sticky w
      radiobutton $w.f.mixed -value mixed -variable resettype -justify =
left \
-	-text "Mixed: Leave working tree untouched, reset index"
+	-text [mc "Mixed: Leave working tree untouched, reset index"]
      grid $w.f.mixed -sticky w
      radiobutton $w.f.hard -value hard -variable resettype -justify le=
ft \
-	-text "Hard: Reset working tree and index\n(discard ALL local changes=
)"
+	-text [mc "Hard: Reset working tree and index\n(discard ALL local cha=
nges)"]
      grid $w.f.hard -sticky w
      pack $w.f -side top -fill x
-    button $w.ok -text OK -command "set confirm_ok 1; destroy $w"
+    button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
      pack $w.ok -side left -fill x -padx 20 -pady 20
-    button $w.cancel -text Cancel -command "destroy $w"
+    button $w.cancel -text [mc Cancel] -command "destroy $w"
      pack $w.cancel -side right -fill x -padx 20 -pady 20
      bind $w <Visibility> "grab $w; focus $w"
      tkwait window $w
@@ -5908,8 +5908,8 @@ proc resethead {} {
  	filerun $fd [list readresetstat $fd $w]
  	toplevel $w
  	wm transient $w
-	wm title $w "Reset progress"
-	message $w.m -text "Reset in progress, please wait..." \
+	wm title $w [mc "Reset progress"]
+	message $w.m -text [mc "Reset in progress, please wait..."] \
  	    -justify center -aspect 1000
  	pack $w.m -side top -fill x -padx 20 -pady 5
  	canvas $w.c -width 150 -height 20 -bg white
@@ -6000,7 +6000,7 @@ proc rmbranch {} {
      set id $headmenuid
      # this check shouldn't be needed any more...
      if {$head eq $mainhead} {
-	error_popup "Cannot delete the currently checked-out branch"
+	error_popup [mc "Cannot delete the currently checked-out branch"]
  	return
      }
      set dheads [descheads $id]
@@ -6959,7 +6959,7 @@ proc showtag {tag isnew} {
      if {[info exists tagcontents($tag)]} {
  	set text $tagcontents($tag)
      } else {
-	set text "Tag: $tag\nId:  $tagids($tag)"
+	set text "[mc "Tag:"] $tag\n[mc "Id:"]  $tagids($tag)"
      }
      appendwithlinks $text {}
      $ctext conf -state disabled
@@ -6989,77 +6989,77 @@ proc doprefs {} {
  	set oldprefs($v) [set $v]
      }
      toplevel $top
-    wm title $top "Gitk preferences"
-    label $top.ldisp -text "Commit list display options"
+    wm title $top [mc "Gitk preferences"]
+    label $top.ldisp -text [mc "Commit list display options"]
      $top.ldisp configure -font $uifont
      grid $top.ldisp - -sticky w -pady 10
      label $top.spacer -text " "
-    label $top.maxwidthl -text "Maximum graph width (lines)" \
+    label $top.maxwidthl -text [mc "Maximum graph width (lines)"] \
  	-font optionfont
      spinbox $top.maxwidth -from 0 -to 100 -width 4 -textvariable maxw=
idth
      grid $top.spacer $top.maxwidthl $top.maxwidth -sticky w
-    label $top.maxpctl -text "Maximum graph width (% of pane)" \
+    label $top.maxpctl -text [mc "Maximum graph width (% of pane)"] \
  	-font optionfont
      spinbox $top.maxpct -from 1 -to 100 -width 4 -textvariable maxgra=
phpct
      grid x $top.maxpctl $top.maxpct -sticky w
      frame $top.showlocal
-    label $top.showlocal.l -text "Show local changes" -font optionfont
+    label $top.showlocal.l -text [mc "Show local changes"] -font optio=
nfont
      checkbutton $top.showlocal.b -variable showlocalchanges
      pack $top.showlocal.b $top.showlocal.l -side left
      grid x $top.showlocal -sticky w

-    label $top.ddisp -text "Diff display options"
+    label $top.ddisp -text [mc "Diff display options"]
      $top.ddisp configure -font $uifont
      grid $top.ddisp - -sticky w -pady 10
-    label $top.diffoptl -text "Options for diff program" \
+    label $top.diffoptl -text [mc "Options for diff program"] \
  	-font optionfont
      entry $top.diffopt -width 20 -textvariable diffopts
      grid x $top.diffoptl $top.diffopt -sticky w
      frame $top.ntag
-    label $top.ntag.l -text "Display nearby tags" -font optionfont
+    label $top.ntag.l -text [mc "Display nearby tags"] -font optionfon=
t
      checkbutton $top.ntag.b -variable showneartags
      pack $top.ntag.b $top.ntag.l -side left
      grid x $top.ntag -sticky w
-    label $top.tabstopl -text "tabstop" -font optionfont
+    label $top.tabstopl -text [mc "tabstop"] -font optionfont
      spinbox $top.tabstop -from 1 -to 20 -width 4 -textvariable tabsto=
p
      grid x $top.tabstopl $top.tabstop -sticky w

-    label $top.cdisp -text "Colors: press to choose"
+    label $top.cdisp -text [mc "Colors: press to choose"]
      $top.cdisp configure -font $uifont
      grid $top.cdisp - -sticky w -pady 10
      label $top.bg -padx 40 -relief sunk -background $bgcolor
-    button $top.bgbut -text "Background" -font optionfont \
+    button $top.bgbut -text [mc "Background"] -font optionfont \
  	-command [list choosecolor bgcolor 0 $top.bg background setbg]
      grid x $top.bgbut $top.bg -sticky w
      label $top.fg -padx 40 -relief sunk -background $fgcolor
-    button $top.fgbut -text "Foreground" -font optionfont \
+    button $top.fgbut -text [mc "Foreground"] -font optionfont \
  	-command [list choosecolor fgcolor 0 $top.fg foreground setfg]
      grid x $top.fgbut $top.fg -sticky w
      label $top.diffold -padx 40 -relief sunk -background [lindex =20
$diffcolors 0]
-    button $top.diffoldbut -text "Diff: old lines" -font optionfont \
+    button $top.diffoldbut -text [mc "Diff: old lines"] -font optionfo=
nt \
  	-command [list choosecolor diffcolors 0 $top.diffold "diff old lines=
" \
  		      [list $ctext tag conf d0 -foreground]]
      grid x $top.diffoldbut $top.diffold -sticky w
      label $top.diffnew -padx 40 -relief sunk -background [lindex =20
$diffcolors 1]
-    button $top.diffnewbut -text "Diff: new lines" -font optionfont \
+    button $top.diffnewbut -text [mc "Diff: new lines"] -font optionfo=
nt \
  	-command [list choosecolor diffcolors 1 $top.diffnew "diff new lines=
" \
  		      [list $ctext tag conf d1 -foreground]]
      grid x $top.diffnewbut $top.diffnew -sticky w
      label $top.hunksep -padx 40 -relief sunk -background [lindex =20
$diffcolors 2]
-    button $top.hunksepbut -text "Diff: hunk header" -font optionfont =
\
+    button $top.hunksepbut -text [mc "Diff: hunk header"] -font option=
font \
  	-command [list choosecolor diffcolors 2 $top.hunksep \
  		      "diff hunk header" \
  		      [list $ctext tag conf hunksep -foreground]]
      grid x $top.hunksepbut $top.hunksep -sticky w
      label $top.selbgsep -padx 40 -relief sunk -background $selectbgco=
lor
-    button $top.selbgbut -text "Select bg" -font optionfont \
+    button $top.selbgbut -text [mc "Select bg"] -font optionfont \
  	-command [list choosecolor selectbgcolor 0 $top.selbgsep background =
=20
setselbg]
      grid x $top.selbgbut $top.selbgsep -sticky w

      frame $top.buts
-    button $top.buts.ok -text "OK" -command prefsok -default active
+    button $top.buts.ok -text [mc "OK"] -command prefsok -default acti=
ve
      $top.buts.ok configure -font $uifont
-    button $top.buts.can -text "Cancel" -command prefscan -default nor=
mal
+    button $top.buts.can -text [mc "Cancel"] -command prefscan =20
-default normal
      $top.buts.can configure -font $uifont
      grid $top.buts.ok $top.buts.can
      grid columnconfigure $top.buts 0 -weight 1 -uniform a
@@ -7072,7 +7072,7 @@ proc choosecolor {v vi w x cmd} {
      global $v

      set c [tk_chooseColor -initialcolor [lindex [set $v] $vi] \
-	       -title "Gitk: choose color for $x"]
+	       -title [mc "Gitk: choose color for %s" $x]]
      if {$c eq {}} return
      $w conf -background $c
      lset $v $vi $c
@@ -7569,7 +7569,7 @@ if {$cmdline_files ne {} || $revtreeargs ne {}} {
      set curview 1
      set selectedview 1
      set nextviewnum 2
-    set viewname(1) "Command line"
+    set viewname(1) [mc "Command line"]
      set viewfiles(1) $cmdline_files
      set viewargs(1) $revtreeargs
      set viewperm(1) 0
--=20
1.5.3.rc2.12.gbc280
