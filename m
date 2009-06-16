From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 2/2] Makefile: use compat regex on Solaris
Date: Tue, 16 Jun 2009 15:07:40 -0500
Message-ID: <v5GZyk1pvyw2mnFGX-8GiCIBKzquUZb5YYcjHNvgkczpXD2vQ4qdjg@cipher.nrlssc.navy.mil>
References: <20090616190550.GA22905@coredump.intra.peff.net> <20090616190821.GB23197@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, John Bito <jwbito@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 22:08:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGewr-0007tt-RA
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 22:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbZFPUHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 16:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbZFPUHr
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 16:07:47 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33971 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbZFPUHq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 16:07:46 -0400
Received: by mail.nrlssc.navy.mil id n5GK7eYc007576; Tue, 16 Jun 2009 15:07:41 -0500
In-Reply-To: <20090616190821.GB23197@coredump.intra.peff.net>
X-OriginalArrivalTime: 16 Jun 2009 20:07:40.0821 (UTC) FILETIME=[1A3D9450:01C9EEBE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121709>

Jeff King wrote:
> The system regex is either slow or buggy for complex
> patterns, like the built-in xfuncname pattern for java
> files.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Rebased to today's master to resolve textual conflicts.
> 
>  Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 0cb21da..3bd0c08 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -725,6 +725,7 @@ ifeq ($(uname_S),SunOS)
>  	NO_MEMMEM = YesPlease
>  	NO_MKDTEMP = YesPlease
>  	NO_MKSTEMPS = YesPlease
> +	NO_REGEX = YesPlease
>  	ifeq ($(uname_R),5.7)
>  		NEEDS_RESOLV = YesPlease
>  		NO_IPV6 = YesPlease


You need to add -DHAVE_ALLOCA_H to the BASIC_CFLAGS statement in
the SunOS section of the Makefile so that alloca.h will be included
in compat/regex/regex.c.  This is necessary for the SUNWspro compiler.
It takes me a long time to compile, so I haven't checked yet whether
this causes any problems for the GNU compiler.

-brandon
