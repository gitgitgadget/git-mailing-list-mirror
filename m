From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 31/41] reachable.c: use error_errno()
Date: Sun,  8 May 2016 16:47:51 +0700
Message-ID: <1462700881-25108-32-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:53:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLNL-0002XW-FT
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbcEHJvo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:51:44 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34339 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbcEHJvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:51:43 -0400
Received: by mail-pf0-f195.google.com with SMTP id 145so13762627pfz.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sptAnTVgqTWhli92LdRfu18uo8C7gDdNccorqSAaOVE=;
        b=HG+Opk7Ig2HGe2LXVNb0VlCWwGW+kfRKJeV/+Fn7MaWusGaYCB6pz4dGdVIWwfjfTv
         07iUE1hoh0XEpSGgKtuNa3aZ5HFN7BNTui/lbgEhCOqNQEYO4GW+l8w5yNO/2F9kC26V
         tlZGTMZvHUiyW2MNgIM2te7jW3TpeahD/Q6aYRb3UNACDWS2ItBGKEXSJ1sV/vh5GQYF
         mWjDRg0Vx2a+E2WSiJkjp0LcHbW000HEOk943rqz8QfEEu4fOLwIYnfTzn9ENlF77tn5
         WF8s/CLyojpFYYmjwWFJIyP01QV8MVMG84qd4g8mbiOzI/hA8v0TsQONinciyRj4o2Dk
         8/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sptAnTVgqTWhli92LdRfu18uo8C7gDdNccorqSAaOVE=;
        b=JzOSkG/d7RFQTZgjqgCRuhpuOXSBfdnknzE7hMJuHGhauBHaTf16oYhY7R9oLLLhbf
         kG+pTMmQvIUW67ZmKcEs9N0g643G2ibxbFZCAIH5HtiwgEdWa1gRuK852+ERTz8+8Fhj
         XHwud+e9pwq55ihIrO3K5B0yh3iNZvu1zcTG+xz78Sn9xCn8rZlj8JU+E5rtVxFS0fhc
         DMBXQGqGTuWf8s3QunGXFmcs9iEY6gcCJmatlR00Kdnuqa0nNx31uPkbqJqZjUX5xxyL
         mHg9iaa2tMVlG52foutWNznMG9EC25RawDLyH3o45C1RtPiQeJW5hOJZSHS53gjHx46R
         6RKA==
X-Gm-Message-State: AOPr4FV5C/omVbDHFRW2hN4HQIZDB2pkEYU/E0ktOM/fO7pZw/3WRNGl1qJyoYADD0oPPw==
X-Received: by 10.98.41.65 with SMTP id p62mr41483141pfp.29.1462701102690;
        Sun, 08 May 2016 02:51:42 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id q70sm32737727pfj.81.2016.05.08.02.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:51:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:51:42 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293945>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 reachable.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/reachable.c b/reachable.c
index ed35201..d0199ca 100644
--- a/reachable.c
+++ b/reachable.c
@@ -119,8 +119,7 @@ static int add_recent_loose(const unsigned char *sh=
a1,
 		 */
 		if (errno =3D=3D ENOENT)
 			return 0;
-		return error("unable to stat %s: %s",
-			     sha1_to_hex(sha1), strerror(errno));
+		return error_errno("unable to stat %s", sha1_to_hex(sha1));
 	}
=20
 	add_recent_object(sha1, st.st_mtime, data);
--=20
2.8.0.rc0.210.gd302cd2
