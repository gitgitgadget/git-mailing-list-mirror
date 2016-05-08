From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 19/41] connected.c: use error_errno()
Date: Sun,  8 May 2016 16:47:39 +0700
Message-ID: <1462700881-25108-20-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:52:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLME-0001GE-Dl
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbcEHJu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:50:29 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35584 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbcEHJu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:50:27 -0400
Received: by mail-pa0-f68.google.com with SMTP id zy2so16126477pac.2
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cy8w2To31+I1tcXrcelmFf06S0W6OU/b4PxmzLEBa8w=;
        b=WZbKloo9kBHrQO6rmMcEH9a0W33wbM5bugAKbgz5tyC130TCFzxR41jsdypwD7E1Xp
         V8Ech6makdaItEVdokQm4rz8L9Ftym83VS4CFhfz3r8r1HQqf8F5iITIHLacgdx+4f21
         gfWF6QhH5/n4XC4D9eRyavqxyb8crSxqIYzPN91h6mMegTZbN2ODPKoXKxb/QR1nKtiX
         I/LM1rLMOboziUFgPr9myisuHboFJtTV+Myb3Eg77XmKinxgtLYUCB/QMDaKil4Ki9AR
         NWTZ2NT80Dget/Z3JQgYyrDedReTJtyT4WkAnPgIn8zqZVe1S0BO8RYate0tGn8exhpB
         Ztug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cy8w2To31+I1tcXrcelmFf06S0W6OU/b4PxmzLEBa8w=;
        b=br66QDT2ARUqzOBJDY3hULE4B+RI27pbHAY72H+Yb2PV34W8/RmTirtLvx9IoNCrdz
         aRF7oBQfpLVeRmqUng9OcdaChp9751XcQGSbfroyYeVmFPB0LbGV6ZJDlUBiOgsKkuaZ
         s2ysbpLMeoWiwdtSaNSALoT1Y3w34w3dBzQrb3g2SWqK2FvKLxpbWy0z9F8wo3TczviV
         nvYeFGtQZnpSZgY9IgqdXuGsTWmxCzCxbJlPwE28kLCuPA30oomImB8PmaGYozhUsunH
         Ip5+7w8Zg8CDc18JORglznSfiXyyDtClk6ALjGnLD9H+7F/rJkBD61MvdnsvBiliRDFF
         iMAQ==
X-Gm-Message-State: AOPr4FUEBEbyYvou35MhJUbGalygc/7khTkjGK2NXvVSM3Paf1kQ8VDST1G3C9xG9kYUag==
X-Received: by 10.66.231.98 with SMTP id tf2mr42074907pac.56.1462701026781;
        Sun, 08 May 2016 02:50:26 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id h6sm32852534paf.23.2016.05.08.02.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:50:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:50:26 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293939>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 connected.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/connected.c b/connected.c
index 299c560..bf1b12e 100644
--- a/connected.c
+++ b/connected.c
@@ -86,17 +86,14 @@ static int check_everything_connected_real(sha1_ite=
rate_fn fn,
 		memcpy(commit, sha1_to_hex(sha1), 40);
 		if (write_in_full(rev_list.in, commit, 41) < 0) {
 			if (errno !=3D EPIPE && errno !=3D EINVAL)
-				error(_("failed write to rev-list: %s"),
-				      strerror(errno));
+				error_errno(_("failed write to rev-list"));
 			err =3D -1;
 			break;
 		}
 	} while (!fn(cb_data, sha1));
=20
-	if (close(rev_list.in)) {
-		error(_("failed to close rev-list's stdin: %s"), strerror(errno));
-		err =3D -1;
-	}
+	if (close(rev_list.in))
+		err =3D error_errno(_("failed to close rev-list's stdin"));
=20
 	sigchain_pop(SIGPIPE);
 	return finish_command(&rev_list) || err;
--=20
2.8.0.rc0.210.gd302cd2
