From: Jeff King <peff@peff.net>
Subject: Re: orthogonal cases of log --date option
Date: Fri, 6 Mar 2009 00:23:18 -0500
Message-ID: <20090306052318.GB3426@sigill.intra.peff.net>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com> <7vtz6bdmfi.fsf@gitster.siamese.dyndns.org> <20090305104304.GA17760@coredump.intra.peff.net> <76718490903051304j6d8138f7qa5492ac15edd6460@mail.gmail.com> <20090305211120.GB20157@coredump.intra.peff.net> <7vy6vjy5js.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 06:24:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfSYE-0005OI-9H
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 06:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbZCFFXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 00:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbZCFFXW
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 00:23:22 -0500
Received: from peff.net ([208.65.91.99]:54565 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbZCFFXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 00:23:21 -0500
Received: (qmail 5691 invoked by uid 107); 6 Mar 2009 05:23:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 06 Mar 2009 00:23:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Mar 2009 00:23:18 -0500
Content-Disposition: inline
In-Reply-To: <7vy6vjy5js.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112386>

On Thu, Mar 05, 2009 at 02:21:27PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yep, it is more invasive. But I consider it more maintainable in the
> > long run.
> 
> Why do you think it is more confusing to ask "--date=local --date=iso"
> than asking "--local-time --date=iso"?  If the patch under discussion were
> not mine, I would have said that --date=local that flips the "lie about
> timezone" bit and tells us to use the "default" format is a brilliant and
> elegant solution.

Because from the user's perspective --foo={bar,baz,bleep} is about
selecting exactly one of {bar,baz,bleep}. Having --date=local is like
having --pretty=abbrev-commit. Yes, it is vaguely related to date
display, but it is orthogonal to the selection of one of the mutually
exclusive options.

Maybe I am alone in viewing the options this way. But at the very least,
the documentation that reads:

  --date={relative,local,default,iso,rfc,short}

should be updated to show that _some_ options are mutually exclusive but
others are not.

> I honestly do not see the point of what you are proposing to make
> "selector" and "format" independent; unless you are shooting for
> "--use-tz=Indian/Christmas --date=iso", that is.

No, I am not really proposing --use-tz as I have no use for it. But it
is an example of why syntactically keeping the orthogonal concept of
"which timezone to use" away from "which date style to use" is useful.
The only reason --date=local _doesn't_ look terrible is that it is a
simple boolean. Any date-related flags that took an argument would look
stupid as --date=option=foo.

-Peff
