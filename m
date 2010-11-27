From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] cache.h: realign and use (1 << x) form for CE_* constants
Date: Sat, 27 Nov 2010 13:22:16 +0700
Message-ID: <1290838936-25601-1-git-send-email-pclouds@gmail.com>
References: <AANLkTinwP=tDYyeyjX8uUChtvOeVmT4QfZjxT0A67hop@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Niedier <jrnieder@gmail.com>, tfransosi@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 27 07:24:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMED0-0001nN-Pn
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 07:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab0K0GXr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 01:23:47 -0500
Received: from mail-pw0-f66.google.com ([209.85.160.66]:40047 "EHLO
	mail-pw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab0K0GXd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 01:23:33 -0500
Received: by pwj5 with SMTP id 5so571888pwj.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 22:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gPcsM7m/Yw4GEk8drTZv2cpz2Ce4aY3xwyX0/Wsd2gA=;
        b=WZUvt90p0LlChhmLECjw6diksG6RmDDqSQS1b8Cib2L4DeZNNaQWxKJOU3fh0L7MsR
         HShGvMNGZEj3jdW0TV7EYuheLLlpobcyR0SHfMdAgPZhetXMpYGUTYL8cCIwOSS30Yiy
         AEb2UcNeHP/TFEI++RxfaC7Szi9iQ6pdqeYGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bp2aDQopsgH7qZJJC4wBuA65t8r1AII+CHaEdLPokw2FjhIfC0CPjf9z1oOjfDLMBC
         GxLJCosvIQGU6+M8bD4jaShvyhG8I6CHWtJ/dkzEy19r8ih5VWVSrnlW9g2zbPAkn0l7
         sepGWoQXWZG5lsvYO8wZVooDIHCgN6/KKD+fg=
Received: by 10.142.237.4 with SMTP id k4mr3257655wfh.171.1290839012745;
        Fri, 26 Nov 2010 22:23:32 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id b11sm3669952wff.21.2010.11.26.22.23.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 22:23:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Nov 2010 13:22:17 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <AANLkTinwP=tDYyeyjX8uUChtvOeVmT4QfZjxT0A67hop@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162299>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2010/11/27 Thiago Farina <tfransosi@gmail.com>:
 > Thanks for fixing this. Maybe these hex can be rewriting as 1 << 0, =
1
 > << 1 and so on?
 >

 It does look better. There a few 0xXXXX constants above, but they
 are short enough.

 cache.h |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index 33decd9..f9545a1 100644
--- a/cache.h
+++ b/cache.h
@@ -170,26 +170,25 @@ struct cache_entry {
  *
  * In-memory only flags
  */
-#define CE_UPDATE    (0x10000)
-#define CE_REMOVE    (0x20000)
-#define CE_UPTODATE  (0x40000)
-#define CE_ADDED     (0x80000)
+#define CE_UPDATE            (1 << 16)
+#define CE_REMOVE            (1 << 17)
+#define CE_UPTODATE          (1 << 18)
+#define CE_ADDED             (1 << 19)
=20
-#define CE_HASHED    (0x100000)
-#define CE_UNHASHED  (0x200000)
-#define CE_CONFLICTED (0x800000)
+#define CE_HASHED            (1 << 20)
+#define CE_UNHASHED          (1 << 21)
+#define CE_WT_REMOVE         (1 << 22) /* remove in work directory */
+#define CE_CONFLICTED        (1 << 23)
=20
-#define CE_WT_REMOVE (0x400000) /* remove in work directory */
-
-#define CE_UNPACKED  (0x1000000)
+#define CE_UNPACKED          (1 << 24)
=20
 /*
  * Extended on-disk flags
  */
-#define CE_INTENT_TO_ADD 0x20000000
-#define CE_SKIP_WORKTREE 0x40000000
+#define CE_INTENT_TO_ADD     (1 << 29)
+#define CE_SKIP_WORKTREE     (1 << 30)
 /* CE_EXTENDED2 is for future extension */
-#define CE_EXTENDED2 0x80000000
+#define CE_EXTENDED2         (1 << 31)
=20
 #define CE_EXTENDED_FLAGS (CE_INTENT_TO_ADD | CE_SKIP_WORKTREE)
=20
--=20
1.7.3.2.316.gda8b3
