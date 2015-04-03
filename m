From: Jeff King <peff@peff.net>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Fri, 3 Apr 2015 17:05:47 -0400
Message-ID: <20150403210547.GA10380@peff.net>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com>
 <20150402180914.GA19081@peff.net>
 <201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com>
 <20150402191452.GA20420@peff.net>
 <xmqq7ftujpu1.fsf@gitster.dls.corp.google.com>
 <62968860-FA58-4339-AF0B-264197EC8A04@rawsound.com>
 <20150402193524.GA21555@peff.net>
 <551DD887.2010403@web.de>
 <xmqqy4m9exj0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"Reid Woodbury Jr." <reidw@rawsound.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 23:05:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye8mp-0001wU-2C
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 23:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbbDCVFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2015 17:05:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:42136 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752719AbbDCVFu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 17:05:50 -0400
Received: (qmail 10164 invoked by uid 102); 3 Apr 2015 21:05:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Apr 2015 16:05:50 -0500
Received: (qmail 25430 invoked by uid 107); 3 Apr 2015 21:06:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Apr 2015 17:06:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2015 17:05:47 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4m9exj0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266726>

On Fri, Apr 03, 2015 at 02:01:55PM -0700, Junio C Hamano wrote:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
> > This makes my think that it is
> > a) non-standard to have the extra colon
> > b) The error message could be better
>=20
> For that, perhaps
>=20
> -ssh: Could not resolve hostname xxxx:: nodename nor servname provide=
d, or not known
> +ssh: Could not resolve hostname "xxxx:": nodename nor servname provi=
ded, or not known
>=20
> would be something we would want to do, no matter what other fixes
> we would apply.

That message comes from the ssh client. So the "we" here would have to =
submit a
patch to OpenSSH".

The easier way to diagnose inside git is to set GIT_TRACE, which makes
it more clear:

  $ GIT_TRACE=3D1 git clone ssh://bogosity:/repo.git
  ...
  17:05:00.734019 run-command.c:347       trace: run_command: 'ssh' 'bo=
gosity:' 'git-upload-pack '\''/repo.git'\'''

-Peff
