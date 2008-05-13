From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use whitespace.
Date: Tue, 13 May 2008 19:10:30 +0100
Message-ID: <e2b179460805131110k3cf582fdn9b8bd31046b90ca7@mail.gmail.com>
References: <20080427151610.GB57955@Hermes.local>
	 <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness>
	 <B287EA35-6C5D-4A5A-BEF1-C55A70D913ED@silverinsanity.com>
	 <20080428094119.GA20499@sigill.intra.peff.net>
	 <e2b179460804280256g4ff903bu39c9460086df7157@mail.gmail.com>
	 <20080513091143.GA26248@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brian Gernhardt" <benji@silverinsanity.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 13 20:11:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvyyB-0007Sg-Mv
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 20:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857AbYEMSKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 14:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756774AbYEMSKc
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 14:10:32 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:51583 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbYEMSKb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 14:10:31 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3369026rvb.1
        for <git@vger.kernel.org>; Tue, 13 May 2008 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YrhUiRq7F9T7wns2a2gvBLuUbdBTGi83yy0PQRElne0=;
        b=nJU02wbvMj1kC4kMUK1N2UR5YvS5NYSBzccI1VQ+0At5wAhttNQ1ioAg0l0DzKV9j/18+z9XrEhskEF2ctifUi/y5ajj067V9gyvqbaaZJI1Pc7Q92SQ2SuIB4Y5xN6Wnc6BqQHi/aOimsjan2qPix4SdVpNJgjlKfVqKCnLB9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tnPb3xJxxrGcyva0OllmN+C6fkObjf2nAmJiujhMSy74GtmabW9CdNZpKD3LH2Gfyw4fuR0t7I5QLOZnVdTF5vDt+AEPe6NsU2zMOj6opD/IjMMy7UDS9BDmwUVrSkbs+tt/lxjhD1frs63gKpZRBll1rsFEKr5mfMODazEmLvY=
Received: by 10.140.165.21 with SMTP id n21mr4398655rve.289.1210702230929;
        Tue, 13 May 2008 11:10:30 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Tue, 13 May 2008 11:10:30 -0700 (PDT)
In-Reply-To: <20080513091143.GA26248@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82036>

2008/5/13 Jeff King <peff@peff.net>:
>
> On Mon, Apr 28, 2008 at 10:56:05AM +0100, Mike Ralphson wrote:
>  > I could run automated build / test [/ bisect?] cycles on AIX if of any
>  > interest.
>
>  I think that would be helpful. We seem to have most Linux variants
>  pretty well covered. I now have a daily pull/build/test running on a
>  FreeBSD 6.1 box. I am going to try to get a Solaris one going, too, but
>  I have to first actually get the test scripts to pass _once_. :)
>
>  AIX would be nice, since it seems easy to break. ;) OS X would be nice,
>  too, though I suspect there are a few developers (Shawn?) who end up
>  running the test scripts occasionally anyway.
>
>  I am just calling the script below through cron, and it dumps a bunch of
>  output if any test fails (at which point I go investigate manually). The
>  only argument is the path to a git repo.

Thanks - that was a helpful spur to action. I'll check tomorrow how it
fairs pulling, building, running the tests etc. I've added a couple of
'try git tag -f's to it, so I have KNOWN_BUILDING and KNOWN_PASSING
points to pass quickly into bisect if necessary.

I'll shout the first time something breaks (after doing a bit of
rudimentary investigation), then maybe we can look at a way of
aggregating the build/test statuses and whether that should be pushed
to a website (or git repo, obviously) or some kind of alert.

Cheers, Mike
