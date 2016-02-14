From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 01/12] grep: allow -F -i combination
Date: Sun, 14 Feb 2016 18:49:45 +0700
Message-ID: <1455450596-11904-2-git-send-email-pclouds@gmail.com>
References: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
 <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 12:51:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvDJ-0001H9-K1
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 12:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbcBNLvh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 06:51:37 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34935 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbcBNLvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 06:51:09 -0500
Received: by mail-pf0-f196.google.com with SMTP id w128so5650853pfb.2
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 03:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ghOs16SUsabMZPrpw3eMN6cQOXDWKv0zIck7rxVdlog=;
        b=m9eBWcnUKz7fdS+YBo8CnrTSIuF5la1qQWdvYPuGqXNi3ah/e+eVwCwEe9rqyMgknS
         fj8WIwI6+h/FuxsNCwZf+Q6lal4I0Cb9jPrpCgdQPovWEO1Jr8+pNoKTKkkOltLXCdta
         kiMIsTsbIHLPp1AiFSTylCIHiW5Z0ed4m/RfQ0Icno1vR2Q/ff5NpL3U/0TQkyg7oUh7
         Ou+QgrEy8ZE0pWc7tYaAlGxdcVV93j4+A77xPoOCreVcmT8LTCwvem/1iR/Y2v9rBmy1
         KwA0EurL3i7hsebil6UWrP+P1pTgFTbSZiCzFBCI1AgTrpUwKo9Xr+0SQpI0Vs1zbv3d
         aMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ghOs16SUsabMZPrpw3eMN6cQOXDWKv0zIck7rxVdlog=;
        b=fMvPgrV9hcgEq3eiAd21DZuvR2YZCHHtCbJmqqkGiMV599ZAjvQUAeIqaxGYpiTC0K
         PS1y33eRhIBgn9reZZj+hged+HcrA0CzaYRVVXwr8lhA8HkBpGMZTu4k4cULXeIuqm7C
         46+tVoo2K85PVpD93VAR7T4JtgB7V+9DaHfOblbQ5+BIvBkCy50G4Qs3FDTF38zH2XgO
         3iG8dqiOIFlvkZdVe8sQVW/Rn/JEkFoAhpDSGf73pvEUsyma1i13U36XxZwTuavZOmEw
         USzUSBkqJsjehWHcp3tYoZOFR8Lwb8kyutBc5LO8+g0LK9C//FvnI9sbSM76i7cX1mac
         CNlA==
X-Gm-Message-State: AG10YORZ0nRASK18vcbeXpmfdlEd4SrAMw5youc+Wm5N/SyS/DVbeZCYNS+mGAHqZLEu+w==
X-Received: by 10.98.68.220 with SMTP id m89mr15545330pfi.65.1455450669532;
        Sun, 14 Feb 2016 03:51:09 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id h89sm31291650pfj.52.2016.02.14.03.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2016 03:51:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Feb 2016 18:51:30 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286135>

-F means "no regex", not "case sensitive" so it should not override -i

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8c516a9..46c5ba1 100644
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
