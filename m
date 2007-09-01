From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-gui i18n status?
Date: Sun, 2 Sep 2007 00:42:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709020003480.28586@racer.site>
References: <20070901042924.GE18160@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Stimming <stimming@tuhh.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Nanako Shiraishi <nanako3@bluebottle.com>,
	Michele Ballabio <barra_cuda@katamail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Xudong Guan <xudong.guan@gmail.com>,
	Harri Ilari Tapio Liusvaara <hliusvaa@cc.hut.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Irina Riesen <irina.riesen@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 01:42:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRcbw-0006f3-HV
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 01:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757617AbXIAXmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 19:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757547AbXIAXmN
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 19:42:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:39752 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756228AbXIAXmM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 19:42:12 -0400
Received: (qmail invoked by alias); 01 Sep 2007 23:42:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 02 Sep 2007 01:42:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lVL8QWUxlUIhDdwYc9FHmSu1KQ4RA0Rfjj5AYwb
	hBGsaLeG/Mjo/7
X-X-Sender: gene099@racer.site
In-Reply-To: <20070901042924.GE18160@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57286>

Hi,

[Cc'ed all contributors.  I mean, the real contributors, not just those 
with cheap talk ;-)]

On Sat, 1 Sep 2007, Shawn O. Pearce wrote:

> Now that git-gui 0.8.2 is out and git 1.5.3 is just around the corner I 
> am starting to think about bringing the git-gui i18n work into the main 
> git-gui tree, so we can start working from a common codebase.

Yes.

> Looking at the repository on repo.or.cz it looks like it needs to be 
> merged/rebased onto 0.8.2.  There is a trivial merge conflict, but there 
> are some more subtle ones caused by the movement of the library 
> directory initialization down lower in git-gui.sh. For example 
> translations won't be initialized if we have an issue with the output of 
> git-version and want to prompt the user.

Hmm.  I am not enough involved in i18n stuff to form a proper opinion 
here...  Do you suggest to move the initialisation earlier?

> What is the current plan?  Should I be looking at the master branch of 
> git://repo.or.cz/git-gui/git-gui-i18n.git for pulling?  Or are folks 
> expecting that this series will be cleaned up before I pull it?

My plan is to put out a cleaned up patch series:

- Christian's patches, consolidated, to

	- Makefile rules for translation
	- Infrastructure in the source (basically adding [mc ...] 
	  everywhere, and initialising msgcat)
	- po/git-gui.pot
	- glossary

Then I'd like to prepare consolidated patches for the individual 
languages, attributed to the author where unique, and to Nanako for 
Japanese (mentioning help from Junio), and to Paolo (mentioning help from 
Michele).

Junio, Michele, is that attribution enough for you?

All these patches will go through the mailing list, so that people can 
comment and suggest improvements.

I'll also try to bug Christian into looking through the output of

	git grep \" -- \*.sh \*.tcl | grep -vwe mc -e bind | less

to make sure that we did not forget a string.  ATM the output consists of 
300+ lines, so it is a bit boring.  Maybe I can improve that command, 
too...

(I see

	"Invalid arguments to git-version",
	"Last arm of $type $name must be default",
	"git-version >= x", "git-gui: fatal error",
	"Cannot move to top of working directory:\n\n$err",
	"error: no icon for $w state={$state} $path",
	"error: no desc for state={$state} $path",
	"Unstaging [short_path $path] from commit",
	"Adding [short_path $path]",
	"fatal: cannot stat path $path: No such file or directory",
	"Possible environment issues exist.[...]",
	"Loading$cur_s annotations...",
	"Loading annotation...",
	"Author:\t",
	"Committer:\t",
	"Original File:\t",
	"Originally By:\n",
	"In File: ",
	"Copied Or Moved Here By:\n",
	"fatal: Cannot resolve $l_trck",
	"branch: Created from $new_expr",
	"merge $new_expr: Fast-forward",
	"Updating working directory to '[_name $this]'...",
	"Checked out '$name'.",
	"class $class already declared",
	"wrong # args: field name value?",
	"class $class is sealed (cannot add new fields)",
	"field $name already declared",
	"wrong # args: method name args body (ifdeleted body)?",
	"make_toplevel topvar winvar {options}",
	"unsupported option $name",
	"Commit $PARENT appears to be corrupt",
	"warning: Tcl does not support encoding '$enc'.",
	"This repository currently has approximately [...]",
	"Loading diff of [escape_path $path]...",
	"Unable to display [escape_path $path]",
	"* Binary file (not showing content).",
	"Unable to display [escape_path $path]",
	"error: Unhandled 3 way diff marker: {$op}",
	"error: Unhandled 2 way diff marker: {$op}",
	"Unstaging [short_path $current_diff_path] from commit",
	"Adding [short_path $current_diff_path]", and
	"The following branches are not completely merged into [...]",

but I could have missed some, and it is possible some do not need [mc 
...].)

Ciao,
Dscho
