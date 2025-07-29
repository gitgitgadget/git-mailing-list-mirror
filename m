Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CBFEEBD
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753828893; cv=none; b=QuXm/CvAjfEDOKpuuOamW0Q1NIIBDSd8WZkYZJdhljYvC+moTOdrxCpTDfYH6hqKPtm+d54KN3aZcVDImmfAuG0SkoDlp4a0mKKoxlA6N3oUEf4ZQXeapDiBWo97A9YqlYikdtQzdx7C0rY1ny1CIZVFs/W6/TyDhgL7X9ZJgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753828893; c=relaxed/simple;
	bh=ABABwf2XHIjXEROh82hESc/JH4Jtc+V6rcaV2T+nbPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eZKJDGPDLbSIrX5CoIhbgacQk3GROAJ2+tjcItTxWSoOo2c+FN9PrTpTwn9BzLnGauJyJRgwJ7Svg5elmohSp9oD9qL99GDFbfrov+imdswii4lKYUi5b/qBRfIfJX4hlYb2eI59c0VUil4W5xz2NCjY5bUGGYs/RS1FTtFU4Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ts8Z7wUh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rc/lnOM1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ts8Z7wUh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rc/lnOM1"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B3581D003B2;
	Tue, 29 Jul 2025 18:41:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 29 Jul 2025 18:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753828889; x=1753915289; bh=pydYKH4nGH
	mO+FuuK/vCsf539Z35GJsispVqhl9XpxY=; b=Ts8Z7wUhKP+6Lc2JQFGVT1G3dx
	FMpFZDTSsBpzb7glTtanKIP+GdFgABhzSv7M4Y2AzUzFWmEmRbuU3ByqyQRV9Met
	HACpqLj+D3iWMi3whDd0HoVI+UJjdTPCRn8hwMxxjiuJGTHWX4hQkWuWa9Zd54wM
	OR+UJROlBqBoZVVK6Gntgf0eihYQIJUFUONoTPNXqYW/SXoZs1SEC2v1cKsb2Yfl
	hhoD8c9K56eYm3qcWoGuESZpiDXOK9+Om7l6PsLhplzu8gLNWylSrrUTtOyoeaN6
	8pVMsVZubQuoVngYW0nkUfMk6UK4MzGmedwwWuKAVlXusBY/BTaAMh5bN5AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753828889; x=1753915289; bh=pydYKH4nGHmO+FuuK/vCsf539Z35GJsispV
	qhl9XpxY=; b=Rc/lnOM15T2SjsqXc0nSxI7/BtLcGb9aC7tXlZANh3WZ6FZbp8e
	+Mlub41irGo9Cmj1ePnXKqUI3w1NkQzVt8jDGKrNgTFdx+1Z8+t6zQzUnJj0GE+9
	2DImuudvCZW4EqMLLwVJj/lHPOe+9C0PHrUaqXaApimDFKjWwWWdOqV2VagYQm6Q
	cmpTO8arR3WBrHsamvXoDPep8YEkMgR+YSGSK9v1ENP8ohV8qphMTZpUuwbrTzuZ
	4SJjsp0FIOz1ipyJ1B1Fet1SsXmfbljtnxep0TPiiB2bsnEzISTgPydR+3OJIK4d
	RLA8DaAqQzT9sB6MYJh0pWDOyFjPF5dTIiw==
X-ME-Sender: <xms:GU6JaNcvuqjJDjvPqxlA5vNR37QCsQCV25bfgRA6P8vs0Argd3o6JQ>
    <xme:GU6JaGsbiE3hfpNwo6ujhj6mpqBRUYo3onC7j9JUCmpagVoZOD3ai3Db0Ko9beZPK
    Pxw2krKH9wFv0FmEQ>
X-ME-Received: <xmr:GU6JaM_42uE885tt__kqxgqARAGOhgsBpvl2sUwxNB23YrxYKuHrxeYEVM5sdg6yc7EO3CzWnnyL7m841wn0FCU-HzOM-DIS38At1wI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeliedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GU6JaB2nr_u3XvNM2Fh8-O0w_bMemDlzArxU4W96Kalrgmrzq6d94A>
    <xmx:GU6JaBCPpjIoHpou7hcrKlo4YGP6GeHqYEqstwlPyB_-Uefx2fHrAA>
    <xmx:GU6JaNeRbE6Gro6wHNFGTi7mJ8KqSmDICv5ayFCRBL5TcciiYMazQA>
    <xmx:GU6JaO6D5srxyg-_FJq5ZYYV9BNEk_PBD8lAryVabO6WgfhuVa6hEA>
    <xmx:GU6JaNMOLlFJK7Jcv9fjXkLsQdqbeii8689GPooXpy8GRpNQQZArV4BU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 18:41:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  shyamthakkar001@gmail.com
Subject: Re: [GSOC PATCH 2/2] builtin/fmt-merge-msg: stop depending on
 'the_repository'
In-Reply-To: <CAE7as+ZUcqRbnOC11DQ7=b+YB+9HTfjfqCvxzmz+mpSH6DxkGQ@mail.gmail.com>
	(Ayush Chandekar's message of "Wed, 30 Jul 2025 03:19:01 +0530")
References: <cover.1753804956.git.ayu.chandekar@gmail.com>
	<04d6f682a6b2257e14682e809a2fd01ccfcf0d08.1753804956.git.ayu.chandekar@gmail.com>
	<xmqqjz3rospl.fsf@gitster.g>
	<CAE7as+ZUcqRbnOC11DQ7=b+YB+9HTfjfqCvxzmz+mpSH6DxkGQ@mail.gmail.com>
X-Gnus-Delayed: Tue, 29 Jul 2025 17:54:01 -0700
Date: Tue, 29 Jul 2025 15:41:27 -0700
Message-ID: <xmqqh5yuoc14.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

>> It generally is a bad idea to read command line options first and
>> then read the configuration (it is a bug if such a flow causes
>> values from configuration to overwrite values from command line).
>> THe current set of options and configuration variables may not
>> overlap, in which case such a questionable arrangement happen to be
>> without bug right now, but it would prevent future developers from
>> adding new options and configuration variables and make them
>> interact with each other in the most natural way.
>
> I understand it, but how do we tackle if NULL repository is passed.

Perhaps you want to study the problem space and related past changes
before going forward.  The first place to look at is what happens
when you call repo_config(), outside a repository or a working tree
and repository is NULL.

f29f1990 (config: teach repo_config to allow `repo` to be NULL,
2025-03-08) and what it calls "the following commits" may be
illuminating.

