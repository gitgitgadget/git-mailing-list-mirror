Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB847F5F
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZHajhN49"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 59AFA1BE561;
	Fri, 15 Dec 2023 15:32:59 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=9UlA2/3F3fPOPr6wW31fYqZ2k
	PsB2BGM1n4/34xYdro=; b=ZHajhN49arIkEIsC7oHJoWfhcIyWx74/0Ep7Wl/k+
	y7av6ONhZFWAAdeEZYM+jG2838rBpGzlzAzBv7R9+WG46fU0X91cmEY28gU0ZIrr
	qgDgudzDWazX+zUWwmyX75z/16YJsHRwtdDLyhDgesA98ZWeILG2Or5UqzinbYZM
	Q0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 501C61BE55F;
	Fri, 15 Dec 2023 15:32:59 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B13181BE55E;
	Fri, 15 Dec 2023 15:32:58 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 4/5] docs: AUTO_MERGE is not that special
Date: Fri, 15 Dec 2023 12:32:44 -0800
Message-ID: <20231215203245.3622299-5-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-76-g1a87c842ec
In-Reply-To: <20231215203245.3622299-1-gitster@pobox.com>
References: <20231215203245.3622299-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 228BB226-9B89-11EE-A475-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

A handful of manual pages called AUTO_MERGE a "special ref", but
there is nothing special about it.  It merely is yet another
pseudoref.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-diff.txt    | 2 +-
 Documentation/git-merge.txt   | 2 +-
 Documentation/user-manual.txt | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 08087ffad5..c065f023ec 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -103,7 +103,7 @@ Just in case you are doing something exotic, it shoul=
d be
 noted that all of the <commit> in the above description, except
 in the `--merge-base` case and in the last two forms that use `..`
 notations, can be any <tree>. A tree of interest is the one pointed to
-by the special ref `AUTO_MERGE`, which is written by the 'ort' merge
+by the ref named `AUTO_MERGE`, which is written by the 'ort' merge
 strategy upon hitting merge conflicts (see linkgit:git-merge[1]).
 Comparing the working tree with `AUTO_MERGE` shows changes you've made
 so far to resolve textual conflicts (see the examples below).
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e8ab340319..3e9557a44b 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -196,7 +196,7 @@ happens:
    can inspect the stages with `git ls-files -u`).  The working
    tree files contain the result of the merge operation; i.e. 3-way
    merge results with familiar conflict markers `<<<` `=3D=3D=3D` `>>>`.
-5. A special ref `AUTO_MERGE` is written, pointing to a tree
+5. A ref named `AUTO_MERGE` is written, pointing to a tree
    corresponding to the current content of the working tree (including
    conflict markers for textual conflicts).  Note that this ref is only
    written when the 'ort' merge strategy is used (the default).
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.tx=
t
index d8dbe6b56d..5d32ff2384 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1344,7 +1344,7 @@ $ git diff --theirs file.txt	# same as the above.
 -------------------------------------------------
=20
 When using the 'ort' merge strategy (the default), before updating the w=
orking
-tree with the result of the merge, Git writes a special ref named AUTO_M=
ERGE
+tree with the result of the merge, Git writes a ref named AUTO_MERGE
 reflecting the state of the tree it is about to write. Conflicted paths =
with
 textual conflicts that could not be automatically merged are written to =
this
 tree with conflict markers, just as in the working tree. AUTO_MERGE can =
thus be
--=20
2.43.0-76-g1a87c842ec

