Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AE91386C5
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342288; cv=none; b=XIaziIyxWdVLj6cHkNXUnXH41J8nux7ymMfBIt/Cc3uf1IUudp4wyIkxvvkc6RApRqOJtvrhRQQCb2MdZ1l9SKHxi/hEf9wlRzaRXCuIFG6TMs0mrpsCr1Ivq1yKbDbK1rMqcLpQznmZ5rNmBKSeuWPidsxN/NBc4eIkhOlDL4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342288; c=relaxed/simple;
	bh=x7hGd3RclxS8BOazHCIXNS79l0lXRtFXnDixY6WfK5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEOX1aI5kKU2RmrpzzJlfGt5tisi4pV9v+CINRT0bwVr6SEZYtPkVYjzzsYxBrdMp1MvbD7F2m0rVk48myWEKtE+5HvZUdVhSFrAddzbz257pk3eLfnWsjxMjmfuy7/GJ6/vshcTlqUeJTX3UPFRlscYdZ3UZAsB3UuVvoSOa0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=j+lKRpJE; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j+lKRpJE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 380612F1C6;
	Wed,  7 Feb 2024 16:44:46 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=x7hGd3RclxS8BOazHCIXNS79l
	0lXRtFXnDixY6WfK5U=; b=j+lKRpJEi9Xy1pMw9wQsNAkcu9Kz6PQ+vW5tcbZqW
	jOtcMzWNo13S/m9L8FCWqH+YHjpdb6OyBV3wWqunJiZ8Er5xcrf0FduSaSH9bvDx
	KZT9r1QCpdl/hCkRiHNBO+BndMDVSAC4bh11/FjO0CAk47i3vSAM+6JnsVv4AUFT
	cs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 31E782F1C5;
	Wed,  7 Feb 2024 16:44:46 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C72342F1C1;
	Wed,  7 Feb 2024 16:44:41 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH 1/2] bisect: document "terms" subcommand more fully
Date: Wed,  7 Feb 2024 13:44:35 -0800
Message-ID: <20240207214436.538586-2-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-561-g235986be82
In-Reply-To: <20240207214436.538586-1-gitster@pobox.com>
References: <24a42fa6-7bc4-4a3b-8bf4-a0ef85dc457a@matthieu-moy.fr>
 <20240207214436.538586-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 19B0D890-C602-11EE-8DAD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

The documentation for "git bisect terms", although it did not hide
any information, was a bit incomplete and forced readers to fill in
the blanks to get the complete picture.

Acked-by: Matthieu Moy <git@matthieu-moy.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-bisect.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index fbb39fbdf5..3d813f9c77 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -20,7 +20,7 @@ on the subcommand:
 		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>..=
.]
  git bisect (bad|new|<term-new>) [<rev>]
  git bisect (good|old|<term-old>) [<rev>...]
- git bisect terms [--term-good | --term-bad]
+ git bisect terms [--term-(good|old) | --term-(bad|new)]
  git bisect skip [(<rev>|<range>)...]
  git bisect reset [<commit>]
  git bisect (visualize|view)
@@ -165,8 +165,10 @@ To get a reminder of the currently used terms, use
 git bisect terms
 ------------------------------------------------
=20
-You can get just the old (respectively new) term with `git bisect terms
---term-old` or `git bisect terms --term-good`.
+You can get just the old term with `git bisect terms --term-old`
+or `git bisect terms --term-good`; `git bisect terms --term-new`
+and `git bisect terms --term-bad` can be used to learn how to call
+the commits more recent than the sought change.
=20
 If you would like to use your own terms instead of "bad"/"good" or
 "new"/"old", you can choose any names you like (except existing bisect
--=20
2.43.0-561-g235986be82

