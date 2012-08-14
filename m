From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 02/16] Integrate remote-svn into svn-fe/Makefile.
Date: Tue, 14 Aug 2012 13:14:12 -0700
Message-ID: <7vd32t9qp7.fsf@alter.siamese.dyndns.org>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 22:14:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1NVM-00055n-UC
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 22:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966Ab2HNUOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 16:14:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756336Ab2HNUOP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 16:14:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1C587B60;
	Tue, 14 Aug 2012 16:14:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9tm/9MLfs3tJBcpnOARIpkT3J8w=; b=k2mttG
	2ojrTO3C2jLX3v27lSYK4KQ0WjiCC0tkbiLkju8Cl0zPNChPsjpzCVmgkplvCRRq
	6t8k4JAxxMSTug/lWZl5EkXhvnpzfxbxDS5mCFqVITjigAzMR/T4whgkBddXk3WT
	m1QPQi9TbbA0LCrLImqHyQc4Jgit8Jo6bAfsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qHzqNExPqNPnv0JF5GXdbyxD8QBFCeAr
	f40fV4K7G7tbqVs/ZoeUGJj2La2cmTy3p6PRrqtcKGxAXzU70g/4yPJ12S2f7he3
	eLABDjuSiq044D5mzeElcmaf0ApdLMPxUxPPNXGsmY+cZ2ROSDx7xCHWlxA0HcGP
	dcQAK0AD6bI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF0947B5F;
	Tue, 14 Aug 2012 16:14:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FFA87B5E; Tue, 14 Aug 2012
 16:14:14 -0400 (EDT)
In-Reply-To: <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Tue, 14 Aug 2012 21:13:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E213F22-E64C-11E1-92F5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203443>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> Requires some sha.h to be used and the libraries
> to be linked, this is currently hardcoded.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> ---
>  contrib/svn-fe/Makefile |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
> index 360d8da..8f0eec2 100644
> --- a/contrib/svn-fe/Makefile
> +++ b/contrib/svn-fe/Makefile
> @@ -1,14 +1,14 @@
> -all:: svn-fe$X
> +all:: svn-fe$X remote-svn$X
>  
>  CC = gcc
>  RM = rm -f
>  MV = mv
>  
> -CFLAGS = -g -O2 -Wall
> +CFLAGS = -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>' -Wdeclaration-after-statement
>  LDFLAGS =
>  ALL_CFLAGS = $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
> -EXTLIBS =
> +EXTLIBS = -lssl -lcrypto -lpthread ../../xdiff/lib.a

I haven't looked carefully, but didn't we have to do a bit more
elaborate when linking with ssl/crypto in our main Makefile to be
portable across various vintages of OpenSSL libraries?

Does contrib/svn-fe/ already depend on OpenSSL by the way?  It needs
to be documented somewhere in the same directory.

If one builds the main Git binary with NO_OPENSSL, can this still be
built and linked?

What does this use xdiff/lib.a for?

The above are just mental notes; I didn't read the later patches in
the series that may already address these issues.

>  GIT_LIB = ../../libgit.a
>  VCSSVN_LIB = ../../vcs-svn/lib.a
> @@ -37,8 +37,12 @@ svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ svn-fe.o \
>  		$(ALL_LDFLAGS) $(LIBS)
>  
> -svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
> -	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
> +remote-svn$X: remote-svn.o $(VCSSVN_LIB) $(GIT_LIB)
> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ remote-svn.o \
> +		$(ALL_LDFLAGS) $(LIBS)
> +		
> +%.o: %.c ../../vcs-svn/svndump.h
> +	$(QUIET_CC)$(CC) -I../../vcs-svn -I../../ -o $*.o -c $(ALL_CFLAGS) $<
>  
>  svn-fe.html: svn-fe.txt
>  	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
> @@ -58,6 +62,6 @@ svn-fe.1: svn-fe.txt
>  	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit.a
>  
>  clean:
> -	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1
> +	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1 remote-svn.o
>  
>  .PHONY: all clean FORCE
