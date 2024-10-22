Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DC018DF6B
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631685; cv=none; b=Ve0OU+u8RIJckulemZb4v5405IPcYiN1tkL5ijbbANm+cSqLcSuSEO+bY2CIIXrimiKlPgfCaSEdTt8EJScX8V7VnMmAdTjv0OpTf3WZrGge76gcbIdD4b7Vpa4qn/gwSAmZ48QvI4C95INiLFRzcLP27GA/A7p9Q5vSAfPotmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631685; c=relaxed/simple;
	bh=JVU+E6hevko9479RnJpbXjJrhu4KPHhp3OxmOSiyv/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q85OA7g2FP+LXjepyOnteN9eY3Akf3RIj17SYHOaVkyzpbuGNWcF/D3HvX0CbsjgdQ2ZgLZmZQgClTxnjX0n3fw8h+abrW5eLbk6R0CdBL/HZYUJ6Hn40g9OPkPN47dE+/Ka4IlVuJfdF/Vvpr875Rj2M+2nOB1IwtPEPdY2S3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=swXiy1hW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pc94yhVc; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="swXiy1hW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pc94yhVc"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 89CD5114012D;
	Tue, 22 Oct 2024 17:14:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 22 Oct 2024 17:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729631682;
	 x=1729718082; bh=caN8fVzggnGCt9AEYeFUafltArNP0pu3hs6/hZQLkbE=; b=
	swXiy1hWZ0t4JHcVRF5Q//Un0zVeExayChTKf9jO4/p6MKIqt1fcoIVYVP7JFvd9
	GYpmEIMbnBmUFGFDh5Z+LV27QeTt52Qaa5baETWmm+/XpwCtU5ii9a/s6Mb6cLNF
	7Xo5ch6IkxRHvLHfGzW/9d3Vqe4ysy6jtea2GaGF/qvvk5CJGyiN5sHAUcMfvGah
	F0s+TtWqo54Shg1b0RizOgTw0AI5wbSmaptKt+3rWwUaI+vB61ytQMV6sVbvrEdg
	+pMXR4iap8ae6aC9bUNlJ6xmVbH/zC46pwPZqFoolPXjcM9IaKXSe1K8S60cn0uW
	7Q9Aaf2AB2LhcRRUkCSB7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729631682; x=
	1729718082; bh=caN8fVzggnGCt9AEYeFUafltArNP0pu3hs6/hZQLkbE=; b=P
	c94yhVcBcEjlCXN6Uvu0mwFLTNijhYxKzj4MWrFb4gQjJAYes43Piq4yIZO3mWI7
	+STu+U3kkaH01mfyVvQTkuRPiMy6zwPTImVbUDHpe2jgseVuPYz/nHZ7xArGROm0
	eMf2Y1hOHpY3gM2/p90x6UwLA9AZ/axWbORtZkoPM+qMIz6CgQvt6Vc+0AyjEWvP
	0ayRQsIMUI5oXCozRN3HmYvIBWmoVUrZO0Cg8ptimhIPxwLl/xjjuxHbmhcMBNiT
	oRIPb11q4/KcI665HZHDxQ79q2Z2ErQdWrSqISEHQj6Z18zOKAooLCgvKoVo0szn
	D7yRan40Us2Kkxs9wLDvw==
X-ME-Sender: <xms:whUYZ6wByiM6g6fTLVvYSzlFpSQb3GPTcRv85-EAJOiB4QCDrYAIqr8>
    <xme:whUYZ2RaCbVFnREg3uBvMCWHn0RDP-3R-8qabo6QU6bXquHNjPenuWCqarJ_dAVLu
    RaWgFLVibaXHvT5DA>
