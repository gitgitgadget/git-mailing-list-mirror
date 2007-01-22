From: Bill Lear <rael@zopyra.com>
Subject: Re: Meaning of "fatal: protocol error: bad line length character"?
Date: Mon, 22 Jan 2007 12:58:42 -0600
Message-ID: <17845.2402.105688.56648@lisa.zopyra.com>
References: <17842.1385.366750.915767@lisa.zopyra.com>
	<7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net>
	<7vfya57ast.fsf@assigned-by-dhcp.cox.net>
	<17842.29542.229557.460473@lisa.zopyra.com>
	<7vbqkt78n7.fsf@assigned-by-dhcp.cox.net>
	<7v7ivh77md.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 19:59:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H94Nd-000473-Cl
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 19:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbXAVS6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 13:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbXAVS6x
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 13:58:53 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61403 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932235AbXAVS6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 13:58:52 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0MIwnI23065;
	Mon, 22 Jan 2007 12:58:49 -0600
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7ivh77md.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37437>

On Saturday, January 20, 2007 at 12:42:18 (-0800) Junio C Hamano writes:
>Junio C Hamano <junkio@cox.net> writes:
>...
>That was output to stdout made from the update hook in my case.
>I do not know your setup, but if you make sure your update hook
>does not spit out anything to its stdout (diag can go to stderr),
>you should be able to work it around.
>
>Funny thing is, at least in recent enough git, I think we set up
>redirection to force output from hook scripts to stderr, but I
>do not remember when it happened.  Let's see...
>
>	...goes and looks...
>
>That was supposed to have been fixed with commit cd83c74c (Dec
>30, 2006), but this indicates the fix is not working at all when
>your login shell is tcsh. ...

One of our developers who uses bash is seeing this error in his pushes
from his private repo to his public repo, through the file system.

Here is one example he conveyed:

% git push
error: remote 'refs/heads/master' is not a strict subset of local ref 'refs/heads/master'. maybe you are not up-to-date and need to pull first?
error: remote 'refs/heads/origin' is not a strict subset of local ref 'refs/heads/origin'. maybe you are not up-to-date and need to pull first?
updating 'refs/heads/fig_mt_1'
  from 85f1ff556f95b0177e69f99d1196a2db26213812
  to   0a5a7ac9b81a90500b9c9c44a22793890513cd5a
Generating pack...
Done counting 16 objects.
Result has 10 objects.
Deltifying 10 objects.
 100% (10/10) done
Writing 10 objects.
 100% (10/10) done
Total 10, written 10 (delta 6), reused 0 (delta 0)
Unpacking 10 objects
 100% (10/10) done
fatal: protocol error: bad line length character
xiphi:~/devel/fig_mt_1/fusion | fig_mt_1 % refs/heads/fig_mt_1: 85f1ff556f95b01
77e69f99d1196a2db26213812 -> 0a5a7ac9b81a90500b9c9c44a22793890513cd5a

In this case, he forgot to limit the push to his fig_mt_1 branch, but
last night he did a similar push (git push origin fig_mt_1), and got
the same bad line length character error report.  His pushes seem to
be propagating, but he's a bit nervous nonetheless.

He has an active update hook in his public repo, to send notices to
his collaborators when his work is ready for them to pull, but we
looked through it and don't see any printing to stdout.


Bill
