Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3A3ECBCC
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119425; cv=none; b=h0s7ov1reriwBVvD1h24c/G84LEWzkzYwqQ+umnUBma7tonitqXs2eYDVLT1PexgKfoLHk6bwMFzFl1LPmwRhFX4hPsTKYw3kyHkaz8eIsPshQvJgsnkaKjz1zRMxksipL2nlF9rMlNAcJ4tx3xa+nlrVbffZ1z85oDFz/v6TYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119425; c=relaxed/simple;
	bh=IxHtekbcABV5mdyubw00ICPj/wGjKqcYxK7ytzIm2us=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KmYufpgXo3QcHnwFYA2E/UpX+W2+K8E2Akzg0fkgHOFrFp1T2GQW4myMMp/MiLO8gJcWCe8PT9Jvf8wwF1Vw3UqYUt+gB2SBEsa8GygdH7bXNO2VvEOyelH/raio1L/a/O4v2KWXWuLMSY54+sbQKdyNBwQn2X9WXlULVYntf/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ARbupMvv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hs9Vg7Nr; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ARbupMvv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hs9Vg7Nr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 10761EC05B3;
	Thu, 26 Feb 2026 10:23:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 26 Feb 2026 10:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772119423;
	 x=1772205823; bh=jXydYiJl8invPvS7jUxXaQeTMkClMADzGxP9xUNKI6o=; b=
	ARbupMvvpMaBDz1S38y2Vuunw7IX8DWkdjjRapvCLUqJag2+ggJVrJ3ufzq3ZTSM
	HRUpX8T0rkB0/NpoQCfMTFWDwBJhsozpQVbxQROfTttTERS5AM9mqOM0ET121faG
	Quzv+UcdWq4/zyYA1s+pIwM5Oz5Mix1NvqePv/6JHF5oH2HQMZy2vl6JmxdjsTHB
	qJx5W88/BkEcH1AII6rL5nNMj54ty//+YiG7Xq0rdUBfLBv4oZfLOHVz5ARFzuHU
	1LGgpUiDETO9fAlWWYLx4cvGixT1YjmHWtirjvFGo3ee7FlkdhoOuVMKBJyCquEB
	D72mZOHIagjpnt3rJN9KzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772119423; x=
	1772205823; bh=jXydYiJl8invPvS7jUxXaQeTMkClMADzGxP9xUNKI6o=; b=h
	s9Vg7NrwtyL3nP86aSnC/gxkEu5ANtzHK9cJmkwfvNU4K3mlVPLq1fFvM/4hsDyM
	ZXIsNkJVo7GS8W1v3IsuYuTasuojb1FpwL3ZmOK99R9BlSwSUXiqOPkOdIu7gWuq
	y/WkrEtaAEXnyRQE6HkF5G4x76n/tkeZ21EmufMKeOqRaB46nlrfmXBGI5wJD1Wf
	xa2d+9EhMwTAoF6Xu1LYXfAoGssRck7NLaAJPDDDrqAalOILIIXJKJIVP6e7zNBP
	d26wmSAJgElNmfewhJqiErQ7rCsRoKVjNtlQq7eBmHWVzRzyyo1X2IypnDS5w8K3
	/JX1nwu73KlCx5HkOww2A==
X-ME-Sender: <xms:fmWgafwUhGY51AP5lKEHshenuiOpU0mWhDr7m4tc5k9PnBTHcBcPbQ>
    <xme:fmWgaT0-M6nWC3ZO9aCGnid5QGGK_rf8ypnQHGeOylWB-N1FpT1N8m8hfYi7H4yTT
    nWzZHl0EH7dvUqXcpX4N_SSvqgdVMgVMzZGwNyTyZ4PcM5aEJtg>
X-ME-Received: <xmr:fmWgadyGns5HHNC9gBnQGUg6dqyqqFOnVDT2A4uDdh5izgoTcPzu9m-FG7cWU-DI_95GhCTDrHi0AgYkVRLUpyWofyVPZGQlOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeifeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepsggvlhhkihguleeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrghrthhitgdrshhivhgrrhgrrghmsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:fmWgaQUV7rGd7IhSV28_mlLNESVXTAvbGAxpb4xnRDbPTqFSEyoSZw>
    <xmx:fmWgaR9J-7uPm7_N8AsU3V_Ze2sbJbUjzD1Ky0hZRZNDK7CescbFNA>
    <xmx:fmWgabtzRvHk0vnNnoQbaMGgJSXtfuMP9vSEJno7trMKiaG4uIZvug>
    <xmx:fmWgaZ2xHXXhrbuFNcAUhPO_Aii_f0mGDBWsQMnaRINRj0ORdqKFaQ>
    <xmx:f2WgaTX9O4vx255PQFDIyyd7J89-dnCbxHhwKEEKj5HX9stndHCHr0Tc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 10:23:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Olamide Caleb Bello <belkid98@gmail.com>,  git@vger.kernel.org,
  toon@iotcl.com,  phillip.wood123@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com,  karthik.188@gmail.com
Subject: Re: [Outreachy PATCH v7 2/3] environment: stop using
 core.sparseCheckout globally
In-Reply-To: <CAP8UFD1c5JgpQwMuTPE-VWS=7-1Lw7mWVaGGXCPwaG5=VYhk2A@mail.gmail.com>
	(Christian Couder's message of "Thu, 26 Feb 2026 13:57:45 +0100")
References: <cover.1771258573.git.belkid98@gmail.com>
	<7d33f1ef0f8182893d63d49b350984025ab757d4.1771258573.git.belkid98@gmail.com>
	<CAP8UFD1c5JgpQwMuTPE-VWS=7-1Lw7mWVaGGXCPwaG5=VYhk2A@mail.gmail.com>
Date: Thu, 26 Feb 2026 07:23:41 -0800
Message-ID: <xmqqikbj5y0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Feb 16, 2026 at 5:39 PM Olamide Caleb Bello <belkid98@gmail.com> wrote:
>
>> @@ -670,7 +672,8 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
>>
>>  void clear_skip_worktree_from_present_files(struct index_state *istate)
>>  {
>> -       if (!core_apply_sparse_checkout ||
>> +       struct repo_config_values *cfg = repo_config_values(the_repository);
>
> Nit: it would be better with a blank line here.
>
>> +       if (!cfg->apply_sparse_checkout ||
>>             sparse_expect_files_outside_of_patterns)
>>                 return;

OK.  Agreed and locally amended.

Let's merge the topic down to 'next'.
