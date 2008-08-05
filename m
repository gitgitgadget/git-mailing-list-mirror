From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Not going beyond symbolic links
Date: Tue, 05 Aug 2008 16:57:44 -0700
Message-ID: <7v4p5zui9z.fsf@gitster.siamese.dyndns.org>
References: <20080721002354.GK10151@machine.or.cz>
 <20080721002508.26773.92277.stgit@localhost>
 <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org>
 <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org>
 <7v8wvc2seh.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808041839130.3299@nehalem.linux-foundation.org>
 <alpine.DEB.1.00.0808050356480.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LFD.1.10.0808041921530.3299@nehalem.linux-foundation.org>
 <7vej54xa80.fsf@gitster.siamese.dyndns.org>
 <20080805125422.GX7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 01:58:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQWQc-0007MW-9i
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 01:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756187AbYHEX55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 19:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756160AbYHEX55
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 19:57:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbYHEX54 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 19:57:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B7AB4C92B;
	Tue,  5 Aug 2008 19:57:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B2D3A4C90E; Tue,  5 Aug 2008 19:57:46 -0400 (EDT)
In-Reply-To: <20080805125422.GX7008@dpotapov.dyndns.org> (Dmitry Potapov's
 message of "Tue, 5 Aug 2008 16:54:22 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51E1E26C-634A-11DD-A0A2-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91472>

Dmitry Potapov <dpotapov@gmail.com> writes:

> Obviously, if a symlink points to a directory inside of the repository
> and then you use "git add sym/file", it is definitely a mistake. OTOH,
> let's consider the following situation:
>
> git init
> mkdir newdir
> touch newdir/foo
> git add newdir/foo
> git commit -m 'add foo'
> mv newdir /tmp/
> ln -s /tmp/newdir
> touch newdir/bar
> git add newdir/bar
> git commit -m 'add bar'
> git ls-files
>
> And you can see:
> newdir/bar
> newdir/foo
>
> Git does exactly what I want here!

Now, do this after the above sequence:

  git diff
  git add . && git ls-files

and tell me what you see.  Does it show exactly what you want here?

I've already told you what kind of changes you would need to make if you
really want to claim this is a feature.
