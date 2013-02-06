From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Wed, 6 Feb 2013 16:57:24 -0500
Message-ID: <20130206215724.GA27507@sigill.intra.peff.net>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 <7vvcafojf4.fsf@alter.siamese.dyndns.org>
 <20130130074306.GA17868@sigill.intra.peff.net>
 <7v6226pdb7.fsf@alter.siamese.dyndns.org>
 <vpqa9rhaml6.fsf@grenoble-inp.fr>
 <876225o5mj.fsf@lifelogs.com>
 <vpqmwvhxyuj.fsf@grenoble-inp.fr>
 <87sj59mo2y.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 22:57:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3D03-0006AQ-Kg
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 22:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758423Ab3BFV52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 16:57:28 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37112 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757790Ab3BFV52 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 16:57:28 -0500
Received: (qmail 10665 invoked by uid 107); 6 Feb 2013 21:58:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 16:58:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 16:57:24 -0500
Content-Disposition: inline
In-Reply-To: <87sj59mo2y.fsf@lifelogs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215646>

On Wed, Feb 06, 2013 at 10:58:13AM -0500, Ted Zlatanov wrote:

> MM> I don't know about the netrc credential helper, but I guess that's
> MM> another layer. The git-remote-mediawiki code is the code to call the
> MM> credential C API, that in turn may (or may not) call a credential
> MM> helper.
> 
> Yup.  But what you call "read" and "write" are, to the credential
> helper, "write" and "read" but it's the same protocol :)  So maybe the
> names should be changed to reflect that, e.g. "query" and "response."

Is that true? As a user of the credential system, git-remote-mediawiki
would want to "write" to git-credential, then "read" the response. As a
helper, git-credential-netrc would want to "read" the query then
"write" the response. The order is different, but the operations should
be the same in both cases.

The big difference is that mediawiki would want an additional function
to open a pipe to "git credential" and operate on that, whereas the
helper will be reading/writing stdio.

-Peff
