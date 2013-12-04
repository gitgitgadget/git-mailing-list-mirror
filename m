From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC/WIP PATCH 4/4] always show committed submodules in summary
 after commit
Date: Wed, 4 Dec 2013 23:23:48 +0100
Message-ID: <20131204222348.GE7326@sandbox-ub>
References: <528FC638.5060403@web.de>
 <20131122215454.GA4952@sandbox-ub>
 <20131122220953.GI4212@google.com>
 <52910BC4.1030800@web.de>
 <20131124005256.GA3500@sandbox-ub>
 <52922962.3090407@web.de>
 <CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
 <20131125174945.GA3847@sandbox-ub>
 <CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com>
 <20131204221659.GA7326@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 23:24:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoKrR-0001qb-Nr
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 23:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089Ab3LDWX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 17:23:58 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:49917 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748Ab3LDWX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 17:23:57 -0500
Received: from [77.21.76.49] (helo=sandbox-ub)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VoKrG-0006eb-E7; Wed, 04 Dec 2013 23:23:50 +0100
Content-Disposition: inline
In-Reply-To: <20131204221659.GA7326@sandbox-ub>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238820>

If an ignored submodule is committed because is was registered in the
index we should always show that to the user in the printed summary
after commit.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 builtin/commit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6ab4605..e551566 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1361,6 +1361,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 	strbuf_release(&committer_ident);
 
 	init_revisions(&rev, prefix);
+	enforce_no_complete_ignore_submodule(&rev.diffopt);
 	setup_revisions(0, NULL, &rev, NULL);
 
 	rev.diff = 1;
-- 
1.8.5.1.43.gf00fb86
