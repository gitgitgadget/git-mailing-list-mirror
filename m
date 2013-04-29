From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Git.pm with recent File::Temp fail
Date: Mon, 29 Apr 2013 10:32:17 +0200
Message-ID: <20130429103217.5f50525b@pc09.procura.nl>
References: <20130322205758.09ca9107@pc09.procura.nl>
	<CAP30j14=_U8iEZAodnfACnBHgF0+j0_OK7n7PvsUnwSDj_Y40A@mail.gmail.com>
	<20130428110933.436786bd@pc09.procura.nl>
	<20130429021651.GA2751@sigill.intra.peff.net>
	<7vr4hung17.fsf@alter.siamese.dyndns.org>
	<20130429074620.17fbf129@pc09.procura.nl>
	<7vy5c1narj.fsf@alter.siamese.dyndns.org>
	<7vd2tdn41h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Ben Walton <bdwalton@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 10:32:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWjVu-0002dK-4u
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 10:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920Ab3D2Icm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 04:32:42 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:3377 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab3D2Icl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 04:32:41 -0400
Received: from pc09.procura.nl (adsl.procura.nl [82.95.216.30])
	(authenticated bits=0)
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id r3T8WWMr031262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 29 Apr 2013 10:32:33 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7vd2tdn41h.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222782>

On Mon, 29 Apr 2013 01:18:18 -0700, Junio C Hamano <gitster@pobox.com>
wrote:

> Here is what I'll queue.
> 
> Thanks for the help, all of you.

Thank you. I will keep this conversation as a guide for possible next
patches

> -- >8 --
> From: H. Merijn Brand <h.m.brand@xs4all.nl>
> Subject: Git.pm: call tempfile from File::Temp as a regular function
> 
> We call File::Temp's "tempfile" function as a class method, but it was
> never designed to be called this way. Older versions seemed to
> tolerate it, but as of File::Temp 0.23, it blows up like this:
> 
>   $ git svn fetch
>   'tempfile' can't be called as a method at .../Git.pm line 1117.
> 
> Fix it by calling it as a regular function, just inside the File::Temp
> namespace.
> 
> Signed-off-by: H. Merijn Brand <h.m.brand@xs4all.nl>
> Helped-by: Jeff King <peff@peff.net>
> ---
>  perl/Git.pm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 497f420..76383b9 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1039,7 +1039,7 @@ sub _temp_cache {
>  			$tmpdir = $self->repo_path();
>  		}
>  
> -		($$temp_fd, $fname) = File::Temp->tempfile(
> +		($$temp_fd, $fname) = File::Temp::tempfile(
>  			'Git_XXXXXX', UNLINK => 1, DIR => $tmpdir,
>  			) or throw Error::Simple("couldn't open new temp file");
>  


-- 
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.17   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/
