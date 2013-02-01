From: Jeff King <peff@peff.net>
Subject: Re: Re: Re: Segmentation fault with latest git (070c57df)
Date: Fri, 1 Feb 2013 05:44:18 -0500
Message-ID: <20130201104418.GA15644@sigill.intra.peff.net>
References: <32006438.796571359714624362.JavaMail.weblogic@epml01>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jongman Heo <jongman.heo@samsung.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 11:47:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1E97-0007CI-QE
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 11:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007Ab3BAKqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 05:46:38 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55382 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030239Ab3BAKoW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 05:44:22 -0500
Received: (qmail 28100 invoked by uid 107); 1 Feb 2013 10:45:46 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 05:45:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 05:44:18 -0500
Content-Disposition: inline
In-Reply-To: <32006438.796571359714624362.JavaMail.weblogic@epml01>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215233>

On Fri, Feb 01, 2013 at 10:30:24AM +0000, Jongman Heo wrote:

> Short answer;
> 
>  * Version of make is 3.81 on both machines
>  * builtin/fetch.o is not rebuilt  (see entire log below)
>  * git works fine with "make all install COMPUTE_HEADER_DEPENDENCIES=no"

OK, that gets us closer. It's definitely a problem with the automatic
header dependencies, then.

> [...make debug output...]
> Reading makefile `builtin/.depend/fetch.o.d' (search path) (no ~ expansion)...

So we definitely have the dep file...

> [...]
>  Finished prerequisites of target file `builtin/fetch.o'.
>  Prerequisite `builtin/fetch.c' is older than target `builtin/fetch.o'.
>  Prerequisite `GIT-CFLAGS' is older than target `builtin/fetch.o'.
> No need to remake target `builtin/fetch.o'.

But it doesn't stimulate any prerequisites in make, which is weird.
What's in builtin/.depend/fetch.o.d?

-Peff
