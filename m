From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] apply: refuse touching a file beyond symlink
Date: Fri, 30 Jan 2015 14:46:15 -0500
Message-ID: <20150130194615.GA30738@peff.net>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
 <CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
 <CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
 <xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
 <xmqqa914klg0.fsf@gitster.dls.corp.google.com>
 <xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
 <xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
 <xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
 <20150130181153.GA25513@peff.net>
 <xmqqa910cax2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 20:46:24 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHHWJ-0005Pg-Jg
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 20:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762984AbbA3TqT (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 14:46:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:43426 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755467AbbA3TqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 14:46:17 -0500
Received: (qmail 1737 invoked by uid 102); 30 Jan 2015 19:46:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 13:46:17 -0600
Received: (qmail 26577 invoked by uid 107); 30 Jan 2015 19:46:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 14:46:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2015 14:46:15 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa910cax2.fsf@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263190>

On Fri, Jan 30, 2015 at 11:42:49AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Jan 29, 2015 at 12:45:22PM -0800, Junio C Hamano wrote:
> >
> >> +	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
> >> +		return error(_("affected file '%s' is beyond a symbolic link"),
> >> +			     patch->new_name);
> >
> > Why does this not kick in when deleting a file?
> 
> Half-written logic, forgotten to be revisited (i.e. "ok, anything
> that is not delete we can check new_name, so do that first, later
> we'd deal with deletion patch and I think the way to do so is by
> checking old_name, but let's make sure this case works first").

OK, I was worried I was missing something clever. :)

I agree that checking patch->old_name should work in that case.

-Peff
