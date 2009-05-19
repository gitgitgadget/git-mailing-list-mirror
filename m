From: Jeff King <peff@peff.net>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Tue, 19 May 2009 07:29:14 -0400
Message-ID: <20090519112914.GA21386@coredump.intra.peff.net>
References: <20090515020206.GA12451@coredump.intra.peff.net> <op.uty0pjb51e62zd@balu> <m34ovmlcve.fsf@localhost.localdomain> <4A0D8211.5010806@viscovery.net> <81b0412b0905150851q232b3f6s95df89e72d4dc381@mail.gmail.com> <4A0D9696.1040805@op5.se> <7v3ab6uuw4.fsf@alter.siamese.dyndns.org> <4A0E67E9.3020208@op5.se> <7vtz3lnf1x.fsf@alter.siamese.dyndns.org> <op.ut6ciwjl1e62zd@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 19 13:29:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6NVe-00084F-LB
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 13:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbZESL3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 07:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbZESL3P
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 07:29:15 -0400
Received: from peff.net ([208.65.91.99]:33537 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092AbZESL3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 07:29:14 -0400
Received: (qmail 22394 invoked by uid 107); 19 May 2009 11:29:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 19 May 2009 07:29:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 May 2009 07:29:14 -0400
Content-Disposition: inline
In-Reply-To: <op.ut6ciwjl1e62zd@balu.cs.uni-paderborn.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119518>

On Tue, May 19, 2009 at 01:21:58PM +0200, Matthias Andree wrote:

> What else can we tag in Git? Commits and Tags.  Is it sensible and does it 
> work to tag blobs or trees?

A tagged blob:

  $ cd git && git show junio-gpg-pub | sed '/^--/Q'
  tag junio-gpg-pub
  Tagger: Junio C Hamano <junkio@cox.net>
  Date:   Tue Dec 13 16:33:29 2005 -0800


  GPG key to sign git.git archive.

  This blob object contains the GPG public key I use to sign git.git
  archive.

  To use it to verify tags I signed, do:

    $ git-cat-file blob junio-gpg-pub | gpg --import

  to import it into your keyring, and then

    $ git-verify-tag $tag_to_be_verified

A tagged tree:

  $ cd linux-2.6 && git show v2.6.11 | sed '/^--/Q'
  tag v2.6.11-tree

  This is the 2.6.11 tree object.

  NOTE! There's no commit for this, since it happened before I started with git.
  Eventually we'll import some sort of history, and that should tie this tree
  object up to a real commit. In the meantime, this acts as an anchor point for
  doing diffs etc under git.

-Peff
