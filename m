From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] pack-protocol.txt: clarify 'obj-id' in the last ACK after 'done'
Date: Thu,  6 Feb 2014 22:10:36 +0700
Message-ID: <1391699439-22781-4-git-send-email-pclouds@gmail.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 16:11:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBQcF-0005bc-FF
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 16:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbaBFPLn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 10:11:43 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:52118 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbaBFPLm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 10:11:42 -0500
Received: by mail-pa0-f49.google.com with SMTP id hz1so1787593pad.36
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 07:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=i0/tkej/S60zIQtn5ecwSGRIZtzNDcOlK6KaDB/i5nU=;
        b=zoiNS5WdTNHJUedZIQhQRxn5mA0j9SPorkpT/Lb05lJU82j3zJ1KVxVNRv8aPaPAWJ
         jSyJkUX3F9vq8faSnHOSfY4mkuiFUoUxh2Le/qqNFxJO2HU7NVfNdMQ++pdcTRO3C3Ib
         f3h2/uqdWqegzCdDMO++kkNj03zsJ2qhuzU4LYhgVgJl+AVOpSN2AM89zmyTlK+poTX9
         l6Teqkl5XzjDcmNAGxez1DSUCr8DAqsC7Wemn0MafJMqeTitsLNUC8R00FCqpdzGGcpQ
         08P7zpWwYO9+0r5cdWNIqz6LkkbJL0vpy60BTiKPb1x027ZRFLoW6N6gP9bJC91XhJoe
         I9Gg==
X-Received: by 10.68.197.99 with SMTP id it3mr12923322pbc.37.1391699501862;
        Thu, 06 Feb 2014 07:11:41 -0800 (PST)
Received: from lanh ([115.73.207.183])
        by mx.google.com with ESMTPSA id tu3sm4318287pbc.40.2014.02.06.07.11.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Feb 2014 07:11:41 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 06 Feb 2014 22:11:41 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241698>

It's introduced in 1bd8c8f (git-upload-pack: Support the multi_ack
protocol - 2005-10-28) but probably better documented in the commit
message of 78affc4 (Add multi_ack_detailed capability to
fetch-pack/upload-pack - 2009-10-30)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/pack-protocol.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index c73b62f..eb0b8a1 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -338,7 +338,8 @@ during a prior round.  This helps to ensure that at=
 least one common
 ancestor is found before we give up entirely.
=20
 Once the 'done' line is read from the client, the server will either
-send a final 'ACK obj-id' or it will send a 'NAK'. The server only sen=
ds
+send a final 'ACK obj-id' or it will send a 'NAK'. 'obj-id' is the
+last SHA-1 determined to be common. The server only sends
 ACK after 'done' if there is at least one common base and multi_ack or
 multi_ack_detailed is enabled. The server always sends NAK after 'done=
'
 if there is no common base found.
--=20
1.8.5.2.240.g8478abd
