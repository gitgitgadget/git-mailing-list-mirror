Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532BB346FB3
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347905; cv=none; b=E18kaLAdj9sO51/6Wm6GdMekKWsJovpGLdAFzkBDOpjhYKDA9nPA8vdDOmdTaYzDiGKvQCovHppL+Je2KmpBs7DxXYS50Mr+pOwkcJ73FqJlHp3+dIQTDRitFsx7OkZEYhZr8vBdv14K1LW/gcuqua4ayRc/oKC6JkQu4dU0hQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347905; c=relaxed/simple;
	bh=hadrz9JSp7yg9ztVwHgljWDj8VC53ZJi2PeMR4nTVF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nKN6y+xlcFF7eGmp3dvD+c8mUlOSHEJ1/g9iisM41hH8ymvKwX5lC4aNWSxPsdvs8pPriBZpU8ZCLO34GrilVdtDgmePl52kiT9VHawdFdbjHgDRooCvrxWhhfui5KvQ1QH3XS8F1vDQSWmpsfKnEnl5p2lPBtrFq503hQRFm9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HD8LR3Tt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e0b2tjeE; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HD8LR3Tt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e0b2tjeE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 915E514002AE;
	Thu, 12 Mar 2026 16:38:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 16:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773347903; x=1773434303; bh=dvpxCEdasX
	K4/PVrs3z+zo56IhJ+R9bPrjXwZ/FczJQ=; b=HD8LR3TtNkSP505ZaOPgF29iqW
	mmiozVXtgAgibOzf6LkEKPwT7jGwIzKtXZhJv+d1fROx0HSa3DsAb/CH2Vp19OLz
	1Ebg+g16hUJg2r47JQ975WDYtWnD9lYcnwmHNV5InBthjj99kTNobugdunX+BSOI
	56EY4bwWtIzywiAK73EgAWLNtL86K6BXmyDmrkM9gcGZ9DUndCfMuQYliQBLjCRf
	xG8EfF0ClKyiG1oPjATkV6oaYHIE5QSrEnFcxXMCiyDcyx9RJmJW0gDHy2Z+nAPa
	K8IKrQkmqDB0ZXtbUnzl+A0E0gdYVQGNS7tyrCOVkezWJm8DwHeYsAdkXpmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773347903; x=1773434303; bh=dvpxCEdasXK4/PVrs3z+zo56IhJ+R9bPrjX
	wZ/FczJQ=; b=e0b2tjeEHx3sf7Ct6VrsTR3FiHr57obxgUyqyqyKUdNWhymoN8V
	CzcjoxoQdg6XT7ypcotB4XxWYNv1E/y5dNklZTzEJfGTZkREqWagJxYs8HMzH3Vl
	DHJYwMtCnQ4rcaUEtHl6V8X1FikPLCPMktL7Xar07+UV8vsXEc+Vk2yQXviO6TWu
	pz7Z+fB1Zl98HaDhLgszWuK9zgu/4i3794ZzWacSq++gQ6vqBTqQKcgDzGXYDaIk
	mITiWgcEGXYxzLfxcLL9aEpSYIs88QdNTX+3CMnAOnze4A1TFYfV+o/ib63XMq4L
	ELGuwTJVSkAOq3TSuvBDNfM3ytQcx9jmTfg==
X-ME-Sender: <xms:PySzaYNVUpsBdo-Fuok8LgqRRCEdzc7OXT5gr1Q8D38CyxGMwlbjZw>
    <xme:PySzaV_b1OzO4TuVTS0GCwwomn7zgbn6FG8AUNg8Jkgp7KDkfBC1cgyDnAL_mwJ2t
    3Qh35x2yTWYKr2TQXulgBH-LwBWsFSHo-GS_SQGg0oZE-_B_B6mgA>
X-ME-Received: <xmr:PySzaUTPNh-lFVDY-hP_UNpK4n4wM96qeISJmqPfSXkpsPIqcEwkYRYo-LeGL6POPz0siF3scm9o8VSdY8i3tPlu5HyWVeuEgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrmhhuvghlrdhthhhisggr
    uhhlthesvghnshdqlhihohhnrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:PySzafllXWymFqsclfoJJXDlNHvE-qpr7Ey0mRg1yx1d6HQ1o6rbTA>
    <xmx:PySzacRWL6rBqicH0rzGnisPkzsJmfkftHvgh5tTHHnfDmD-t3DDng>
    <xmx:PySzaVNXYkFhV9bEsZGISSHFtFSxsCq1qbCgs5iOic6JYNl81K46Kw>
    <xmx:PySzadXTwjPjZUcb4LpziZYeqk76U4pOzXN0fbAu25H-XlkLBaR8rA>
    <xmx:PySzaSWhrfL4BxxHFXE5X33ZulnqdQ5I5XH4224nbP4GIfUmuQ1rtzJg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 16:38:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Fix GNU/Hurd build
In-Reply-To: <20260312191901.174808-1-samuel.thibault@ens-lyon.org> (Samuel
	Thibault's message of "Thu, 12 Mar 2026 20:19:01 +0100")
References: <20260312191901.174808-1-samuel.thibault@ens-lyon.org>
Date: Thu, 12 Mar 2026 13:38:21 -0700
Message-ID: <xmqqbjgsdbr6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Samuel Thibault <samuel.thibault@ens-lyon.org> writes:

> GNU/Hurd does not have a PATH_MAX limitation

Thanks.  clar folks might prefer to take it upstream and have us as
a downstream to import from them, so I'll forward it first before
taking it for ourselves.

It makes me wonder if an organization like this is easier to follow,
i.e., platform specific settings first and then catch-all default at
the end:

	#if defined(CLAR_LONGPATHS)
	#define CLAR_MAX_PATH 4096
	#elif defined(PATH_MAX)
	#define CLAR_MAX_PATH PATH_MAX
	#elif deifned(MAX_PATH)
	#define CLAR_MAX_PATH MAX_PATH
	#fi

	#if !defined(CLAR_MAX_PATH)
	#define CLAR_MAX_PATH 4096
	#fi

but that is a separate issue best handled by the clar folks.


--- >8 ---
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 12 Mar 2026 20:19:01 +0100
Subject: [PATCH] clar: compilation fix for GNU/Hurd

<clar.h> fails to define CLAR_MAX_PATH on GNU/Hurd where PATH_MAX is
not defined.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/unit-tests/clar/clar.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/clar/clar.h b/t/unit-tests/clar/clar.h
index ca72292ae9..4394aabbb9 100644
--- a/t/unit-tests/clar/clar.h
+++ b/t/unit-tests/clar/clar.h
@@ -10,7 +10,7 @@
 #include <stdlib.h>
 #include <limits.h>
 
-#if defined(_WIN32) && defined(CLAR_WIN32_LONGPATHS)
+#if defined(__GNU__) || defined(_WIN32) && defined(CLAR_WIN32_LONGPATHS)
 # define CLAR_MAX_PATH 4096
 #elif defined(_WIN32)
 # define CLAR_MAX_PATH MAX_PATH
-- 
2.53.0-707-gf7b889d8f7



