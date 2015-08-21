From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 02/10] grep: break down an "if" stmt in preparation for next changes
Date: Fri, 21 Aug 2015 19:47:12 +0700
Message-ID: <1440161240-28554-3-git-send-email-pclouds@gmail.com>
References: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
 <1440161240-28554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, plamen.totev@abv.bg,
	l.s.r@web.de, Eric Sunshine <sunshine@sunshineco.com>,
	tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 14:58:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSlu3-0003uO-Ur
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 14:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbbHUM6f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 08:58:35 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35378 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbbHUM6e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 08:58:34 -0400
Received: by pacdd16 with SMTP id dd16so44131887pac.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 05:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ge6akOBv2UFVjNAoFaKDt6CTNklIJTNYzhI+rxrrEvk=;
        b=xHIZ/7Vd2BDdzZicPgW7x0ZUS+Cumj7A2RlloDEXgXACqFW0jjYRrFUS1+B0bMLwCX
         92FprJwZsG4CUWqDGQV93INb3gtPQXVpOrAB5ZpMzY4UQjfJ3ul8Tpvhq9FfdQhHBAp3
         mItQgp58C623az5lqPMNpATyw2P0WHsyQjL3dTcdt/ydT2cDAV0DVZKoWdm5BFNLiKCP
         ONiDaQ1Kbw2nRiFSyCttiY/lGzlu+oWRp/D2v7hqUaqC/7TTZL+ClTACJaecRedPKt14
         fqwgTgAdi1nfaPkOVWse/2RrVuyDsk7aTnLghHLLsHNlAZbO0L8LxmQS+bASs4gcq2Fh
         Y8iw==
X-Received: by 10.66.149.102 with SMTP id tz6mr16805872pab.125.1440161914139;
        Fri, 21 Aug 2015 05:58:34 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id j5sm7847035pdi.7.2015.08.21.05.58.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 05:58:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 21 Aug 2015 19:58:25 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440161240-28554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276289>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index b58c7c6..bd32f66 100644
--- a/grep.c
+++ b/grep.c
@@ -403,9 +403,11 @@ static void compile_regexp(struct grep_pat *p, str=
uct grep_opt *opt)
 	p->word_regexp =3D opt->word_regexp;
 	p->ignore_case =3D opt->ignore_case;
=20
-	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
+	if (is_fixed(p->pattern, p->patternlen))
 		p->fixed =3D 1;
-	else
+	else if (opt->fixed) {
+		p->fixed =3D 1;
+	} else
 		p->fixed =3D 0;
=20
 	if (p->fixed) {
--=20
2.3.0.rc1.137.g477eb31
