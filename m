From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] Prettify log decorations even more
Date: Thu, 14 May 2009 00:32:53 +0300
Message-ID: <1242250373-9120-1-git-send-email-felipe.contreras@gmail.com>
References: <20090513212812.GA21268@coredump.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 23:33:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4M4l-0002ja-80
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 23:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761630AbZEMVdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 17:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761617AbZEMVdA
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 17:33:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:61122 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048AbZEMVdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 17:33:00 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1104527fga.17
        for <git@vger.kernel.org>; Wed, 13 May 2009 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=u6/rxprYcw8TASNxB9/feggyps6/mPz4OmI0kVdh57s=;
        b=Gvps2SiG+P2e//hIGnyZC/PN6p4IOmnt12pCWFkfebF9Cf35fABYJCOrJi4rcrIOo1
         47peOD94/ej4AJnpd/qmdPUFaSwBLf4PSxIgoedE5l+G+kUYUW0nMcZz895OJv3ICecm
         mTbZuEOiHeJuaa4UoXRDd0EwqCo2xdomLo7+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F0ZjYm+r4z/TkPaPzlm8i5bPoTwfYmQ2bzp9b5ED02vwVpsbLyKSAKKaF63sZ17h1v
         t1im52WcRvRXB6MOpCjBx06Ei4W/m3Vvsb2vMJjXbXs6Mi90NDez+LA+YosP7iBIOC+H
         OSWakkC7poVolvRiwhSK7vv0AxAkcmDxxb0LI=
Received: by 10.86.91.3 with SMTP id o3mr1731625fgb.29.1242250379323;
        Wed, 13 May 2009 14:32:59 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 4sm4007260fge.18.2009.05.13.14.32.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 14:32:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <20090513212812.GA21268@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119115>

"tag: v1.6.2.5" looks much better than "tag: refs/tags/v1.6.2.5".

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 log-tree.c                        |    1 +
 t/t4013/diff.log_--decorate_--all |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 5bd29e6..59d63eb 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -25,6 +25,7 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	struct object *obj = parse_object(sha1);
 	if (!obj)
 		return 0;
+	refname = prettify_refname(refname);
 	add_name_decoration("", refname, obj);
 	while (obj->type == OBJ_TAG) {
 		obj = ((struct tag *)obj)->tagged;
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index 12da8ac..954210e 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -1,12 +1,12 @@
 $ git log --decorate --all
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (refs/heads/master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (master)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side'
 
-commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (refs/heads/side)
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (side)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
 
@@ -26,7 +26,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
     
     This is the second commit.
 
-commit 444ac553ac7612cc88969031b02b3767fb8a353a (refs/heads/initial)
+commit 444ac553ac7612cc88969031b02b3767fb8a353a (initial)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:00:00 2006 +0000
 
-- 
1.6.3.1
