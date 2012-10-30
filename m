From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] fix 'make test' for HP NonStop
Date: Tue, 30 Oct 2012 07:13:09 -0400
Message-ID: <20121030111308.GA32150@sigill.intra.peff.net>
References: <003101cdb29f$7c8d9490$75a8bdb0$@schmitz-digital.de>
 <20121029070642.GD5102@sigill.intra.peff.net>
 <005701cdb67f$f8b44d00$ea1ce700$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 12:13:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT9l8-0001QZ-RR
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 12:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519Ab2J3LNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 07:13:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43690 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070Ab2J3LNN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 07:13:13 -0400
Received: (qmail 31688 invoked by uid 107); 30 Oct 2012 11:13:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Oct 2012 07:13:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2012 07:13:09 -0400
Content-Disposition: inline
In-Reply-To: <005701cdb67f$f8b44d00$ea1ce700$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208697>

On Tue, Oct 30, 2012 at 10:21:40AM +0100, Joachim Schmitz wrote:

> This fixes the vast majority of test failures on HP NonStop.
> Some test don't work with /bin/diff, some fail with /bin/tar,
> so let's put /usr/local/bin in PATH first. 
> Some tests fail with /bin/sh (link to /bin/ksh) so use bash instead
> 
> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> ---
> 
> Makefile | 9 +++++++++
> 1 file changed, 9 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index f69979e..35380dd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1381,6 +1381,10 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
> 	MKDIR_WO_TRAILING_SLASH = YesPlease
> 	# RFE 10-120912-4693 submitted to HP NonStop development.
> 	NO_SETITIMER = UnfortunatelyYes
> +	SANE_TOOL_PATH=/usr/coreutils/bin:/usr/local/bin 
> +	SHELL_PATH=/usr/local/bin/bash
> +	# as of H06.25/J06.14, we might better use this
> +	#SHELL_PATH=/usr/coreutils/bin/bash
> endif
> ifneq (,$(findstring MINGW,$(uname_S)))
> 	pathsep = ;

Your patch was whitespace damaged, but I was able to fix it up. Thanks.

-Peff
