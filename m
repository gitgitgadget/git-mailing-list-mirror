From: Theodore Tso <tytso@thunk.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 07:38:22 -0400
Message-ID: <20071019113822.GB16726@thunk.org>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org> <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 13:45:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiqHs-0003Hi-Ki
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 13:45:08 +0200
Received: from mail-mx6.uio.no ([129.240.10.47])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IiqHl-0002Tl-Jz
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 13:45:01 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx6.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IiqHc-0007KJ-TD
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 13:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbXJSLif convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Oct 2007 07:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbXJSLif
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 07:38:35 -0400
Received: from THUNK.ORG ([69.25.196.29]:52463 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670AbXJSLie (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 07:38:34 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IiqLI-0000eo-O5; Fri, 19 Oct 2007 07:48:40 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1IiqBK-0008MG-Qf; Fri, 19 Oct 2007 07:38:22 -0400
Content-Disposition: inline
In-Reply-To: <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
1;1609;0cFrom: Theodore Tso <tytso@mit.edu>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=12.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: CC7FAABD960871C4D8CF2F058545BD7005EEA0D5
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 110 total 622645 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61691>

On Fri, Oct 19, 2007 at 12:03:24PM +0200, Santi B=E9jar wrote:
> This way it is slightly less terse than the other proposals but not
> that cryptic and it normally fits in one line without padding. And I
> really like to see what has changed explicitly with the old..new line=
=2E

Same here.

I find the old..new information occasionally useful, since it allows
me to do the git diff --- something for which ORIG_HEAD isn't enough
when you are pulling multiple heads, such as in git.  Can we keep that
optional via a config or an command-line option?

Hmm... how about this?

=3D=3D> git://repo.or.cz/git/spearce.git
 * branch gitk -> spearce/gitk		(new)
 * branch maint -> spearce/maint	1aa3d01..e7187e4
 * branch master -> spearce/master	de61e42..7840ce6
 * branch next -> spearce/next		895be02..2fe5433
 + branch pu -> spearce/pu		89fa332...1e4c517
 * branch todo -> spearce/todo		(new)

If the branch is new, obviously old..new won't be useful.  The
non-fast forward branch is getting indicated twice, once with the "+"
sign, and once with the triple dot in the range.  =20

As far as the padding, it would be a pain to figure out how to make
the right hand column be padded so that it starts 3 spaces after the
longest "  * branch foo -> bar" line, but that would look the best.

=46inally, one last question --- am I the only one who had to take a
second look at the whether the arrow should be <- or ->?  The question
is whether we are saying "gitk is moving to include all of
spearce/gitk"; but I could also see it stated that we are assigning
refs/heads/gitk with refs/remotes/spearce/gitk, in which case the
arrow should be reversed.   Or maybe:

=3D=3D> git://repo.or.cz/git/spearce.git
 * branch gitk :=3D spearce/gitk		(new)
 * branch maint :=3D spearce/maint	1aa3d01..e7187e4
 * branch master :=3D spearce/master	de61e42..7840ce6
 * branch next :=3D spearce/next		895be02..2fe5433
 + branch pu :=3D spearce/pu		89fa332...1e4c517
 * branch todo :=3D spearce/todo		(new)

(Or is that too Pascal-like?  :-)

      	       	    	       	      	  	   - Ted
