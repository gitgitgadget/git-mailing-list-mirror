From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] read-tree: setup worktree if merge is required
Date: Thu, 28 Aug 2008 20:03:22 +0700
Message-ID: <1219928602-25155-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 15:06:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYhBk-0002vE-4P
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 15:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbYH1NDn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 09:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbYH1NDm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 09:03:42 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:56156 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbYH1NDl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 09:03:41 -0400
Received: by wf-out-1314.google.com with SMTP id 27so336587wfd.4
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 06:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=3El38stRO/NZaksrH1Vgp6bqUAXlrbKSTYb0ajBeISo=;
        b=sPh2tHtSmZLQ8LtuyU/I+Nyq/Q07orohc+ITWh4jgwI85bttA7OF11cYnWH79/jStj
         KuSrNXsc3BBpxdKw/+JvvLo/WLHTNjbu3WD6GdL3aBTfaM2pO+sF1CUtmDxmVqgfXtwt
         0gaYsfXtONOt6UsiwzLn+tqag+U6/fAh/CpvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=NArqLe9eAs+FLuAmXxpsfWgf4xBtBpT1ospLFxDk9LuE5uukOCAZToCGML1WmlYupg
         HSX/NCQOxZ4eFvPRaT4uWUfPyNDRwypUfPMmaD3x3lYEW1V8H8hV0l18V3EYHYNVx/t5
         RU876peVRUtQqWD0DhglbV63CQE6F3cDJCTS8=
Received: by 10.142.125.9 with SMTP id x9mr463213wfc.89.1219928621756;
        Thu, 28 Aug 2008 06:03:41 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.54.222])
        by mx.google.com with ESMTPS id 28sm1703494wfd.4.2008.08.28.06.03.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Aug 2008 06:03:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 28 Aug 2008 20:03:22 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94049>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-read-tree.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 72a6de3..dddc304 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -194,6 +194,8 @@ int cmd_read_tree(int argc, const char **argv, cons=
t char *unused_prefix)
 		usage(read_tree_usage);
 	if ((opts.dir && !opts.update))
 		die("--exclude-per-directory is meaningless unless -u");
+	if (opts.merge && !opts.index_only)
+		setup_work_tree();
=20
 	if (opts.merge) {
 		if (stage < 2)
--=20
1.6.0.96.g2fad1.dirty
