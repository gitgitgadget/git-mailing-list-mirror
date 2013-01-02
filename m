From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] NetBSD 6?
Date: Wed, 02 Jan 2013 15:11:50 -0800
Message-ID: <7vd2xn18p5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 00:12:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqXTo-0005ci-Ir
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 00:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745Ab3ABXLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 18:11:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206Ab3ABXLw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 18:11:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58378AD9E;
	Wed,  2 Jan 2013 18:11:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=U
	nJw2FZfhogZsH/WU1TA5bH9aCg=; b=fm4Dn5gNHiXDXXrmD5b1+7HchMcK69F39
	KY+8i6jy1tV9MXAwXYC7rDLjFW15f4bNL70S0+9I4CfEqMbav3eZVuOFzp8QQ7wD
	aHwfvZqCHNt+yEoCFVLjZYVs0u20nOaks483GSZ0Ec3tBSgnPoyCFidJvP3+rZjt
	AZa4bS9LYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ybE
	cuHuZ7iZu5+GEkB37f6Jry82DRiThVt2AjArS/xRxM/d7ogRmC4FKNo2bV2a4wOd
	fuiIXRK8tIGdqNQ+/EmfimXzvuEaSZZPrSoSuUwVDuQGdCOcqiOI4NBqLubq+ZQE
	eMZUP/rXSvTj+s+DK2ylx8dhx1DjsLdtSXuiu8oI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49C1BAD9C;
	Wed,  2 Jan 2013 18:11:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B976EAD9B; Wed,  2 Jan 2013
 18:11:51 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CABCBF76-5531-11E2-9E7C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212553>

I would appreciate if somebody with more familiarlity with the
platform can suggest a better alternative than applying the
following patch to our Makefile.  Right now I have an equivalent of
this change in config.mak locally when building on the said
platform.

The "2.7" bit certainly looks fishy, as users should be able to
choose between "2.6" and "2.7" (and possibly "3.0"), IIUC.

 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index b0df41b..2ca6047 100644
--- a/Makefile
+++ b/Makefile
@@ -1163,8 +1163,11 @@ ifeq ($(uname_S),NetBSD)
 	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
 		NEEDS_LIBICONV = YesPlease
 	endif
+	PYTHON_PATH = /usr/pkg/bin/python2.7
+	PERL_PATH = /usr/pkg/bin/perl
 	BASIC_CFLAGS += -I/usr/pkg/include
 	BASIC_LDFLAGS += -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
+	OLD_ICONV = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
