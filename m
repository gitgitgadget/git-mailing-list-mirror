From: =?UTF-8?Q?Daniel?= <mjucde@o2.pl>
Subject: =?UTF-8?Q?Re:_checkout_-m_dumping_core?=
Date: Wed, 06 Jan 2010 09:20:34 +0100
Message-ID: <262d5577.e4806de.4b4447d2.6079e@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Tomas_Carnecky?= <tomas.carnecky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 09:20:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSR8E-0006WF-AJ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 09:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab0AFIUh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2010 03:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754607Ab0AFIUh
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 03:20:37 -0500
Received: from mailout1.go2.pl ([193.17.41.11]:34872 "EHLO mailout1.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754172Ab0AFIUg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2010 03:20:36 -0500
X-Greylist: delayed 531 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2010 03:20:36 EST
Received: from mailout1.go2.pl (unknown [10.0.0.105])
	by mailout1.go2.pl (Postfix) with ESMTP id 823D45F000D;
	Wed,  6 Jan 2010 09:20:35 +0100 (CET)
Received: from o2.pl (unknown [10.0.0.37])
	by mailout1.go2.pl (Postfix) with SMTP;
	Wed,  6 Jan 2010 09:20:35 +0100 (CET)
X-Originator: 153.19.128.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136250>

Argh, this one is better... (does not contain !). Stupid typo :/

---
=46rom b2203bded22db1a496ee3c9f6f5f4a384a8ccefa Mon Sep 17 00:00:00 200=
1
=46rom: Daniel Baranski <mjucde@o2.pl>
Date: Wed, 6 Jan 2010 08:58:21 +0100
Subject: [PATCH] checkout -m: Fix SEGFAULT if HEAD is not valid.

Signed-off-by: Daniel Bara=C5=84ski <mjucde@o2.pl>
---
 builtin-checkout.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 64f3a11..0ab59b2 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -422,7 +422,8 @@ static int merge_working_tree(struct checkout_opts
*opts,
                        struct merge_options o;
                        if (!opts->merge)
                                return 1;
-                       parse_commit(old->commit);
+                       if (parse_commit(old->commit))
+                               die("Couldn't parse commit '%s'",
old->path);

                        /* Do more real merge */

--=20
1.6.5.6
