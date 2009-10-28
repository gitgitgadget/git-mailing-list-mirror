From: Vietor Liu <vietor@vxwo.org>
Subject: [PATCH v2] imap-send.c: fix pointer to be const
Date: Wed, 28 Oct 2009 15:26:26 +0800
Message-ID: <1256714786-3723-1-git-send-email-vietor@vxwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:23:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32sS-0001GR-1V
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbZJ1HXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 03:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbZJ1HXS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:23:18 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:57740 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932292AbZJ1HXR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:23:17 -0400
Received: by ywh40 with SMTP id 40so412834ywh.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 00:23:22 -0700 (PDT)
Received: by 10.150.76.36 with SMTP id y36mr1747913yba.44.1256714602557;
        Wed, 28 Oct 2009 00:23:22 -0700 (PDT)
Received: from localhost.localdomain ([123.113.74.202])
        by mx.google.com with ESMTPS id 15sm357708gxk.4.2009.10.28.00.23.20
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 00:23:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131430>

=46ixes some compiler warnings:
imap-send.c: In function =E2=80=98ssl_socket_connect=E2=80=99:
warning: assignment discards qualifiers from pointer target type

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
OpenSSL Changes between 0.9.8k and 1.0:

*) Let the TLSv1_method() etc. functions return a 'const' SSL_METHOD
     pointer and make the SSL_METHOD parameter in SSL_CTX_new,
     SSL_CTX_set_ssl_version and SSL_set_ssl_method 'const'.

Signed-off-by: Vietor Liu <vietor@vxwo.org>
---
 imap-send.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 3847fd1..10dd025 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -273,7 +273,7 @@ static int ssl_socket_connect(struct imap_socket *s=
ock, int use_tls_only, int ve
 	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
 	return -1;
 #else
-	SSL_METHOD *meth;
+	const SSL_METHOD *meth;
 	SSL_CTX *ctx;
 	int ret;
=20
--=20
1.6.5.2
