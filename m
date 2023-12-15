Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A10047F43
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ssUkjhRi"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B127A27BAD;
	Fri, 15 Dec 2023 15:32:53 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=/Daf+PK2gEgAvD1qdQsmVKrNS
	rfOjuIWLl/w7EUXYdk=; b=ssUkjhRizeV8lBCV+KkzaEIGw/5l19fWbJT4MuEn4
	ZLsV6mJK+t+Todt/Hb1dWagl3v6Fid+75NeXl1JywVdJ8i65n+eOCaN5Fhrd3K+T
	mcreg+uAGEtBX55cro0gM0bCxW+6oCIfSzc5M7YRoaf4U6hu5pjVOeOKs+jZaczN
	1M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 96CCA27BAC;
	Fri, 15 Dec 2023 15:32:53 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 44DAF27BAB;
	Fri, 15 Dec 2023 15:32:50 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/5] git.txt: HEAD is not that special
Date: Fri, 15 Dec 2023 12:32:41 -0800
Message-ID: <20231215203245.3622299-2-gitster@pobox.com>
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
 1D81FABA-9B89-11EE-A3D2-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

The introductory text in "git help git" that describes HEAD called
it "a special ref".  It is special compared to the more regular refs
like refs/heads/master and refs/tags/v1.0.0, but not that special,
unlike truly special ones like FETCH_HEAD.

Rewrite a few sentences to also introduce the distinction between a
regular ref that contain the object name and a symbolic ref that
contain the name of another ref.  Update the description of HEAD
that point at the current branch to use the more correct term, a
"symbolic ref".

This was found as part of auditing the documentation and in-code
comments for uses of "special ref" that refer merely a "pseudo ref".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2535a30194..880cdc5d7f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1025,10 +1025,11 @@ When first created, objects are stored in individ=
ual files, but for
 efficiency may later be compressed together into "pack files".
=20
 Named pointers called refs mark interesting points in history.  A ref
-may contain the SHA-1 name of an object or the name of another ref.  Ref=
s
-with names beginning `ref/head/` contain the SHA-1 name of the most
+may contain the SHA-1 name of an object or the name of another ref (the
+latter is called a "symbolic ref").
+Refs with names beginning `ref/head/` contain the SHA-1 name of the most
 recent commit (or "head") of a branch under development.  SHA-1 names of
-tags of interest are stored under `ref/tags/`.  A special ref named
+tags of interest are stored under `ref/tags/`.  A symbolic ref named
 `HEAD` contains the name of the currently checked-out branch.
=20
 The index file is initialized with a list of all paths and, for each
--=20
2.43.0-76-g1a87c842ec

