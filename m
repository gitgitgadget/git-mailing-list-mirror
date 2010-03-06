From: Tait <git.git@t41t.com>
Subject: using gvim as editor on Windows
Date: Fri, 5 Mar 2010 23:06:28 -0800
Message-ID: <20100306070628.GM2480@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 08:17:34 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnoGS-00085O-Bj
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 08:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab0CFHRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 02:17:16 -0500
Received: from rcpt.cat.pdx.edu ([131.252.208.107]:48212 "EHLO
	rcpt.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab0CFHRP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 02:17:15 -0500
X-Greylist: delayed 699 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Mar 2010 02:17:15 EST
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by rcpt.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id o2676TcH008500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 5 Mar 2010 23:06:29 -0800
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id o2676Svg023401
	for <git@vger.kernel.org>; Fri, 5 Mar 2010 23:06:28 -0800 (PST)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id o2676SXx023400
	for git@vger.kernel.org; Fri, 5 Mar 2010 23:06:28 -0800 (PST)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (rcpt.cat.pdx.edu [131.252.208.107]); Fri, 05 Mar 2010 23:06:29 -0800 (PST)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on rcpt.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.95.2 at rcpt.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141606>


I'd prefer to use gvim as an editor on Windows XP instead of vim. (I also
prefer it as a difftool, but that's a separate issue.) Gvim releases
the terminal when it launches, which git doesn't like too much. So I
create gvimf.cmd in my path and use it for core.editor. Gvimf.cmd is
quite simple; it calls:
	start "dummy" /b /wait "C:\Program Files\Vim\vim72\gvim.exe" %*

In .gitconfig:
[core]
	editor = gvimf.cmd

This works well enough for git commit. However, git rebase -i is not
happy. It errors:
	C:\path to\repo> git rebase -i HEAD~10
	The system cannot find the file dummy.
	Could not execute editor

Okay, I can fix that. I change core.editor to "cmd \\/c gvimf.cmd". (This
is the same pattern I use for gvim as a difftool.) Now my .gitconfig has:
[core]
	editor = cmd \\\\/c gvimf.cmd

Git rebase is happy, but git commit is not. It errors:
	C:\path to\repo> git commit
	'OMMIT_EDITMSG' is not recognized as an internal or external command,
	operable program or batch file.
	error: There was a problem with the editor 'cmd \\/c gvimf.cmd'.
	Please supply the message using either -m or -F option.

In the selfish hope to avoid work, has anyone else already encountered
and solved how to use gvim as an editor?

Tait
