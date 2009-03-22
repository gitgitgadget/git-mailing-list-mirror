From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH] Makefile: turn on USE_ST_TIMESPEC for FreeBSD
Date: Sun, 22 Mar 2009 15:15:57 +0100
Organization: private
Message-ID: <86skl5d4o2.fsf@broadpark.no>
References: <20090322080847.GA9075@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 22 15:17:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlOUq-0008KD-PC
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 15:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbZCVOQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 10:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbZCVOQE
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 10:16:04 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:33665 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbZCVOQD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 10:16:03 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGW00G94VMMNV30@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 22 Mar 2009 15:15:58 +0100 (CET)
Received: from localhost ([80.202.166.137]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGW00IRNVML9X90@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 22 Mar 2009 15:15:58 +0100 (CET)
In-reply-to: <20090322080847.GA9075@coredump.intra.peff.net>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114140>

Jeff King <peff@peff.net> writes:

> Fixes broken compilation on FreeBSD 6.1.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> No idea if older versions support this, or if they just need NO_NSEC
> instead.

  I google'd a litle and found this:

    http://fuse4bsd.creo.hu/localcgi/man-cgi.cgi?lstat+2
    http://www.nabble.com/st_mtimespec-or-st_mtime--td21217981.html

  So, at least FreeBSD 6.2 also seems to need this.  And I suspect that
  OpenBSD and/or NetBSD maybe need a simmilar patch.  Anybody who can
  test this?

  -- kjetil

>  Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index aae3b09..320c897 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -713,6 +713,7 @@ ifeq ($(uname_S),FreeBSD)
>  	BASIC_CFLAGS += -I/usr/local/include
>  	BASIC_LDFLAGS += -L/usr/local/lib
>  	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
> +	USE_ST_TIMESPEC = YesPlease
>  	THREADED_DELTA_SEARCH = YesPlease
>  	ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
>  		PTHREAD_LIBS = -pthread
