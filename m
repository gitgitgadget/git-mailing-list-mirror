From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/6] builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
Date: Thu, 11 Jul 2013 15:26:16 -0700
Message-ID: <1373581580-13651-3-git-send-email-gitster@pobox.com>
References: <1373581580-13651-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 00:26:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxPJu-0002Hy-Ey
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 00:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101Ab3GKW0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 18:26:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59704 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753090Ab3GKW00 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 18:26:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F722303DF
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=5Hxe
	OT1UwFDYt4eZElutK/6pq/g=; b=wQNDEyBpqI2ljC8Ax/mm/GmZElJXaiRbjzcc
	JRpJKeSBk4lX15395Trq8oHvRrONKhcSDQS6rcI0tg92CTBIXhHZcCYfdzUHH7kF
	fX1Ia5zvEwfw+ay5YHVEXdlQGoahjoLqt2w/YzCMU17AQt6kKf30C/+nQYGS3Di5
	9mEJYNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=VM62Er
	jKGA7RnJ9OQ6ZtzjA/HJYlYNYzPlz6Gt2Ob3ER6sBN2zfQfU83GTkfiJWGkhYc65
	T1Nr+Aqv4E2goSlSGfw//AscP7OEXbONFjvW5GJuBPp/Ed9ghBf/alExjZ2sk2UY
	Zef2aTvITMT+/nGDfnkaxwuuU+K2avvVe9lUg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84A48303DE
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:26 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E94E9303DC
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:25 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-911-g2c4daa5
In-Reply-To: <1373581580-13651-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EC849656-EA78-11E2-A48D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230137>

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
1.8.3.2-912-g65cf5cf
