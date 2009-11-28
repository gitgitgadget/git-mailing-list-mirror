From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] Makefile: make ppc/sha1ppc.o depend on GIT-CFLAGS
Date: Sat, 28 Nov 2009 05:33:23 -0600
Message-ID: <20091128113323.GC10059@progeny.tock>
References: <20091128112546.GA10059@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 12:21:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NELMh-0001Dt-9M
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 12:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbZK1LVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 06:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbZK1LVK
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 06:21:10 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:64943 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbZK1LVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 06:21:09 -0500
Received: by ywh12 with SMTP id 12so2374011ywh.21
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 03:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=oX87tHb8Hf4Wz/C+3wBJcqYpGr4jhNd/OxnifcumrkY=;
        b=unDhlATdJ/gLBdGtU+Wr2niHevekQRORiItNCn90qSRsfA/DVSUS+ixUn2A1kX5ypv
         MT25ph9GDdRaXKyXygpgTtjeQZ/vwf/9q6GlOzTepu1T5GdQz1GLx4WIKQ4wppxpMM0l
         iSjkbM8kgdSsy0+2spsOnK+G1P6wRExIJ6/YQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bjhwfcenaWj5xjdWPUpViqOzg3B8Y23TEkj67pukjzItD7ubkxN11rSbFVleLmnPk/
         z8+RwkrmGHWmHlM1Nkt2GTDpTn58ZX1m6ILfCsroAAs0UGtAzBR86uCNflgQqbXtL35f
         6ZCMTuPrarCs5pex6aSm1mLo55ooGZoI+ZiDM=
Received: by 10.150.210.5 with SMTP id i5mr3352224ybg.174.1259407273350;
        Sat, 28 Nov 2009 03:21:13 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm561290gxk.5.2009.11.28.03.21.11
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 03:21:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091128112546.GA10059@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133952>

Any rule that makes use of ALL_CFLAGS should depend on GIT-CFLAGS
to avoid trouble.  This one would not actually be affected by any
build flags except the optimization level, so leaving the
dependency out was mostly harmless.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index dc7c929..bb3879e 100644
--- a/Makefile
+++ b/Makefile
@@ -1526,7 +1526,7 @@ git.o git.spec \
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
-%.o: %.S
+%.o: %.S GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
-- 
1.6.5.3
