From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 02/10] grep: break down an "if" stmt in preparation for next changes
Date: Thu, 28 Jan 2016 18:56:15 +0700
Message-ID: <1453982183-24124-3-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 12:56:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOlBs-0006i6-Cz
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 12:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934390AbcA1L4m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 06:56:42 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33461 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbcA1L4k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 06:56:40 -0500
Received: by mail-pf0-f194.google.com with SMTP id x125so2005948pfb.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 03:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2MOSXFyfZM/0PO+rIO5I5plijO4MEm/V8InByt0UR5E=;
        b=ce1MS1b8Op+Bjz39gEJyAbXNsCMW3gD6D1RDxMSX1aPBoad1Wrva9lH4n3uiryG8G7
         rljevOLTB7s2YBnWYvMyuMI7SYkQ/nPq/Whx5q5GXzAGCUhRXd1jg538W6RLaSCLQCjC
         Eqxxw5z8Lc2iFtAHtE/fY5MBgJf6S0ZpIcI7KhE0hXqFC4KSaxnOtcRx0a0/geyu63Wf
         JN14l1992Kyrv9QAW0A52aXp7cRX4ggvvnADeqm8Q/gIeN3k3wtehpu6L+KbTJ0bMxAY
         DMV339T3FfO48x46d4hmyxf66GCG6W60D9C+bIEtO9nHtaU9Jk/1qYtgkr57eid25v0B
         1+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=2MOSXFyfZM/0PO+rIO5I5plijO4MEm/V8InByt0UR5E=;
        b=TUpCA6KSLxtqxivrog1dFFOM5CBH3p9u6MBDv73PmxvymlPZTBfIBSfzT2DGq/e2LI
         EliUTkPkGvDY8YZWq5CupEf0Jw367RUyTJP1yQF/D1Ua2nmc6Rlh9xftoCxDsZFOs6GA
         2JhDBT2+eaGRTBotRIJtUnRpOUJjTPDz1HHyxjEt22EG/qQpUVnDNxobfMc9B05gbrED
         HRzJ6bPv6U0K3Q8P0hRziU0Ya7sSmk/XLfsjTkaiUrtcTj6qptUbTZUhjex328NQkqpb
         FYgkNcYLGH6n2zKSmikbPwS3j/dXa6kL+ycUPWnIvwFeugbQV+nxdOjXcHQWQkd8uOI9
         OGEA==
X-Gm-Message-State: AG10YOTIIPJH/VrlxsK+IcFGx5jLFUbq1yaN9iYYj5BaPyRJd4g0rrQf8Hy5QkPIljzFMw==
X-Received: by 10.98.10.203 with SMTP id 72mr3838574pfk.87.1453982199913;
        Thu, 28 Jan 2016 03:56:39 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id uk10sm15975812pab.31.2016.01.28.03.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 03:56:38 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 28 Jan 2016 18:56:45 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285008>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 7b2b96a..e739d20 100644
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
2.7.0.288.g1d8ad15
