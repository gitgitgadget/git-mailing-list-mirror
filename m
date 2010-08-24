From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 31/32] send-pack: do not use thin pack in narrow mode
Date: Wed, 25 Aug 2010 08:20:21 +1000
Message-ID: <1282688422-7738-32-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:25:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1vf-0004Dg-GF
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170Ab0HXWYa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:24:30 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49107 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756056Ab0HXWY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:24:28 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so2814108pvg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zmt6k9vLR60GUhXiLl0xZJ2zR7WFL5YtheDua4iVgMI=;
        b=nFdf0RdZNL/Kjv0uD1uU0tvBuCU3ryntoO2cZCFvE3DCnLrHR/+cVHUPIx1wpl3jxi
         exjkwo3LcKxUOcYWddxwlUDSN8WRhW+RQxW8JNG2JrXTRz+k20mCL4UUEADnmy7kN6yA
         ek5hio7UmFFtr/3FWzupVoMob4aPWvFDcn2iM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bDRO1TK9YtCWGZCDAti9SzvFQvUGsbe1q56WTeZx+8xl/AGj6wQHNUpsCwOBYPMZL8
         1ikYXgBDNOO4HKqpX1izOgAX15xjf4iYv9S59jAxTwSgnux464Oc25FKgozEpBsZp+zL
         ThnTwhEgsflvmetgUU2IP/pGk7E1mNv4dq8jY=
Received: by 10.114.52.8 with SMTP id z8mr8449183waz.140.1282688668272;
        Tue, 24 Aug 2010 15:24:28 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id g4sm955957wae.2.2010.08.24.15.24.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:24:27 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:24:21 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154373>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/send-pack.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 481602d..c2138df 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -457,6 +457,10 @@ int cmd_send_pack(int argc, const char **argv, con=
st char *prefix)
 	}
 	if (!dest)
 		usage(send_pack_usage);
+
+	if (get_narrow_prefix())
+		args.use_thin_pack =3D 0;
+
 	/*
 	 * --all and --mirror are incompatible; neither makes sense
 	 * with any refspecs.
--=20
1.7.1.rc1.69.g24c2f7
