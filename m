From: Jeff King <peff@peff.net>
Subject: Re: git clean performance issues
Date: Sat, 4 Apr 2015 15:55:07 -0400
Message-ID: <20150404195507.GA31763@peff.net>
References: <CAMpP7NY++BwV+UygRj1C6Zsf=jE-z1AQuN3On0HeEqQpKGQtqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: erik =?utf-8?B?ZWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 21:55:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeU9z-0002vQ-7R
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 21:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbbDDTzL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Apr 2015 15:55:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:42480 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752779AbbDDTzK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 15:55:10 -0400
Received: (qmail 5216 invoked by uid 102); 4 Apr 2015 19:55:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 14:55:10 -0500
Received: (qmail 32233 invoked by uid 107); 4 Apr 2015 19:55:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 15:55:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Apr 2015 15:55:07 -0400
Content-Disposition: inline
In-Reply-To: <CAMpP7NY++BwV+UygRj1C6Zsf=jE-z1AQuN3On0HeEqQpKGQtqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266782>

On Sat, Apr 04, 2015 at 08:32:45PM +0200, erik elfstr=C3=B6m wrote:

> In my scenario get_ref_cache will be called 10000+ times, each time
> with a new path. The final few calls will need to search through and
> compare 10000+ entries before realizing that there is no existing
> entry. This quickly ads up to 100 million+ calls to strcmp().
>=20
> From what I can understand, the calls to get_ref_cache in this
> scenario will never do any useful work. Is this correct? If so, would
> it be possible to bypass it, maybe by calling
> resolve_gitlink_ref_recursive directly or by using some other way of
> checking for the presence of a git repo in clean.c:remove_dirs?

I think this is the same issue that was discussed here:

  http://thread.gmane.org/gmane.comp.version-control.git/265560/focus=3D=
265585

There is some discussion of a possible fix in that thread. I was hoping
that Andreas was going to look further and produce a patch, but I
imagine he got busy with other things. Do you want to try picking it up=
?

-Peff
