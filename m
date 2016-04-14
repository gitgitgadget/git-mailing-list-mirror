From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] ll-merge: fix typo in comment
Date: Thu, 14 Apr 2016 15:12:15 -0700
Message-ID: <xmqqbn5bg7r4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 00:12:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqpVD-0007x0-Nj
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 00:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbcDNWMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 18:12:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752063AbcDNWMh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 18:12:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E306B13801;
	Thu, 14 Apr 2016 18:12:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=9
	x27aQ0fZYlvkPssGY9XH/ow4kE=; b=kIcjIsehZY41IHGXrNlKTfNOXYqtGH/4g
	iVJuCWKzqr04si+RiXcY0JXFk0uvn5YONMK0aWYKy2OEtiwoHQCorJ9tcPdTm3FJ
	FZ1KXXFNTZ2mRB7mwHcr3QGhYAewzd0EfM5A2jgOBYyB+Cwenei89uLVkxpb+OSZ
	IIkXyu0UbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Vzq
	g/KvTdN/sEQ7evwctHUNb9rkyg/bYlz7IglJ9nMjyryynAVAuPmRckKPEtcc0l6O
	QlQvB0jG/wPHZQTk1TgtyFCFAyraHHncxt27b8/Acw985BkoaXdK44f4FolZFjsx
	50fvhCHy4zqLJUJ/3wuhpyHKF7DIHJBbRnU5AktQ=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D4B4613800;
	Thu, 14 Apr 2016 18:12:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 251B1137E3;
	Thu, 14 Apr 2016 18:12:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F2FBF8BE-028D-11E6-AA5D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291570>

When a944af1d (merge: teach -Xours/-Xtheirs to binary ll-merge
driver, 2012-09-08) introduced FAVOR_OURS/FAVOR_THEIRS to the binary
ll-merge driver, it changed what happens to the merge result for the
outer merge, and updated the comment from:

    The tentative merge result is "ours" for the final round, or
    common ancestor for an internal merge.  Still return "conflicted
    merge" status.

to

    The tentative merge result is the or common ancestor for an
    internal merge.

What happened is obvious.  I noticed the lack of definitive article
in front of "common" but failed to remove "or".  Also I forgot to
describe what I did for the final merge, probably because I was
satisified by the description in the log message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ll-merge.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ll-merge.c b/ll-merge.c
index ff4a43a..fe22412 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -47,7 +47,9 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 	assert(opts);
 
 	/*
-	 * The tentative merge result is the or common ancestor for an internal merge.
+	 * The tentative merge result is the common ancestor for an
+	 * internal merge.  For the final merge, it is "ours" by
+	 * default but -Xours/-Xtheirs can tweak the choice.
 	 */
 	if (opts->virtual_ancestor) {
 		stolen = orig;
