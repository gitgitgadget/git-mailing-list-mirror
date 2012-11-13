From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] Git.pm: teach "ident" to query explicitness
Date: Tue, 13 Nov 2012 12:25:08 -0500
Message-ID: <20121113172508.GA12951@sigill.intra.peff.net>
References: <20121113164845.GD20361@sigill.intra.peff.net>
 <20121113165320.GE12626@sigill.intra.peff.net>
 <20121113172300.GA16241@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 18:25:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYKEs-0000c8-UN
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 18:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335Ab2KMRZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 12:25:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47645 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755301Ab2KMRZN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 12:25:13 -0500
Received: (qmail 27279 invoked by uid 107); 13 Nov 2012 17:26:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 12:26:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 12:25:08 -0500
Content-Disposition: inline
In-Reply-To: <20121113172300.GA16241@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209646>

On Tue, Nov 13, 2012 at 09:23:00AM -0800, Matt Kraai wrote:

> Minor nits:
> 
> On Tue, Nov 13, 2012 at 11:53:20AM -0500, Jeff King wrote:
> > @@ -750,6 +750,10 @@ and either returns it as a scalar string or as an array with the fields parsed.
> >  Alternatively, it can take a prepared ident string (e.g. from the commit
> >  object) and just parse it.
> >  
> > +If the C<explicit> option is set to 1, the returned array will contain an
> > +additional boolean specifying whether the ident was configure explicitly by the
> 
> s/configure/configured/

Thanks.

> >  	if (wantarray) {
> > -		return $identstr =~ /^(.*) <(.*)> (\d+ [+-]\d{4})$/;
> > +		my @ret = $identstr =~ /^(.*) <(.*)> (\d+ [+-]\d{4})$/;
> > +		if ($options{explicit} && defined $explicit) {
> > +			push @ret, $explicit if defined $explicit;
> 
> Isn't the test on this line redundant given that defined $explicit is
> already guaranteed by the condition on the previous line?

Yes, thanks (left over from an earlier attempt that tried to avoid
having $options{explicit}).

-Peff
