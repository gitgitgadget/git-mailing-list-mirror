From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 02/11] grep: break down an "if" stmt in preparation for next changes
Date: Sat,  6 Feb 2016 09:03:01 +0700
Message-ID: <1454724190-14063-3-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 03:03:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRsDr-0003OO-4D
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 03:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbcBFCDf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 21:03:35 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33983 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbcBFCDe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 21:03:34 -0500
Received: by mail-pa0-f51.google.com with SMTP id uo6so43734978pac.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 18:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8rfZxiL84c0NvfSvCfUoQGqym1fsXZ1/Mo6mUuURepg=;
        b=Xd5Qv6thbE3fhaSYgBnQT+AtVLBWMz47/LxSG1ujV9q/0BGb8M+a0UT1QA1Ag5cYID
         QnaAAM3ks6hkpDO+kJZS5PTAc+MqoJhNlrnp8jB3wrivQDT/7UiYqcZTJvg0tKuXWwbI
         7YH/1p9ihJo70jrNOX/TGyrSJDQjE+yu3KObCNRgaCxRlLUROYSMt9pJhSkvVKUCcxaO
         WBMbMrZhi1IqR0xMI/Rz3nHEYH1tNZ7fo6wZ7qcaFeTwWhFPH4F/Yl5NAHxBm7mzma+Y
         mvYHYJUk9cFQ+yx2AaACj80ubh0dy3J4VbmO82fvcKEOFThWHgDlw7s0yg0/YQC4ovtM
         pr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=8rfZxiL84c0NvfSvCfUoQGqym1fsXZ1/Mo6mUuURepg=;
        b=gj66PkI/C4NLvJcN1waR7G956coaapQEjASdwnuc4Q6lvuRqJZjIvrLisASQYACSK6
         WoNq0t772+W3ARXm9/1m9tT9GGalMQY15htC2Sk+7cfgX8+52guZGIDT5/ljw+zsj9a/
         Cpf5Sg+SFCPpojsESM2QhhtGDhLkUqo6xJqqx+A04RmOaabK9ppvmvyk56WAUgyPePaa
         yygM7KUvgnZFnIZkmdM7O5Em5qC8fIosmvBajkWO34LKzVkve37DHIACvfs+tzY3RcGY
         Dpd39TYc63m3LNdNqdekDoQs2g4c5Amqnp1r9cBXEGXgUC6KibMKSgTlkf88ynGmtvaW
         LJKQ==
X-Gm-Message-State: AG10YOSEXZMrhqeM+/YyJ8fobMm3LNAk+fbMoU3q3+d9vzuB+5Q/YKkwzINuRnm8kr26cw==
X-Received: by 10.66.55.106 with SMTP id r10mr10135797pap.133.1454724214052;
        Fri, 05 Feb 2016 18:03:34 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 1sm27268741pfm.10.2016.02.05.18.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 18:03:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 06 Feb 2016 09:03:48 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285667>

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
2.7.0.377.g4cd97dd
