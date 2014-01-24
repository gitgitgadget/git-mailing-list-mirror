From: Jeff King <peff@peff.net>
Subject: Re: Globbing for ignored branches?
Date: Fri, 24 Jan 2014 15:48:25 -0500
Message-ID: <20140124204825.GA17167@sigill.intra.peff.net>
References: <20140124090104.GA396@x4>
 <0C723FEB5B4E5642B25B451BA57E273075148284@S1P5DAG3C.EXCHPROD.USA.NET>
 <20140124170739.GC396@x4>
 <20140124170909.GD396@x4>
 <20140124182341.GB8202@sigill.intra.peff.net>
 <20140124183222.GE396@x4>
 <20140124185538.GA9836@sigill.intra.peff.net>
 <xmqq4n4trvzj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>,
	Jim Garrison <jim.garrison@nwea.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 21:48:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6nfz-0007Hg-Rv
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 21:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbaAXUs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 15:48:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:38375 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751686AbaAXUs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 15:48:27 -0500
Received: (qmail 8440 invoked by uid 102); 24 Jan 2014 20:48:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Jan 2014 14:48:27 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jan 2014 15:48:25 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4n4trvzj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241037>

On Fri, Jan 24, 2014 at 12:00:16PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Jan 24, 2014 at 07:32:22PM +0100, Markus Trippelsdorf wrote:
> >
> >> > However, you do have to specify each branch individually. You probably
> >> > want to say "all branches except X", and you cannot currently specify
> >> > a negative refspec like that.
> [...]
> The end result might be not so hard in the mechanical sense, but
> designing the interface would be hard.  I do not offhand think of a
> good way to do this.

I had imagined a "not" token at the front of the refspec, like:

  git fetch origin +refs/heads/*:refs/remotes/origin/* ^refs/heads/foo

In this case, a colon in the refspec would be an error. An alternative
would be:

  git fetch origin +refs/heads/*:refs/remotes/origin/* refs/heads/foo:

I.e., to say "put foo to nowhere". But generally refspecs do not affect
each other. So "refs/heads/foo:refs/heads/bar" would generally work _in
addition_ to the other refspec. Making the "null destination" work
differently might be confusing.

I dunno. I have not thought very hard on the topic, so maybe there are
some subtle cases I am missing.

-Peff
