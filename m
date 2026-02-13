Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C521C5D72
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771004490; cv=none; b=eyqyyBzYwEE1Qakor9g5rde0N5nbJr/BQ/1rUpEhGNcEX6UXZNfCHjTg5jvU0o19NTa0HTy8WzGzr3MLkMLDiyKox7PsvFo/tuntPJNp2i5EI64jLCDbvIRcrD5cDQSxIodnXUPrmSIxVMfK0wXWhf2CSLYXE3EIYPYRMrYrQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771004490; c=relaxed/simple;
	bh=JHBlcLtzTJoBc4ou8ZTdsQVjVW1BCJol97G6I+KgdM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sHbflTJk7URw3ylLg9SxQ41KAe5kWbRleCSBKERkkj527/9u68Cekr8KQNpSoAq8PB03uaKjYkqBvVcVkLUeo1SevS332mTEs3HswfcyAdBepeDKa/8bw7MQWf06SLf9l8uvqmolOEyXulrkLJco9Nple/59WYuG8PFoJuBfeIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pvRSJUra; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=puK0EJtL; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pvRSJUra";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="puK0EJtL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4EAE87A0188;
	Fri, 13 Feb 2026 12:41:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 13 Feb 2026 12:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771004488; x=1771090888; bh=jfZ6CbS7Qx
	QSGa6d88r8DwUeXZzSwl6GBpBbKaKyVYE=; b=pvRSJUraT1lFDnyXYCmSt2pYdZ
	tZXmWzgoHulcJFyy9Iaiokp8dczWMAHI3RzRCBwC5nylx311dTR/Ua75O5EswFPw
	EgTDX5A2gAR3kPyqbRx7TTYdSR5O4cabZNPmMqKJI3Fi1x2PG5JqqB+yRGCIzFXf
	sp8Bdvo2WdLsWPuPm2Zm6jXFC2VZrkRbjvwXrvxRJzHQLHsCMmuavCsbGzKDzwyC
	6EsNh02O79Q8BpoLgQQqPCJmyDBZOj3S+zmyIspKnh1aIqPj4gkpVWhyenzQWl70
	u1bSnT9DFbfmwYq2i4Cvoq4FKA+rXm8pLUFkgy10fhoVpgHj4TigSkM/+4YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771004488; x=1771090888; bh=jfZ6CbS7QxQSGa6d88r8DwUeXZzSwl6GBpB
	bKaKyVYE=; b=puK0EJtLE20mllop8sJ7cHHH9g7xWX7GBp61wblulLS8LTKV0JY
	lEpXy2AQqXvJ9CnznTfHtTEYvvwgWp3tqcgaY25QWKlER3aFJEJCAIvW8i6Lr744
	XbJQp8OVJtJ1EWysG+iATOdnrZ0xuLaRppEooDXwQfOChPJS3YCgUal+8tMeSzzh
	p19BZNQdSkysr5qr5L1HtWu55vRm9H3kqSGQxWUKiHqZzPwsi0SuksKtluIOQqvE
	QlguMKizdvenCHlYNvlipDX0vNmGpZOlHv/iPNDAmKf1asgARKMz5Gp+FPUxs+EO
	YlQMJxd9Ecf7WiEaEQmLYltU1pv+IWSUMWw==
X-ME-Sender: <xms:R2KPaYUlbHH3eRF3llUwOiNEZDmwy5VozQHSrGSY7tjJsFtj3_TLwg>
    <xme:R2KPae17K2Aloss4P-wC-WQSjJ529qN_sjLxQ7qVsV53J0z8sRu8uA-ie3saEhhxN
    g_GU2i7yEAya99G58ghmga2WiW29Gd5RVuk6xUtOpEQ-Lt7iM0HXw>
X-ME-Received: <xmr:R2KPaeqNmrP8xUYpMjIvXc9gAAT2HL-WuGrF9Uj8y_54AwNMmvb6EK80algqWZAvrw4dVAXt1G-EO9jqjF5vtLW4zu-i4WGADg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmrghilhessggvhigvrh
    hmrghtthhhihgrshdruggvpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphihohhkrghgrghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:R2KPadUWtqLKdfIMuMtNgvjzw8sxO_7aSQg-GA9DV1O3QxvZOR64OQ>
    <xmx:R2KPaRbrG-rTLiUyYWagxc5tln02WJXzJ67vVHjuu8fnXMRhXJ9PGQ>
    <xmx:R2KPaSc8ruFw2j-br6TvvlrMPVT-RhufxmRffOVsPdM5Jvly_B2jyA>
    <xmx:R2KPaT0CCVvtyD3KpeYlFlI20XruNX_tgcjuJ9Hj7gjEKEx3BYBNxQ>
    <xmx:SGKPaSPxKdPzHxQF29zC4LkCsjv2Z7dPC-pziQ8G3vAm44ls-mH6zJlB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 12:41:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Matthias Beyer
 <mail@beyermatthias.de>,  Jacob Keller <jacob.keller@gmail.com>,
  pyokagan@gmail.com
Subject: Re: [PATCH v2 0/2] commit-msg.sample: reject messages that would
 confuse "git am"
In-Reply-To: <cover.1770993281.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Fri, 13 Feb 2026 14:34:47 +0000")
References: <20260206090358.GA2761602@coredump.intra.peff.net>
	<cover.1770993281.git.phillip.wood@dunelm.org.uk>
Date: Fri, 13 Feb 2026 09:41:25 -0800
Message-ID: <xmqqjywgmth6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This series adds a check to the sample commit-msg hook to reject commit
> messages where the body of the message contains lines starting with
> "diff -" and "Index: ". Such lines confuse "git am".
>
> Changes since V1:
>
>  - Allow subjects to start with "diff -" as they end up in an email
>    header and so do not confuse "git am"
>
>  - Allow "---" lines as they are useful when preparing patches.

I see some mention of scissors line that is also new.

