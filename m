Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404A80034
	for <git@vger.kernel.org>; Thu,  9 May 2024 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289209; cv=none; b=UJPGhXv4q06o6qu8j2wamZUtAFzckQyrLlYDE+GU+YA1rhgNwwmOajmram2R+y7M2/b4zxETmaynLCbYAZkgkcQI8tERwh6cPB/WylMz/3fu7DKxeMvcF2ruxRVNlAfL3PblzwF5Mf5yeJkwiYdr7YgIQaoGFnWleAFdTgNkktE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289209; c=relaxed/simple;
	bh=uOBcnmgbZsxq/38BX91iBBlDsm/Lb/LCnnEQLrci14M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVWYlajl9eHcFNsprTEtUrSo1PHA/XJChkxEsNQjXeYCf08Uy4FztYeeIgiZyK4YSF4a35+yQF8cFGZmxgqRvCy/XssI9XQeEh2tOXbKs6cuHZbYe70Sz6sz91VQ/5+kboozsmG+zddSCgITlWQR4AlDnnRvf33xddpq3STbSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OeRoxca3; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OeRoxca3"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FDE12F92C;
	Thu,  9 May 2024 17:13:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=uOBcnmgbZsxq/38BX91iBBlDs
	m/Lb/LCnnEQLrci14M=; b=OeRoxca3xs/0DO3Psgt86Dnwnqj/C59RTjOrOtcgY
	qsivXRlEMl4cDKw6WFECzukkV0LzwXDfJlv8PtfTCtaWTymAH6TqZVynjwACKsE2
	sGZxIGwnXGQE6kfINOO6r0mxCAfepVmcPq5+k58wXssiXr3Wl0FxKhiGf4LMd+Ye
	DE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0885D2F92B;
	Thu,  9 May 2024 17:13:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B3112F928;
	Thu,  9 May 2024 17:13:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] SubmittingPatches: move the patch-flow section earlier
Date: Thu,  9 May 2024 14:13:17 -0700
Message-ID: <20240509211318.641896-2-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-119-g0f3415f1f8
In-Reply-To: <20240509211318.641896-1-gitster@pobox.com>
References: <xmqqy18issfv.fsf@gitster.g>
 <20240509211318.641896-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 F82C226C-0E48-11EF-92F6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Before discussing the small details of how the patch gets sent, we'd
want to give people a larger picture first to set the expectation
straight.  The existing patch-flow section covers materials that are
suitable for that purpose, so move it to the beginning of the
document.  We'll update the contents of the section to clarify what
goal the patch submitter is working towards in the next step, which
will make it easier to understand the reason behind the individual
rules presented in latter parts of the document.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 98 ++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPa=
tches
index 727992541c..142b82a71b 100644
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
@@ -569,55 +618,6 @@ Patches to these parts should be based on their tree=
s.
 	https://github.com/jnavila/git-manpages-l10n/
=20
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

