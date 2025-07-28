Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F426B093
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715383; cv=none; b=Fh+l4Z0Tev8ALlVXZ4LfC04IR6GMOnCi/qeld3N0Ul0MXtxhHp4FBZHUa0dcgXHEb5yXKDX4VsvHkBOHUjNQ+kXJycRy7RqELEokLpRU1Z7305SLVDxu+fFWRBGnzUgKi59C0FUJNqgR6CQN1A0a/X+GDQJIC7RNw3IIKZkAOSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715383; c=relaxed/simple;
	bh=gd4sPmfRAoHSHv56mVl9Ea5OObYilGMVpQ6Uit5H7nM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E9/gL3bxdPjQm6VjbQPIzMHLBfdqNnA1pik1lU9dKcNlcJ0ZYpECt1PUwbD5LJgUxGXwxT1GVn04z9ZuG2VeQO1guGoxQREur2f3RUMF8m+mXE7+Bujv8qFxH2P7dxiCu4RMnw7QRlsM7mYEaYvwXHgdlW6csCq9GRtUcfahx3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MjpAXyuO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K0gXe0he; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MjpAXyuO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K0gXe0he"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id AA5DFEC11DC;
	Mon, 28 Jul 2025 11:09:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 28 Jul 2025 11:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753715380; x=1753801780; bh=7YDq7PkSZq
	8JWimy50AQ2qJO0qxbWoMUzKgYAtSMI58=; b=MjpAXyuOa2D01uQlZ0PPPrV8AQ
	8JE/e4oZczewIWUb9sRmoZBVTl2q0E6b29t/J3UhkXfnm/ovO7wKoaTCLb7tLB9Z
	7kzJMk4Y0fCoHprIIx3UkA85Ko78FGN3eC0Hz/Q0pbCcCqeH20idkiJFHTOM38Lk
	+wGoXL292BfFZmyk9ENgOk/O3ULd+ReZsG0AIh6Lz92YWS3NQOkhCEaL1gONn2kP
	gdItbM6U98kjR4a/QX9mk6TxoMcjmMJkD0Szvd5Aze4jzOmcfrIGoF6p4znMwVxW
	/bBzTWAGauwoehGfBKBFDKsG5BC8eOJeS8pkHDklMo5IYbKSHSP9FRjOZMSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753715380; x=1753801780; bh=7YDq7PkSZq8JWimy50AQ2qJO0qxbWoMUzKg
	YAtSMI58=; b=K0gXe0heouqdUoYPlSyhIOGj7VHecpAhHu8pMAZ4f7mtzKBPMAu
	/MK3+/sRJUu9o9+YClxOcP9Z+tGBLAKzmermwHn0cegHVmUKVfkicpsZvg8eslQ6
	uzu30+mDhieAAVlCH/0nXAsy7dbxL34Y+S9kLNCC/89m8OE4CaOg0pHifEd+YzL3
	70hyKTOrTb/qd2lxGP0ghcvlTJbhRcWL1HaKatPQYyW9Vh/Ox6jDbvgZ41FggMgo
	nwlvVb8rrzRjO5cniAwb2YGKKynLNgyohUFoXcX9dAQb0slwlxLsaf6gu7KbAiP6
	6gsIConsJyVMreJs00QHzhdmjP5WFHYMYnA==
X-ME-Sender: <xms:tJKHaFlqtCOJNdP0-Vgr3H41L-tEyxmUwzn01Op5u7KgKbVmIUO_mA>
    <xme:tJKHaNz79Ra8ASqWQ7YkGlewNi6dkl2z75PxbxJv3gwG52MJIqn5fChfFedQr2WQ4
    COuzKXpxGkjNRgncQ>
X-ME-Received: <xmr:tJKHaHQCvTKbKQU8z86p-_FZP95Mk-bYKZkvY4T8CiJ1tLvdg3UOUvSlJukXO6Dvufki6jlav7tYBslN9wmIyyXM580ulv4llghQZ3k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrh
    hishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopegthhhrihhsthhi
    rghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tJKHaN_R3G2jQxQbz9zJzGXxu6v-I7QeeYimvlScF3gNpr5UNbQ7cQ>
    <xmx:tJKHaNuz3-eMOSUaAvZHc4jg-hpxuAd7CQm9mq5k_HawI2KoZ9sx5A>
    <xmx:tJKHaNOmffA4ZuT7CekbfvVFEybW3UnsW3MqDskNvzl5z4Cj-LU3_w>
    <xmx:tJKHaCh6mUBIHchxwSRKYi9_lVZV2BJeWdYTv5yWyPZkG10cfS1lxQ>
    <xmx:tJKHaBzv3fYvnuhXGultKeX6Ec8MPin-l8FtIuYOn0YvPdX707i0DzAJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 11:09:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org,
  chriscool@tuxfamily.org,  christian.couder@gmail.com,  me@ttaylorr.com,
  ps@pks.im
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside
 a repository
In-Reply-To: <CALnO6CCFXfPDZKzx1SBufwzkBJchZr0XYigo_8AQ_U=MuJa7xg@mail.gmail.com>
	(D. Ben Knoble's message of "Sat, 26 Jul 2025 10:37:33 -0400")
References: <xmqqcya63cqx.fsf@gitster.g>
	<20250721115519.140361-1-usmanakinyemi202@gmail.com>
	<20250721115519.140361-2-usmanakinyemi202@gmail.com>
	<CALnO6CCFXfPDZKzx1SBufwzkBJchZr0XYigo_8AQ_U=MuJa7xg@mail.gmail.com>
Date: Mon, 28 Jul 2025 08:09:38 -0700
Message-ID: <xmqqv7ncxsgd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> Sorry, one more thing: I spot-checked a few of these, and it seems the
> main issue that causes failures is the exit code; they seem to work
> with "-h" outside a repo. Out of scope for this series, but something
> worth tidying up as #leftoverbits ?

Great suggestion.  Thanks.
