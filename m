From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Provide a dirname() function when
 NO_LIBGEN_H=YesPlease
Date: Fri, 8 Jan 2016 17:18:51 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601081717430.2964@virtualbox>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de> <560C30B1.3010508@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:19:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHZl4-00057U-Be
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 17:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbcAHQTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 11:19:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:52903 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932352AbcAHQTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 11:19:09 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LwXCt-1a8qG03RVf-018NMy; Fri, 08 Jan 2016 17:18:55
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <560C30B1.3010508@ramsayjones.plus.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:nRMDr25PLiYNmtRxSicMsq2rSZ3NmfW4QMpC6lawN7e84TKgxgy
 OSO0frU7n1Juo6X6fHnYrxHyj9dfIxROvejcSUzpau87eaxpi/dYWDu4KaGby6guqXR2ed5
 Vf6mAWh1D6SvysTF4HI/eNGxVPGfGCf+YNOh4YL3ROOKLeoS9ow9j0POT95+0KjNpp52yq2
 8uzGLeKqpJhvwjeNK1nDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+BTliSHF9uw=:zMVoGDCFLShFn6YC/jbUZD
 6pgIBP+Z0oY56yapXuJw4iyVlZuIxOzfqEYEP1flFTDlbLPVUuGYHOnPUj0PAPaEkpP0ECN90
 lo3Rf9Ooyj4WCxOccAeAjD6eEum4zPLylsa/joCUo8wnL0Ya3LNtdfCqXH7gUt5GwSSLBLvsJ
 AcQ5ccOAv/YvxDZs4Fox3uhOVpxGOklIrYR9teziD90zzlNIBxUkozzJYYN5cioOrFtVpq2wk
 0V/5cEsQxcX3+akZOvwRArs+lvb76aldvt5qN7VP5ch+mS8tkOPsnf3mVeTMTb2Lbh3VJg43l
 vVPleByKqZcpcn9Bg7QrxRk2u0N/U52bAPbgvGWvxsWUXuzOnCeQ8s19qE+LRw/0IRPD8a6GP
 shBU86y5HPd6di5uED9nPyzfBIfRhw+wpLD7cQscEaq6I5V2oBi4F1YZawv9xFYhlK5HXOpa3
 A6olNa/GEaMa8mXH8yQoETfpg7nubm5BK3VTpQTT+BHEuW6bTDS4tR8kvf50ShuXj2poN25xy
 RgWouq1To5+UOVXpJ4hzVhlWxtdZQVJWdiF4E+00Vty0LSWKGJZtx2YVuiXtvAYwMX+M7afXb
 LJXrj+d0v4IHpeMuO9V0fBbp+DdbwKVwNyHdaBB5qFHdEdTEPz1D9uucqWsSn9uMeGt7JWidQ
 iVqTley4uP/SMzLxYTVdKIood81oyO8BnGFRLHBFn/jmOC9CYb8hdOJ8Q8QghyEcETxdsnh4s
 YtrWB0HCs1QNTLCAwnsYkYcgswyTpubLMrgpKG4TSHym6miJGH59+gtf/4mhAITLR/7PfuD7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283562>

Hi Ramsay,

On Wed, 30 Sep 2015, Ramsay Jones wrote:

> On 30/09/15 15:50, Johannes Schindelin wrote:
> > When there is no `libgen.h` to our disposal, we miss the `dirname()`
> > function.
> > 
> > So far, we only had one user of that function:
> > credential-cache--daemon (which was only compiled when Unix sockets
> > are available, anyway). But now we also have `builtin/am.c` as user,
> > so we need it.
> 
> Yes, many moons ago (on my old 32-bit laptop) when I was still 'working'
> with MinGW I noticed this same thing while looking into providing a win32
> emulation of unix sockets. So, I had to look into this at the same time.
> Since this didn't progress, I didn't mention the libgen issue.
> 
> Anyway, I still have a 'test-libgen.c' file (attached) from back then that
> contains some tests.

Awesome. Thank you! I integrated the tests back into test-path-utils.c
(from where the framework clearly came) and made it part of the regression
test suite in the upcoming v2.

Ciao,
Dscho
