From: Jeff King <peff@peff.net>
Subject: Re: thin packs ending up fat
Date: Fri, 13 Jan 2012 10:15:45 -0500
Message-ID: <20120113151545.GA9373@sigill.intra.peff.net>
References: <20120112221523.GA3663@sigill.intra.peff.net>
 <20120112223234.GA4949@sigill.intra.peff.net>
 <7vwr8wz8u9.fsf@alter.siamese.dyndns.org>
 <20120113015117.GA8245@sigill.intra.peff.net>
 <7vmx9sysqe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 16:16:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlirH-00060v-QP
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 16:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758248Ab2AMPPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 10:15:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36687
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778Ab2AMPPy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 10:15:54 -0500
Received: (qmail 9953 invoked by uid 107); 13 Jan 2012 15:22:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jan 2012 10:22:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jan 2012 10:15:45 -0500
Content-Disposition: inline
In-Reply-To: <7vmx9sysqe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188514>

On Thu, Jan 12, 2012 at 11:19:37PM -0800, Junio C Hamano wrote:

> I wanted to make sure I understood the root cause of the issue and the
> approach the patch takes to address it, instead of committing something
> that smelled correct. And the only way I know to do so is to write it
> down.

I use something of the same technique myself...

> Especiallly, before coming up with the description, I was wondering if
> this kind of symptom appears in non-thin cases, but after writing down the
> justification for this patch, it became clear that we wouldn't have to
> worry too much about that case. In a non-thin pack, we need to record one
> object at least in a delta family in inflated base form, so we may as well
> send that one near the tip that is already in that form for that, letting
> the existing "avoid futile delta" heuristics to kick in. Other objects in
> the same delta family will delta against it.

Exactly. You asked earlier why my one-liner patch was not in the first
message. It's because it was only through writing the first message that
I came to the same realization. :)

-Peff
