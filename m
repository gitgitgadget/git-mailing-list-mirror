From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 2/2] gitweb: introduce localtime feature
Date: Mon, 21 Mar 2011 23:20:10 +0100
Message-ID: <201103212320.11336.jnareb@gmail.com>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost> <201103211701.01785.jnareb@gmail.com> <4D879B70.8070405@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Kevin Cernekee <cernekee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 23:20:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1nSc-0000AO-Fv
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 23:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443Ab1CUWUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 18:20:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46631 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309Ab1CUWUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 18:20:20 -0400
Received: by wya21 with SMTP id 21so6200679wya.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 15:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=0vhWG/r10Yi2FyPEXMuUcxXRjxWKG9YlYb2GF7IKWms=;
        b=F0jr1IcIK8HJZOiREpH/HRMS5Ncpn7/3rs+jVKeUh0QEyaE4Jk7PPfDnELnWcjr6xN
         bVWD+zasupGRDIH0bOC2Z5pHrX0F7eevO4wxWCUAprdmoR50AC2rLQ537WoVbv6cdCap
         xocloU3wXWEo+3X/WvZzMtBqmdTRwLrem1m7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=X/TKtFKWup4fdI9aaI8MkCKJWTI2AYbrF9LhCTLrkwaXKuoQnCqUR9uF9fKg9kwSgX
         ekb6TczM0dFpsLQcGmPPUM0SdQOlrufqP3OZ035i9AzV0pt15sjFIitHhsVpnjnfFxNm
         KuUAZF4+QtYSq9BWvGBh7HmQCbtNKkGUn63jo=
Received: by 10.216.142.221 with SMTP id i71mr4235394wej.93.1300746019308;
        Mon, 21 Mar 2011 15:20:19 -0700 (PDT)
Received: from [192.168.1.13] (abvo154.neoplus.adsl.tpnet.pl [83.8.212.154])
        by mx.google.com with ESMTPS id r80sm2722066wei.15.2011.03.21.15.20.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 15:20:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4D879B70.8070405@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169680>

J.H. wrote:
> On 03/21/2011 09:01 AM, Jakub Narebski wrote:

> > First, it would complicate caching, as output would depend not only purely
> > on URL, but can also depend on cookies.  Cache key would have to take it
> > into account.
> > 
> > Second, it would reduce effectiveness of cache, as single page would have
> > to have multiple versions (up to 24, one per timezone, I guess).
> 
> The implementation I have running in the back of my head would be
> completely independent, so I'm not sure what implementation you are
> thinking of that would cause this.  One of the reasons I'm suggesting
> Javascript at all is to avoid exactly this problem.

Well, of course if output is the same, only post-processed by JavaScript
(and no server-side fallback), then there is no interference between
timezones and output caching.
 
N.B. caching of git output, or of parsed data, allows to generate multiple
outputs from one cached value... but OTOH output caching is simpler.

[...]
> > Well, if we are doing it on server side, then by having 'timezone' feature
> > rather than 'localtime' one from Kevin patches, we would have per-repo
> > configuration "for free".
> 
> Doing it on the server overly complicates things, breaks web caches,
> gitweb-caching and generally I'd argue is not what we want.  It would
> work for small installations, in particular those not using
> gitweb-caching, but honestly this is a useful enough feature for a more
> distributed audience it needs to work with gitweb-caching, without
> putting undue burden on the caching engine (as a whole).  Javascript is
> the obvious, and simple answer to that.  Won't add any substantial
> complexity to the backend, and will allow for more complex choices and
> instant changes (without involving the backend at all).
> 
> That pretty much sounds like a win to me anyway...

Note that proposed "on server" solution, like the one in Kevin's patches,
would not include a way to select a way of presenting dates by client: it
all would be set on server, and not interfere with output caching.

As to complexity: you would either have complexity in backend, or 
complexity in JavaScript...


But I agree that JavaScript enhancement solution is better.

> > > I would think, if we are doing this in JavaScript, that this is an over
> > > complication to do on a per-repo basis.  I would guess setting a generic
> > > default and letting people deviate makes more sense.  Just my thought
> > > anyway, but I think there's a lot of extra per-repo configurations that
> > > add complexity with minimal gain.
> > 
> > It it is set _by client_, then of course it doesn't make much sense to
> > make it configurable per-repository.  Besides it would be difficult to
> > implement and store in JavaScript, I think.
> 
> Cookies solve the problem, and those are basically trivial to deal with
> in Javascript.

I was talking about difficulty of _per-repo_ configuration with 
_client-side_ scripting.  For each [visited] repository we would have to
store config: too much for a cookie (well, perhaps localStorage... ;-)).
 
> > Per-repository settings makes sense for _server-side_; different 
> > repositories may have different character: some might be geographically
> > distributed, some might have all contributors in single timezone.
> 
> Agreed, since I've been arguing for the client side work, I think we are
> on the same page here.

[...]

> Also keeping in mind that miroformats are almost explicitly for the
> benefit of search engines, which I'm not sure if a majority of gitweb
> installations care about, it may not be worthwhile to actually go down
> that road.

Right.
 
> > > > Note that JavaScript mangling of dates is quite independent on whether
> > > > dates are displayed in GMT/UTC or in author / committer / tagger timezone
> > > > like for current 'localtime' feature.
> > >
> > > I wasn't intending to change the current formatting of the times we have
> > > in place currently.  Just allowing people to change what time was being
> > > displayed.
> > 
> > I wanted to say that JavaScript post-processing of dates is a bit 
> > orthogonal to David's server-side localtime (or similar) feature.
> 
> It's a different direction, yes, but it's definitely not orthogonal.  If
> you do this on the server side, as David originally suggested, you can
> create a mess in other places (external proxies, external web caches,
> gitweb-caching, etc).  I like his idea, just not where it's implemented
> at current.  If you leave the server side alone, and deal with the
> processing of the dates on the client side you alleviate all of the
> server side gotchas, while only introducing one or two gotchas to the
> client side.
> 
> This isn't an orthogonal discussion, it's a discussion of where the
> right place / right solution to accomplish the same goal is.

Well, perhaps it is not orthogonal discussion, but you can those two
_slightly different_ solutions:
 * server-side, per-repository config, no client choice
 * client-side, JavaScript enhancements, global per-client choice,
   client choice stored in cookie

might work together... though it probably doesn't make much sense.

-- 
Jakub Narebski
Poland
