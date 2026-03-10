Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7B3C9430
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177649; cv=none; b=oFjwV9g19G43F8iplqeLLjIsSV35k9FpnN92etrGg0yXe3EPzWs+hno4T9b0berHOn6br5QFngy+q39hpSlDVIYm3M2W1sn+BND1vAK5GA2KJgfMhh056GmQfl6X6mEtWHwSmAQpgbdGv/ZX3TeWaEuaTzm5q2QO8qnkir/wOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177649; c=relaxed/simple;
	bh=uNjoReKZLd11yKA5nbYxpfrrPmBwnFvuUReuy91ZlOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n27MKbyg9DJzxv8DAKILum3MkzCEJqFMOf27lfv4QyHS4t/BpgLHlcr257c3r8DJxZbAI++VPZKlr//aGLN5gmdmh3wryQS49C94j6MBXTHKTc6683fpvqjiwRRjajrO65SafNByzvnpsb2hwc7TgNFyqI+ijglxk3ahoyqHqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RXoPh+H9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CzTUc29B; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RXoPh+H9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CzTUc29B"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D49EEC05C8;
	Tue, 10 Mar 2026 17:20:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 17:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773177646; x=1773264046; bh=vJ7TgtYBbK
	gyPtOoXAi6mfOzj9W3QRPyQr25IclQlJA=; b=RXoPh+H98wYZ2Vh5DTAv0QyT4T
	wzdH2u2TOunRkTmOy+rFKWidfZuPEjwKSk6aykcURhxYjH9mbQLq7QQg0GPrS5/b
	ewOtCVNRQdyfYng6uWEOk7wctIXKTWa2nQn02VsONJrtPw+oEOM1sused2MTdNRH
	IqcTRiAMznHwH5tOgQQT5FPRD041abjhnP+Oes2rP5sooAS7G4fzaQG7MaeJRwA3
	mNUVI7qLcoZ4WJSW13Rw7w3owm70qMnG3/ZTziN7TInti3gSneqXekhFh7pRsiQb
	8XMLQD/PYsfkvRLYYD0TE+iAroj8ptHE9urXy7X/C07+Fol4ZYMzEV+dJaDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773177646; x=1773264046; bh=vJ7TgtYBbKgyPtOoXAi6mfOzj9W3QRPyQr2
	5IclQlJA=; b=CzTUc29B94MNlEGp+0YkOv0hYAZWsyy/PK9Z6NTtVJlbX8573gX
	F101aIfF0DHlNiazDiRAK9HIlLmuH/J84SzbNgYNonhjSr/0foKYtRcQysrISFNH
	oVaU5L/o5J+jPct7sb34IrIlAGgvxMg4CuJcwlO7BH4e1HORiGVJseQ6IlXuIoyQ
	8TeDCaRdX9TCdCTMUqJRtEX3YUmv8UOso0Tu/w+AmXEY/Ivfdlu9SbIB9KW7DkTw
	bBtvzMZ1eVVBDvxJSmRQAZCi66qLNYxpU4hkqmPs2ilgs5x7ltjRJAqxHllsOv5c
	zI9KevCmt1Rpa7c/e+NcYDV38BXfhNtqPOA==
X-ME-Sender: <xms:LouwaS9fMhL7NelSVrVGXq8EqEqJExgWmDYR9bQ3vn7wVVxpTIdcQw>
    <xme:LouwaWYCvHk5DEL5lbjJz2ZnNrCxczjG8wR0J4QM_AxcpeBoUVM7Cy9mIjBj9w2U8
    B6zVEeKa-mdbg-1zd8RK6Lvd0ctIbie3OC69aCAMUwTJ61hc49Y2A>
X-ME-Received: <xmr:LouwaR0EALJdL9ArY-majyzvl1St0S7oNR2CHofMGgroky_VHzo5Y8AcKxU13oHoqrdvIaRnCMj6tPlecYKxJpqSVtykhESIMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LouwaRY-XaJA48ZjsqbdB1EH1VIFW4q1cstu1a56ZCe8Q-tJJzi-wg>
    <xmx:LouwaZICOZ68gEwxq9iCGZ9j4hZ_HgipqCIEpVs6rUm9RhBXGwjK6w>
    <xmx:LouwaQFjXSD-Nv1ZBHU6h50kaSRQdXMFhDT5eOmHKE1KcEuCDmSCsg>
    <xmx:LouwaQuEqt8Q2s6ZiwBPMx0U5vLB_ML5fl9pmHwUMfvhs8osCJyaiA>
    <xmx:LouwaTqbw-1Y4Rzt17StHhGT39N61or-oU_opjVKpJwCAqhEBP6KSHcR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 17:20:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net,
  christian.couder@gmail.com,  ps@pks.im
Subject: Re: [PATCH v3 0/3] fast-import: add mode to re-sign invalid commit
 signatures
In-Reply-To: <abCFKEHxu7OZr9bm@denethor> (Justin Tobler's message of "Tue, 10
	Mar 2026 16:06:23 -0500")
References: <20260306205359.1723254-1-jltobler@gmail.com>
	<20260310201116.1130160-1-jltobler@gmail.com>
	<xmqqv7f3s93l.fsf@gitster.g> <abCFKEHxu7OZr9bm@denethor>
Date: Tue, 10 Mar 2026 14:20:44 -0700
Message-ID: <xmqqqzprs7o3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> From my perspective, "re-sign" implies that the signature was previously
> signed, but we are now going to sign it again. Indeed, the resulting
> commit signing is functionally the same as if the object never had a
> previous signature though. Also, "if-invalid" already implies that the
> object is signed, but its signature is invalid. So it could be argued
> that "re-sign" is already redundant.

Yup.  if-invalid part indeed was why I thought "re-" was redundant.

Also, if a project is redoing its history with such a bulk
operation, I wonder if it _still_ makes sense to tie this re-signing
to the --signed-{tags,commits} option.  Adding signature to commits
that were not signed is not covered well with the
"--signed-commits=<mode>" option.

A project may have required that all commits and tags to be signed,
in which case "--signed-*=sign-if-invalid" would create a new
history with everything freshly signed, but if the original history
has signed and unsigned commits, and if they want to sign all the
objects while rewriting their history, they may find it more handy
if we let them do --signed-commits=strip-if-invalid --sign-commits
i.e., drop the invalid ones and make sure all commits are signed.

