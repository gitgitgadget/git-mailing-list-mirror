From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
	to "rebase-merge"
Date: Wed, 23 Jul 2008 18:47:39 +0200
Message-ID: <20080723164739.GB17648@leksak.fem-net>
References: <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org> <4882350B.6020003@free.fr> <7v3am5zfea.fsf@gitster.siamese.dyndns.org> <20080722234703.GD5904@leksak.fem-net> <7vbq0pifwq.fsf@gitster.siamese.dyndns.org> <20080723011341.GE5904@leksak.fem-net> <48874617.3010108@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Wed Jul 23 18:48:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLhWD-0005XK-Je
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbYGWQru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbYGWQru
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:47:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:55169 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751012AbYGWQrt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:47:49 -0400
Received: (qmail invoked by alias); 23 Jul 2008 16:47:47 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp040) with SMTP; 23 Jul 2008 18:47:47 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18lUctobvolEV0kDGMom+IB1RhP3MmjYMJDAhUJUK
	TAdMaWPPGpd6eR
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KLhV5-00082o-Di; Wed, 23 Jul 2008 18:47:39 +0200
Content-Disposition: inline
In-Reply-To: <48874617.3010108@free.fr>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89709>

Hi,

Olivier Marin wrote:
> > The reason of my question was that I *blindly* incorporated the change into
> > sequencer to make it able to work on a dirty working tree and thus to be
> > able to migrate am onto it without losing the ability to apply patches
> > on a dirty working tree....
> 
> Are you talking about your seq-proto-dev3 branch?

Right, and your suggested changes are right, too, and I've incorporated
them yesterday (with an --allow-dirty option) but I hadn't commited them...
(Hence, not pushed.)

> > Now, because t4151 does not pass, I am wondering what's the best thing
> > I could do...

Well, that was solved...
The problem was that the additional "HEAD" (that made t4151 work), resulted
in untracked files in some test cases of sequencer and rebase-i. Those made
merges fail, because these merges would overwrite these files. So the
merges failed, and the test cases failed.

I've solved this with the trick that the "HEAD" argument is only added if
--allow-dirty is set (and git-am uses --allow-dirty of course).

This is perhaps not the cleanest way but seemed to be far more better
than forcing overwrites on merges (checkouts, etc.).

> Ah, you should change "Applying 6" with "Applying \"6\"" in t4151-am-abort.sh
> too.

I btw wondered if the quotes are useful in original am.
Well, I've just sent a patch adding a colon (instead of quotes). Let's
see ;)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
