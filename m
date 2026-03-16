Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D45238B7BB
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655702; cv=none; b=AxOm0HO8+XFsDmzQV1tesqfHcsHW9tj2VUKAY0p+3tNqcJVYTO0SQgKx9XmNlrhuxn7pDXAsIsEDFRJ3NEPZQFZd79FDPYU+9Nfhi6y5cRb4IRuRPAejY2/Ab3nTLa2ArCFYm3BA7QJEtzIaRv/EBGtvY4NZucn5QlldSgfAitc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655702; c=relaxed/simple;
	bh=AIEoBKHn5fHIseGde8DzC6ceFeHij7L80zSSoaraWi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cE6Yq3F94n/JAQeHDzHZZIAit41YVvJJuJzN20T+wYcCjD1H7k6yNA8B3lrVm2OEvmv9NuuVsxjPe8+aO8mc9efM72Lsp7DdnIYwzyeDVabN2msJcwcFlzUwFqVwA2/Dq8Ipp62kTcT81VULDdWJ05DAcZ51YAHj/6PP2Ac96rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M1t3Hxse; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KjKoZO4P; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M1t3Hxse";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KjKoZO4P"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 84AE2EC031B;
	Mon, 16 Mar 2026 06:08:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 16 Mar 2026 06:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773655700;
	 x=1773742100; bh=Lz9gSTQ4ojhN8cad9+6SbAZX6cncf6hCw33cnAQRK/o=; b=
	M1t3HxseWT31I84W6VCXeOpvS3nybNdWdgXiUoU8B8iJJC7ZEgTTq8zod+/m785h
	umMjGnREl3STq0N6jOIwriD9do6HIxloHvB7L4qjEpqjpWaqDCPTZP2ZmNywoqiD
	BOd4OvcTZzm4R2KQTdTVPZSu8PkW3R6CuZuo7cCfW3e+xLGK0nrr8pLVqmgsPm1Y
	0dN4AYBl3Zc4nl3ptPWPR9Rpm4oZ5kve/T9dOaTA6Y025oGJDve59HXmEq/U889l
	otAk4Usv1fYkyAOc3OGPNs6Xc9tdrKBZH33pltUN8c7JCi6MTYcQFy3xcQoIhAKj
	3YvbpqcXms92LiP8lgo+rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773655700; x=
	1773742100; bh=Lz9gSTQ4ojhN8cad9+6SbAZX6cncf6hCw33cnAQRK/o=; b=K
	jKoZO4Pb/ZHsB0aSW6U51YAFfQgXAmH8SssQlRhtBQyykl7sX2fzlB1qe0rrOUdF
	BfX7oXuTUv+uzxYBmT8C1V1KiB22D7IXEKJK4RK5Rk1wjRmVY/8sufmM2B1d7Ti/
	/Ua/9lVhaKtjB8zXmBsQqF2Q3BXCRpyM93hiJfLomYwDGwL/ycvLqORMjn9+aR7w
	IyBL0+miggVveq3u+0Kn7gV6Nt5JVKZhcpAE7I2jmhzIBtz6PSIdixkN5VVQ70de
	0Db9w+PEurUoVIdF84KdsJm+UvbHMCLqvs26hG/s0IQ4kms3QKP89cNledIuBRdL
	KqV6DT5ViWeGB73dHq0Mw==
X-ME-Sender: <xms:lNa3adkwgHiCxXB8SKdZqIlc8tv0kVVeQOP0nLA278sbNQr0AH7miQ>
    <xme:lNa3aWrQo4lbAb-Q8914YB-TswRYguVJmzHcv711KaOBVTuPA6XPKr0kMNJz8lmB_
    W55E6-s7SRmsBkNzJHctDCu5ZQSYsb3cb0BePZYxnsqRluTkksSfA>
X-ME-Received: <xmr:lNa3aeEu-IJgpVfe8GaWMdSh-q6SRcG02vh10hmxSMZ36vWg0kHK-yUqtC-LepAEcdMLp1cpMfVA3M9f87y3DIpCGqGxRSYuYvb_5mPca8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughu
    nhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:lNa3aaxpzGHphHVMe-A_1t9noVn5znrLUMlBz3sfiVu9ELTUM8nAOw>
    <xmx:lNa3abqZdGUBUKM7feCjfZ00xUgJeIhkOwGPpdfUXVxQ-NloZ6ZvXA>
    <xmx:lNa3ach2ZxPvlxArWoG5xBfnxtBtoF2UDGSvHsKoFUKyqzs8NirIUA>
    <xmx:lNa3aQjWN8uflQB14mt5osGyJrjz4zHB5T-IYHR34_CokB5sh0JdCw>
    <xmx:lNa3aQC4HLaicAw_I4QWVQIsWzDLitf2mk5CEefHs5BNF-La6xe1m8TI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 06:08:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4505809a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 10:08:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Mar 2026 11:07:59 +0100
Subject: [PATCH v2 4/8] contrib: move "update-unicode.sh" script into
 "tools/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-b4-pks-build-infra-improvements-v2-4-4b2c2c0c0425@pks.im>
References: <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
In-Reply-To: <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3

The "update-unicode.sh" script is used to update the unicode data
compiled into Git whenever a new version of the Unicode standard has
been released. As such, it is a natural part of our developer-facing
tooling, and its presence in "contrib/" is misleading.

Promote the script into the new "tools/" directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 {contrib => tools}/update-unicode/.gitignore        | 0
 {contrib => tools}/update-unicode/README            | 0
 {contrib => tools}/update-unicode/update_unicode.sh | 0
 3 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/contrib/update-unicode/.gitignore b/tools/update-unicode/.gitignore
similarity index 100%
rename from contrib/update-unicode/.gitignore
rename to tools/update-unicode/.gitignore
diff --git a/contrib/update-unicode/README b/tools/update-unicode/README
similarity index 100%
rename from contrib/update-unicode/README
rename to tools/update-unicode/README
diff --git a/contrib/update-unicode/update_unicode.sh b/tools/update-unicode/update_unicode.sh
similarity index 100%
rename from contrib/update-unicode/update_unicode.sh
rename to tools/update-unicode/update_unicode.sh

-- 
2.53.0.959.g497ff81fa9.dirty

