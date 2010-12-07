From: Anders Kaseorg <andersk@ksplice.com>
Subject: [PATCH 1/2] describe: Use for_each_rawref
Date: Tue, 7 Dec 2010 13:22:00 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1012071320240.23348@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu> <20101203084348.GD18202@burratino> <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu> <20101206073214.GA3745@burratino> <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <20101207095818.GB1867@neumann>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Dec 07 19:22:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ2B2-0004JO-6l
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab0LGSWG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 13:22:06 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52271 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab0LGSWE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 13:22:04 -0500
Received: by qyk11 with SMTP id 11so5298369qyk.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 10:22:03 -0800 (PST)
Received: by 10.224.11.66 with SMTP id s2mr6000357qas.311.1291746122437;
        Tue, 07 Dec 2010 10:22:02 -0800 (PST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
        by mx.google.com with ESMTPS id m7sm4589028qck.13.2010.12.07.10.22.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 10:22:01 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
In-Reply-To: <20101207095818.GB1867@neumann>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163103>

Don=E2=80=99t waste time checking for dangling refs; they wouldn=E2=80=99=
t affect the
output of =E2=80=98git describe=E2=80=99 anyway.  Although this doesn=E2=
=80=99t gain much
performance by itself, it does in conjunction with the next commit.

Signed-off-by: Anders Kaseorg <andersk@ksplice.com>

diff --git a/builtin/describe.c b/builtin/describe.c
index 43caff2..700f740 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -418,7 +418,7 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
 		return cmd_name_rev(i + argc, args, prefix);
 	}
=20
-	for_each_ref(get_name, NULL);
+	for_each_rawref(get_name, NULL);
 	if (!found_names && !always)
 		die("No names found, cannot describe anything.");
=20
--=20
1.7.3.3
