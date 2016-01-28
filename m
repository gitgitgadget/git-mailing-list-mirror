From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 01/10] grep: allow -F -i combination
Date: Thu, 28 Jan 2016 18:56:14 +0700
Message-ID: <1453982183-24124-2-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 12:56:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOlBn-0006dg-Op
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 12:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934377AbcA1L4g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 06:56:36 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36466 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbcA1L4f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 06:56:35 -0500
Received: by mail-pa0-f65.google.com with SMTP id a20so1893733pag.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 03:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=M14cvHAjZBNubMEwoBxyG4gN0P8t2YNRn+d6bj7qYnM=;
        b=O4TN1RVzj3br/jYpE1a4PZF6DOlsWDoTaVz//BBZC+3Kkpu3zBQIEhHJ7Y/D0aYYza
         NQ6EWHC3fPMahgeVJFi2KBxMJwYs/r7yIVjPMfzamNu4mqZnmgz62P6tDyv/GORmOA7W
         XRYeffAzX7EvdILz7DfgwhtzfUtHuLoov4Q+8Dm2RJoH9LMG9m5nIuTzBHY8X+DabzvK
         2QOyjyNVjYRaUzcsBcodk3yleQ+vMkg7SS1NcLe0H7rKESHzQclIUuv+FjBK7vvWSKj1
         PFyt1c0BOY0bZabRajsZpxC4hG6rKgioR8mQGkHtox+EQ/vhJ0AuEaoCPxMp1SrL8ZSs
         i9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=M14cvHAjZBNubMEwoBxyG4gN0P8t2YNRn+d6bj7qYnM=;
        b=W3wqfvitg25PrKAuelbp7yRE/NME8ym1VhigcnQMQM/eMdQLlmXlNDrRys/sMmq3q0
         OhVSZXCojbFsuKO5Kh5h4OEkCrAv9ShUVKDdcmObbcYYBS0YtW43YK26EiW/wzeSi0FI
         FYGZ5es47pWqXM6GPVGxE/AlPw+cFRm8FRBtLXshfslg0SseBbmYsj4ZRkCyPS3ht7Eg
         lmOuTIp2xCVyKQSgYAhtdiq5/zp4NEXca0VUXh3HIFA1L8OvdTNIWRoBNtnvXl6BB18c
         kyZjVYJ4Sno+n2YG9k+Gs2YqHam0mjX3cNSiGsYzmKEzg9YylbzkbOSGaCwX9JDbS201
         /8Ng==
X-Gm-Message-State: AG10YOSvoEsKBrw80cJLfJJvtlIXT1Xu+XUddu+N6zBAk1vK3FnElcm0dBXpaAVLZTS9Zg==
X-Received: by 10.66.216.69 with SMTP id oo5mr3769927pac.126.1453982194473;
        Thu, 28 Jan 2016 03:56:34 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id ze5sm15975377pac.32.2016.01.28.03.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 03:56:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 28 Jan 2016 18:56:39 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285006>

-F means "no regex", not "case sensitive" so it should not override -i

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5526fd7..4be0df5 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -809,7 +809,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
=20
 	if (!opt.pattern_list)
 		die(_("no pattern given."));
-	if (!opt.fixed && opt.ignore_case)
+	if (opt.ignore_case)
 		opt.regflags |=3D REG_ICASE;
=20
 	compile_grep_patterns(&opt);
--=20
2.7.0.288.g1d8ad15
