From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Advertising the prebuilt htmldocs and manpages
Date: Sun, 20 Feb 2011 03:40:32 -0600
Message-ID: <20110220094032.GA9340@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie>
 <4D5F0A7C.1080507@gmail.com>
 <7v39nkooem.fsf@alter.siamese.dyndns.org>
 <AANLkTikb0W-yLihPtvm5LDUKgxgRg_a5Rsq7pjnpZLCt@mail.gmail.com>
 <20110219094104.GA31980@elie>
 <7v4o7zmc3e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 10:40:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr5mi-0001fj-AF
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 10:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab1BTJkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 04:40:42 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62977 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab1BTJkl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 04:40:41 -0500
Received: by iwn8 with SMTP id 8so902884iwn.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 01:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=hs5dZF9HBmkcE6NX2aqyQxz9PiGYgqkySaPOhBf1UGY=;
        b=LSiGiptKFh7vcnlKKkKIthnK2bDqK+ehZ0VEHn4FC/eNmT3lbWEGmou/ovsHiNoBFH
         6tW5w3jf07sFKCqsQd3tU4trPDRkWcukN+XuxBEvqP3HVD1tMIDAI+DzJXAeOyeXIz0A
         TxXdX7/GoF0K7lCdEM75NloiTMrxQz1Y/HCp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vp6hBn3kOj6FcsF1uh1ayHyk1X4Yy09EaXJxnQf8XIdObrWHikzTSfv35JCeVVoaXz
         A2FtNHHzjXrQgyEQEwi1OJZnDfBhJ1WErkC0Ix+CDA/FrUGKNQ7BzQW0rD2sXWgQTu15
         jpWFE+WtxNzzT9wTvdZyGgFr6nqx0f3DfX6Qc=
Received: by 10.42.218.137 with SMTP id hq9mr303492icb.75.1298194840968;
        Sun, 20 Feb 2011 01:40:40 -0800 (PST)
Received: from elie (adsl-69-209-79-88.dsl.chcgil.sbcglobal.net [69.209.79.88])
        by mx.google.com with ESMTPS id gy41sm3866369ibb.23.2011.02.20.01.40.37
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Feb 2011 01:40:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v4o7zmc3e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167406>

Junio C Hamano wrote:

> If all-caps INSTALL and README are not discoverable, there is not much
> hope that anything can be made more discoverable, is there?

I dunno.  Something like the following could work, but I don't think
it's worth it.

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 36989b7..9217c05 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -161,7 +161,22 @@ html: $(DOC_HTML)
 
 $(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7): asciidoc.conf
 
-man: man1 man5 man7
+man_toolchain_test:
+	@$(ASCIIDOC) --version >/dev/null && \
+	xmlto --version >/dev/null || \
+	{ \
+		printf '%s\n' \
+		'' \
+		'Building the manpages requires asciidoc and xmlto.' \
+		'Alternatively, pre-formatted documentation is' \
+		'available in the "man" branch of the git repository itself.' \
+		'See the INSTALL file for details.' \
+		'' && \
+		false; \
+	}
+.PHONY: man_toolchain_chest
+
+man: man_toolchain_test man1 man5 man7
 man1: $(DOC_MAN1)
 man5: $(DOC_MAN5)
 man7: $(DOC_MAN7)
