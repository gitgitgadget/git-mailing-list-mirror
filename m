From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin/merge.c: drop a parameter that is never used
Date: Fri, 24 Oct 2014 11:27:22 -0700
Message-ID: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 20:27:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhjaS-0005Zr-Gc
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 20:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933005AbaJXS1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 14:27:33 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932935AbaJXS1b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 14:27:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5CEB158B8;
	Fri, 24 Oct 2014 14:27:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=g
	QGlDjirJylKzDLv1HEJEVl9go8=; b=o7Ud4Xq6y12zcS2u0xwV7LIv/eWqgXKOu
	khriqQWaMpDeePUpdwDlaFRYyPcBALoo68/WcG/4XTmyqyYW2bqTUylcQwYKOd4n
	12cry+/H+6IR71uGeXp9ugNyn43ABIDw/brZRrz4q7x6dUQ00hncI3qfAhlu02Ba
	utvj5Vv8ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=t26zx/FwnuSqfeCj8rSe5B4R54r5cGKPgQ8XKD0LMum1dPUbeJOqvlTq
	6smcAAGMugcDU5t3lisRDqUhnVu7Pq/GgLpDBmE3aEssMXulO/t6v05wpYjHXFT9
	cl9U6AR0tBB8z4ujMqdVv1rNNVoMTJBLftvMnpUmdl/s1YFlWig=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CED2158B7;
	Fri, 24 Oct 2014 14:27:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20C39158B6;
	Fri, 24 Oct 2014 14:27:24 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 66473F44-5BAB-11E4-9490-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the very beginning when we added the "renormalizing" parameter
to this function with 7610fa57 (merge-recursive --renormalize,
2010-08-05), nobody seems to have ever referenced it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * ... or is there any "renormalization" the said commit meant to
   but forgot to do?

 builtin/merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 41fb66d..f6894c7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -884,7 +884,7 @@ static int finish_automerge(struct commit *head,
 	return 0;
 }
 
-static int suggest_conflicts(int renormalizing)
+static int suggest_conflicts(void)
 {
 	const char *filename;
 	FILE *fp;
@@ -1557,7 +1557,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, _("Automatic merge went well; "
 			"stopped before committing as requested\n"));
 	else
-		ret = suggest_conflicts(option_renormalize);
+		ret = suggest_conflicts();
 
 done:
 	free(branch_to_free);
-- 
2.1.2-595-g1568c45
