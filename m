From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC] FreeBSD iconv function signature is "old"
Date: Thu, 23 Jul 2009 23:29:50 -0700
Message-ID: <7v7hxysie9.fsf@alter.siamese.dyndns.org>
References: <7vr5w6tzq8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 08:30:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUEII-0003hq-52
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 08:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbZGXG36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 02:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbZGXG36
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 02:29:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbZGXG35 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 02:29:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 65AA5F619;
	Fri, 24 Jul 2009 02:29:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 56EB5F618; Fri, 24 Jul 2009
 02:29:51 -0400 (EDT)
In-Reply-To: <7vr5w6tzq8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 23 Jul 2009 22\:30\:07 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6783FC0E-781B-11DE-8E25-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123906>

I noticed that my build on FreeBSD-7.2-RELEASE-i386 fails without
OLD_ICONV=YesPlease.

Is it just me and my installation (i.e. I might have failed to install
saner iconv from the port that everybody uses), or is everybody who runs
on FreeBSD using this option himself because our Makefile doesn't do that
automatically for them?

Just in case it is the latter, here is a proposed patch.

---

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index bde27ed..9a25c08 100644
--- a/Makefile
+++ b/Makefile
@@ -777,6 +777,7 @@ ifeq ($(uname_O),Cygwin)
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
+	OLD_ICONV = YesPlease
 	NO_MEMMEM = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
