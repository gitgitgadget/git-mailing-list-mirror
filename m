Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15361142E77
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938672; cv=none; b=V3bRQzNvysm1QcdQQL45R3ADoLQ8cH/NNXo5Y3imYn7SvYaaenZYfWFYK1+oxoV1tzUzQcK8yNOO6+rCxOz3QOZLOhZoAeI7/O4rPnL/uPwXAsbU7/Lb5pG6L0Z2HN2YqODrg3Lz+7tjrf7EP7vsTOf2UjK9kHSgKlNFzeekm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938672; c=relaxed/simple;
	bh=T4Z/aIlXQM40eYAdWaE1Tbo1Qzv3/1rwFTQdYJxBJ+s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7GxHF39vzyyLUfRsVzq3ERpCKHoUdBGzNxlpTyrkj19isWPu5KE2oBs/JcD6NT/6X9cwrCooNXNymbprDfDTeUfeCo06YKk2D6WiZdqNgUmf5UaUd4v12drAL6cCICLyMuZOl7fp1DftdUioo8+BSKTGhIHJeiZKTBkYxq8xEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O7PmwoHZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H1tEqNrl; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O7PmwoHZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H1tEqNrl"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0508613805D0;
	Mon, 14 Oct 2024 16:44:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 14 Oct 2024 16:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728938669; x=
	1729025069; bh=XPBZwgbGBh1Q0CSgpG8314GukKjnlYCvFZYSi+12CVE=; b=O
	7PmwoHZK+8Xl5CN2KQTuiyVrHUg+RY1fNGsz5sxuuCG8JiPSUOM4wq6rY+JUXVGK
	K7oeHpNdZ1BSor/KPePy22YsoRbYOS86itOOliOyRL/GQZWLxyfaK7vjUjm7hRSa
	HXHB0/C9pZ8Shq/GIL8TsB0LGVyvr389gTkWQLfB5cs7dsQdpnmi3Y2pYK4ZDOP+
	Gh7474JWNb+XjonYDgi6P1JC/kTymq0LBMoG55gK76/qHJyhU0XpAirEz0tRkmFp
	JEsQ0iPQKoar5lqCUIMhqruTE5r2EpN24QOyBeUSfY6mWK3WI9gx2lm4hrhyrxVu
	+2c9bjCpg1UvY5/CLaRWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1728938669; x=1729025069; bh=XPBZwgbGBh1Q0
	CSgpG8314GukKjnlYCvFZYSi+12CVE=; b=H1tEqNrlpxrlIfhJqYa5+PMF15egv
	eofpa+evb5lewjy2VmAa1IhWlYL+FC3WJ7qUJEId++k8cyYQtXX6HF0A/RTwRbqT
	OXEhL1qindGvoHm3I4Ma1qa9wLneBf+BcGLpnLuREzqu5pajGPM+PrqGC0RusJ5b
	Sb2/vSsEsMdCIG4JKJ9HbneUqTO0avGmsKyiTFxIC7r7G7HIwnVFnxzcbejsdJZ9
	U7oyzSYVAuKE0ZB4hCcmKPgLOS0cGM+vJAtyZwsoJe0+0rJPPjD6IfvMyV+o10qH
	YH8T2qxlqwP6GmZJhxqXMV3wesZAOrRSCOLrod3s293SO0PJS7+rTTpeg==
X-ME-Sender: <xms:rIINZ6LYOO7fASNvmFdrRxOHukcQU1NceijtPQ9UiLVs_47SJWls3Q>
    <xme:rIINZyLlI_oLOvrMRzY9z9p0lH-WB4xEGPfsXnfWphQ7PgkwaRghgMnL7EqE1RDlJ
    apHyI5S1dsATKzZvQ>
X-ME-Received: <xmr:rIINZ6tz3W_Kz6ARJprN07hwznHAOmpLHLS8IymR1x0IkSCpoHZ56E8GEATssyAY7oKH4BPJ_7A7D0aZ4MBeOwmX_d7_auLFQIPJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelve
    eifeeiueffueeghfevueeggfefvedvfeelveeuvdefvddufeekhedtfedtgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rIINZ_ZNvccWm5b-A3E21utD8y240j4zRIPCMN5EuqeuLofeGakMTA>
    <xmx:rIINZxb6sI64-uuJqyET81BmMUhVlCH7Q9Ooyq8K6rTZuqYz0PgpUg>
    <xmx:rIINZ7DbOOOvOG7bpgEPB4M0KzuUtiCr1WME7PlEFh-Iz5YRHHk01Q>
    <xmx:rIINZ3Y7c235V-dcJW56bmnsYgV3YK0aVJpNX0bQpnJ7pmW4xheTlQ>
    <xmx:rIINZwn0HNxI_c-5CRE7CoDHTD-htaDQCm-hVeOp3KPqn8kFdKQ7Vpo_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 16:44:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/3] specifying a file that can optionally exist
Date: Mon, 14 Oct 2024 13:44:24 -0700
Message-ID: <20241014204427.1712182-1-gitster@pobox.com>
X-Mailer: git-send-email 2.47.0-148-g19c85929c5
In-Reply-To: <xmqq5ywehb69.fsf@gitster.g>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Refernces: <xmqq5ywehb69.fsf@gitster.g>
Content-Transfer-Encoding: 8bit

In a discussion a few years ago (cf. <xmqq5ywehb69.fsf@gitster.g>),
we wondered if it is a good idea to allow a configuration variable
(or a command line option for that matter) to name an "optional"
file, and pretend as if such a configuration setting or a command
line option was not even given when the named file did not exist or
empty.

Here are a few patches I did while passing time without anything
better to do.

Even though I updated the documentation for the configuration
variables, I didn't find a good central place to do the same for
parse-options.  I'll leave it as an exercise for the readers ;-).

The first patch is a preliminary clean-up for test script that is
used to house tests added by the later patches.

The second patch is for configuration variables, and the last one is
for command line options.

Junio C Hamano (3):
  t7500: make each piece more independent
  config: values of pathname type can be prefixed with :(optional)
  parseopt: values of pathname type can be prefixed with :(optional)

 Documentation/config.txt                  |  5 +++-
 config.c                                  | 16 +++++++++--
 parse-options.c                           | 31 +++++++++++++-------
 t/t7500-commit-template-squash-signoff.sh | 35 +++++++++++++++++------
 4 files changed, 65 insertions(+), 22 deletions(-)

-- 
2.47.0-148-g19c85929c5

