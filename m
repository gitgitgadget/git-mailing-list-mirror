From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] Refactoring: remove duplicated code from
 transport.c and builtin-send-pack.c
Date: Mon, 15 Feb 2010 02:55:15 -0500
Message-ID: <20100215075514.GB5347@coredump.intra.peff.net>
References: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
 <20100215052853.GJ3336@coredump.intra.peff.net>
 <7v7hqfknwz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Lukashov <michael.lukashov@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 08:55:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngvnb-0008Rm-89
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 08:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327Ab0BOHzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 02:55:12 -0500
Received: from peff.net ([208.65.91.99]:52012 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755285Ab0BOHzL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 02:55:11 -0500
Received: (qmail 15368 invoked by uid 107); 15 Feb 2010 07:55:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Feb 2010 02:55:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2010 02:55:15 -0500
Content-Disposition: inline
In-Reply-To: <7v7hqfknwz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139994>

On Sun, Feb 14, 2010 at 10:34:20PM -0800, Junio C Hamano wrote:

> > I can't remember the exact details of why the originals were not
> > removed, though (I think I complained about it once before, and there
> > was some technical reason, but I don't recall now). Daniel (cc'd) might
> > remember more.
> 
> Also the names of these functions probably need to be made more specific
> so that people not so familiar with the transport code can tell that they
> are from "transport" family.  The names didn't matter much while they were
> file scope static, but this series changes that.

Actually, I wonder if we can simply get rid of some of the calls in
send-pack. I think that the code in send-pack isn't even called anymore
via "git push"; it only gets called when you call send-pack directly.
And arguably send-pack as plumbing shouldn't be generating all sorts of
user-facing output. But it is a behavior change. I wonder if anybody
actually calls send-pack directly anymore. It seems like even scripts
use "git push" because of the transport agnosticism.

-Peff
