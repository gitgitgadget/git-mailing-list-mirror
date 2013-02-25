From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Add pthread support in QNX. Do not declare NO_
 macros if they can be autodetected.
Date: Mon, 25 Feb 2013 09:34:10 -0800
Message-ID: <7vhal0z4a5.fsf@alter.siamese.dyndns.org>
References: <CAHXAxrPTe6Q4BPtsGjiRnfFjZjUjwY6qXSAtZCzzAthODzA6EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gorchak <mike.gorchak.qnx@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 18:34:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA1wk-0003Qg-Re
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 18:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757533Ab3BYReO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 12:34:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101Ab3BYReN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 12:34:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECD1FBAC0;
	Mon, 25 Feb 2013 12:34:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KG3QPOXwME3Hy1I0xc2GpBQ7y4E=; b=g2Ft/C
	d5ZWnkWG1GEwwjulHacN+csQty3czuPi15WYyj/8Y3LPPKMBrP/zniG0XmCNvNSl
	jrCZIt7S/a/IltcSL90t4wTPZFg8D1KvDEwSYQTxoLY70rZlHpR193SFx8nbk/oO
	vEZ99MRM8OHKUdbOGCegHIoQTRDMqpF8G2/uY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s4Gy5kVvrBQ9QQkhuefKQjbEfMoOfn+1
	T4b3oGSSe7mGIZEDsl5VYegwCEJzrAwlYDfDe3w34Yvcm3WYlu1tIdlKpzWAor8E
	2FyLZ7Ulfdcg/5N18j7kERrBO4I0SkgWBpHP39S0iMnyL21DDpG0H7xs3dGUPMQM
	EzQ/hRL6Awc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1051BABF;
	Mon, 25 Feb 2013 12:34:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32BD6BABB; Mon, 25 Feb 2013
 12:34:12 -0500 (EST)
In-Reply-To: <CAHXAxrPTe6Q4BPtsGjiRnfFjZjUjwY6qXSAtZCzzAthODzA6EA@mail.gmail.com> (Mike
 Gorchak's message of "Mon, 25 Feb 2013 10:39:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 916926BE-7F71-11E2-A0C4-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217067>

Mike Gorchak <mike.gorchak.qnx@gmail.com> writes:

> Add pthread support in QNX. Do not declare NO_ macros if they can be
> autodetected.
>
> From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
> Signed-off-by: Mike Gorchak <mike.gorchak.qnx@gmail.com>

One procedural nit.  Please drop that "From:" immediately before
S-o-b: from future submissions (I'll remove it locally for this
patch and others you already posted when I apply, so this alone is
not a reason to resend them).  If you are forwarding somebody else's
patch, you would want "From:" in body, but the correct place to do
so is before everything else, i.e.

	... your e-mail headers ...
        From: Mike Gorchak <your.email@address.xz>
        Subject: [PATCH] title of the patch

        ... your e-mail body ...
	From: A U Thor <real.author@address.xz>

	The first line of the commit log message and
        the second line of it.

	Signed-off-by: A U Thor <real.author@address.xz>
        Signed-off-by: Mike Gorchak <your.email@address.xz>

Also, please leave the "autodetection" out.  If it is common to have
strcasestr (or any other) on a newer QNX, then not defining the
symbol NO_STRCASESTR in this file may still be the right thing to
do, but the justification for such a change should not be because we
rely on "autodetection".  The defaults given in config.mak.uname is
primarily for people who do not use the optional ./configure script,
so pick the default to help the most common configuration for the
platform.

I'd rewrite the patch like the attached, and tentatively queue the
patch to 'pu', but I do not use or have access to QNX myself, so you
may have to adjust the default set of symbols and the log message
and in such a case, please do re-submit a fixed version.

Specifically, I do not know if "... and others are also supported"
is universally true with QNX 6; if not, we need to define NO_* for
them to help people who build without using the ./configure script.

Thanks.

-- >8 --
From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Date: Mon, 25 Feb 2013 10:39:27 +0200
Subject: [PATCH] QNX: newer QNX 6.x.x is not so crippled

The initial port to QNX declared that the platform does not have
support for pthreads, getpagesize, strcasestr, mkstemps, mkdtemp,
strlcpy, and iconv, but QNX 6.x.x does support these.

On the other hand, older QNX lack gettext support, so define
NO_GETTEXT for them.

Also newer QNX do not need to link to any special library to enable
pthreads; define PTHREAD_LIBS to an empty string.

Signed-off-by: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.uname | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 8743a6d..ce2832b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -527,14 +527,21 @@ ifeq ($(uname_S),QNX)
 	HAVE_STRINGS_H = YesPlease
 	NEEDS_SOCKET = YesPlease
 	NO_FNMATCH_CASEFOLD = YesPlease
-	NO_GETPAGESIZE = YesPlease
-	NO_ICONV = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_MKDTEMP = YesPlease
-	NO_MKSTEMPS = YesPlease
 	NO_NSEC = YesPlease
-	NO_PTHREADS = YesPlease
 	NO_R_TO_GCC_LINKER = YesPlease
-	NO_STRCASESTR = YesPlease
-	NO_STRLCPY = YesPlease
+	# All QNX 6.x versions have pthread functions in libc;
+	# getpagesize and others are also supported.
+	ifeq ($(shell expr "$(uname_R)" : '6\.[0-9]\.[0-9]'),5)
+		PTHREAD_LIBS = ""
+	else
+		NO_PTHREADS = YesPlease
+		NO_GETPAGESIZE = YesPlease
+		NO_STRCASESTR = YesPlease
+		NO_MKSTEMPS = YesPlease
+		NO_MKDTEMP = YesPlease
+		NO_STRLCPY = YesPlease
+		NO_ICONV = YesPlease
+		NO_GETTEXT = YesPlease
+	endif
 endif
-- 
1.8.2.rc0.167.gd8ba4de
