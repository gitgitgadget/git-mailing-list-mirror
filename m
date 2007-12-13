From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/2] parseopt: Enforce the use of the sticked form for optional arguments.
Date: Thu, 13 Dec 2007 11:26:36 +0100
Message-ID: <20071213102636.GD12398@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 11:27:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2lHS-0005ir-0M
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 11:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300AbXLMK0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 05:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755655AbXLMK0k
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 05:26:40 -0500
Received: from pan.madism.org ([88.191.52.104]:48890 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754492AbXLMK0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 05:26:39 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 26EB619737;
	Thu, 13 Dec 2007 11:26:37 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 99EA7D370; Thu, 13 Dec 2007 11:26:36 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20071213093536.GC12398@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68139>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index e12b428..7a08a0c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -89,7 +89,7 @@ static int get_value(struct optparse_t *p,
 			*(const char **)opt->value = NULL;
 			return 0;
 		}
-		if (opt->flags & PARSE_OPT_OPTARG && (!arg || *arg == '-')) {
+		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
 			*(const char **)opt->value = (const char *)opt->defval;
 			return 0;
 		}
@@ -103,7 +103,7 @@ static int get_value(struct optparse_t *p,
 			return (*opt->callback)(opt, NULL, 1);
 		if (opt->flags & PARSE_OPT_NOARG)
 			return (*opt->callback)(opt, NULL, 0);
-		if (opt->flags & PARSE_OPT_OPTARG && (!arg || *arg == '-'))
+		if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
 			return (*opt->callback)(opt, NULL, 0);
 		if (!arg)
 			return opterror(opt, "requires a value", flags);
@@ -114,7 +114,7 @@ static int get_value(struct optparse_t *p,
 			*(int *)opt->value = 0;
 			return 0;
 		}
-		if (opt->flags & PARSE_OPT_OPTARG && (!arg || !isdigit(*arg))) {
+		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
 			*(int *)opt->value = opt->defval;
 			return 0;
 		}
-- 
1.5.3.7.2249.g89c99-dirty
