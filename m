From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 1/4] apply: Clarify the description of -z
Date: Sun, 22 Nov 2009 17:19:26 +0100
Message-ID: <4B09648E.5060203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 17:19:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCF9z-0001aZ-5g
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 17:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbZKVQTY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 11:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755279AbZKVQTX
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 11:19:23 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:57667 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571AbZKVQTX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 11:19:23 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so1079490ewy.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 08:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=+WSv7LC5BlXd98Npx8Bv7OHval5Oys4zFX6lxnL8ICk=;
        b=Ksc/EIkCZibSxt5Yl83VcNavh2nl4hNTKoXK6feIH2YdNWsk3qAZfx9Npep/CnYEqw
         aKSBCkyj02JO3Yj28RmNm7jHNjinGx3M9gysBgcki9GCyHUCDSKTYFTdJQKoMoUHt5BJ
         VCr5qpTam/ygYCXSblXEN1qqHpYWGso36OTLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=uiJQQlGml9t5Lpsy3FRDCn4rsswCSU9MQmtve0SWAvZqIoHLffev9HtnSY1W4nlFlF
         Qe1feLbV5e+aOCINasE84k2deTdFdFp2ojJ1nCT/PBbYOYfRsj9YGwaLgpQyCGpXJnKm
         JQ/nLo49fkB4OhlaAhnnPTtFqEyZjnCITB/hU=
Received: by 10.213.23.78 with SMTP id q14mr2547483ebb.80.1258906768726;
        Sun, 22 Nov 2009 08:19:28 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 28sm831571eyg.44.2009.11.22.08.19.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 08:19:27 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133439>

The description of -z says that a machine-readable format will be
used "when showing the index information". From that description,
it is not at all clear which other option it will modify the
behaviour of. Explicitly state that -z modifies the behavior
of --numstat.

Also correct the description of the "munging" that takes places
in the absence of -z, namely that apart from the characters
mentioned, double quotes are also escaped and that the pathname
will be enclosed in double quotes if any characters are escaped.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/git-apply.txt |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 5ee8c91..4f791ee 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -87,11 +87,13 @@ the information is read from the current index inst=
ead.
 	rejected hunks in corresponding *.rej files.
=20
 -z::
-	When showing the index information, do not munge paths,
-	but use NUL terminated machine readable format.  Without
-	this flag, the pathnames output will have TAB, LF, and
-	backslash characters replaced with `\t`, `\n`, and `\\`,
-	respectively.
+	When `--numstat` has been given, do not munge pathnames,
+	but use a NUL-terminated machine-readable format.
++
+Without this flag, each pathname output will have TAB, LF, double quot=
es,
+and backslash characters replaced with `\t`, `\n`, `\"`, and `\\`,
+respectively, and the pathname will be enclosed in double quotes if
+any of those replacements occurred.
=20
 -p<n>::
 	Remove <n> leading slashes from traditional diff paths. The
--=20
1.6.5.3.298.g39add