X-ME-Received: <xmr:whUYZ8WswX_KEUBuwKIFKiW7axtzAcCl57V74qdVaeHF49USp72Ap_nPEHobLnJhdQHGWXiRznrhv7jGFSWpr2kRhRWDyphoVNC_IzUUX5wSuqfkX13r-3Hfng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedule
    fgueeiueetkeelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopegushhimhhitgesmhgrnhhjrghrohdrohhrghdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:whUYZwj6LscQ7ExwSxkhAC2IklOCYYzhoKaYkJcmkzx8Mg4FEeCnfw>
    <xmx:whUYZ8BpR6-BJJHpEBIL9f2y6HdQwDsGp1WNYKFsEDgUoWvialzLEA>
    <xmx:whUYZxIjUUiON6PmW42hQxeOXuv5lV3rrOvwQ8lePLBlPz-BGwYcbQ>
    <xmx:whUYZzCsQxPyf5Dml1SrKNwibgFt27wbleEOsz84WgfzdqTuSHWjLQ>
    <xmx:whUYZ77Me7ZigJrGN8tO0jUN431WJNnYD55EXliamQ5v0zS-QtLj9s64>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 17:14:40 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	gitster@pobox.com,
	dsimic@manjaro.org,
	me@ttaylorr.com
Subject: [PATCH v3] t7001: add failure test which triggers assertion
Date: Tue, 22 Oct 2024 23:14:33 +0200
Message-ID: <c4ada0b787736ecd5aee986b1b8a4f90ccb84e21.1729631436.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <29d71db280c972c91174bd0a501af66be72643af.1729462326.git.code@khaugsbakk.name>
References: <29d71db280c972c91174bd0a501af66be72643af.1729462326.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: c4ada0b787736ecd5aee986b1b8a4f90ccb84e21
X-Previous-Commits: 29d71db280c972c91174bd0a501af66be72643af
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

`git mv a/a.txt a b/` is a nonsense instruction.  Instead of failing
gracefully the command trips over itself,[1] leaving behind unfinished
work:

1. first it moves `a/a.txt` to `b/a.txt`; then
2. tries to move `a/`, including `a/a.txt`; then
3. figures out that it’s in a bad state (assertion); and finally
4. aborts.

Now you’re left with a partially-updated index.

The command should instead fail gracefully and make no changes to the
index until it knows that it can complete a sensible action.

For now just add a failing test since this has been known about for
a while.[2]

† 1: Caused by a `pos >= 0` assertion
[2]: https://lore.kernel.org/git/d1f739fe-b28e-451f-9e01-3d2e24a0fe0d@app.fastmail.com/

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Rewrite commit message based on Junio’s reply
    • Tweak test description: less volatile.  Also mention index state.
    v1/v2:
    • It’s been a good while.  Let’s just add this as a known breakage?

Notes (meta-trailers):
    Helped-by: Junio C Hamano <gitster@pobox.com>
        Comment: Commit message is based on his description
        Link: https://lore.kernel.org/git/xmqqil47obnw.fsf@gitster.g/

 t/t7001-mv.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 86258f9f43..69c9190772 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -551,4 +551,16 @@ test_expect_success 'moving nested submodules' '
 	git status
 '
 
+test_expect_failure 'nonsense mv triggers assertion failure and partially updated index' '
+	test_when_finished git reset --hard HEAD &&
+	git reset --hard HEAD &&
+	mkdir -p a &&
+	mkdir -p b &&
+	>a/a.txt &&
+	git add a/a.txt &&
+	test_must_fail git mv a/a.txt a b &&
+	git status --porcelain >actual &&
+	grep "^A[ ]*a/a.txt$" actual
+'
+
 test_done

Interdiff against v2:
  diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
  index 739c25e255..69c9190772 100755
  --- a/t/t7001-mv.sh
  +++ b/t/t7001-mv.sh
  @@ -551,7 +551,7 @@ test_expect_success 'moving nested submodules' '
   	git status
   '
   
  -test_expect_failure 'nonsense mv triggers assertion failure at builtin/mv.c:502' '
  +test_expect_failure 'nonsense mv triggers assertion failure and partially updated index' '
   	test_when_finished git reset --hard HEAD &&
   	git reset --hard HEAD &&
   	mkdir -p a &&

base-commit: 34b6ce9b30747131b6e781ff718a45328aa887d0
-- 
2.46.1.641.g54e7913fcb6

