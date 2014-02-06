From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] protocol-capabilities.txt: document no-done
Date: Thu,  6 Feb 2014 22:10:38 +0700
Message-ID: <1391699439-22781-6-git-send-email-pclouds@gmail.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 16:12:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBQcT-0005me-13
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 16:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbaBFPL4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 10:11:56 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33260 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbaBFPL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 10:11:56 -0500
Received: by mail-pa0-f48.google.com with SMTP id kx10so1800053pab.21
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 07:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eTJXilRJT8gArFzCBe7fCuUbn53hLR715NXGkg5LFcI=;
        b=rEMZWEuNcOpkmjvtdaj0X8w8VtkB0PPJLNYX/vU+BcWD2SgqJXbvexNuPBpsN6yIgl
         kT2xQh0gi5J0MTcs6QHXtdFIaVx9rcWninHM1z1re2sBGUdMurk0ASisbEW6Lk7A79vv
         5Bzj0h3hPTEVfj12TbK4vN1VxPNKusUqtA8FsANFLj3jxVIg5fYmKjAmwfGdAhCMa4cU
         iLE2khC0FSj6ciODcSvsaQUB4+IqKav2BK/c6tCFX1O4k1EQbWKr1/YeZlBPSwP1pR9F
         xDOOccQ5w7DOn1P56+rMVaIgpahn5zQME/BZV8rx8+osfUL+yLBgHkS1JPZnI0y29VKj
         7ZIw==
X-Received: by 10.68.75.9 with SMTP id y9mr13068844pbv.61.1391699515649;
        Thu, 06 Feb 2014 07:11:55 -0800 (PST)
Received: from lanh ([115.73.207.183])
        by mx.google.com with ESMTPSA id hb10sm4425944pbd.1.2014.02.06.07.11.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Feb 2014 07:11:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 06 Feb 2014 22:11:55 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241699>

See 3e63b21 (upload-pack: Implement no-done capability - 2011-03-14)
and 761ecf0 (fetch-pack: Implement no-done capability - 2011-03-14)
for more information.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/protocol-capabilities.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
index cb40ebb..cb2f5eb 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -75,6 +75,18 @@ This is an extension of multi_ack that permits clien=
t to better
 understand the server's in-memory state. See pack-protocol.txt,
 section "Packfile Negotiation" for more information.
=20
+no-done
+-------
+This capability should be only used with smart HTTP protocol. If
+multi_ack_detailed and no-done are both present, then the sender is
+free to immediately send a pack following its first "ACK obj-id ready"
+message.
+
+Without no-done in smart HTTP protocol, the server session would end
+and the client has to make another trip to send "done" and the server
+can send the pack. no-done removes the last round and thus slightly
+reduces latency.
+
 thin-pack
 ---------
=20
--=20
1.8.5.2.240.g8478abd
