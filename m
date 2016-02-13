From: Jeff King <peff@peff.net>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Sat, 13 Feb 2016 12:00:44 -0500
Message-ID: <20160213170044.GB30144@sigill.intra.peff.net>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
 <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
 <20160210214945.GA5853@sigill.intra.peff.net>
 <CAP3OtXjyy+7cSi0S17FSsx8gnP1rKboeSAz_Hz1ZNVDuqcGASw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Blake Burkhart <bburky@bburky.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 18:00:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUdYw-0008Nj-QO
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 18:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbcBMRAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 12:00:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:41525 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750898AbcBMRAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 12:00:46 -0500
Received: (qmail 8236 invoked by uid 102); 13 Feb 2016 17:00:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 12:00:46 -0500
Received: (qmail 26793 invoked by uid 107); 13 Feb 2016 17:00:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 12:00:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2016 12:00:44 -0500
Content-Disposition: inline
In-Reply-To: <CAP3OtXjyy+7cSi0S17FSsx8gnP1rKboeSAz_Hz1ZNVDuqcGASw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286116>

On Fri, Feb 12, 2016 at 07:40:43PM -0600, Blake Burkhart wrote:

> On Wed, Feb 10, 2016 at 3:49 PM, Jeff King <peff@peff.net> wrote:
> >> 2. Servers that support resumable clone include a "resumable"
> >> capability in the advertisement.
> >
> > Because the magic happens in the git protocol, that would mean this does
> > not have to be limited to git-over-http. It could be "resumable=<url>"
> > to point the client anywhere (the same server over a different protocol,
> > another server, etc).
> 
> I'd like to call this out as a possible security issue before it gets
> implemented. Allowing the server to instruct the client what protocol
> to use is a security risk. This sounds like a fine feature, just do it
> carefully.

Thanks for mentioning this. I agree it's a potential issue, and we
should use the same solution as submodules, as you pointed out:

> To address this GIT_ALLOW_PROTOCOL was introduced, and git-submodule
> now uses it as of 33cfccb. This environment variable specifies a
> default whitelist of protocols. Whoever implements this should
> probably make use of GIT_ALLOW_PROTOCOL to limit resumable clones to
> the same default whitelist that git-submodule now uses.

-Peff
