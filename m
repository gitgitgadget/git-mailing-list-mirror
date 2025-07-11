Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263512EF2B8
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261049; cv=none; b=san6ma8RLKFJ1JEz0irVVhBqcthyP5huZrnsHeBOh8VGWFqhm8arT/ymFmuJChxVVHbApi3pvYkgC2frZLXkqIxw1wE7SA/npKFHawmkwTrE/aDTxHLSsxi59lWM43Ho7vAiBzLhNADy85IK7lpg64BW2BE9J80VTjKi/xRdWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261049; c=relaxed/simple;
	bh=r2jIkAJyqgEIP27+FF7Ngn0y/7Ofz/NSHYxcMromsiA=;
	h=From:To:Subject:References:Date:Message-ID:MIME-Version:
	 Content-Type; b=QA2866TFS0eFuLCtPssswbMoak1aFikElXQE7jFh/QJwDDBE/Znm02/d9KC7+8bsuTOrQt+hOUJtEJdhxk6rMld5XhCusl/yqGb9ynKnT6HadarCEUkLnUbAYQl6ZpC3X3A5D5En0NECM8XrgkcWJ69nKXlhlghDLI55+vmy3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VoARvfuA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EYEsbhsn; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VoARvfuA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EYEsbhsn"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id EA3911D002B5;
	Fri, 11 Jul 2025 15:10:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 11 Jul 2025 15:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1752261045; x=1752347445; bh=G7xYRnCIXSRl9PUwjq8br
	kGwxYKKZlxAdzOsO2srylw=; b=VoARvfuAcGce4+BkV7e6PovzUxt1EXeLYsvmM
	l2DAq5+dT7Srdq9+q14pl0PnAxxaSw7WySqen10Y3MO6diLnNUHII9xVuK8fGYwv
	wGdmCdeIuSVpfh6bQRSVzzYhNJje8qR2/2hDq5FnolkmON4b61lnis9qliEY591z
	9GoFgL6YWfVCUdOtnbaY8XHLdm6M5LhzDBaf0ApuSTJTepQ5LcgfDd87SXsvcqnO
	H2FqVJ/RwG0P0Yi3YcUk+Dd7GoXa899C2Eo3o/2yQaszlna+oi4YS2Ef91lF0Bwe
	mOoP4pJSH6IelMNmcLDkwjh4ZRbfL4WmMDJvlmueDXaxt/2qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752261045; x=1752347445; bh=G7xYRnCIXSRl9PUwjq8brkGwxYKKZlxAdzO
	sO2srylw=; b=EYEsbhsnxdxKCcxoP0Oic8a17//Db5pfAz35/Ykh4D2IOIMNwUv
	FzrDzzCO+nZQdkHxB2BbJYytbHORONNq0EtYNMYoNbwUwjuXga06T175qTcibZHn
	lo2f/TmYo9RCTnliTv7Zu1/D2maxiYifbOXUoQUN2mmAGYET6H5giTGg6zLexaFS
	DwapdWSjUyB6HkOpQV73meuhhkBDbpjm8QhOYH7OrZ58PGhzYZVgSPAyWP158I5Z
	V2qgarYCUwBKGU6fl0S/anRWY5+qKczgN2oGVHs8Hi1xtL0pSAUc1bLt/kZeZbLw
	kk0PoN9EJ1FpoTIGe9XvaG3gTfJ1fEfsleA==
X-ME-Sender: <xms:tWFxaL_OMEe8CaDKUeZu7mqo5_kuwKS2wbszs-Vx95p903oyGv6Ptw>
    <xme:tWFxaH6X5JfWn3rS9slGRBW0LvoPnj7DWFcv1bV7Y2oosWcTkfdNLkY9-bkckJ0Qe
    14ds08WfRk2rZg3wA>
X-ME-Received: <xmr:tWFxaK39cSAVQKGZk2_1mX0fGqSHkkaJnnezbol-MlKrE9anrSc-Z0cvMXSowRzMI0SUwuBzU0hFouTpT6kooIZXeQm9bw4Qol-kgFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufhffffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnheptedvvdduffekiefhhfevleevhffgkeffud
    ettddvveeuudegudejieeghfeiveevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tWFxaGDutAXnt1Zvk8ffv2-A80So_fO-SfslUUVw4Tm09Wm8AhO-0g>
    <xmx:tWFxaE2qS5qaCoZtqswK-x3K1mFAxZdqqownSloa3pKQ26q3Q0WJTw>
    <xmx:tWFxaItjyU2_I_qzzKt_E-5jcmoDyPn5MiZWVKsqCET-KqljF1vstw>
    <xmx:tWFxaM47JA647YzYfSeHHZC0hS92ipQ5Me5tiqeWjxB4zsNjy3K5Dw>
    <xmx:tWFxaOgVQ9pHUirFgYuelqEpa5dq8rQJL947na5_w4do5fkL6L4IZ-lq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 15:10:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] tag: allow idempotent "git tag" without "--force"
References: <xmqqzfefodje.fsf@gitster.g>
Date: Fri, 11 Jul 2025 12:10:44 -0700
Message-ID: <xmqqv7nyzgp7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When "git tag T O" is told to create a tag pointing at an object O
without the "--force" option, it refuses with "tag T already exists",
even when T points at O (which makes it a no-op).

Let's allow this "idempotent" case by special casing and making it
truly a no-op.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * In thread https://lore.kernel.org/git/xmqqzfefodje.fsf@gitster.g/
   I had a slightly different version but I think the logic flow
   reads better in this version, even though they essentially do the
   same thing.

 builtin/tag.c  |  2 ++
 t/t7004-tag.sh | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index c4bd145831..1dd69b3447 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -647,6 +647,8 @@ int cmd_tag(int argc,
 
 	if (refs_read_ref(get_main_ref_store(the_repository), ref.buf, &prev))
 		oidclr(&prev, the_repository->hash_algo);
+	else if (!create_tag_object && oideq(&object, &prev))
+		exit(0);
 	else if (!force)
 		die(_("tag '%s' already exists"), tag);
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 10835631ca..9a253a44a8 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -126,7 +126,7 @@ test_expect_success 'annotated tag with --create-reflog has correct message' '
 '
 
 test_expect_success '--create-reflog does not create reflog on failure' '
-	test_must_fail git tag --create-reflog mytag &&
+	test_must_fail git tag --create-reflog mytag no-such-object &&
 	test_must_fail git reflog exists refs/tags/mytag
 '
 
@@ -183,8 +183,14 @@ test_expect_success 'listing tags using a non-matching pattern should output not
 
 # special cases for creating tags:
 
-test_expect_success 'trying to create a tag with the name of one existing should fail' '
-	test_must_fail git tag mytag
+test_expect_success 'recreating a tag without --force' '
+	# light-weight tag pointing at the same thing
+	# now succeeds
+	git tag mytag HEAD &&
+	# light-weight tag pointing at a different thing
+	test_must_fail git tag mytag HEAD: &&
+	# creating annotated tag, pointing at the same object.
+	test_must_fail git tag -a -m anno mytag $taggedobject
 '
 
 test_expect_success 'trying to create a tag with a non-valid name should fail' '
-- 
2.50.1-396-g5c2aadec13

