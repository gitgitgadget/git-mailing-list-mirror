From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/2] date: make "local" orthogonal to date format
Date: Tue, 1 Sep 2015 09:37:31 +0100
Message-ID: <20150901083731.GE30659@serenity.lan>
References: <20150831204444.GA4385@sigill.intra.peff.net>
 <20150831204831.GB10338@sigill.intra.peff.net>
 <20150831212754.GD30659@serenity.lan>
 <20150831213336.GA11720@sigill.intra.peff.net>
 <20150831220508.GA31973@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 01 10:37:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWh4j-0002h2-BR
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 10:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637AbbIAIhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 04:37:48 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:44233 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148AbbIAIhr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 04:37:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 3B522866007;
	Tue,  1 Sep 2015 09:37:46 +0100 (BST)
X-Quarantine-ID: <NXTy7qivo8Rq>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NXTy7qivo8Rq; Tue,  1 Sep 2015 09:37:45 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 1E758CDA5F4;
	Tue,  1 Sep 2015 09:37:33 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20150831220508.GA31973@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276973>

On Mon, Aug 31, 2015 at 06:05:09PM -0400, Jeff King wrote:
> On Mon, Aug 31, 2015 at 05:33:37PM -0400, Jeff King wrote:
> 
> > > diff --git a/date.c b/date.c
> > > index aa57cad..3aa8002 100644
> > > --- a/date.c
> > > +++ b/date.c
> > > @@ -817,9 +817,7 @@ void parse_date_format(const char *format, struct date_mode *mode)
> > >  		if (!skip_prefix(p, ":", &p))
> > >  			die("date format missing colon separator: %s", format);
> > >  		mode->strftime_fmt = xstrdup(p);
> > > -	}
> > > -
> > > -	if (*p)
> > > +	} else if (*p)
> > >  		die("unknown date-mode modifier: %s", p);
> > 
> > Yeah, that works. We could also advance "p" in the DATE_STRFTIME
> > conditional, but I think your solution is less ugly.
> > 
> > Thanks for debugging my mess.
> 
> By the way, I was imagining you would pick these up and add to them with
> more tests and documentation. If that's the case, please feel free to
> squash that in and keep my signoff. If not, then I can post a re-roll
> after waiting for other comments.

OK, I'll send them with some additions to t6300 built on top, although
it may take a couple of days.

The other documentation improvements feel like an independent topic that
isn't necessary for this series to graduate; I'd prefer not to block
this waiting for those changes.
