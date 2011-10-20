From: Jeff King <peff@peff.net>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Thu, 20 Oct 2011 11:44:06 -0400
Message-ID: <20111020154406.GA16114@sigill.intra.peff.net>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net>
 <20111019193834.GA14168@sigill.intra.peff.net>
 <7vvcrk9td7.fsf@alter.siamese.dyndns.org>
 <CACsJy8B7CJ3VO-UKCym2kgfOOPadL25gt2sxApk95nKoWVk2yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 17:44:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGun0-0005CS-Qk
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 17:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254Ab1JTPoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 11:44:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36217
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420Ab1JTPoI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 11:44:08 -0400
Received: (qmail 10365 invoked by uid 107); 20 Oct 2011 15:44:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Oct 2011 11:44:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2011 11:44:06 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8B7CJ3VO-UKCym2kgfOOPadL25gt2sxApk95nKoWVk2yQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184026>

On Thu, Oct 20, 2011 at 08:14:56PM +1100, Nguyen Thai Ngoc Duy wrote:

> > But you cannot hide from "cat-file commit" ;-)
> >
> > With the recent push to more (perceived) security, it may probably make
> > sense to teach "log" family commands to quote-show ^@ and what is behind
> > in their output by default, perhaps with an option to turn it off.
> 
> What about NUL in file name in tree objects? Suppose the original tree
> has an entry named "goodthing". With luck, they might be able to
> create a new tree object with the entry renamed to "evil\x001234" that
> has the same SHA-1. Could that possibly cause any problems?

NUL is already meaningful in a tree object; it is the end of the
filename. So after the NUL, we will consider the next 20 bytes to be
sha1, and then after that, the mode of the next file entry.

-Peff
