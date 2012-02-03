From: Jeff King <peff@peff.net>
Subject: Re: General support for ! in git-config values
Date: Fri, 3 Feb 2012 07:13:52 -0500
Message-ID: <20120203121352.GD31441@sigill.intra.peff.net>
References: <7vliom13lm.fsf@alter.siamese.dyndns.org>
 <CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
 <7v7h06109t.fsf@alter.siamese.dyndns.org>
 <CANgJU+WCdsF+igCWoueYcChYBvNyj5je_kvWorCBOgh5D7Bb9g@mail.gmail.com>
 <20120202023857.GA11745@sigill.intra.peff.net>
 <CANgJU+X2dRP__PFAywGEisDS3xyF7fSszSQG6BO61j2TMKL3Qg@mail.gmail.com>
 <20120202095432.GA19356@sigill.intra.peff.net>
 <CANgJU+XoZd6x6jdSHszigZaPgi+6H3Nbf4OG7p0y1_=7m+qntA@mail.gmail.com>
 <CAGZ=bq++R+X+2r2_zQ4UZ6JvDC9W9_4nF23MQ6+612_Qe2RS4Q@mail.gmail.com>
 <7vmx90say8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kyle Moffett <kyle@moffetthome.net>, demerphq <demerphq@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 13:14:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtI1e-0002UI-UX
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 13:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221Ab2BCMN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 07:13:56 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55772
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755177Ab2BCMNy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 07:13:54 -0500
Received: (qmail 31017 invoked by uid 107); 3 Feb 2012 12:21:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Feb 2012 07:21:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2012 07:13:52 -0500
Content-Disposition: inline
In-Reply-To: <7vmx90say8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189752>

On Thu, Feb 02, 2012 at 10:11:27PM -0800, Junio C Hamano wrote:

> Kyle Moffett <kyle@moffetthome.net> writes:
> 
> > Alternatively, you could extend the recent proposal for GIT config
> > "include" statements so that something like this works:
> >
> > [include]
> >     exec = echo "deploy.prefix = `cat /etc/SERVER_ROLE`"
> >     exec = /usr/local/bin/git-config-for-ldap-user
> 
> Erh...
> 
> Running known stuff from your own .git/config may be justifiable as "at
> your own risk", but if we consider sources that are not under your direct
> control, such as /etc/gitconfig and whatever your project encourages you
> to include from your .git/config,... eek.

For normal use, I don't see this as a big deal. They could also be
specifying diff.external, which would run arbitrary code (and who
doesn't run "git diff" once in a while?).

I see it as a bigger issue for sites which serve repositories on behalf
of their users, and already take care never to use porcelain commands
which will run arbitrary code from the config by default (e.g., gitweb
carefully uses diff plumbing for this reason). Introducing such an
option provides a mechanism for users who control the config of the
served repositories to execute code as the user running git-daemon or
gitweb.

-Peff
