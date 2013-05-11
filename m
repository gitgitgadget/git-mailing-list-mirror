From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3 5/5] do not die when error in config parsing of
 buf occurs
Date: Sat, 11 May 2013 12:30:21 +0200
Message-ID: <20130511103020.GA6329@book-mint>
References: <20130509154020.GA26423@book-mint>
 <20130509162102.GG3526@book-mint>
 <20130509223936.GC30774@sigill.intra.peff.net>
 <20130511085531.GA3670@book-mint>
 <20130511095936.GB17326@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 11 12:30:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub74f-0007SD-6p
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 12:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab3EKKaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 06:30:30 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:57286 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab3EKKa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 06:30:29 -0400
Received: from [213.221.117.228] (helo=book-mint)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Ub74L-0000Tv-41; Sat, 11 May 2013 12:30:25 +0200
Content-Disposition: inline
In-Reply-To: <20130511095936.GB17326@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223955>

On Sat, May 11, 2013 at 11:59:36AM +0200, Jeff King wrote:
> On Sat, May 11, 2013 at 10:55:31AM +0200, Heiko Voigt wrote:
> > We where not outputting to stdout before so the test is correct there as
> > well. I extended the test when implementing the non-dying version of
> > git_config_with_options() so I could see the test fail. If just
> > returning the error it would still output the values read until then. So
> > if you think that it belongs into the initial version of this test
> > (maybe including some comment why we need an extra parseable value) I
> > am happy to move it there.
> 
> From what you wrote above, it sounds like we would expect git-config to
> write out some.value before failing on some.error. But that isn't what
> the test is checking, is it? It is checking that nothing is output.
> 
> I do not think the output matters much either way when git-config has
> failed; if it returns a non-zero exit code, then the results of stdout
> cannot be trusted (after all, it may have been killed by signal after it
> had written out half of the output).
> 
> Still slightly puzzled...

Well before my "do not die patch" there was no output to stdout since git
already died during reading.
Afterwards there would be output of values to stdout until the error
occurred and then the error code would be returned. So my intend was to
keep the output the same. Since the blob reading is new I thinks its
fine either way. So currently I am thinking about just removing the
whole "stop to write anything on error" part of this patch and just
return the error. What do you think?

Cheers Heiko
