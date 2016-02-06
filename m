From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 01/11] grep: allow -F -i combination
Date: Sat,  6 Feb 2016 09:03:00 +0700
Message-ID: <1454724190-14063-2-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Feb 06 03:03:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRsDn-0003LJ-4S
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 03:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbcBFCDa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 21:03:30 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36573 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbcBFCD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 21:03:28 -0500
Received: by mail-pa0-f50.google.com with SMTP id yy13so42936427pab.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 18:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gTYjVmRl+Vp4BWePhbdAXthDONldW8HL+hqiQZN8544=;
        b=VnqDxOebQ+huI6zI/PXUn5nDcspjPFwhtdnZCQEOkKZ49WR2SZfkfFkJtz8DCcljP6
         Hb5WcnKlnuiyLpjbrC7s3BSvN0cteJ382DqZzwE8hWfyWz59nfNYRIdQJ19TsB/4I5wX
         wVVJet0sxamhDNCArHhEfdqAY6vlhFPvGKyg7VZFpRNkZuz2tXV/pf1cMym2WKYE67T3
         TRTOAVrQECyXuM6KU1RzlqQ0h7XxvAiaXAw02vX8nXY54yMFn+mvu+kob6UumR1sXtuh
         Eo8rK3aHf5wjK0+wl2rWQ1WqLu+cWQo5T77zGu//VjFMIXSlo1mHtAH6vGQX5N1Z+DCk
         21dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=gTYjVmRl+Vp4BWePhbdAXthDONldW8HL+hqiQZN8544=;
        b=hW+1gkNDdSLb4d0dfxDczNsRoc3r9jcxneN9bWJYSsBVYcxe/tI/cMFUm1IP2dRMqP
         Q62epMM1srpIiAURaMQkxWAthkfG9Q66j8Y4Y99ReTXrHRpkFfq5w1ygrPdYaAVoFvH3
         nvLJBZDNJe5QlXUHUDZhJtadjKpoo2rgOcFEeqkDc8W4wCIApxkXWkxbTRcIng0S//t8
         SpAkjZ5kdjRuzbRQWF3tWYc7d+T/T1D9Wcri73PThS9XE2KdOp4oAOziVC7G/j68ijq3
         sRlN/w6Q2M6/dBlthNgSK1rYgKmdpg5Vh7FzTrZsX47x/l2YiuqPKGodN5M5y+ZvgWJs
         058A==
X-Gm-Message-State: AG10YOR7S1q9o4Wg4ZxIveJswTgmkCFJbioN1qM5txg6FISrM+oYrH7jh/fTM63MpbfwYw==
X-Received: by 10.66.140.14 with SMTP id rc14mr24539754pab.65.1454724207770;
        Fri, 05 Feb 2016 18:03:27 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id n8sm27228365pfj.46.2016.02.05.18.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 18:03:26 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 06 Feb 2016 09:03:41 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285665>

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
2.7.0.377.g4cd97dd
