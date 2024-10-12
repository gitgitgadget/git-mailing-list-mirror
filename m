Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBCF28370
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728760958; cv=none; b=YnzjwAaj6zVOfEgeXjmrgruSIxsN4jQS5Wuou/j/FASupsKju26rHL6gOpGrqwD7iU9qS6g+5mDMFHXA9iFm9B/quSJH8Pym0OCaWGjU4wykrtGXeKgMqfT8ZsaP041jx5Sf1usOwnBeGVETviB9HoShpCFRccKF/FRX4NW1aVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728760958; c=relaxed/simple;
	bh=YOvcrtvylp20HOL82IHWrKxE4I7mXqDwIkHfHH1aW9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o4J7ffOqIfPPO4bgWPXyX1S2gOw6fbO3YBWeplTx7lMqcPPO8jCd6ALMJlitkXpaU5jx2EVE/DvGw0hLln5iblHBYoWwfz26qBA/V416HEszw/Ge9uFjabaSFaXtYzmEJ6Fl3itdS/dv/ufHpq1ZCo8zJB2gosGS094TUAAW2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cBLKf+vj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h1Kr5fhB; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cBLKf+vj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h1Kr5fhB"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9ECD513801A0;
	Sat, 12 Oct 2024 15:22:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 12 Oct 2024 15:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728760954;
	 x=1728847354; bh=RIluj6TuCwNpXIqNpJIMCoGYCgAwUHL0Ii2z26b8Cls=; b=
	cBLKf+vjUmynMm3chYUeb1/uClD1gdpnRH+DVX0Y6hZVqVbvOK49GM080pH87TpW
	MxiBb2Dr248sFzeUG5BZQhtzKJ5WV5/wDdjURaJOX1oCZDrQq8JMRZA6IapHUN0Q
	S/UTDwEe+fWDtIoKAvlMOnI1/Mj6yHYR7JgNQgeREY79sXubPtuF7zxk3aG1fKFE
	WfJtoLOcVu6wDCzSnjw/TDg0RwnBJnmt8SdT25Ro4JvhRmEo6BpfsOenSPadUsqO
	QsKdrYHg3nelnydcIT6Yn8dk7SvH7MozW6x6KDLd5Ej4bgSy4v0wgzXocsAZA/Jg
	Bb+6AxfeVR041x9nmu7I8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728760954; x=
	1728847354; bh=RIluj6TuCwNpXIqNpJIMCoGYCgAwUHL0Ii2z26b8Cls=; b=h
	1Kr5fhB3rF2+YtAXSQjrRxdsXuWgDdUITT4iZcFqbMZDOVXJmQRR5mqMWeBsHxQr
	0F2hqnpEp4pkm6FTk7hPKWdDtnbxYqdsNEHpuKnmOGKOfMXjnhZfFjPIc15D9mTa
	TOXd0lL7EbVtXktGmSPpwhvlEBG9JjgdK33L2wZIhJvRQ8ZIhGxAkLFNRPBkkXAr
	i0PmaFJeX+onBvgYvBy97B3ew9B0Evp5uys/2i6pfe49Wi4n2LDq7UcXigf/80Fo
	xHX+Lw65/RzbkOsNnvqeA+Pt91Qvgw7eIx7MqVDJsMX01QpkPFGc0Uwt7U+QjSgL
	VZ56QkAxHAyFl+FhqJyKg==
X-ME-Sender: <xms:eswKZ17ZwDC1yc47G0pXkNlNptQsmAqyI6otSVNquTJOs096udD1hw>
    <xme:eswKZy4dBTQVt49ddCR6i9pR2yltxHCRHS_mTg0y_Kr1WyjPqtNMgvI9hyghKbGKW
    _7jij3W0XkxZ1Z4yg>
X-ME-Received: <xmr:eswKZ8cYLYA5vhuCU3vCUSuXla3B2tp5-BkD0yPrD9F854hO_WJkruC6nHbeLaf9brgEYGliOaF-s4ohR9hxVukMb5CQG-yCaA4XZvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeguddgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepveejieejtdektdeilefhvdeiveethedu
    veevjeejveegfeejgffggeelheeivddunecuffhomhgrihhnpehophgvnhhgrhhouhhprd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepfihilhhlodguvghvvghlohhpvghrseifihhllhhf
    rhhishdrnhhlpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:eswKZ-LCzcVWVpOOmib03WEp6AACnZxo1EOsbwy-5a-0aJbHD6gkzw>
    <xmx:eswKZ5LKTvbFWYwsj-FVSK_cdCO4YyZeLx8AY1W5E2Q5pWNs9VSMzA>
    <xmx:eswKZ3wICoUZhgV9U07L4M1uJHSeIztlaMzSGtrL_sq6lipFlAnUFQ>
    <xmx:eswKZ1KW0nXawziWLnNXeRNTp6eGyMC2yf5SabC-DYEZtBfD0MVLRA>
    <xmx:eswKZx9Sr0wjoHbz3BMPrI0YhjiidoJWCDDTLANOraoIjccwOK6XjLG5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Oct 2024 15:22:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?imme=C3=ABmosol?= <will+developer@willfris.nl>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Josh Soref
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH v2] diff-highlight: make install link into DESTDIR
 #Makefile
In-Reply-To: <CABOUa4aY6GdoBH+XZFCRknpiOP-F=SE_b=B3RLjO-WdS_Quikw@mail.gmail.com>
	(=?utf-8?Q?=22imme=C3=ABmosol=22's?= message of "Sat, 12 Oct 2024 21:10:09
 +0200")
References: <pull.938.git.git.1728745399993.gitgitgadget@gmail.com>
	<pull.938.v2.git.git.1728754230466.gitgitgadget@gmail.com>
	<d2aeda41-84fe-4ddb-89e2-5cafbbb213fc@app.fastmail.com>
	<CABOUa4aY6GdoBH+XZFCRknpiOP-F=SE_b=B3RLjO-WdS_Quikw@mail.gmail.com>
Date: Sat, 12 Oct 2024 12:22:32 -0700
Message-ID: <xmqq8qut9ldz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

immeëmosol <will+developer@willfris.nl> writes:

> On Sat, 12 Oct 2024, 20:35 Kristoffer Haugsbakk,
> <kristofferhaugsbakk@fastmail.com> wrote:
>>
>> On Sat, Oct 12, 2024, at 19:30, immeëmosol via GitGitGadget wrote:
>> > [PATCH v2] diff-highlight: make install link into DESTDIR #Makefile
>>
>> What does `#Makefile` mean?  […]
>
> not much.
> It is an attempt to signify what the commit relates to.
> In this case it might hint at the commit not impacting the sources of
> what is built, but the build process itself.
> Maybe #🏗️ would be more clear.

Drop all these.  Study "git shortlog --no-merges" from the recent
history and try to blend in.  Don't try to be original where the
originality does not matter.

Also, resist the temptation to go outside POSIX.1 needlessly.

  https://pubs.opengroup.org/onlinepubs/9799919799/utilities/rm.html#tag_20_104

does not say "rm" takes "--force" and

  https://pubs.opengroup.org/onlinepubs/9799919799/utilities/ln.html#tag_20_67

does not say "ln" takes "--symbolic" nor "--target-directory".

Be inclusive and help those whose userland tools are not tainted by
GNUisms.

Thanks.
