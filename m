From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/11] resolve_ref_unsafe(): use skip_prefix() to skip over "ref:"
Date: Wed, 15 Oct 2014 17:06:16 +0200
Message-ID: <1413385583-4872-5-git-send-email-mhagger@alum.mit.edu>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:07:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeQAX-0002gO-U3
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 17:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbaJOPHL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2014 11:07:11 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52145 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751515AbaJOPGj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 11:06:39 -0400
X-AuditID: 12074413-f79bb6d000001e81-66-543e8d7dfb7f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 43.DF.07809.D7D8E345; Wed, 15 Oct 2014 11:06:37 -0400 (EDT)
Received: from michael.fritz.box (p4FC96250.dip0.t-ipconnect.de [79.201.98.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9FF6SNW020034
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 15 Oct 2014 11:06:35 -0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqFvbaxdicGk9p0XXlW4mi4beK8wW
	t1fMZ7bonvKW0eLfhBqLM28aGR3YPP6+/8DksXPWXXaPBZtKPS5eUvZY/MDL4/MmuQC2KG6b
	pMSSsuDM9Dx9uwTujA8Lv7IWTOKo2PX0E3MD4zy2LkZODgkBE4nN144wQ9hiEhfurQeLCwlc
	ZpR49Ne5i5ELyD7OJNGz8jMLSIJNQFdiUU8zE0hCRKCBUeLQq4VsIA6zwCJGifZVV8BGCQuE
	Sjx8upYJxGYRUJXY1LwZbCyvgLPEvavrGSHWyUnsnbwabCqngIvEr5fbGCFWO0ssWDqZBaJe
	UOLkzCdANgfQAnWJ9fOEQMLMAvISzVtnM09gFJiFpGoWQtUsJFULGJlXMcol5pTm6uYmZuYU
	pybrFicn5uWlFuma6+VmluilppRuYoQEvPAOxl0n5Q4xCnAwKvHwbthrGyLEmlhWXJl7iFGS
	g0lJlDepxy5EiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv/ASgHG9KYmVValE+TEqag0VJnFdt
	ibqfkEB6YklqdmpqQWoRTFaGg0NJgtceZKhgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJp
	SUY8KFLji4GxCpLiAdrrCdLOW1yQmAsUhWg9xagoJc77rhsoIQCSyCjNgxsLS2OvGMWBvhTm
	DQNp5wGmQLjuV0CDmYAGTwy1BRlckoiQkgJGede5kO23c2L2zt9dsL1BnzHguuxzO0axCTt1
	C2YFefVr9HvellW+yR7w773vqpeLwzXabe956Ji9UxU2y5G64fqbW1/BkTW3/2X6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

This requires buf to be declared (const char *), which is how it is
used anyway.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 771941b..020ee3f 100644
--- a/refs.c
+++ b/refs.c
@@ -1416,7 +1416,7 @@ const char *resolve_ref_unsafe(const char *refnam=
e, unsigned char *sha1, int rea
 	for (;;) {
 		char path[PATH_MAX];
 		struct stat st;
-		char *buf;
+		const char *buf;
 		int fd;
=20
 		if (--depth < 0) {
@@ -1497,11 +1497,10 @@ const char *resolve_ref_unsafe(const char *refn=
ame, unsigned char *sha1, int rea
 			len--;
 		buffer[len] =3D '\0';
=20
-		if (starts_with(buffer, "ref:")) {
+		if (skip_prefix(buffer, "ref:", &buf)) {
 			/* It is a symbolic ref */
 			if (flag)
 				*flag |=3D REF_ISSYMREF;
-			buf =3D buffer + 4;
 			while (isspace(*buf))
 				buf++;
 			if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
--=20
2.1.1
