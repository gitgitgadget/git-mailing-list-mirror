Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418D41F4E48
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276032; cv=none; b=bAPLJ9rx+zMj7uv7HahlAhH8SKFtRAaaVNeKhp1wRNOPdSvIwMpRC1062TeBhD0/QpE2s1kYj+zshaJniSSHxGljLNr7eG3bzoyHuFDj284PsR/q7r9DBp9KRGGT4G6zJ1v9sjUw8yERlJ/nKZuMMyMjlamw4zhPGUmunLCBpt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276032; c=relaxed/simple;
	bh=2Cwm6CGUNrxVBNslXObM87IoQmFIXhZOusY8hO4JIv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gHDpGBYJzhK8bqgB0JNIuzLX4xzZN4kbxS1sz6DGQVJaqbjtoUYWd7U9O6I6qOyuvvypLyIWYAwdEztSoJScDQBu0jSY+xh7IK29Nv4k85LkaKKs3N2VBGrjtC7FG+Sk7rjwxvM5qcMrepDBlQYOAc/Vz49zvbj7u0HSp20IXAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0DHDAzmB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EsgqXHM4; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0DHDAzmB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EsgqXHM4"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5129711401A4;
	Tue,  7 Jan 2025 13:53:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 07 Jan 2025 13:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736276029; x=1736362429; bh=JO/dfj0Dju
	6ELuyQhfvEsr0lr9Qu4Ci+cysmynABu68=; b=0DHDAzmBIUt8r4Ai7Xs7shF1/c
	Nh57Ub2xTp6Xo/aHAxU4nmbEMHJd7yY0QMa4quGtjLhHNXEhBR2JZPlkUlcY6GH0
	AHAV2oV+IpMJ/q/Lvy5PwlKvT+KCdwQjawoxDuhpdfBxrN3iAGPVeC5CLgnC8Qv5
	h4BybIfF8O55X/NDRHL95/eqt0U6qPuieROuEqvYb/OacZEAMkArGwJm0E4PbL2H
	U8hijAc0Lx2Gmbhx2Ub/7ehRgMnMG8tKOkDIZZMcg6mew5QyY7VNQxhCADjssEVG
	LZFocKH4EDKCIJabEx5vE+90OPlW//n3eTIQujuF5Zdp33/94dhRVf94mucg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736276029; x=1736362429; bh=JO/dfj0Dju6ELuyQhfvEsr0lr9Qu4Ci+cys
	mynABu68=; b=EsgqXHM4IQm6xiZVMLnIJF6oYl94GsgRaORfLzikoi1q21i//77
	xLOfLSyl/UdVae9rWtBIV51OADSp3cYdJ0Tnc0oCMdMu5bF8NecqF3IYVSUBwQCX
	Oi5+FlaC4YjHrB825lRg0kYbgLdP9OYU0lhkKWdM2sAOGXWKA1bUOdNg7EQLEk9Y
	hhJB3ALCKQ2XGpPzGOhUaTPA3FalBhBZr+MF3dUD5Ku1ueRc5Fq7SGr+glvJpPhM
	2RkX8kqfPYdaHyFumZrw8r1o35YRpETuRhOUrPVfgjX1g+XLUgYmzgYuvvrdg4np
	BRQdI2At6FWRBmOw64Cge/6CApcEvAUEhhQ==
X-ME-Sender: <xms:PHh9Z7LUjXeI6II40XDrfD9AYBRzn23msUUWCNYG4HoXQuEpTIiR5g>
    <xme:PHh9Z_KXiQxCLwDxGK7IXrAK6mWNSbtThTi3aUe4cfYpUgU6tWupZ4dFEHs4ZCpIw
    iloO53bl5zlJm_-lw>
X-ME-Received: <xmr:PHh9Zzt2kdvsWDhRhu_Hoop7kcnHNlVaaBXHUE5_v94F-1zJF55I1R8kRy6SltWLYurYSIOgozT9wjR4iVlbd5gv64axRCgOvV8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghlvhhinhifrg
    hnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvrhhitgdrphgvihhjihgrnhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghp
    thhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PHh9Z0bFb5qIjB1Alj4ZTe8Esm7qPiZ7wTtfPpD-af9iDmaJUc8fMA>
    <xmx:PHh9Zyann_nakQXuJsav6X7bDKM6mcNWo8uCoXopSxsLS-2BaEbVjg>
    <xmx:PHh9Z4DrFEVs0XF6tIH8ZTO5bEyXz2AkINNErF0UkMVt5KZhQAMukA>
    <xmx:PHh9ZwbXGsKP5DYxVk1M_7cargCuX1EJ3iOTJgXpjExZTdGr_52BSg>
    <xmx:PXh9Z4nDuNZ-mGBeDyyt7BKsWnUFyjyBcW1FDhArJG4WjmJ6xg4rhMlA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 13:53:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: Eric Ju <eric.peijian@gmail.com>,  git@vger.kernel.org,
  jonathantanmy@google.com,  chriscool@tuxfamily.org,
  karthik.188@gmail.com,  toon@iotcl.com,  jltobler@gmail.com
Subject: Re: [PATCH v8 5/6] transport: add client support for object-info
In-Reply-To: <CAFySSZAqh6J14+r9JLM3LmRmV02ZvPRf5dB3rWVnUZS_5XaHcQ@mail.gmail.com>
	(Calvin Wan's message of "Tue, 7 Jan 2025 10:31:40 -0800")
References: <20240628190503.67389-1-eric.peijian@gmail.com>
	<20241223232523.76236-1-eric.peijian@gmail.com>
	<20241223232523.76236-6-eric.peijian@gmail.com>
	<CAFySSZAqh6J14+r9JLM3LmRmV02ZvPRf5dB3rWVnUZS_5XaHcQ@mail.gmail.com>
Date: Tue, 07 Jan 2025 10:53:46 -0800
Message-ID: <xmqqikqqsbet.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Calvin Wan <calvinwan@google.com> writes:

> Thanks for picking up this series btw!
> ...
> I think we can flatten this logic a bit more here to make it more intuitive.
>
> if (!unsorted_string_list_has_string(args->object_info_options, reader->line))
>         return -1;
> if (!strcmp(reader->line, "size")) {
>         size_index = i;
>         for (size_t j = 0; j < args->oids->nr; j++)
>                 object_info_data[j].sizep = xcalloc(1, sizeof(long));
> }

Indeed the updated code structure gets easier to follow.

Thanks, both of you.
