From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
Date: Mon, 08 Jul 2013 14:59:46 -0700
Message-ID: <7vsizoyap9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 08 23:59:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwJTQ-0007s7-ES
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 23:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab3GHV7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 17:59:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64925 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322Ab3GHV7v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 17:59:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E28C92EF75;
	Mon,  8 Jul 2013 21:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=s
	X/osipC9IVweodBKmJ78c9/zsA=; b=LZmZS+RcRPJffFtMuclgH2DwMCm2y8ozN
	I/RVOfkwgMZwkniqVSi+FnzkL7elsbsMtEJj9PwK0Wwsd+QA0tV2QgNIvxQZ3sf8
	l8NPVRcI8bjHvKvUbdW9EaTXYga0TN59+AuuQbp9D6xmqUPrxZ+MEUDQJBUe1ukh
	rPfU1PPLD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=l/v
	RkhcX9b/1DTM4BTaI+jk6oelAputX1AbEu5F8rVbqDJte2MSMOuWFFBmH9nO1+r1
	UvfIvqlE7z2QD/8PlgiD++qyN2DTLnfbG2UoSfXMezQGUyFwfsRuHC+UOpHadA5g
	scJKGrsciVZYmM44o0SnQxrg8g+R9Vuf5Hx52Lxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9A192EF74;
	Mon,  8 Jul 2013 21:59:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A7E52EF6E;
	Mon,  8 Jul 2013 21:59:50 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B632BDF0-E819-11E2-9A6D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229897>

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
1.8.3.2-876-ge3d3f5e
