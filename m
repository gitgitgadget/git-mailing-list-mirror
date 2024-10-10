Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88E558B7
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580183; cv=none; b=nlYuA4I9x+XgJLBiX8GY0MkEwrvQR/8YHMm1SBEuQvx1J5dJGrfrBflvSfeesu+gXvml7lSR7CUZ7krgWifYxx2C4mnFPZrpCzIbzYPzrmKiANfd2uSDE94idE8psI2pabpZz8JDfrAzsYR8kpssb0GdG5ZkU3SuPBZKW0CM2pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580183; c=relaxed/simple;
	bh=q/ZrRUE1qfujSqA/ML37WOTW8ntmE8HVx4YrE2MQmes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NJGBNwNiPg8tgZ9qeSsIHZ77Usq2C07pMjYt6b78ZuLP6h/bc576Pm94RA7DdkUzIcBl9rk/SiD1Jv96JK0lo8mGVKF3zLZQF8CucRR14IPvkky7kfIlABDgt7mUrEc/7mLUn9gDckdo2UC6xHdLC9hQQ9RksRYdfB9jz/jvtXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NTuNj1ea; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gB9sc70q; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NTuNj1ea";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gB9sc70q"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D985F1380507;
	Thu, 10 Oct 2024 13:09:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 10 Oct 2024 13:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728580180; x=1728666580; bh=ywfON3RgcJ
	x7BH+oq2Tzq6zs0XZaH0QFwle8KQmXyhk=; b=NTuNj1eaTZ5obiPY67OhFq+VKF
	v776/dla6FIk/TAeYFCuv7NCrbQVBujfoRQzW+7NB7jf3KAW48mh6Beo9sBnFelC
	x25XGzAGutaNmiRxaBG/fWaTIgyxBmawVJh91ZH0s1r9MIt3jVF1RXxPgXfuuvRM
	KhszkgF75Wo3NoEkbz1gDDiqHTd1Bw/tySxa7+PY9szMkYT5xaxAX4VrzIoGSYyO
	Zt8g9HugTx3FImVgT1sglpFjzkOYb8GaHYcpEorkoBquLag4eHkg81C7C8TnSNdx
	bjt0Hov45FsBRN0MEbhP5ZmamNWbt4d4muHevb00MLIG5Y+VYlcZZTiR5hZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728580180; x=1728666580; bh=ywfON3RgcJx7BH+oq2Tzq6zs0XZa
	H0QFwle8KQmXyhk=; b=gB9sc70qWNlZdXWxR3S2zJND7M7yF7qMnhUbcdzvHEjb
	SyNzzvwbE3viiZQdhNog9i56IvcUmm0W38Kq3WPqxktArXyy38inO+zkg6pEo/mc
	WxBHxnYCNkKzyj4FjI0CjLIBHZTRvAb1vPZBQ9Fe2AWAWJhULF+5ulH4nIWApvdi
	CGZvTsseYsFGtVfpswBnkV3FpsDvVnGANEErnrWvGmN8rPM6XeCqNEynDs85FNB9
	XfdTx3DO61+W3t1QcY4HqCAVq+9ar91waVJcjDvI0NkB8g51HVzQtF8HXTamkxOI
	zga5WW3RstW0ESZvhsqQXG903SuZiCITtwTdPexplA==
X-ME-Sender: <xms:VAoIZxle4Mi0Bw153I0OW_9gr-J5yw4X8WSJcfU8KqtgsXnGx0fr5g>
    <xme:VAoIZ82iFNHhIB4RrtU0hXPJ9V5CxIGoQOYlsviXnwVqZw6qMZ3uL781nJcQrM3rS
    JeW2gRqdlQjH-rd-w>
X-ME-Received: <xmr:VAoIZ3rXaWIz7bFi-VG8Bq_h4SUmsYvIZUBekgR-5m_Y7ACI4SYKLr7wcIpQsu-uI00yjxeZ7ISKi7K6wArqliqi3c8YAjFNmI_PTkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehshhhusghhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VAoIZxnHA7QJtpVi3QGIdor6ZpF4jRAWcP7av8BoEPuJa-3zYUf9qQ>
    <xmx:VAoIZ_3_y3-Rpj7FVDDCie2heBXFEq-XOfPXZk4Z1ghFcrdOFk3zkg>
    <xmx:VAoIZwvp-5XNr45GyYvhoCI_QwzZsG81nwH6eKXqdFzpwcGsavoEpw>
    <xmx:VAoIZzWtYwKKjuUd4lJLQ8_McF-j9c3lMjR6KtqZS9d5LTS-THAQHA>
    <xmx:VAoIZ6TNB4DBpjsFJUf_06w_5xH5PngTZ6qUV5DhFzWxbjDKT7L14WxW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 13:09:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Shubham Kanodia <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH v3] builtin/gc: fix crash when running `git maintenance
 start`
In-Reply-To: <a5b1433abfd84cb627efc17f52e0d644ee207bb0.1728538282.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 10 Oct 2024 07:33:01 +0200")
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
	<a5b1433abfd84cb627efc17f52e0d644ee207bb0.1728538282.git.ps@pks.im>
Date: Thu, 10 Oct 2024 10:09:39 -0700
Message-ID: <xmqqcyk7lwa4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +	write_script script/systemctl <<-\EOF &&
> +	echo "$*" >>../systemctl.log
> +	EOF

Ah, for the purpose of this test, we _know_ in which directory the
"systemctl" will be spawned, so this is good enough for us, of
course.

> +	git init repo &&
> +	(
> +		cd repo &&
> +		sane_unset GIT_TEST_MAINT_SCHEDULER &&
> +		PATH="$PWD/../script:$PATH" git maintenance start --scheduler=systemd

I suspect we can use the same idea and add a relative path in $PATH
for the test, perhaps, even though it is not a good coding
discipline.  If $PWD, instead of $(pwd), works, it is perfectly OK.

Will queue.  Thanks.
