From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/6] builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
Date: Mon, 22 Jul 2013 23:43:16 -0700
Message-ID: <1374561800-938-3-git-send-email-gitster@pobox.com>
References: <1374561800-938-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 23 08:44:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1WKE-0002l7-U6
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 08:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059Ab3GWGnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 02:43:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57719 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab3GWGn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 02:43:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D781B24A03
	for <git@vger.kernel.org>; Tue, 23 Jul 2013 06:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/758
	6cU7HkVK/SwCcFLzv8gpv4Q=; b=Z7RlkT8D73u2OetGH9bVSNMet6LrR4KFDC4D
	ouwYYSDshWz9IL7zY7szRoqcHDPtLXlmhRqxeTObmJCLu2dcTBK91ejjjJUdSoVh
	o8Q+bWvbh1dxVyNALsCtmGi3tADQ0x3TmcL9X850oXRgxV62K3cWE96p0ExrU3cc
	0eIQksA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xef4UU
	wIoWfbCvQAyTUBKO/UD4xJWd3A7efnzRicg9OdkWXGA8QKaCAvjFD/RqmPleBtCF
	fPCVPHkhkjhIR1pz/Jck2LD2y26jpQ5sFID1wAAw1wTsQ1Pa1gONKL//KWRf2uYG
	sGQ2lJJTyV9MCgvsxrcoJ+YJaBt8rmVSVrcFQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF22124A00
	for <git@vger.kernel.org>; Tue, 23 Jul 2013 06:43:26 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3477B249FE
	for <git@vger.kernel.org>; Tue, 23 Jul 2013 06:43:26 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.4-985-g5661af8
In-Reply-To: <1374561800-938-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2D527340-F363-11E2-B6B3-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231024>

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
1.8.3.4-980-g8decd39
