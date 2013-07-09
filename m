From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
Date: Tue,  9 Jul 2013 12:53:25 -0700
Message-ID: <1373399610-8588-3-git-send-email-gitster@pobox.com>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
 <1373399610-8588-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 09 21:53:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwdys-0005y4-Fc
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 21:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab3GITxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 15:53:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57198 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753084Ab3GITxg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 15:53:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D5272F3C1
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2z7F
	gvSSyOo4apX2vly+jNquQrE=; b=uvDzdskabe+VIgLGGHcBECiCYrUVp4d7HCAt
	Ge0GwFRoOqblazALtyPE6x2Ht/KjxLKnHQpOPZA9VdqQ3i1UAePuu256PqMWvUVM
	7AOFFInefApYhKnPCSPAw43py9YCrb6b/K9rJVQAMnPv7TL9xJQ9d0c+L1b89H6h
	SaQYeRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=UxjISH
	Wu6Yxh+0BKorbwiuuQzn8gZ3uHWLMnVe8QNQG8gfa8b1styiUVBQBRyWqxHt8crU
	SoHthk+WhDFo8lNy7Q0ptOqUFRO0g2z5wQ5l6v3Bo7D+7Aq2GJtfz0bEy0WTMKL7
	8vleFhZERVhZB95/g6X24xZSJMGqqFw/rkooQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4194A2F3C0
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B373E2F3BD
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:35 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-875-g76c723c
In-Reply-To: <1373399610-8588-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3DD10D40-E8D1-11E2-9D32-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229990>

The command line parser of "git push" for "--tags", "--delete", and
"--thin" options still used outdated OPT_BOOLEAN.  Because these
options do not give escalating levels when given multiple times,
they should use OPT_BOOL.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 2d84d10..342d792 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -427,15 +427,15 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT( 0 , "all", &flags, N_("push all refs"), TRANSPORT_PUSH_ALL),
 		OPT_BIT( 0 , "mirror", &flags, N_("mirror all refs"),
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
-		OPT_BOOLEAN( 0, "delete", &deleterefs, N_("delete refs")),
-		OPT_BOOLEAN( 0 , "tags", &tags, N_("push tags (can't be used with --all or --mirror)")),
+		OPT_BOOL( 0, "delete", &deleterefs, N_("delete refs")),
+		OPT_BOOL( 0 , "tags", &tags, N_("push tags (can't be used with --all or --mirror)")),
 		OPT_BIT('n' , "dry-run", &flags, N_("dry run"), TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
 		{ OPTION_CALLBACK, 0, "recurse-submodules", &flags, N_("check"),
 			N_("control recursive pushing of submodules"),
 			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
-		OPT_BOOLEAN( 0 , "thin", &thin, N_("use thin pack")),
+		OPT_BOOL( 0 , "thin", &thin, N_("use thin pack")),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", N_("receive pack program")),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", N_("receive pack program")),
 		OPT_BIT('u', "set-upstream", &flags, N_("set upstream for git pull/status"),
-- 
1.8.3.2-875-g76c723c
