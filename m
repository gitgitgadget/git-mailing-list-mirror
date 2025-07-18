Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056415E5C2
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752860173; cv=none; b=Q+Y1V7p6KeLKsWFl6bnqGzf3zmP2F3NfJhjCw90+pvmjRNqN++KJMw0/y3sI6qNSCOOC3RMNopKLL/YfoX5hXwMTx9FZMw39SwBUb6IyUjc0MTlz7GyFsgN0Jyo28ADCsEZV5tUKpnAvtS11XUqbmoMkSl9nm0tgrrwodWJxE70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752860173; c=relaxed/simple;
	bh=vBLk/FHzr5bhewnor5VaOEN3KBMXPGwdyV3tKmeb5mg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPCwI4XoM0fBHyUt81w1ayjVlX6ni0SE/Z76OB7omjMp3KJzeFqnyOmkhFd7DO120jSRzLnDp0iPQ0poMMWLUSftyV/KmfkT/3+IGGu8dLgJCWJQzzFuSg78D/RpXV2hRJF4ZbXoESUkO7DK6SEIZhNLUkil/SQQ+LNlpo4eAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P2he0MeQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LfTAyXne; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P2he0MeQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LfTAyXne"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 932C17A0110;
	Fri, 18 Jul 2025 13:36:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 18 Jul 2025 13:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752860169; x=1752946569; bh=TI1++8i0Z2
	Y7ttvvRZCVPlkQzgwbax5MCC1E7GtuX0A=; b=P2he0MeQMq+kRYgFtFRNrgzDg4
	1IlLZjDNdh55VYlV0LfFAYVyHGomeh8OXvKxahxuXWlFQrtB8lZgm/+HLeJbS6Vg
	gRXGmk9xlbGDmt43PbiwKKoefQfcpvS747BLQT53El+rl7OedeHBGNjUyWFIGZl9
	j0pJhI9HWbSjoAJkzfI10boMqcZz+gB3zw6lMtK1isBxMwYz4pJZn4bcH3O9Dqp/
	3C0nVF9slIUbFJJNJktF8MFrDyx8CaaXCC7oIbzuq/Zpq1IqIzrNRs5Hhg60pDps
	hfZUAyqwvYpkhxlnm1HAEHecdvSAZmFKpZRx1dE7yzvpCCJ1n6310/FKcLBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752860169; x=1752946569; bh=TI1++8i0Z2Y7ttvvRZCVPlkQzgwbax5MCC1
	E7GtuX0A=; b=LfTAyXneBytId7qRcYpqGUYWvDjMSDDoqICWlniLnhWI81V/As/
	gGUkV6hg1c2tzir3dvL738e9PsIp/aOMUFrwXy0BY+Qbs+CHKOLp/oxivkmgU9kX
	HKxhhkhbNzqwl68r06zBlX4RT+NDMSM9E+0qbucSk33Ke2hCW88nJy4vF8pooAhg
	8FbLuySyw4/Bhlm8EIXIKXVqMXatczD+pioNHJa/d+CQTu19M+E/UglX/WgXbhpV
	lsk4vozPeeaEpu9Q+KUz4V7w7OVOOOdO60eySWG5k2AyP50+7FAuy+07Owt+U+O9
	Iud33fEMURd5hR76tl2QKHjEHGjldBOxAxg==
X-ME-Sender: <xms:CIZ6aDF8IzHh4ij_bRLPxS2cevGWwJYC9yCRB2PFngqWSCuK7aeTOQ>
    <xme:CIZ6aIxBnxErQJHBouvKBgLDedwvd8b27_lIEUQv_-lZVciQ2TVmbFhS3aU7uXfNJ
    IEsZ4uPqfrXTbmnLg>
X-ME-Received: <xmr:CIZ6aFkgsE5ZLEfTe1TNOp2P-Zpu_5sfFN9njYgW6w-k_W_I6cLkEcmMiFWaq9t3iTbrAHTmRgcwUm1beS5Rujx3Ox0-tnFyaL3A4W4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CIZ6aBmLjyTK7bj8uvYUJyVVstbEuoBsf6STPVk-pfk84mhXQ-Vtcw>
    <xmx:CIZ6aHzOUgD0eqpfRhCI6LrU6GyFHQyOwxd-dPXXCWKLmuU967S3iQ>
    <xmx:CIZ6aGrJHXm1vfqIRH1WHQzHjPEpU8oHQsF-OJiuEVI3SEaweE2eXQ>
    <xmx:CIZ6aG4CKu3copScx7LmFxdCuBEBcwevaotMtS3C6ipxOBt5NQVAcg>
    <xmx:CYZ6aFwp2Huj5llhKJ4ocfFcqw7QGfgxTKhOevzVU59UKVj5Nb-pkwJT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 13:36:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Derrick Stolee <stolee@gmail.com>,
  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 5/6] last-modified: support --extended format
In-Reply-To: <xmqqseiu4f6p.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	17 Jul 2025 15:37:18 -0700")
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
	<20250716133518.1788126-5-toon@iotcl.com> <xmqqseiu4f6p.fsf@gitster.g>
Date: Fri, 18 Jul 2025 10:36:06 -0700
Message-ID: <xmqq5xfp4d15.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Hmph.  This hardcoding of everything does not look easy to maintain.
>
> Besides, the test will fail rather miserably when run with SHA-256
> hash (e.g., post Git 3.0 where the "git init" command by default
> will give you a repository with new hash).
>
> It looks somewhat inconsistent that tree is shown with its object
> name, but commit is not.


I do not address neither the first point or the last point above,
but at least something like the attached patch needs to be squashed
into this step to make the SHA-256 tests pass.

Thanks.

commit 86a64ae7a4b866db0f17f906ca5be95333d907ab
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Jul 18 10:33:58 2025 -0700

    fixup! last-modified: support --extended format

diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index 008ea708ab..e737cb2505 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -6,10 +6,12 @@ test_description='last-modified tests'
 
 test_expect_success 'setup' '
 	test_commit 1 file &&
+	TREE1=$(git rev-parse HEAD^{tree}) &&
 	mkdir a &&
 	test_commit 2 a/file &&
 	mkdir a/b &&
-	test_commit 3 a/b/file
+	test_commit 3 a/b/file &&
+	TREE3=$(git rev-parse HEAD^{tree})
 '
 
 test_expect_success 'cannot run last-modified on two trees' '
@@ -49,10 +51,10 @@ test_expect_success 'last-modified non-recursive' '
 '
 
 test_expect_success 'last-modified extended output' '
-	check_last_modified --extended <<-\EOF
+	check_last_modified --extended <<-EOF
 	path a
 	commit 3
-	tree e9a947598482012e54c9c5d3635d5b526b43a6a4
+	tree $TREE3
 	parent 2
 	author A U Thor <author@example.com> 1112912113 -0700
 	committer C O Mitter <committer@example.com> 1112912113 -0700
@@ -61,7 +63,7 @@ test_expect_success 'last-modified extended output' '
 
 	path file
 	commit 1
-	tree f27c6ae26adb8396d3861976ba268f87ad8afa0b
+	tree $TREE1
 	author A U Thor <author@example.com> 1112911993 -0700
 	committer C O Mitter <committer@example.com> 1112911993 -0700
 
