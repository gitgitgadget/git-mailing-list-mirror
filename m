From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Commit f5bbc322 to git broke pre-commit hooks which read stdin
Date: Wed, 5 Mar 2008 00:46:46 -0500
Message-ID: <20080305054646.GB8410@spearce.org>
References: <0tableanpe.wl%bremner@pivot.cs.unb.ca> <alpine.LSU.1.00.0803041044120.22527@racer.site> <7vk5ki91zj.fsf@gitster.siamese.dyndns.org> <0t4pbmaew9.wl%bremner@pivot.cs.unb.ca> <alpine.LSU.1.00.0803041203320.22527@racer.site> <0tr6eq87az.wl%bremner@pivot.cs.unb.ca> <20080305051212.GZ8410@spearce.org> <7vtzjl3f6d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Bremner <bremner@unb.ca>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 06:47:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWmTa-0003gb-BT
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 06:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbYCEFq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 00:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbYCEFq7
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 00:46:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60322 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbYCEFq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 00:46:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWmSl-0001C7-Nb; Wed, 05 Mar 2008 00:46:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BC91920FBAE; Wed,  5 Mar 2008 00:46:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vtzjl3f6d.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76174>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > What happens to such hooks under git-gui?
> >
> > git-gui invokes the pre-commit hook with stdin coming off the stdin
> > that the wish process inherited when it was spawned.  This may not
> > be the best way to interact with the end-user of that repository.
> 
> Well, if git-gui is designed to interoperate with CLI git (and I think
> that is a sensible thing to aim for), we probably should revisit the list
> of hooks in hooks.txt and make sure we define the environment these hooks
> are invoked in precisely enough (this incidentally will help C rewrite
> effort to avoid regressing).

Yup.  That I think is key, because then hook authors know what they
can assume, and what they cannot.

> Then, hooks that take input from and give
> output to the user could be launched with I/O redirected to talk with wish
> (which I presume has a terminal lookalike widget you can embed in your
> application).

Nope.  In fact the one that I already have right now is not dealing
with the \r in the progress meters from git correctly.  Someone needs
to revisit that code.  Something's not right with it.

Oh, and the one that git-gui does have only handles output.  It does
not permit input.  Nor does it actually honor weird stty modes like
say noecho.  Its most decidely *not* a tty.

-- 
Shawn.
