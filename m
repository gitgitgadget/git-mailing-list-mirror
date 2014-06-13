From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 29/32] read-tree: note about dropping split-index mode or index version
Date: Fri, 13 Jun 2014 19:19:48 +0700
Message-ID: <1402661991-14977-30-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:23:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQVT-0004t1-Qe
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbaFMMWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:22:51 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:48078 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbaFMMWu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:22:50 -0400
Received: by mail-pb0-f53.google.com with SMTP id uo5so1825253pbc.12
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qMs6bjD38GdvvSeJQKmcXBJaVAYerCjFg7hileiuaOI=;
        b=uRiqhSGbn75G6AQbNMlAcNcWwwINw/8GjWRwngX1Kiv57RuGG/Y4E6ceYdMFtzTKXw
         5wEyGKCcuNVNWkU9R9sqlqBsW39aNtTFcpOuAsxtejR2i41e9V3Qq/q6vL/4c74HJ9Zw
         ojgirqbByvyPwDGXOw8NtJS/9+H0PScm84rSih0Uqn5jVpeB/dSvPNl6ROa1cfxMFjdu
         4XnQNmaIh4CGJqMnNYHg9skOD1fmxfpObrjNO9E7i3B+g2EAgoIPMO4mzIb8jKJDQRPM
         eRVZXcHUqvn4mLGDXtD2m4spSniNmlA9xlgqeR4ca2YK/sGVR2cNv+0flDicJoZmrcHY
         mMDQ==
X-Received: by 10.66.248.65 with SMTP id yk1mr3008301pac.38.1402662170628;
        Fri, 13 Jun 2014 05:22:50 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id bz4sm3415228pbb.12.2014.06.13.05.22.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:22:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:22:50 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251586>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/read-tree.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 3204c62..e7e1c33 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -155,6 +155,15 @@ int cmd_read_tree(int argc, const char **argv, con=
st char *unused_prefix)
 	if (1 < opts.merge + opts.reset + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
=20
+	/*
+	 * NEEDSWORK
+	 *
+	 * The old index should be read anyway even if we're going to
+	 * destroy all index entries because we still need to preserve
+	 * certain information such as index version or split-index
+	 * mode.
+	 */
+
 	if (opts.reset || opts.merge || opts.prefix) {
 		if (read_cache_unmerged() && (opts.prefix || opts.merge))
 			die("You need to resolve your current index first");
--=20
1.9.1.346.ga2b5940
