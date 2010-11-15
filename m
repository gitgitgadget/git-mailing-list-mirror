From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] clean: avoid quoting twice
Date: Mon, 15 Nov 2010 17:12:44 +0700
Message-ID: <1289815964-31999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 11:14:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHw4g-0004vw-LQ
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236Ab0KOKOF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 05:14:05 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45498 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655Ab0KOKOE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 05:14:04 -0500
Received: by pzk28 with SMTP id 28so919801pzk.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=8GqhRyMx7u7Ws2cEHZ6j4DHbshJqP+mX/a6sgPkdJfU=;
        b=aZF8q+EmXU+w4UkFWHQS0dlcESfTDhyqIkHyF6SN9htxvD+WA35M5QxhW+FOw0+AXl
         OsiO+DEgPiesbNGW4JmbFqQpwxZrqzpFWA7sh6i/TdG3EFM6tPDLpXWKVPXQ+tIvDkGI
         8zEBTbInCTeaOWwPwuqAIZeP8aKBSuZl9Mt4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=DeZw4Utmb5ORuePdYybatR/Go4n9k9tnoDQiUpCptUKohentqGUSEXw+aWTaLRzP2u
         0FEvMrLGhQhKrFxNJUBTCbCzOSxHx2zYf/zLv/8YrQ9yrQ2uYGGFWJesHfBsbQ3ZYhDg
         IN3Y61xiXyfyTvn3cOmChy6VybmYt5KcfgTu8=
Received: by 10.142.166.4 with SMTP id o4mr5002411wfe.58.1289816043171;
        Mon, 15 Nov 2010 02:14:03 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id y42sm8548456wfd.10.2010.11.15.02.13.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 02:14:01 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Nov 2010 17:12:45 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161475>

qname is the result of quote_path_relative(), which does
quote_c_style_counted() internally. Remove the hard-coded quotes.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index c8798f5..8f602c9 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -153,7 +153,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 					printf("Removing %s\n", qname);
 				if (remove_dir_recursively(&directory,
 							   rm_flags) !=3D 0) {
-					warning("failed to remove '%s'", qname);
+					warning("failed to remove %s", qname);
 					errors++;
 				}
 			} else if (show_only) {
@@ -173,7 +173,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 				printf("Removing %s\n", qname);
 			}
 			if (unlink(ent->name) !=3D 0) {
-				warning("failed to remove '%s'", qname);
+				warning("failed to remove %s", qname);
 				errors++;
 			}
 		}
--=20
1.7.3.2.210.g045198
