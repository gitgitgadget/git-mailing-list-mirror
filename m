From: Christian Stimming <stimming@tuhh.de>
Subject: Re: git-gui-i18n: Make "Revert changes in these $n files"
	translatable.
Date: Thu, 26 Jul 2007 14:34:49 +0200
Message-ID: <20070726143449.iklqfh5c6c48844k@webmail.tu-harburg.de>
References: <20070726104723.ugsfnbj1ogw8gg4k@webmail.tu-harburg.de>
	<20070726115301.GA27821@cc.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
To: Harri Ilari Tapio Liusvaara <hliusvaa@cc.hut.fi>
X-From: git-owner@vger.kernel.org Thu Jul 26 14:36:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE2Zc-0000zj-AY
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 14:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759799AbXGZMff (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 08:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758446AbXGZMff
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 08:35:35 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:60820 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758750AbXGZMfd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2007 08:35:33 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6QCYoxg012763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 26 Jul 2007 14:34:50 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6QCYoZA016000;
	Thu, 26 Jul 2007 14:34:50 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id 178FDE50349; Thu, 26 Jul 2007 14:34:49 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Thu, 26 Jul 2007
	14:34:49 +0200
In-Reply-To: <20070726115301.GA27821@cc.hut.fi>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53824>

Quoting Harri Ilari Tapio Liusvaara <hliusvaa@cc.hut.fi>:
> On Thu, Jul 26, 2007 at 10:47:23AM +0200, Christian Stimming wrote:
>> The issue with plural forms is even more complicated than that.
>
> Yes, I know that some languages have very complex plural forms. I even
> tought about that, but forgot to tack in FIXME comment. :-(

Ok. Thanks for adding the explanation.

> One can do bit nasty workarounds for the msgcat's inability to do
> proper plural form translation.

I don't think any workarounds for the plural forms would bring us very  
far. For now, I think it is just fine to state there is no plural form  
support in msgcat, so we can't use it. (That being said, I think the  
approach taken by gettext is by far the best one: Let the translator  
define the available plural forms inside the po file header by  
"Plural-Forms:". One would have to transfer this information over to  
tcl and add the necessary instrumentation into msgcat to process this  
expression. Maybe some day, some time.)

> BTW: Here is list of some missed translations:
>
> - Git version query when it can't grok the version (the yes/no one).
> - 3 Menu entries in "Repository" menu ("Browse branch files", "Browse
>   foo's files", "Visualize foo's history".

Thanks for all of them. I think now I caught them all. See patch  
below, which I'll push but not before the weekend (due to firewall  
restrictions).

> - Font setting names in options window.

You mean the names of the fonts? But those are names. I thought by  
definition they cannot be translated.

> - "Starting revision" in branch create window.
> - "Revision" in branch checkout window.

Thanks, fixed.

> - Buttons in hard reset confirmation (branch->revert or merge->abort,
>   and it is yes/no dialog).

I see this in translated form (German Ja/Nein), and also the button  
text (translated or not) doesn't appear in the git-gui source code.  
Maybe those need to be translated in the tcl/tk system libraries?

> - "Fetch from foo" entries in fetch menu.

Done. Thanks a lot.

---
  git-gui.sh              |   16 ++++++++--------
  lib/branch_checkout.tcl |    2 +-
  lib/branch_create.tcl   |    2 +-
  lib/browser.tcl         |    2 +-
  lib/checkout_op.tcl     |    2 +-
  lib/option.tcl          |    3 +--
  lib/remote.tcl          |    2 +-
  7 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 3536d38..9f903ba 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -564,14 +564,14 @@ if {![regexp {^[1-9]+(\.[0-9]+)+$} $_git_version]} {
  		-type yesno \
  		-default no \
  		-title "[appname]: warning" \
-		-message "Git version cannot be determined.
+		 -message [mc "Git version cannot be determined.

-$_git claims it is version '$_real_git_version'.
+%s claims it is version '%s'.

-[appname] requires at least Git 1.5.0 or later.
+%s requires at least Git 1.5.0 or later.

-Assume '$_real_git_version' is version 1.5.0?
-"] eq {yes}} {
+Assume '%s' is version 1.5.0?
+" $_git $_real_git_version [appname] $_real_git_version]] eq {yes}} {
  		set _git_version 1.5.0
  	} else {
  		exit 1
@@ -1689,16 +1689,16 @@ menu .mbar.repository
  .mbar.repository add command \
  	-label [mc "Browse Current Branch's Files"] \
  	-command {browser::new $current_branch}
-trace add variable current_branch write ".mbar.repository entryconf  
[.mbar.repository index last] -label \"Browse \$current_branch's  
Files\" ;#"
+trace add variable current_branch write ".mbar.repository entryconf  
[.mbar.repository index last] -label \[format \"[mc "Browse %s's  
Files"]\" \$current_branch\] ;#"
  .mbar.repository add command \
-	-label {Browse Branch Files...} \
+	-label [mc "Browse Branch Files..."] \
  	-command browser_open::dialog
  .mbar.repository add separator

  .mbar.repository add command \
  	-label [mc "Visualize Current Branch's History"] \
  	-command {do_gitk $current_branch}
-trace add variable current_branch write ".mbar.repository entryconf  
[.mbar.repository index last] -label \"Visualize \$current_branch's  
History\" ;#"
+trace add variable current_branch write ".mbar.repository entryconf  
[.mbar.repository index last] -label \[format \"[mc "Visualize %s's  
History"]\" \$current_branch\] ;#"
  .mbar.repository add command \
  	-label [mc "Visualize All Branch History"] \
  	-command {do_gitk --all}
diff --git a/lib/branch_checkout.tcl b/lib/branch_checkout.tcl
index c727437..7d71821 100644
--- a/lib/branch_checkout.tcl
+++ b/lib/branch_checkout.tcl
@@ -29,7 +29,7 @@ constructor dialog {} {
  	pack $w.buttons.cancel -side right -padx 5
  	pack $w.buttons -side bottom -fill x -pady 10 -padx 10

-	set w_rev [::choose_rev::new $w.rev {Revision}]
+	set w_rev [::choose_rev::new $w.rev [mc Revision]]
  	$w_rev bind_listbox <Double-Button-1> [cb _checkout]
  	pack $w.rev -anchor nw -fill both -expand 1 -pady 5 -padx 5

diff --git a/lib/branch_create.tcl b/lib/branch_create.tcl
index acfe411..53dfb4c 100644
--- a/lib/branch_create.tcl
+++ b/lib/branch_create.tcl
@@ -63,7 +63,7 @@ constructor dialog {} {
  	grid columnconfigure $w.desc 1 -weight 1
  	pack $w.desc -anchor nw -fill x -pady 5 -padx 5

-	set w_rev [::choose_rev::new $w.rev {Starting Revision}]
+	set w_rev [::choose_rev::new $w.rev [mc "Starting Revision"]]
  	pack $w.rev -anchor nw -fill both -expand 1 -pady 5 -padx 5

  	labelframe $w.options -text [mc Options]
diff --git a/lib/browser.tcl b/lib/browser.tcl
index 9435e67..f9cfc6a 100644
--- a/lib/browser.tcl
+++ b/lib/browser.tcl
@@ -271,7 +271,7 @@ constructor dialog {} {
  	pack $w.buttons.cancel -side right -padx 5
  	pack $w.buttons -side bottom -fill x -pady 10 -padx 10

-	set w_rev [::choose_rev::new $w.rev {Revision}]
+	set w_rev [::choose_rev::new $w.rev [mc Revision]]
  	$w_rev bind_listbox <Double-Button-1> [cb _open]
  	pack $w.rev -anchor nw -fill both -expand 1 -pady 5 -padx 5

diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
index 25bf9cf..d2fbc30 100644
--- a/lib/checkout_op.tcl
+++ b/lib/checkout_op.tcl
@@ -76,7 +76,7 @@ method run {} {
  		_toplevel $this {Refreshing Tracking Branch}
  		set w_cons [::console::embed \
  			$w.console \
-			"Fetching $r_name from $remote"]
+			[mc "Fetching %s from %s" $r_name $remote]]
  		pack $w.console -fill both -expand 1
  		$w_cons exec $cmd [cb _finish_fetch]

diff --git a/lib/option.tcl b/lib/option.tcl
index 8d9e09d..20f1e8e 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -74,8 +74,7 @@ proc do_about {} {
  	pack $w.buttons -side bottom -fill x -pady 10 -padx 10

  	label $w.desc \
-		-text [append [mc "git-gui - a graphical user interface for Git."] "
-$copyright"] \
+		-text "[mc "git-gui - a graphical user interface for Git."]\n$copyright" \
  		-padx 5 -pady 5 \
  		-justify left \
  		-anchor w \
diff --git a/lib/remote.tcl b/lib/remote.tcl
index c47ae50..71c7a0d 100644
--- a/lib/remote.tcl
+++ b/lib/remote.tcl
@@ -153,7 +153,7 @@ proc populate_fetch_menu {} {
  		if {$enable} {
  			lappend prune_list $r
  			$m add command \
-				-label "Fetch from $r..." \
+				-label [mc "Fetch from %s..." $r] \
  				-command [list fetch_from $r]
  		}
  	}
-- 
1.5.3.rc2.12.gbc280
