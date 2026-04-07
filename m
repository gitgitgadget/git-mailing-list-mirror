Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B93C6A56
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579044; cv=none; b=uhHWhh3yKftFS1eFzn5+iP+ofQchPsz1iwnPq/kMa/PJe0xetEqKjQSUHmKlIustHdEW4e7EhlXnN7MUeTJc/Z9k8D0EIb1aKg1yl5QfIuYuLxftY6Tsi6nZP4yyb9yUsVFYn8pNG+Hk2v4hpUTdZfb04Ca8CQnNpcKa8i7OYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579044; c=relaxed/simple;
	bh=k4KXNe5VP0X9VIlMApRVmP+KJqgjUa6+j23jy2q3CwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KZku/48OxAk4NPm89oUdJjULaqRKvpck6qMLAmVLF3sR1U3u3Cw1WUZWwxMG12bxXDh5zo/+NqrHxX5VdDhSUN9lbAV63YuwViDLijUpAV8XQ29Yt6deRzNjUAHxVqXfn33/loCzXzBc01N2FIOozMwp0qoaw37NXiyNfhEVS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ITLeFn0Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jaQrooC1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ITLeFn0Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jaQrooC1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D212EC0477;
	Tue,  7 Apr 2026 12:24:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 07 Apr 2026 12:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775579041;
	 x=1775665441; bh=z+AVn214JmWeqC2pOGHP7JqWmt3gcH0cDC6tEdh+qDY=; b=
	ITLeFn0QprlJdJTPevRBVrPTfWFGNyr3bA2rMwiLtFFVRYrghIWt3bmNji2rGZyE
	vjqusxnDk050CPt8hJLFJ/jQRSVYg25dWWKEHpcBYCFCFd03gbQW3KADtIsW/MMW
	xunJQm7tL+4lMr4Npz5gbetEsEo0LvF9LTted73qsuOVBbAeSjlqk/b2oyE8P6mP
	M8nm5z4js3yGhOxd2sIciQXia6zSDcfuOupnf71v50C5fcH/0Zgfvpgq99waTZIV
	uxc1Bz6ETlO2zJEfWd3vQsJHUqkY67Z4+DlrPeuK5HO8/uFAxHrnzOqnPHzLDmZB
	Zf9GgYOHdiF/28iyIaVnJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775579041; x=
	1775665441; bh=z+AVn214JmWeqC2pOGHP7JqWmt3gcH0cDC6tEdh+qDY=; b=j
	aQrooC1BcGia1yuJSNY2xHUXRs2CrrHxlzo6jHrVWhRY+yiLEV5DUL/06rILNecG
	8+HC26H0Bg+txNtsTjKznyCeqxgyGjFZGfN6QiZSXaoRWol4arDGx4MWCB35mjrg
	3ZFQyCTO0nOGwGo9QFkYI5wITSLXxQAvfB36PKOET3b2uhlj2AwGxuya8OsoM22F
	cv/l4UkRfZzxfrKzMx9SToqwSia1TZ8oqpLW+Zk+4VFeuEnHdKle238wrwmP0KCo
	ugif+Xb0hAgjEFccjcu2MWD0HHqNh0cWfEzV3bVz9ybbJJ88yvX4l5IPxbKgY+5p
	PFydWg5ySKd/JH7N6x1KQ==
X-ME-Sender: <xms:oS_VaTRcn7PeO0qPv_trBiLaEl7L9t3KycDaOELSks4NJkxA0nCSCw>
    <xme:oS_VaQSNs2JS2q-4ApU6WJHVKHu04Sk7AsnS9MW6lvHmUZtGdpfWvC0gvA2EI6DXE
    IfOn6f6DKYcPJeeSoox9XskgaBvGl_yFG3B11VKuXqJv9IGS7c1vw>
X-ME-Received: <xmr:oS_VafTMdVTj9AtqXTpRRIdw65fNgk9hvDJqyGai8P4oCZ0lh9J6vAV980Prt26sJFCTVnEfWk5Dl9rFM0x19ifEW-81cC2xkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephfetvdejheduheegleehfeeivedtgeelfedvffdtvedtudffieekieeijedv
    lefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjvghskhhosehstghh
    figrrhiivghrshdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtrdhvghgvrhdrkhgvrhhnvghlrdhorhhgsehstghhfigr
    rhiivghrshdruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oS_Vad44UYrcARlN9v48lSfAOythDO3fW9SfutPqv_ihjhAAYqRuxg>
    <xmx:oS_VaT0EUdJ_S1Bw_fxD-goKd0zCNod6-LZ2qGXDFqP8stN_o9O-xg>
    <xmx:oS_VaQDkwno3X2cdzLMJwx_Y68g5426zuxv2SFx9uL98WJ7vTQaPoQ>
    <xmx:oS_VaWNVRIWxnM7yOxIZOHkzEH6CwNHEORBgOKtE_dcoFFYn2tEeZg>
    <xmx:oS_VaVMGxsWPbgYnvAq1HSeQBjfujBmLZgB0dhR-c-yH1DvdMrx8MlNK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 12:24:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Jesko Schwarzer <jesko@schwarzers.de>,  git@vger.kernel.org,
  git.vger.kernel.org@schwarzers.de
Subject: Re: checkout: clarify "up to date with origin/" uses local
 remote-tracking ref
In-Reply-To: <5DFBE9D6-0EC8-4702-99C5-827AEF8C6265@gmail.com> (Ben Knoble's
	message of "Tue, 7 Apr 2026 12:13:27 -0400")
References: <xmqq4ilm7q1n.fsf@gitster.g>
	<5DFBE9D6-0EC8-4702-99C5-827AEF8C6265@gmail.com>
Date: Tue, 07 Apr 2026 09:23:59 -0700
Message-ID: <xmqqpl4a68o0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

> I seem to recall a recent (last ~6 months) thread about “last
> fetch time” and there being some question of how to record
> it. Alas I haven’t searched the archives to find it.

Is it a bit older thread?

    https://lore.kernel.org/git/xmqqh65b2ci3.fsf@gitster.g/



