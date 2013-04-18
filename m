From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame: handle broken commit headers gracefully
Date: Thu, 18 Apr 2013 12:56:01 -0400
Message-ID: <20130418165600.GA24492@sigill.intra.peff.net>
References: <516D93C4.1000100@lsrfire.ath.cx>
 <7v61zml0ow.fsf@alter.siamese.dyndns.org>
 <516DBE2E.4060201@lsrfire.ath.cx>
 <7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
 <7vli8hhgmn.fsf@alter.siamese.dyndns.org>
 <20130417063942.GA27703@sigill.intra.peff.net>
 <516EE300.7020200@lsrfire.ath.cx>
 <516EEB12.5050209@lsrfire.ath.cx>
 <20130417210713.GB635@sigill.intra.peff.net>
 <7vsj2oesa6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Ivan Lyapunov <dront78@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 19:03:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USsEv-0006M9-Ny
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 19:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967633Ab3DRRC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 13:02:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:43383 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967655Ab3DRRCr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 13:02:47 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2013 13:02:47 EDT
Received: (qmail 5157 invoked by uid 102); 18 Apr 2013 16:56:10 -0000
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (75.15.5.89)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Apr 2013 11:56:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2013 12:56:01 -0400
Content-Disposition: inline
In-Reply-To: <7vsj2oesa6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221666>

On Wed, Apr 17, 2013 at 02:55:29PM -0700, Junio C Hamano wrote:

> Or you can imagine nastier input strings, like
> 
>    Name <>-<email@host> 123456789 -0000
>    Name <ema>-<il@host> 123456789 -0000
>    Name <email@host~ 1234>56789 -0000
> 
> I am afraid that at some point "we should salvage as much as we
> can", which is a worthy goal, becomes a losing proposition.

Good point. In the worst cases, even if you cleaned things up, you might
even need to allocate a new string (like your middle one), which would
make calling split_ident_line a lot more annoying. Probably not worth
the effort.

-Peff
