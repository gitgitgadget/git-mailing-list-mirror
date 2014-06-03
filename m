From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/9] fetch doc: remove "short-cut" section
Date: Tue,  3 Jun 2014 15:16:30 -0700
Message-ID: <1401833792-2486-8-git-send-email-gitster@pobox.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 00:17:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrx1h-0005hE-MZ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965687AbaFCWRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:17:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55636 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965472AbaFCWRN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:17:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9192E1DD87;
	Tue,  3 Jun 2014 18:17:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2phh
	TJc464dAUrkc7+hlXgdwf/s=; b=MEouWWA+6EQgIS8FQppNY28DD1h0zGSJXy6l
	UZvSKKTNsIIaHtMnSqVj/CbZcc1XOS77K4Ob71I9smDPI9TeL3ZXm/wI5ecDVsbB
	Y1X7+rwTZmb72XNE4j6JiU9VX8IBy8BTIUtJc0GExWA0hST+GSo2rW3A7r+AanlN
	opu/1QU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=B9Hq4v
	li3JXJ6ZWuc14kakMQNyhP+H3oTsNlSZs6ZkcLRXS+OUwd3I/n9KFXp6O2r42Ywm
	a/+IdmVeoXKURO6/swxEMTjZuzT3sbjlA/kyvfOoShN3wmTcCk7iwu4uhqgyMIE6
	cwvMtoLoAiaZPcxtYKs+ceLerPud6kI6CXOYs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8596A1DD86;
	Tue,  3 Jun 2014 18:17:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C06741DD83;
	Tue,  3 Jun 2014 18:17:08 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-518-g8437b4f
In-Reply-To: <1401833792-2486-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CD806AE6-EB6C-11E3-8396-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250704>

It is misleading to mention that <ref> that does not store is to
fetch the ref into FETCH_HEAD, because a refspec that does store is
also to fetch the LHS into FETCH_HEAD.  It is doubly misleading to
list it as part of "short-cut".  <ref> stands for a refspec that has
it on the LHS with a colon and an empty RHS, and that definition
should be given at the beginning of the entry where the format is
defined.

Tentatively remove this misleading description, which leaves the
`tag <tag>` as the only true short-hand, so move it at the beginning
of the entry.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pull-fetch-param.txt | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index a090d4a..9e62434 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -17,6 +17,9 @@ endif::git-pull[]
 	by a colon `:`, followed by the destination ref <dst>.
 	The colon can be omitted when <dst> is empty.
 +
+`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
+it requests fetching everything up to the given tag.
++
 The remote ref that matches <src>
 is fetched, and if <dst> is not empty string, the local
 ref that matches it is fast-forwarded using <src>.
@@ -55,16 +58,3 @@ Octopus from remote refs is rarely done, while keeping track
 of multiple remote heads in one-go by fetching more than one
 is often useful.
 endif::git-pull[]
-+
-Some short-cut notations are also supported.
-+
-* `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
-  it requests fetching everything up to the given tag.
-ifndef::git-pull[]
-* A parameter <ref> without a colon fetches that ref into FETCH_HEAD,
-endif::git-pull[]
-ifdef::git-pull[]
-* A parameter <ref> without a colon merges <ref> into the current
-  branch,
-endif::git-pull[]
-  and updates the remote-tracking branches (if any).
-- 
2.0.0-511-g1433423
