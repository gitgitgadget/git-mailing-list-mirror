From: Jeff King <peff@peff.net>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Thu, 31 Jul 2008 05:05:28 -0400
Message-ID: <20080731090528.GC20691@sigill.intra.peff.net>
References: <20080730093903.GA14330@cuci.nl> <20080730150123.GB9758@atjola.homenet> <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com> <20080731064814.GA32431@sigill.intra.peff.net> <7vfxpq3559.fsf@gitster.siamese.dyndns.org> <20080731072149.GA2304@sigill.intra.peff.net> <7v8wvi33ok.fsf@gitster.siamese.dyndns.org> <20080731082553.GA19522@sigill.intra.peff.net> <7v8wvizc16.fsf@gitster.siamese.dyndns.org> <20080731090146.GA12867@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, sverre@rabbelier.nl,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@c
X-From: git-owner@vger.kernel.org Thu Jul 31 11:06:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOU7E-0000i3-Kr
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 11:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbYGaJFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 05:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbYGaJFa
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 05:05:30 -0400
Received: from peff.net ([208.65.91.99]:1740 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499AbYGaJF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 05:05:29 -0400
Received: (qmail 22391 invoked by uid 111); 31 Jul 2008 09:05:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 31 Jul 2008 05:05:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jul 2008 05:05:28 -0400
Content-Disposition: inline
In-Reply-To: <20080731090146.GA12867@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90915>

On Thu, Jul 31, 2008 at 11:01:46AM +0200, Pierre Habouzit wrote:

>   Ack this is a correct fix. I wonder how this even works with other
> commands that use --all and stuff like that.

--all is parsed separately in setup_revisions _before_ we call
handle_revision_opt. So the only codepath hitting that is parse_options
users who call parse_revision_opt (i.e., blame and shortlog).

-Peff
