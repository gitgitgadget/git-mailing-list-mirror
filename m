From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 20/26] worktree: avoid 0{40}, too many zeroes, hard to read
Date: Tue, 16 Feb 2016 20:29:21 +0700
Message-ID: <1455629367-26193-21-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:31:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfir-0003mH-Et
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbcBPNbP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:31:15 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36172 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932405AbcBPNbN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:31:13 -0500
Received: by mail-pf0-f177.google.com with SMTP id e127so105514074pfe.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1ncwCWxHgh4bGONFw5FLoRaX6f/rlzZFYJq6t5kbI9I=;
        b=JPZb56JGrV80dJYz2JBnqG1aPfoEuKVqqTp872xn+vfMAvTqy2ZUb+Uaxcv6bzNh59
         Rj6ZFIcVhsCm4VN4lQlL8MliMexFTbg8ZnfaE1qVT0TYfhHnm+5yuy3bPXxsdCFjtCGU
         pn1fz49fw6DYBMWYQQhKoADZA6fsqazodmnzLT+AbMe/KVhoYKyzIq/2bcNj+FltGQ+I
         nf5UdQrfZghr8NDtyVZWtdmqHpYmJ2VTFam5aC47gTW+qskZAcb1wxpm8u7R9zjR/gOs
         T/jD0szLD5+l3Bn1QbX7WnOIvHDu9oj8npvG9ttf9aKYg+t0QXuUaBthxoW7BWpw8SPO
         7LIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=1ncwCWxHgh4bGONFw5FLoRaX6f/rlzZFYJq6t5kbI9I=;
        b=See8cOYLAWeZwK/sKXYRq0tWuyrPD5JDT5jOw1zgTNIF/R3MKZleiDFFCCYZDl/VgM
         C68j82wT5ArHZ0ooNAfyTF7nlyHSKSsiVR5TkKHEad+HIy9M91TiWvwRWG0TctQZQsb4
         h2J4yznGEVmyQjYiuB1nmLosWPhxybQ+4oNdyXIRjV4DPRD72pD3xqR5Aw0y1QN9hZNR
         nLdKbGu5hDnQ+YkXgvBtJvrBHAtrZ8pU52Nx3Y6i86fIqaIln9s/5iRk8oj/jFGXswC5
         +Ue4krfqP117BnugAXCv05sVx6teXZdshME/fyC1CzZ4nIEX87rCF+Mwf+Igf11/XcJC
         yb5A==
X-Gm-Message-State: AG10YOQeU4rosEvoYh0dH4a93FYsBSF77NylRdMsSkCayVdXsVDUGntKeYWqmLzCo1T9SQ==
X-Received: by 10.98.73.205 with SMTP id r74mr31170340pfi.118.1455629473032;
        Tue, 16 Feb 2016 05:31:13 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id z3sm46043957par.17.2016.02.16.05.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:31:11 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:31:36 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286387>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index cfc848d..97666cc 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -263,7 +263,7 @@ static int add_worktree(const char *path, const cha=
r *refname,
 	 */
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, "0000000000000000000000000000000000000000");
+	write_file(sb.buf, sha1_to_hex(null_sha1));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
--=20
2.7.0.377.g4cd97dd
