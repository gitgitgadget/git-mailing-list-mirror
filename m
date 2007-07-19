From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 14:46:47 +0200
Message-ID: <863azka7d4.fsf@lola.quinscape.zz>
References: <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr> <20070719105105.GA4929@moonlight.home> <86zm1sbpeh.fsf@lola.quinscape.zz> <20070719123214.GB4929@moonlight.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 14:47:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBVPy-0002sM-Vf
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 14:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757674AbXGSMrj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 08:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754016AbXGSMrj
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 08:47:39 -0400
Received: from main.gmane.org ([80.91.229.2]:37254 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755211AbXGSMri (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 08:47:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBVPf-0006Vm-Hp
	for git@vger.kernel.org; Thu, 19 Jul 2007 14:47:23 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 14:47:23 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 14:47:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:TlWiTz23G6ZYw/JiK7KaoI8yoSs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52989>

Tomash Brechko <tomash.brechko@gmail.com> writes:

> Hi David,
>
> On Thu, Jul 19, 2007 at 13:31:50 +0200, David Kastrup wrote:
>> core.excludefile: .
>
> Really nice idea to give directories 'DIR/.' name.  I'm sure there are
> several other ways to implement your proposal.  But why to put in in
> Git itself?  Decomposition and abstraction principle tells me that
> this should go to some other place.

Because of a fundamental law of computation: information maintained in
two separate places will get out of synch eventually.

> Please consider this: I myself use Git to track my own local
> projects, and for this usage you proposal have no value for me,
> i.e. as a _Source_ Code Management system Git is rather complete.
> But I also track /etc and ~/ in Git, and for this I'd love to have
> directories, permissions, ownership, other attributes, to be
> tracked.  I have Perl script wrapping Git that allows me to filter
> tracked paths by full regexps instead of Git's file globs, and also
> to filter out too big files assuming that they are binary anyway.

Look, git _tracks_ contents.  Your permissions managements needs to be
told explicitly when and how things change.  So you end up with git
_tracking_ material and your permissions/directory management needing
the level of manual handholding Subversion demands.

> And my point is that rather than building the support for all of it
> into core Git, and then implementing sophisticated configuration to
> disable parts of it, wouldn't it be better to have a separate tools
> orthogonal to Git itself?

And my personal answer to that is "no".  We don't want orthogonality
for intimately related things, because it forces us to work the
"orthogonal" things in lockstep.  And if you force git to operate in
lockstep with manual explicit tracking, then git becomes useless for
tracking stuff automatically.

> So the essence of my objection is that we should not pollute core
> Git with file system state tracking more than it's required to know
> where to put the contents to.  Everything else should go elsewhere.
>
> Again, I'd love to have your proposal be implemented, but only in a
> way that won't interfere with pure SCM's operations.

Tell git to ignore "." and it won't "interfere".

-- 
David Kastrup
