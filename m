From: Jeff King <peff@peff.net>
Subject: Re: Hardcoded #!/bin/sh in t5532 causes problems on Solaris
Date: Tue, 12 Apr 2016 13:22:47 -0400
Message-ID: <20160412172247.GA2856@sigill.intra.peff.net>
References: <570965B9.9040207@jupiterrise.com>
 <20160409210429.GB18989@sigill.intra.peff.net>
 <57098259.1060608@jupiterrise.com>
 <20160409223738.GA1738@sigill.intra.peff.net>
 <xmqqmvp2ti20.fsf@gitster.mtv.corp.google.com>
 <20160411173224.GE4011@sigill.intra.peff.net>
 <xmqqvb3mrcgj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Tom G. Christensen" <tgc@jupiterrise.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 19:22:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq21e-00077D-Nc
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 19:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbcDLRWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 13:22:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:48091 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933675AbcDLRWu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 13:22:50 -0400
Received: (qmail 24628 invoked by uid 102); 12 Apr 2016 17:22:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Apr 2016 13:22:49 -0400
Received: (qmail 8791 invoked by uid 107); 12 Apr 2016 17:22:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Apr 2016 13:22:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Apr 2016 13:22:47 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvb3mrcgj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291282>

On Tue, Apr 12, 2016 at 09:58:20AM -0700, Junio C Hamano wrote:

> > Looks good and is the minimal change. I kind of wonder if the example
> > would be more clear, though, as just:
> >
> >   write_script .git/hooks/pre-commit <<-\EOF &&
> >   exit 1
> >   EOF
> >   echo whatever >file1 &&
> >   ...
> >
> > I don't think we ever actually need the pre-commit check to pass, as we
> > simply override it with --no-verify. But I dunno. Maybe people find it
> > easier to read with a pseudo-realistic example (it took me a minute to
> > realize the trailing whitespace in the content was important).
> 
> I was mostly worried about closing the door for future enhancement
> where there are multiple commits to be replayed, some of which fail
> and others pass the test.  Unconditional "exit 1" would have to be
> reverted when it happens.

Yeah, that's fair. It is at least trying to re-create a real-world
situation.

-Peff
