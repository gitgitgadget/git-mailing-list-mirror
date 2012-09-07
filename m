From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document MKDIR_WO_TRAILING_SLASH in Makefile
Date: Fri, 07 Sep 2012 10:29:31 -0700
Message-ID: <7vliglyc5g.fsf@alter.siamese.dyndns.org>
References: <003301cd8cf1$d26258c0$77270a40$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Sep 07 19:29:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA2NC-0000BM-3k
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 19:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab2IGR3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 13:29:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46344 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab2IGR3d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 13:29:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 240757FCB;
	Fri,  7 Sep 2012 13:29:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=URUQvK7M3MGweGEP1SxYVa95yIE=; b=xF4I4J
	FZZN/GQGHRYKXTLCo6ayxel3tIhcThJdTQdC1+dH0NA68lAQtqlvVUx/lvp3A5Bf
	s7hkKsp1jK4fMviujvYF/G7uY5Hh0dKBWFzQMVXe7eQRt75BlFZXiu+8j+mXM+QR
	/eBoapgiwkEmUFnp52j7AomwokJkpiB337JNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nt3cieKW5V3lCUuq5lDEefhDJd0Vx2HV
	/aXplo9vaNqpOCkSrIIX3fm7BH4tAtEZ7UabEz/AOCVlXr8Zno/tOKrh/XaZCh0I
	HjDzfEDmbpXPu5peCnTiF6yoR2DaoNdsOqb9KjuF0T4n/JONOlicCzuMqRDv9SZ0
	U6Nr9FSSO7Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11DBD7FCA;
	Fri,  7 Sep 2012 13:29:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8002C7FC9; Fri,  7 Sep 2012
 13:29:32 -0400 (EDT)
In-Reply-To: <003301cd8cf1$d26258c0$77270a40$@schmitz-digital.de> (Joachim
 Schmitz's message of "Fri, 7 Sep 2012 14:10:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9611926E-F911-11E1-8858-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204981>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> ---
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index ac49320..03e245a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -90,6 +90,8 @@ all::
>  #
>  # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
>  #
> +# Define MKDIR_WO_TRAILING_SLASH if your mkdir() can't deal with trailing slash.
> +#
>  # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
>  #
>  # Define NO_STRTOK_R if you don't have strtok_r in the C library.

Not really.  "make MKDIR_WO_TRAILING_SLASH=YesPlease" won't do
anything.

You would need at least something like this, no?

 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git c/Makefile w/Makefile
index 66e8216..21b4816 100644
--- c/Makefile
+++ w/Makefile
@@ -90,6 +90,8 @@ all::
 #
 # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
 #
+# Define MKDIR_WO_TRAILING_SLASH if your mkdir() can't deal with trailing slash.
+#
 # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
 #
 # Define NO_STRTOK_R if you don't have strtok_r in the C library.
@@ -1639,6 +1641,9 @@ ifdef NO_MKDTEMP
 	COMPAT_CFLAGS += -DNO_MKDTEMP
 	COMPAT_OBJS += compat/mkdtemp.o
 endif
+ifdef MKDIR_WO_TRAILING_SLASH
+	COMPAT_CFLAGS += -DMKDIR_WO_TRAILING_SLASH
+endif
 ifdef NO_MKSTEMPS
 	COMPAT_CFLAGS += -DNO_MKSTEMPS
 endif
