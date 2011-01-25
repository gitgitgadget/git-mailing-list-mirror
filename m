From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: add config value gui.diffopts for passing additional diff options
Date: Tue, 25 Jan 2011 00:25:48 +0000
Message-ID: <87ipxdn81f.fsf@fox.patthoyts.tk>
References: <1295607585-15971-1-git-send-email-tilman.vogel@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tilman Vogel <tilman.vogel@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 25 01:26:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhWjo-0004pU-9A
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 01:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab1AYAZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 19:25:52 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:45444 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752799Ab1AYAZv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jan 2011 19:25:51 -0500
Received: from [172.23.170.142] (helo=anti-virus02-09)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1PhWjG-0004rc-Fz; Tue, 25 Jan 2011 00:25:50 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1PhWjE-000773-Pl; Tue, 25 Jan 2011 00:25:48 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 87E1521E0E; Tue, 25 Jan 2011 00:25:48 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <1295607585-15971-1-git-send-email-tilman.vogel@web.de> (Tilman
	Vogel's message of "Fri, 21 Jan 2011 11:59:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165465>

Tilman Vogel <tilman.vogel@web.de> writes:

>Signed-off-by: Tilman Vogel <tilman.vogel@web.de>
>---
> Documentation/config.txt |    4 ++++
> git-gui/git-gui.sh       |    1 +
> git-gui/lib/diff.tcl     |    1 +
> git-gui/lib/option.tcl   |    1 +
> 4 files changed, 7 insertions(+), 0 deletions(-)
>
>diff --git a/Documentation/config.txt b/Documentation/config.txt
>index ff7c225..0ed7bcf 100644
>--- a/Documentation/config.txt
>+++ b/Documentation/config.txt
>@@ -1100,6 +1100,10 @@ gui.diffcontext::
> 	Specifies how many context lines should be used in calls to diff
> 	made by the linkgit:git-gui[1]. The default is "5".
> 
>+gui.diffopts::
>+	Specifies additional parameters to pass to diff from 
>+	linkgit:git-gui[1]. The default is "".
>+
> gui.encoding::
> 	Specifies the default encoding to use for displaying of
> 	file contents in linkgit:git-gui[1] and linkgit:gitk[1].
>diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>index d3acf0d..2a3aed5 100755
>--- a/git-gui/git-gui.sh
>+++ b/git-gui/git-gui.sh
>@@ -823,6 +823,7 @@ set default_config(gui.fastcopyblame) false
> set default_config(gui.copyblamethreshold) 40
> set default_config(gui.blamehistoryctx) 7
> set default_config(gui.diffcontext) 5
>+set default_config(gui.diffopts) {}
> set default_config(gui.commitmsgwidth) 75
> set default_config(gui.newbranchtemplate) {}
> set default_config(gui.spellingdictionary) {}
>diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
>index dcf0711..de3827a 100644
>--- a/git-gui/lib/diff.tcl
>+++ b/git-gui/lib/diff.tcl
>@@ -295,6 +295,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
> 
> 	lappend cmd -p
> 	lappend cmd --color
>+	set cmd [concat $cmd $repo_config(gui.diffopts)]
> 	if {$repo_config(gui.diffcontext) >= 1} {
> 		lappend cmd "-U$repo_config(gui.diffcontext)"
> 	}
>diff --git a/git-gui/lib/option.tcl b/git-gui/lib/option.tcl
>index 3807c8d..1e5d28c 100644
>--- a/git-gui/lib/option.tcl
>+++ b/git-gui/lib/option.tcl
>@@ -153,6 +153,7 @@ proc do_options {} {
> 		{i-20..200 gui.copyblamethreshold {mc "Minimum Letters To Blame Copy On"}}
> 		{i-0..300 gui.blamehistoryctx {mc "Blame History Context Radius (days)"}}
> 		{i-1..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
>+		{t gui.diffopts {mc "Additional Diff Parameters"}}
> 		{i-0..99 gui.commitmsgwidth {mc "Commit Message Text Width"}}
> 		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
> 		{c gui.encoding {mc "Default File Contents Encoding"}}

This seems ok but you don't say what it is for. Why do you want to be
able to pass additional options to git diff?

I can apply this to git-gui's repository. The Documentation change will
need to be sent to git separately once this is merged from git-gui.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
