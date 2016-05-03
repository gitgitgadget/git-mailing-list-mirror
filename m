From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 23/41] editor.c: use error_errno()
Date: Tue,  3 May 2016 19:03:56 +0700
Message-ID: <1462277054-5943-24-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:08:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ87-0000hW-R5
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932878AbcECMIg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:08:36 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33084 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932860AbcECMIf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:08:35 -0400
Received: by mail-pf0-f181.google.com with SMTP id 206so9361652pfu.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQQvbPgpDADclqRFs6G0rC4KFjtucsT1ykBQJaYgYmM=;
        b=SUzXuf1CyaGrKi9gRE1llh7JwG9syGS64niTgU0SS4yCFJzNr1EB32p4W333dlKKp6
         b09n/oK1n72CtGv1MI1du5T9jFWU7KiadCsIeEaZvP4m2wQUkIvDaCeBHCOIPPdBVW0o
         48ARdctpTO+odhcH/oItANGtv5VQ9RNTjkImcBvKoRsTJ+BJx08CBT1JUxI0tIMnYfUx
         PfOeVaI0tI4LchJsEicjxwdWD77/MrKj6i+KboUrIjK2j9vNtFzxEDO7J5qJOqhHluXy
         lm9LNl4TGUizz0Eoy4xHPBlqr15w+Z7bGhzDi0P+kuUncKCOfs/C3OpNKOCpuN+ulQGA
         2x5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQQvbPgpDADclqRFs6G0rC4KFjtucsT1ykBQJaYgYmM=;
        b=GZmsnPKemurQDbKyN1IMkULFd9vAN5PfX5k4OV0fmCjgd4G5yG3Wfw0h9gJ8Jhzjp9
         BtJ9S6Q9b3P7eHOVn1uE6000fR6bzsQI5tVdUWPf1mZ0X2SN1ZSkHdwNtXVRWqCsWvzG
         skKSa2uAZ6efagPbajn+1MOSWECOZ+A30IqhjexbjxCJ69Uj4zsPhqoxzYt+3rXshpbG
         jSjkOPMeSmNsHu0zeK5no9TqNEzxdEL/m9uY5p6Lmu2H7s54CZOULeus3anq2RMXqrmK
         mN5/fpHiA4tzU/zNHgc/SKNK3kXZuqBvn4XhM0F+U5rCQpS/k5UyrqzqP4QBHOa7kXjk
         AcLw==
X-Gm-Message-State: AOPr4FWEe+zFOMPPg3XVLWX5wZosH/3nWqPkOIBin5YktoF2wxzcBZwtUR4GabZPfZYj9A==
X-Received: by 10.98.93.5 with SMTP id r5mr2863264pfb.15.1462277314577;
        Tue, 03 May 2016 05:08:34 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id 82sm5496176pfb.64.2016.05.03.05.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:08:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:08:30 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293377>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 editor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/editor.c b/editor.c
index 01c644c..7519ede 100644
--- a/editor.c
+++ b/editor.c
@@ -63,7 +63,6 @@ int launch_editor(const char *path, struct strbuf *bu=
ffer, const char *const *en
 	if (!buffer)
 		return 0;
 	if (strbuf_read_file(buffer, path, 0) < 0)
-		return error("could not read file '%s': %s",
-				path, strerror(errno));
+		return error_errno("could not read file '%s'", path);
 	return 0;
 }
--=20
2.8.0.rc0.210.gd302cd2
