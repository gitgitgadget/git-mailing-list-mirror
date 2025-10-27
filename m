Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B82FAC09
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564853; cv=none; b=eHUGpdkLD/LzIu5tQ4OgEXE34jl77QgYcAyY95IQeRY3rN2Ur0onL7+qZk4pNDG89CL7QJC2/py+e8wxg4EKocpKg/zy38TliL2Wlhk1fTetgnoG+tg+mMw/8jIwyratjJsy6KkDDeioAEJ5KOEH0u//2Gl0roNPgcU+IDBwSiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564853; c=relaxed/simple;
	bh=3nr2+2zYs22DuwVGumuJZ0GXdxh7427Jd42+D7A3Vns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dw/uE063N2jtvZ5iO7zorNzKoEGsbZCvzIYtHjUor3hd+pHO4pG3YzV2HILYYTm1CNsxFT+Wk+9cZP2/vYE/7XVHhbH8FaoBVlffG0z6Tgxbpf6S3u0Q285aMGTd30lWgNC14U0mRi0X0xCPBog8F/AZXMm1zkuq6wDiJuN0RmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QIX1V8PQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=db8BrVxc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QIX1V8PQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="db8BrVxc"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C947714002EA;
	Mon, 27 Oct 2025 07:34:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 27 Oct 2025 07:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761564850;
	 x=1761651250; bh=m69RYVHPBK+qQts78hvVrrOAF9qHKubBGgqUG/HXXNg=; b=
	QIX1V8PQv8y+VRMpk4d1fq4zaKlLPUkVnCMlnQXFd6s+KVUPYZ9y4w/iUDafgRFf
	NcScNDsg1OKIcGHJgMqVXrMWEvp4LcZ0cKRHoU0XZ5dUGnwLCn50tcfdRzJYVS9q
	CzmUpC+UUFnAAeAM7xk6kfSoHZ+j2EzrlkpOmPBaOZxbej0sKNkme13dovGodc87
	lNWGOPRI9PHkgJZ93gOWV39PDeaYnnIx6FkaxE73cP4JKhXhaDfzZXUQXVthfPZj
	mJu5JM08xw4AU8UUXbNDgDYuCGrfTLcQrWvO7ww9Fm3S7dV+phe0PC3LIA9U+Nhg
	o2YDuXoNbJUAPaSbzVa5Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761564850; x=
	1761651250; bh=m69RYVHPBK+qQts78hvVrrOAF9qHKubBGgqUG/HXXNg=; b=d
	b8BrVxc6zrULpZo6cctgShqDdsF7AQyNd8g/2+htkDvNUkXxUfq7tOSmY92Djr5B
	AKwIqgcoppzMbHUId9dOWAG/ZQPV57CWt1tzvfQ+Kq+kCcigfV1XVb/Nb9CxFXsG
	fyd+DQmzEfwrESss37Mqw4Yuucib4ALsKjee6ZP7sWvkAXR/wuRjQKV694aUGOA5
	hilsl2lgF4RI6UuBsLYPgx04Pop59WokmaJaCSNe7E7L+jnHIePOWsk0d2LJZGjE
	l0TcvJVGeYOFd6cUaqEr5a17NnFHKW8xV4Sdp7ougz8drRGVrS2szsE3BlgvZ9Eh
	LPHCjvJPj26AW2cMvRCxQ==
X-ME-Sender: <xms:slj_aIvkZqBSYv4k2Ba13vSjTWxjTBAk5njCxcZq6LLYeMS4FrKoew>
    <xme:slj_aIAR_CnloOvuN3VFItuXJdZ28PTj2qCQVeb3JP78ukT0BSz16K_lyBNisQ1pP
    EAcnoHcHgnSfd48kftzrACiyITyX9KT3q3Chs4j-HcwN3sOYSwq0A>
X-ME-Received: <xmr:slj_aHZIKgH_yK6ETXQy0k1wM56tyZHxnX_r70ookC3VM_Cccpn7zEZZpUtI186C-7CsnJGIiyJS7nY_57Wncpy16oAHXpYQ_eF5j4FZsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvh
    honhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdr
    fhhrpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:slj_aLWTb6pN8jf91CB3dON_UO4RCF5eua6Ng8TuhoKn05-rZMwjZA>
    <xmx:slj_aOOxknLfoWCwJx27U-wlhW7We_efW8W38_lDpl57cA2O5-TKdA>
    <xmx:slj_aNZlLX3aBBpvo6J0jBwl-0SEIvz68sQg3lEiAKtXfFhZMNzs2A>
    <xmx:slj_aF-cIVQZnUqdOLWQKB8OCE1P0AypkdkH1jfAKJsy_XfSkS4sqw>
    <xmx:slj_aA4Z3G9m3yXLmKF0Y1xA4fAfrUkECRP7PWd-ZME6KW0l0mAktq8E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:34:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6c5695b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 11:34:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 12:33:51 +0100
Subject: [PATCH v6 03/11] replay: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-b4-pks-history-builtin-v6-3-407dd3f57ad3@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

In `create_commit()` we're using `the_repository` even though we already
have a repository passed to use as an argument. Fix this.

Note that we still cannot get rid of `USE_THE_REPOSITORY_VARIABLE`. This
is because we use `DEFAULT_ABBREV and `get_commit_output_encoding()`,
both of which are stored as global variables that can be modified via
the Git configuration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/replay.c b/replay.c
index 98be33b854..58fdc20140 100644
--- a/replay.c
+++ b/replay.c
@@ -62,7 +62,7 @@ struct commit *replay_create_commit(struct repository *repo,
 	obj = parse_object(repo, &ret);
 
 out:
-	repo_unuse_commit_buffer(the_repository, based_on, message);
+	repo_unuse_commit_buffer(repo, based_on, message);
 	free_commit_extra_headers(extra);
 	free_commit_list(parents);
 	strbuf_release(&msg);

-- 
2.51.1.930.gacf6e81ea2.dirty

