Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19EF4F1
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726651995; cv=none; b=bkf/VGGLFs9520WtbN+rQbqjoj2CeK3HHAQVLrdGySuarx5vdY2L+5XzK82cmiEdFiGVPabuxt4PjDR3/uIEjStalftN1kmfud9BNajiYMnmHibhh8Qh3mwq4XGtUp0bWpxit+8rZR4FS5p5wl2HNktxjMvYzNmzY7Psg3AKWLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726651995; c=relaxed/simple;
	bh=wCLhLGx7b2buzFX7DfMyEDJmbDnBKTAqminP+LmF/7A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KT8GsMnoK/L9FBbRUGof9cqx6ADsXe8frCaLIA+96POgZAcadVru9VdhHH+J1voCnl5Kfy8AzzpL3rroD4AEerfNKOKsN/oemIU+/q4IlwjnG6OI4V0Q00iwYtdNYOusiOWc4tXkGnpakJsCE5KJuXimEfCHxLCHCnnu56Aao98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=xe2oJkWJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rur52FK8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="xe2oJkWJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rur52FK8"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CFD311401A7;
	Wed, 18 Sep 2024 05:33:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 18 Sep 2024 05:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1726651992;
	 x=1726738392; bh=wCLhLGx7b2buzFX7DfMyEDJmbDnBKTAqminP+LmF/7A=; b=
	xe2oJkWJ4NOcBoq9oz0OmxgXqhvNszYXbqu8caBVr9ALMhZICIhPtvhCmoH71Rvu
	5pj8qwJ1sx6Y8Y4s9u5fCqxWjXGR+oroC/G83STG84ykcu8LYFZWNOt4DQDb4C9F
	krJfHqic/2TxFDqHf9PQeBKjliSM1jRyH0vHPAdwFKY4jc38/0dDPcV8J2kH70XB
	HDbGIUUe8usWqHXiQJHKFMGgdhmJYhnaSbVA3ontjQr4OBDF8hcsU3WCIxexQOEg
	jeDS9+fQ7z1dk0dTXIqKNHDA5GWcod2UP8UndPZvxAMvkkFjDchSL7F4IAJ/HfrA
	ll3JWNGOi277lfmY6Y/1hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726651992; x=
	1726738392; bh=wCLhLGx7b2buzFX7DfMyEDJmbDnBKTAqminP+LmF/7A=; b=R
	ur52FK82c0n7mngeb/b3/0Sf4eI6xtb2Ldwzp1vZqYONKgPteMd0t2X3V2c8ss0Y
	G/8SbO2cdObpS8Dqc+mn11wIBjDgwE49NDLoSNJOpYxB9YbB1sQD40sJ/VqrZcnr
	7o0pTmOcSI5Qi51vN3rWaP7qsi0t6l+3OPXMu0E1fvNpiNraJa/5PDYyAA8zRviR
	9W4ZDFdHvdye6BwIP/eYdCpuAa120FD1T/hyobExdnmFdzCPQK5XzeIRF5EJ9F/d
	32OJHWbRwxl/bYA9BytN6XDaQ1ieJWW1LhGRk91RJRXnetVBA0qI2oWqnAK0wFdF
	Ihe+WOQXX1q3HE3PsFFUQ==
X-ME-Sender: <xms:WJ7qZrs71gOlujcIX7qn6ByYbKFSO0XenfibM7GPYJV21qUuDyhSZA>
    <xme:WJ7qZseMO57b4XiKPa_u21PNNIxYkqgJqN1oHUgk90cDUuqJlsrnqzwrP60msKZ7I
    NbbSh4PemWfSUoF_A>
X-ME-Received: <xmr:WJ7qZuwSqjBG5ns5g560HTLjOFv30DL2YMgU6iCZArfdTVuIoZ2--nmRnNjn1Kmgl-llTw8FkwWu20o8u6WSGxk-IZBx6NwyIlIKnLLp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdej
    necuhfhrohhmpedflfgrmhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurd
    hioheqnecuggftrfgrthhtvghrnhepffeukedtiefgjefhhefhgeelieeguddvveeujeej
    hfegtddviefhjeetudekjeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:WJ7qZqOC3ePQ2jHl4FgUh8FGu438Z9oRR5oAoeAZSi6VSeKN2LDScw>
    <xmx:WJ7qZr_VNg0RYcoxVkg2g5DUpAacXL3As9BdrNmmg_bm-jTweI_h6g>
    <xmx:WJ7qZqU4XRNig9B9OGczpKIqDurD9iZnYcNBTRPWh7tQdel-0ReQ9A>
    <xmx:WJ7qZsftTsBGzMACoh1IPeJLQeUBpHey8xl1mDh1ha4CtEqF3c3JnQ>
    <xmx:WJ7qZnbOjxtr6gmA-wqK-jGQJ0UpDdq5WV-pm4ithWeBmuRZu9_xXi7U>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:33:10 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Sep 2024 19:33:09 +1000
Message-Id: <D49B1PC1DJX4.3SMBLL1G9PRMD@jamesliu.io>
Cc: "karthik nayak" <karthik.188@gmail.com>, "Eric Sunshine"
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] reftable: graceful concurrent writes
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <cover.1726578382.git.ps@pks.im>
 <cover.1726633812.git.ps@pks.im>
In-Reply-To: <cover.1726633812.git.ps@pks.im>

Thanks Patrick! I've just left two comments.

Cheers,
James
