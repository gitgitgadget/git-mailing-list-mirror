From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Git.pm with recent File::Temp fail
Date: Mon, 29 Apr 2013 07:46:20 +0200
Message-ID: <20130429074620.17fbf129@pc09.procura.nl>
References: <20130322205758.09ca9107@pc09.procura.nl>
	<CAP30j14=_U8iEZAodnfACnBHgF0+j0_OK7n7PvsUnwSDj_Y40A@mail.gmail.com>
	<20130428110933.436786bd@pc09.procura.nl>
	<20130429021651.GA2751@sigill.intra.peff.net>
	<7vr4hung17.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Ben Walton <bdwalton@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 07:46:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWgvK-0007Om-MZ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 07:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab3D2Fqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 01:46:46 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:3598 "EHLO
	smtp-vbr12.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab3D2Fqq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 01:46:46 -0400
Received: from pc09.procura.nl (adsl.procura.nl [82.95.216.30])
	(authenticated bits=0)
	by smtp-vbr12.xs4all.nl (8.13.8/8.13.8) with ESMTP id r3T5kYZ9052221
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 29 Apr 2013 07:46:36 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7vr4hung17.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.9.0-196-ge98c82 (GTK+ 2.24.10; x86_64-suse-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222776>

On Sun, 28 Apr 2013 20:59:16 -0700, Junio C Hamano <gitster@pobox.com>
wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Sun, Apr 28, 2013 at 11:09:33AM +0200, H.Merijn Brand wrote:
> >
> >> Still failing in 1.8.2.2
> >> 
> >> Short fix:
> >> --8<---
> >> diff --git a/perl/Git.pm b/perl/Git.pm
> >> index dc48159..7a252ef 100644
> >> --- a/perl/Git.pm
> >> +++ b/perl/Git.pm
> >> @@ -1265,7 +1265,7 @@ sub _temp_cache {
> >>                         $tmpdir = $self->repo_path();
> >>                 }
> >> 
> >> -               ($$temp_fd, $fname) = File::Temp->tempfile(
> >> +               ($$temp_fd, $fname) = File::Temp::tempfile(
> >>                         'Git_XXXXXX', UNLINK => 1, DIR => $tmpdir,
> >>                         ) or throw Error::Simple("couldn't open new temp file");
> >
> > I think this fix is the right thing. Your patch probably didn't get
> > applied because it did not follow the guidelines in SubmittingPatches.
> 
> It was more like "It managed to miss people's attention because the
> subject didn't say [PATCH]", but yes you are right that the change
> the patch text itself shows looks reasonable and that I cannot apply
> a patch that is not signed off (and worse yet in multipart/mixed).

My first attempt (when git-1.8.2 was released) had the patch attached
and the reply was

On Sat, 23 Mar 2013 16:32:47 +0000, Ben Walton <bdwalton@gmail.com>
wrote:

> This list prefers patches to be inline so that they can easily be
> commented on, etc.  I took a quick look at your patch and while it
> looks fine to me, fwiw.
> 
> You may want to resubmit using git send-email though so that others
> will look at it and possibly apply it.

So I retried inlining. No mention about *how* to inline or that the
subject should have the word "PATCH".

I don't need any credits. I just want git to work from scratch :)

> > ...
> > So I think the right commit message is something like:
> >
> >   We call File::Temp's "tempfile" function as a class method, but it was
> >   never designed to be called this way. Older versions seemed to
> >   tolerate it, but as of File::Temp 0.23, it blows up like this:
> >
> >     $ git svn fetch
> >     'tempfile' can't be called as a method at .../Git.pm line 1117.
> >
> >   Fix it by calling it as a regular function, just inside the File::Temp
> >   namespace.

Sounds about right.

> > -Peff
> 
> Thanks.

-- 
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.17   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/
