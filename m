From: David Kastrup <dak@gnu.org>
Subject: Interpreting EDITOR/VISUAL environment variables.
Date: Wed, 01 Aug 2007 15:36:48 +0200
Message-ID: <86abtbnzpr.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 15:37:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGEO2-0005Ri-JD
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 15:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762339AbXHANhL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 09:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761913AbXHANhL
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 09:37:11 -0400
Received: from main.gmane.org ([80.91.229.2]:46139 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762190AbXHANhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 09:37:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IGENo-0004ir-LI
	for git@vger.kernel.org; Wed, 01 Aug 2007 15:37:00 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 15:37:00 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 15:37:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:oi3ZiHVLKGUhTdymErdmrp5Gi3k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54436>


Whatever I have been able to Google, is completely silent on this
matter.  If anybody has an idea where to find authoritative
information, holler.

In the meantime, in the Emacs manual there is the following bit of
information:

(info "(emacs) Invoking Emacsclient")

       The option `-a COMMAND' or `--alternate-editor=COMMAND' specifies a
    command to run if `emacsclient' fails to contact Emacs.  This is useful
    when running `emacsclient' in a script.  For example, the following
    setting for the `EDITOR' environment variable will always give you an
    editor, even if no Emacs server is running:

         EDITOR="emacsclient --alternate-editor emacs +%d %s"

That makes it likely that the way to call an editor should be via
system.  However, there are certainly programs around which will not
interpret the +%d and %s thingies.  My current setting is

         EDITOR="emacsclient --alternate-editor vi"

and this seems to do the trick with most applications.  Not so with
git-commit and other git scripts.  The easiest way out will be to
create something like ~/bin/myemacsclient which does the respective
argument splicing.  I am just not sure this is the "canonically
correct way" of interpreting $EDITOR.

Actually, splicing $EDITOR into a system command is a nuisance because
it means having to shell-quote its arguments.  So the current
interpretation is likely easier to maintain.

Is it the correct one?

-- 
David Kastrup
