From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH] git.el: Add a git-grep command
Date: Sun, 24 Feb 2008 03:00:01 +0100
Organization: GNU's Not UNIX!
Message-ID: <200802240200.m1O201Rh015406@localhost.localdomain>
References: <87odaa4tcl.fsf@lysator.liu.se>
	<m3myptcqji.fsf@localhost.localdomain> <87tzk19wn5.fsf@lysator.liu.se>
	<200802221121.35706.jnareb@gmail.com> <87ir0h9soh.fsf@lysator.liu.se>
	<87d4qpgs9y.dlv@maison.homelinux.org>
	<200802230200.m1N202Y7007392@localhost.localdomain> <8763wfwjg6.dlv@maison.homelinux.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: vanicat@debian.org, davidk@lysator.liu.se, jnareb@gmail.com,
	julliard@winehq.org, git@vger.kernel.org
To: Remi Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 03:34:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT6hF-00044U-ON
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 03:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbYBXCda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 21:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755034AbYBXCda
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 21:33:30 -0500
Received: from master.uucpssh.org ([193.218.105.66]:33200 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbYBXCd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 21:33:29 -0500
Received: by master.uucpssh.org (Postfix, from userid 10)
	id 5C6B3C85A6; Sun, 24 Feb 2008 03:32:34 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m1O202hw015409;
	Sun, 24 Feb 2008 03:00:02 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m1O201Rh015406;
	Sun, 24 Feb 2008 03:00:01 +0100
In-reply-to: <8763wfwjg6.dlv@maison.homelinux.org> (message from Remi Vanicat
	on Sat, 23 Feb 2008 20:39:53 +0100)
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.356,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.04,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74899>


   Xavier Maillard <xma@gnu.org> writes:

   > Hi,
   >
   >    Here is a modification with inclusion of git-grep only when the grep
   >    library is available. 
   >
   >    +(require 'grep () t)
   >
   >    +(when (featurep 'grep)
   >    +  (defvar git-grep-history nil)
   >    +
   >    +  (defun git-grep (regexp &optional files dir)
   >
   > Why not just do something like this ?
   >
   > (when (require 'grep () t)
   >       (defvar ...)
   >       (defun git-grep ...))

   Because I wanted require to stay on top of the file, but I didn't want
   to put the rest of the git-grep stuff there.

Good point. Though, you can still "embed" the require form
directly into the defun. This is thing I have already seen in the
past. Dunno if it is a convention or a coding style but something
like:

(defun git-grep ()
 "Docstring"
 (interactive)
 (when (require 'grep nil t)
       here the rest
  ))

is doable too. Maybe the if-else form would be better though with
an else clause to (error "No grep package foud.").

Well just kidding, your patch is okay ;)

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
