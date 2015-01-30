From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/1] apply: reject input that touches outside $cwd
Date: Fri, 30 Jan 2015 14:16:21 -0500
Message-ID: <20150130191621.GA30156@peff.net>
References: <CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
 <CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
 <xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
 <xmqqa914klg0.fsf@gitster.dls.corp.google.com>
 <xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
 <xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
 <xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
 <xmqqzj91cfnl.fsf_-_@gitster.dls.corp.google.com>
 <20150130182456.GA29477@peff.net>
 <xmqqegqcccjt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 20:16:36 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHH3O-0006zn-HH
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 20:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763229AbbA3TQ0 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 14:16:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:43405 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752259AbbA3TQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 14:16:24 -0500
Received: (qmail 464 invoked by uid 102); 30 Jan 2015 19:16:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 13:16:24 -0600
Received: (qmail 26334 invoked by uid 107); 30 Jan 2015 19:16:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 14:16:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2015 14:16:21 -0500
Content-Disposition: inline
In-Reply-To: <xmqqegqcccjt.fsf@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263188>

On Fri, Jan 30, 2015 at 11:07:34AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It looks like your new --allow-uplevel goes to verify_path(). So this
> > isn't just about "..", but it will also protect against applying a patch
> > inside ".git". Which seems like a good thing to me, but I wonder if the
> > option name is a little misleading.
> 
> True; not just misleading but is incorrect, I would say.
> Suggestions?

I think just "--verify-paths" (and "--no-verify-paths", since the former
would be the default) might be fine. That leaves the definition of
"verify" vague, but I think that's OK. It used to mean "no '..' and no
'.git'", and now it has been widened to include "no weird
filesystem-specific variants of .git".

If you wanted to avoid the negative being the commonly used option,
maybe "--unsafe-paths" (or "--allow-unsafe-paths" if you like verbs).

-Peff
