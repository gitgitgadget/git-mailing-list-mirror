From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add DEVELOPER makefile knob to check for acknowledged warnings
Date: Thu, 25 Feb 2016 09:40:04 -0800
Message-ID: <xmqqd1rkpu2z.fsf@gitster.mtv.corp.google.com>
References: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: larsxschneider@gmail.com,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 25 18:40:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYzti-0005K7-Qy
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 18:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933386AbcBYRkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 12:40:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933052AbcBYRkI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 12:40:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F51447AD5;
	Thu, 25 Feb 2016 12:40:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8O9WlaNtzapk+Wg2fSvOw0mEgwE=; b=RDV5Oz
	002PZKt0negrWyk47pSSnVxhLQD08+jsKMuin6xTDjXo/dP6L8J6jxrNvZ5QuRST
	JJiE8zaOiKyRzf/3Txa3foI55I51Mup73yhovtbsRBiUIv0Ah0AnsoOnM/TnBwWy
	PAzXnUz/c1uAHSJLEyrtYDbWwE/zLOV7keIa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P5q4kA7aP30pYJ3tkxaxL+O/Vs/b/o+P
	b/YmRjwB9chzv3ftIvlJfQevw6bU0yyO3fv5qEmByDDCkXDFM26xOXfQ4ypxf2AW
	Pon2cvmIEPLUqfi3/VF1TxEJEVQVaTF9W7jgQz4C9ZgYBf1R40L+mV/ha6aoJvNz
	A+5cA00lKpY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2621747AD4;
	Thu, 25 Feb 2016 12:40:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 820E747AD3;
	Thu, 25 Feb 2016 12:40:06 -0500 (EST)
In-Reply-To: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Thu, 25 Feb 2016 09:42:22
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CEFADD18-DBE6-11E5-98AF-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287405>

Perhaps squash these two while queuing to address comments from you two?

Thanks.

 Documentation/CodingGuidelines |  3 ++-
 Makefile                       | 18 +++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 1c676c2..0ddd368 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -173,7 +173,8 @@ For C programs:
 
  - As a Git developer we assume you have a reasonably modern compiler
    and we recommend you to enable the DEVELOPER makefile knob to
-   ensure your patch is clear of all compiler warnings we care about.
+   ensure your patch is clear of all compiler warnings we care about,
+   by e.g. "echo DEVELOPER=1 >>config.mak".
 
  - We try to support a wide range of C compilers to compile Git with,
    including old ones. That means that you should not use C99
diff --git a/Makefile b/Makefile
index 9eb4032..7dc5b88 100644
--- a/Makefile
+++ b/Makefile
@@ -381,15 +381,15 @@ ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
 
 ifdef DEVELOPER
-	CFLAGS +=	-Werror \
-				-Wdeclaration-after-statement \
-				-Wno-format-zero-length \
-				-Wold-style-definition \
-				-Woverflow \
-				-Wpointer-arith \
-				-Wstrict-prototypes \
-				-Wunused \
-				-Wvla
+CFLAGS += -Werror \
+	-Wdeclaration-after-statement \
+	-Wno-format-zero-length \
+	-Wold-style-definition \
+	-Woverflow \
+	-Wpointer-arith \
+	-Wstrict-prototypes \
+	-Wunused \
+	-Wvla
 endif
 
 # Create as necessary, replace existing, make ranlib unneeded.
