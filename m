From: David Kastrup <dak@gnu.org>
Subject: Re: bisect / history preserving on rename + update
Date: Tue, 14 Aug 2007 12:03:10 +0200
Message-ID: <86d4xqh1r5.fsf@lola.quinscape.zz>
References: <1187080681.12828.174.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 14 12:03:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKtFV-0004iw-7n
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 12:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbXHNKDc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 06:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbXHNKDc
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 06:03:32 -0400
Received: from main.gmane.org ([80.91.229.2]:51696 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755170AbXHNKDb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 06:03:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IKtFD-0003QZ-CP
	for git@vger.kernel.org; Tue, 14 Aug 2007 12:03:23 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Aug 2007 12:03:23 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Aug 2007 12:03:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:ismdicjr4IXOHHE5JK6EUZT5TG8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55822>

Thomas Gleixner <tglx@linutronix.de> writes:

> is there a built in way to handle the following situation:
>
> file A is renamed to B
> file A is created again and new content is added.
>
> I found only two ways to do that, which both suck:
>
> 1)
> 	git-mv A B
> 	git-add A
> 	git commit
>
> 	results in a copy A to B and lost history of B
>
> 2)
> 	git-mv A B
> 	git commit
> 	git-add A
> 	git commit
>
> 	preserves the history of B, but breaks bisection because
> 	A is needed to compile
>
> I have no real good idea how to solve this. After staring at the git
> source for a while, I think that 1) is quite hard to solve. A sane
> solution for 2) might be to add a flag to the second commit, which
> bundles the two commits for bisection.
>
> Any other solutions ?

You are confused, probably because something like "git-mv" exists (it
is just syntactic sugar, and it might be less confusing to users to
actually remove it).  git does _not_ track file histories.  Not the
tiniest bit.

It _constructs_ them when you ask it nicely.  All commands that
display "tracking" information have options like -M -C -R and so on
that tell git just how much effort it should spend on keeping abreast
of copying/renaming/modification.

-- 
David Kastrup
