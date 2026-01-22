Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8736F431
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105381; cv=none; b=h49iRZn1dBYIVQ3lhocm7Umhbmm2uHHB2rOwjdfaWTdFeMGplSBrfNqQkQhx3GYqNETSOgAhbJ9V63176h/UcCFWaVSV+D0fZiTGUso4c0tyoScUY9JlB6GL8vi7Ch7OiXufB3KZGJsfeeznE34GWzXkZiWn8KA3mp8im7DHIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105381; c=relaxed/simple;
	bh=Q6rcETaWEqvDH7fEEUe7Ez3wvIzCexJqFo9M2looc+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GZ3cuV40YJluDHTyXXJAMLX38TcxLBXVGij6dSVuVuxXHVxQtRqwYhZvvpifjuR3CUFif9Xs8vYz88gr4FO3ymCQaVKNoryHYcs3dsJyTb+zGk4JQVth5fjtq0wMh3kbRdDugHfjySDslxVAfud3Qfg39yA/kYgjUnWCwMouHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ca6qKWEw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rTDppb3+; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ca6qKWEw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rTDppb3+"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id CEA96EC016F;
	Thu, 22 Jan 2026 13:09:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 22 Jan 2026 13:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769105371; x=1769191771; bh=BirlOklotk
	ssqXLKiS4q3BdVnHiRgTnyU1s3soxy1lc=; b=ca6qKWEwUTLqY2CdmtrCspbRzA
	aKqIGNEs7hQJMXJY8rPy4eszPOWmRrk+VdhW8CB+woUwZFJnD2pa7YvGVm9B6D7l
	b1JUTmabSXqMLdw1CYB7LjVCjNkc4Ah/X6XxhaK9Np+3dIhC/xO6W7QenUcn4LX2
	v9/dVqQd+RdtpWazXlUE9utBNCTxiUMpKxQTPypOYlcTbirUQi88TneHwqJSpkMG
	XevWhwp/9E+SrorlSxvypSTaYjJgK6QOilBIWq+e4UZJqHzT8wYXRTbujovAzJW1
	6xufAo1yhGG4nPAm3+Iuz4Pd4nbRj6xOMSzxvOcIVCcFt/Ck0xtazuvcpzjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769105371; x=1769191771; bh=BirlOklotkssqXLKiS4q3BdVnHiRgTnyU1s
	3soxy1lc=; b=rTDppb3+P8XgCZ0SVbKBNNz2pLufYWtvWwqccrGjvCuazhbpgqy
	YjYPbisbcEdzBvdQoBmZaJKbVQlGOcx8YXqn92PZ76Mu2OiQfXDdruB01Ft4XQUN
	gkPgmoLh1S87efqihfUnLO5wlahhfyUacL87jJktcXrFbF3uNmxmW7Jw5jlaXLlz
	gTmnGTjDR46zxe0zq18BvNTRh6elYYGgMTZOCuhVf196aZdvkRWs37PfTZo9W6jf
	IePMaFevpSYdStT/h+MC5tZ2zieOLXkVGXLAZ9DYfVlvzLXYt5DEVVjaH3l22Wu6
	GbfbL5i5ijrE8i1WL0OiYhxZuk2GRxd5gQA==
X-ME-Sender: <xms:22dyaeqzq32y45xXC2_m2DR9jhX8V-OefmjxsQrrl4Q7a-KWrNO1gQ>
    <xme:22dyaUHOST9VOvoMCT1Of9-OuyBGvbaBOlF_ozxi2NVQ76Ph8VaJp4j7XrODVs7Fi
    kvb5hST3OoQge041LDd8YsgJD_UrjnKcbKahrWG7WP-gH1jAUAV>
X-ME-Received: <xmr:22dyaQlAJfhVUd6g2Oie5P4DljLfchaSUhB9Ss9zT4IQ0Rt5s_RRcfhaLtI6rWvatoEIdcQ7g-d3OSMRwShJXdvsJrmqub4OrqEWfPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeikeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffie
    ejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhuihhsrdgrlhhvrghrrgguohdrthhorhhrvghsse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:22dyaXndet5i6zRkxJmneaXs1tE7oZBH6M-ERmXEw2Wxjlp9n7EzTQ>
    <xmx:22dyaRt-OKFYTQH1KIIzrvb8pu4Sv51WOQuuvGlR8ivip1cNeq3DLg>
    <xmx:22dyaal0zxtfNi7iUaUsX5AWlMrHRcKq-s67rkDL4bYi5VSjFc29rw>
    <xmx:22dyacuLw8GoH_QD5lvsJPk1Y-ggC5fWMcNFdHMsQ06ZSfGEPrVKYg>
    <xmx:22dyacFzjslJ2IaRRzPafZP6iLBQQY4Ys0IjthrZzzKd4pdR-rkXH_1Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 13:09:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Luis Alvarado <luis.alvarado.torres@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: CVE-2025-66476
In-Reply-To: <CALFwtBbK6sNo0swy5k_+jgcKQmOpw3b=o8_UKhvLhtYYLqoUow@mail.gmail.com>
	(Luis Alvarado's message of "Thu, 22 Jan 2026 11:40:30 -0500")
References: <CALFwtBbK6sNo0swy5k_+jgcKQmOpw3b=o8_UKhvLhtYYLqoUow@mail.gmail.com>
Date: Thu, 22 Jan 2026 10:09:29 -0800
Message-ID: <xmqqikcto6xy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luis Alvarado <luis.alvarado.torres@gmail.com> writes:

> I need some help or guidance on how to remediate this vulnerability.
> We have a customer with Git, which includes VIM and is vulnerable to
> CVE-2025-66476. However, the GIT version for Windows was last updated
> in November 2025. How can I remediate this issue, is there a way to
> update VIM without updating git? if so , how.

The Git project does not ship any binary, not even Git binary, let
alone Vim binary.  We work on and ship only the source code of Git.

If you are getting your vim as part of the windows port of Git,
please redirect your inquiry to the Git for Windows project; you can
probably reach out to them at their issue tracker at

    https://github.com/git-for-windows/git/issues.

Please be sure to search first before asking, since the maintainer
of the project is busy.

Thanks.
