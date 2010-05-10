From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v3 2/5] strbuf: Added strbuf_add_uint32().
Date: Mon, 10 May 2010 11:51:47 +0200
Message-ID: <127d7018774ac06757bcffb2c691b4ab7b866021.1273482409.git.grubba@grubba.org>
References: <cover.1273482409.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 10 11:52:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBPf7-000389-RU
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 11:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244Ab0EJJwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 05:52:16 -0400
Received: from mail.roxen.com ([212.247.29.220]:41470 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756149Ab0EJJwN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 05:52:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id D1F6D628103
	for <git@vger.kernel.org>; Mon, 10 May 2010 11:52:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ioy2MvOZSDP for <git@vger.kernel.org>;
	Mon, 10 May 2010 11:52:11 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id BFE536280F5
	for <git@vger.kernel.org>; Mon, 10 May 2010 11:52:11 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o4A9psiD016655;
	Mon, 10 May 2010 11:51:54 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o4A9psq6016654;
	Mon, 10 May 2010 11:51:54 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
In-Reply-To: <cover.1273482409.git.grubba@grubba.org>
In-Reply-To: <cover.1273482409.git.grubba@grubba.org>
References: <cover.1273482409.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146786>

Added convenience function for adding an unsigned 32bit
integer in network byte-order to a strbuf.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
New trivial function.

 strbuf.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index fac2dbc..52cd71e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -107,6 +107,10 @@ static inline void strbuf_addbuf(struct strbuf *sb=
, const struct strbuf *sb2) {
 	strbuf_grow(sb, sb2->len);
 	strbuf_add(sb, sb2->buf, sb2->len);
 }
+static inline void strbuf_add_uint32(struct strbuf *sb, uint32_t val) =
{
+	val =3D htonl(val);
+	strbuf_add(sb, &val, sizeof(val));
+}
 extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
=20
 typedef size_t (*expand_fn_t) (struct strbuf *sb, const char *placehol=
der, void *context);
--=20
1.7.0.4.369.g81e89
