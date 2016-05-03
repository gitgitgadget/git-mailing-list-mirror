From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 37/41] transport-helper.c: use error_errno()
Date: Tue,  3 May 2016 19:04:10 +0700
Message-ID: <1462277054-5943-38-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:10:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ9c-0001Qq-Ba
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933200AbcECMKF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:10:05 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34152 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930AbcECMKD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:10:03 -0400
Received: by mail-pf0-f175.google.com with SMTP id y69so9214872pfb.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVMDjXB7MwRk56ezfUFvtUWFXZYtncTgl5sm5H4rVkU=;
        b=ZO0iJe32Gwg8U5ITU/3e+lLHPo3qbiXoZ55Fpl6oaP9Pj+zfoQYMWF3l72oaxD7RVd
         YBzTHo3B3TK4BFu/rMuSfzJ1QmWRYGjqCqpJi/7n67ZciilUZbsULELIFTdXCpkZMnsa
         H/YdBuKlQAi0hR2sXEhSs6iqXy97a8n5ZXeviAhFacaBwCSGn3NMiq2E72Vcx5tTVysN
         z7ZCKrEaNzPVAZgMYPO5sgB6ioyewIrD8GhJff/40KoOOvlEk4ixbUDc8kJQmysOftkK
         f6vSbW3RmGaAoUFaoMp0EoH67TUbwMXF0MIUsqRj8aydaUrGXazjsoojMYeLlFaRJRh7
         xQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVMDjXB7MwRk56ezfUFvtUWFXZYtncTgl5sm5H4rVkU=;
        b=XfSKGvHZR19W6i+QGIs+syXclaxx8p/a6bdbCqjm0W8bSArpvWfeJIe22/EcJfxsXc
         3SFF3mPYnM0WVvCcIEbWLLHjVRVipoJssqJjJjnEZdRbW+NjvXaalaZDZx2+Hgi0kSiW
         MYZzSzyE5q8nBTXiN8t+HtbrmrazGIFJgxw4nNAUoiXXq6wUUh2q351gTcuyvYVbv6AU
         Kv5Zva3fQrImAkHbObKsD+fpJgAKgDbVYjEAlt6swbzF6CcWaO2iZWInhtosf/posLBm
         J7ZxptwpnsvV64XH8kp5soUTq95xenzoJhAOmDzWaN2YVq4gBbsq9pAeah6vZCUzsDTj
         Fp8A==
X-Gm-Message-State: AOPr4FXDHtanqwV40HT7/i/ze3TFP9cArxLm28N8APIArnAS/6AnlGByVvwu1EZs70V7Ug==
X-Received: by 10.98.69.1 with SMTP id s1mr2971102pfa.56.1462277402534;
        Tue, 03 May 2016 05:10:02 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id n6sm5551445pfa.2.2016.05.03.05.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:10:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:09:58 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293391>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 transport-helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index b934183..f09fadc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1166,7 +1166,7 @@ static int udt_do_read(struct unidirectional_tran=
sfer *t)
 	bytes =3D read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
 	if (bytes < 0 && errno !=3D EWOULDBLOCK && errno !=3D EAGAIN &&
 		errno !=3D EINTR) {
-		error("read(%s) failed: %s", t->src_name, strerror(errno));
+		error_errno("read(%s) failed", t->src_name);
 		return -1;
 	} else if (bytes =3D=3D 0) {
 		transfer_debug("%s EOF (with %i bytes in buffer)",
@@ -1193,7 +1193,7 @@ static int udt_do_write(struct unidirectional_tra=
nsfer *t)
 	transfer_debug("%s is writable", t->dest_name);
 	bytes =3D xwrite(t->dest, t->buf, t->bufuse);
 	if (bytes < 0 && errno !=3D EWOULDBLOCK) {
-		error("write(%s) failed: %s", t->dest_name, strerror(errno));
+		error_errno("write(%s) failed", t->dest_name);
 		return -1;
 	} else if (bytes > 0) {
 		t->bufuse -=3D bytes;
@@ -1306,7 +1306,7 @@ static int tloop_join(pid_t pid, const char *name=
)
 {
 	int tret;
 	if (waitpid(pid, &tret, 0) < 0) {
-		error("%s process failed to wait: %s", name, strerror(errno));
+		error_errno("%s process failed to wait", name);
 		return 1;
 	}
 	if (!WIFEXITED(tret) || WEXITSTATUS(tret)) {
--=20
2.8.0.rc0.210.gd302cd2
