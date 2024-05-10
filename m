Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8C17BA3
	for <git@vger.kernel.org>; Fri, 10 May 2024 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715360137; cv=none; b=Qlqx805pXyfhCwDT35nQYaBIlc0DSb3oD3wmkE9ytFvtr77lhXKkq0GSLzTyt6CtTR/eZ7wLHY9kPXvyapJS49Kuo/mtIUZwuqd3jpkwxbkVNIlC05MAjLsazmEmmvZ7XrdtB0zv/Iod1Xcua9+IQgFdD39BquEYWFwVT9zbcf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715360137; c=relaxed/simple;
	bh=Yi9WRNr58tvynBu/b4mSOs61C5qYwAfHSWeuqbsCVDo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTqwjAJ6x8pGjQ6tUYIIqFIzeHs0HV8Xm0rs7RDZw97PY2kQFP4jnfZGZuaYiVci1JpP28HxzdmJva1To+cAeeJ63ea2v/d8xtYETP1DbqhY0EUxY7LonYxvLM+mqleTaPbJNqUsEy7h/EXq37sF2kR4NvPV3kJLjxlkMvgLA0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wTcVqvf8; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wTcVqvf8"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E9B8354B7;
	Fri, 10 May 2024 12:55:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=Yi9WRNr58tvynBu/b4mSOs61C
	5qYwAfHSWeuqbsCVDo=; b=wTcVqvf8XRZihAopx+nueUSKLwnK1SDGli7DWv6OF
	BFbnou/UfHjoyHFGHbu7on8ctzI14F1ZGS0TzJKljIiHS2qdZFBmL0pFWbHsFkRQ
	pV5mHOIFiav8Ys2fv/0qe9PYpUvzczvzZZ58fcydGOSWtoX0KsckcoTI9T3cPNwR
	vk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 87B4E354B6;
	Fri, 10 May 2024 12:55:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 14D8D354B5;
	Fri, 10 May 2024 12:55:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/2] SubmittingPatches: move the patch-flow section earlier
Date: Fri, 10 May 2024 09:55:25 -0700
Message-ID: <20240510165526.1412338-2-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-119-g0f3415f1f8
In-Reply-To: <20240510165526.1412338-1-gitster@pobox.com>
References: <xmqqy18issfv.fsf@gitster.g>
 <20240510165526.1412338-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 1CDC5302-0EEE-11EF-974F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Before discussing the small details of how the patch gets sent, we'd
want to give people a larger picture first to set the expectation
straight.  The existing patch-flow section covers materials that are
suitable for that purpose, so move it to the beginning of the
document.  We'll update the contents of the section to clarify what
goal the patch submitter is working towards in the next step, which
will make it easier to understand the reason behind the individual
rules presented in latter parts of the document.

This step only moves two sections (patch-flow and patch-status)
without changing their contents, except that their section levels
are demoted from Level 1 to Level 2 to fit better in the document
structure at their new place.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 98 ++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPa=
tches
index 384893be1c..e82c119dfa 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -7,6 +7,55 @@ Here are some guidelines for contributing back to this
 project. There is also a link:MyFirstContribution.html[step-by-step tuto=
rial]
 available which covers many of these same guidelines.
=20
+[[patch-flow]]
+=3D=3D=3D An ideal patch flow
+
+Here is an ideal patch flow for this project the current maintainer
+suggests to the contributors:
+
+. You come up with an itch.  You code it up.
+
+. Send it to the list and cc people who may need to know about
+  the change.
++
+The people who may need to know are the ones whose code you
+are butchering.  These people happen to be the ones who are
+most likely to be knowledgeable enough to help you, but
+they have no obligation to help you (i.e. you ask for help,
+don't demand).  +git log -p {litdd} _$area_you_are_modifying_+ would
+help you find out who they are.
+
+. You get comments and suggestions for improvements.  You may
+  even get them in an "on top of your change" patch form.
+
+. Polish, refine, and re-send to the list and the people who
+  spend their time to improve your patch.  Go back to step (2).
+
+. The list forms consensus that the last round of your patch is
+  good.  Send it to the maintainer and cc the list.
+
+. A topic branch is created with the patch and is merged to `next`,
+  and cooked further and eventually graduates to `master`.
+
+In any time between the (2)-(3) cycle, the maintainer may pick it up
+from the list and queue it to `seen`, in order to make it easier for
+people to play with it without having to pick up and apply the patch to
+their trees themselves.
+
+[[patch-status]]
+=3D=3D=3D Know the status of your patch after submission
+
+* You can use Git itself to find out when your patch is merged in
+  master. `git pull --rebase` will automatically skip already-applied
+  patches, and will let you know. This works only if you rebase on top
+  of the branch in which your patch has been merged (i.e. it will not
+  tell you if your patch is merged in `seen` if you rebase on top of
+  master).
+
+* Read the Git mailing list, the maintainer regularly posts messages
+  entitled "What's cooking in git.git" giving
+  the status of various proposed changes.
+
 [[choose-starting-point]]
 =3D=3D=3D Choose a starting point.
=20
@@ -562,55 +611,6 @@ repositories.
=20
 Patches to these parts should be based on their trees.
=20
-[[patch-flow]]
-=3D=3D An ideal patch flow
-
-Here is an ideal patch flow for this project the current maintainer
-suggests to the contributors:
-
-. You come up with an itch.  You code it up.
-
-. Send it to the list and cc people who may need to know about
-  the change.
-+
-The people who may need to know are the ones whose code you
-are butchering.  These people happen to be the ones who are
-most likely to be knowledgeable enough to help you, but
-they have no obligation to help you (i.e. you ask for help,
-don't demand).  +git log -p {litdd} _$area_you_are_modifying_+ would
-help you find out who they are.
-
-. You get comments and suggestions for improvements.  You may
-  even get them in an "on top of your change" patch form.
-
-. Polish, refine, and re-send to the list and the people who
-  spend their time to improve your patch.  Go back to step (2).
-
-. The list forms consensus that the last round of your patch is
-  good.  Send it to the maintainer and cc the list.
-
-. A topic branch is created with the patch and is merged to `next`,
-  and cooked further and eventually graduates to `master`.
-
-In any time between the (2)-(3) cycle, the maintainer may pick it up
-from the list and queue it to `seen`, in order to make it easier for
-people to play with it without having to pick up and apply the patch to
-their trees themselves.
-
-[[patch-status]]
-=3D=3D Know the status of your patch after submission
-
-* You can use Git itself to find out when your patch is merged in
-  master. `git pull --rebase` will automatically skip already-applied
-  patches, and will let you know. This works only if you rebase on top
-  of the branch in which your patch has been merged (i.e. it will not
-  tell you if your patch is merged in `seen` if you rebase on top of
-  master).
-
-* Read the Git mailing list, the maintainer regularly posts messages
-  entitled "What's cooking in git.git" giving
-  the status of various proposed changes.
-
 =3D=3D GitHub CI[[GHCI]]
=20
 With an account at GitHub, you can use GitHub CI to test your changes
--=20
2.45.0-119-g0f3415f1f8

