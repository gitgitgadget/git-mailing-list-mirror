From: "=?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: [PATCH] Avoid recalculating filename string pointer.
Date: Wed, 21 Nov 2007 22:59:41 -0200
Message-ID: <b8bf37780711211659i65a99493te3e3d5cee008ae7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_25924_2932386.1195693181377"
Cc: "Git Mailing List" <git@vger.kernel.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 22 02:00:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv0QD-0001r2-JI
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 02:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbXKVA7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 19:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbXKVA7o
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 19:59:44 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:11698 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbXKVA7n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 19:59:43 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1587933wra
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 16:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        bh=c+Gbiiec6tX8LM/XP/Qplnhn3n4Num4iiNHjtzJAQEA=;
        b=POgwn9+0tdA2ekXykAAZG9KX9nGiK9oYTHN4G20Xylmet6UrG/lW1pkxBoDxypOzha+lFfjI/MYyOq8fBvDkfyVrTHzeuutDxCkOl920bzhDOAnrbYmkCg47EBGy/sS1rman/sy8F9iVkenb+XBtngrqYNX+X7j1m40x+fYTXes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Vxt207X6zDRY0z9ayd8bg4MBrmfQSwmERxTY0kZAYAwM+CFJuZcHOE1lqQUQfDiRA1YCo+59TD+nOT0i/2Uy9Affz2YKZtFgxIipk6VqTiixfhdqBjrbuvGXrykAIZVgX/uAtRJDm0NprRFC0liqA+dyVA4EmEJ9gjgdcTS1yy8=
Received: by 10.78.150.7 with SMTP id x7mr9089245hud.1195693181424;
        Wed, 21 Nov 2007 16:59:41 -0800 (PST)
Received: by 10.78.120.18 with HTTP; Wed, 21 Nov 2007 16:59:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65725>

------=_Part_25924_2932386.1195693181377
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, all!

    Please cc: me as I'm not subscribed. I'm sending the patch inline
only for review, probably it is mangled.
    Please use the attached patch if you agree with it. Sorry about
sending it attached.

>From b6b05d9f8d8e053df4e971cd229e03b778c4d163 Mon Sep 17 00:00:00 2001
From: Andre Goddard Rosa <andre.goddard@gmail.com>
Date: Tue, 27 Nov 2007 10:17:54 -0200
Subject: [PATCH] Avoid recalculating filename string pointer.

Signed-off-by: Andre Goddard Rosa <andre.goddard@gmail.com>
---
 fast-import.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 98c2bd5..2d262eb 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2304,11 +2304,13 @@ int main(int argc, const char **argv)
 		else if (!prefixcmp(a, "--export-marks="))
 			mark_file = a + 15;
 		else if (!prefixcmp(a, "--export-pack-edges=")) {
+			char *filename = a + 20;
+
 			if (pack_edges)
 				fclose(pack_edges);
-			pack_edges = fopen(a + 20, "a");
+			pack_edges = fopen(filename, "a");
 			if (!pack_edges)
-				die("Cannot open %s: %s", a + 20, strerror(errno));
+				die("Cannot open %s: %s", filename, strerror(errno));
 		} else if (!strcmp(a, "--force"))
 			force_update = 1;
 		else if (!strcmp(a, "--quiet"))
-- 
1.5.3.6.861.gd794-dirty

------=_Part_25924_2932386.1195693181377
Content-Type: text/x-patch;
 name=0003-Avoid-recalculating-filename-string-pointer.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f9akp7470
Content-Disposition: attachment;
 filename=0003-Avoid-recalculating-filename-string-pointer.patch

RnJvbSBiNmIwNWQ5ZjhkOGUwNTNkZjRlOTcxY2QyMjllMDNiNzc4YzRkMTYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZSBHb2RkYXJkIFJvc2EgPGFuZHJlLmdvZGRhcmRAZ21h
aWwuY29tPgpEYXRlOiBUdWUsIDI3IE5vdiAyMDA3IDEwOjE3OjU0IC0wMjAwClN1YmplY3Q6IFtQ
QVRDSF0gQXZvaWQgcmVjYWxjdWxhdGluZyBmaWxlbmFtZSBzdHJpbmcgcG9pbnRlci4KClNpZ25l
ZC1vZmYtYnk6IEFuZHJlIEdvZGRhcmQgUm9zYSA8YW5kcmUuZ29kZGFyZEBnbWFpbC5jb20+Ci0t
LQogZmFzdC1pbXBvcnQuYyB8ICAgIDYgKysrKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mYXN0LWltcG9ydC5jIGIvZmFz
dC1pbXBvcnQuYwppbmRleCA5OGMyYmQ1Li4yZDI2MmViIDEwMDY0NAotLS0gYS9mYXN0LWltcG9y
dC5jCisrKyBiL2Zhc3QtaW1wb3J0LmMKQEAgLTIzMDQsMTEgKzIzMDQsMTMgQEAgaW50IG1haW4o
aW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2KQogCQllbHNlIGlmICghcHJlZml4Y21wKGEsICIt
LWV4cG9ydC1tYXJrcz0iKSkKIAkJCW1hcmtfZmlsZSA9IGEgKyAxNTsKIAkJZWxzZSBpZiAoIXBy
ZWZpeGNtcChhLCAiLS1leHBvcnQtcGFjay1lZGdlcz0iKSkgeworCQkJY2hhciAqZmlsZW5hbWUg
PSBhICsgMjA7CisKIAkJCWlmIChwYWNrX2VkZ2VzKQogCQkJCWZjbG9zZShwYWNrX2VkZ2VzKTsK
LQkJCXBhY2tfZWRnZXMgPSBmb3BlbihhICsgMjAsICJhIik7CisJCQlwYWNrX2VkZ2VzID0gZm9w
ZW4oZmlsZW5hbWUsICJhIik7CiAJCQlpZiAoIXBhY2tfZWRnZXMpCi0JCQkJZGllKCJDYW5ub3Qg
b3BlbiAlczogJXMiLCBhICsgMjAsIHN0cmVycm9yKGVycm5vKSk7CisJCQkJZGllKCJDYW5ub3Qg
b3BlbiAlczogJXMiLCBmaWxlbmFtZSwgc3RyZXJyb3IoZXJybm8pKTsKIAkJfSBlbHNlIGlmICgh
c3RyY21wKGEsICItLWZvcmNlIikpCiAJCQlmb3JjZV91cGRhdGUgPSAxOwogCQllbHNlIGlmICgh
c3RyY21wKGEsICItLXF1aWV0IikpCi0tIAoxLjUuMy42Ljg2MS5nZDc5NC1kaXJ0eQoK
------=_Part_25924_2932386.1195693181377--
