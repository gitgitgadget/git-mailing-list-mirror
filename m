Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EBD1D95B3
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758003; cv=none; b=NzRSKD5kyZsblcJQbSnnYWY4f2RkLBjwvCAEZTb9w3ALMOPR9PQMigRkYCfyktwtcSOGAcHweBwoetTbOmlmxQlvOgSqtzRdUh1hNoVeob0zI+3gCkBF1fImA+0GodI1z+HuevIghE4G7vEXUJhg/NbNMxuqTMVINRVDTDffI84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758003; c=relaxed/simple;
	bh=y0s6+WqboQJzADTlZnJRj23ipRUKlUZSq+cqtTjQdnk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mf/G+YVLdwXql+oUHqxMBRthNWJfUkNtqdTHWHLxz493RvCK59CGWJplylE23rkkczOLQN+i4L1/MlxLruqdezgdy8X2rmlCMuKNN2ZGxa0Gqaj06cEQuD6o+C7DXmcG8ImPoiT82g9vkw9mrGedYCaJU5kMQa8R36D7lKauEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nilicvGP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dG1VzUwN; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nilicvGP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dG1VzUwN"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 31FC911402AA;
	Thu, 12 Jun 2025 15:53:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 12 Jun 2025 15:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749758000; x=1749844400; bh=Dv8O72Acmb
	xUlceNPKHZf1ZMJZHZqeI8PvlijCS58yg=; b=nilicvGPGox/jOOCMUmYR4AzTi
	wbCTvxvAjIu0vMObRGW4pei0pnRgScurcBZfgIHNLvMm/weKJQ2+kjI2XlJsPkcS
	VyKjPc5iuDly/3Ekpy59TWHqPgzyjHV/I32sBCa5V9Rn+iW0LdVZJ0Xyxj5CZlJI
	VioUnut4Qf+0tr/OPgN1sNl4yps7qiFc2c3/eBLPe9s9rlWUNHop8UY02lkxib+H
	RcXPzmBFx3BILCZlDC4mVtgCtyTw9Zp4Hd75frBjjWyk0c56Wm+z3ykKol91GVrE
	XHSJsK7WZKoR3vE1vU8BBZMjlPEfelbpWgrCulWrnaJudnRilOxscF1KnKSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749758000; x=1749844400; bh=Dv8O72AcmbxUlceNPKHZf1ZMJZHZqeI8Pvl
	ijCS58yg=; b=dG1VzUwNln/juW+T3oB8Cz/QcVxVQWhz0ZlY3FsGyq7ldZTotOH
	LMw8Hx9bwtwbSRL7y2rbFxbzJ2G9C2dq1DC1Ayq34pJC7owKurCUpZMzIcVjGArw
	zC2uH0g/KCN5j56w4E4Tp3e1cCiUBdyBezNGKBii19QjXB+XsMVyYa72/xztG0Ba
	sD+i1+DGZo8/zxkBc0YxqnlTO+3WwGjOVZ75yeEYsC5n9O/NBZRkebmSIqjGXNtO
	9f+N/ZHpqnCWdn8lGi+c8bhu2mQr8IFRIvRcC1s4FTQB0nI0ERDR2knP7wP/ZcwU
	3jNEdfxGlNfuPKvy0thGx1RlGFH2RxdU34Q==
X-ME-Sender: <xms:LzBLaD2UV2LZl2yLqYEYl-mRaSeh6lQ086-gZkVwKA7vtKNzGCqNjQ>
    <xme:LzBLaCEIq2RXNwEYBE3QkpQazcRmzswlvRm3PF8b6xGR_y-wbdVOJ_A4PUc05vRUO
    -MkslxKUHnBKG0khg>
X-ME-Received: <xmr:LzBLaD507JnejB1gYV5W4a7kbJw6Fx_QLm7fl0v-loqbO2NsJU3L-xCLh8BUc5JVUuG80dY2RLWmk3Kqcq4KCXrn4pyXtDz2A6-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhgtrghsshgvih
    hkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LzBLaI2eKCxUowWK2wYXXu83F7oW5D3fmscJuHY3JE8L5btexYfk8g>
    <xmx:LzBLaGH0_fcsmIGNfhbv4SjgphDx1p8gGM1VtC6emujjKBtK0xiGeA>
    <xmx:LzBLaJ_PAql9b-5S26b7wmWozQljJOSiPZqSBsVba_hmY6GXXzRv0A>
    <xmx:LzBLaDnS7DdU2C68ABboIY0XyhPdfE3xejmbLFsk_JUJMPDafxoJdA>
    <xmx:MDBLaJXdFLvgiD9zYg_Z9p-sKgYC2YnHlLyip4qDSKM00SMCE-sqnhZP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 15:53:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [GSoC RFC PATCH 4/5] repo-info: add field layout.bare
In-Reply-To: <CF0AD6B1-80D8-417D-9DFD-32338D9EC92A@gmail.com> (Lucas Seiki
	Oshiro's message of "Thu, 12 Jun 2025 16:39:36 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250610152117.14826-5-lucasseikioshiro@gmail.com>
	<CAOLa=ZTvC7Hq5Fz6N1ESzf1s=7kkyZG5iYTA6pzxnKm2p4oMNw@mail.gmail.com>
	<CF0AD6B1-80D8-417D-9DFD-32338D9EC92A@gmail.com>
Date: Thu, 12 Jun 2025 12:53:18 -0700
Message-ID: <xmqq7c1genyp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>>> +#define USE_THE_REPOSITORY_VARIABLE
>>> 
>> Ah! Seems like `is_bare_repository()` is responsible for this, it would
>> be nice to not introduce global dependency in a new command, but this
>> isn't part of your project, so it's okay here.
>
> Yeah, to be honest I was reluctant to use this, and I tried to find if
> I could easily drop this dependency. But this is `is_bare_repository`:
>
> int is_bare_repository(void)
> {
> 	/* if core.bare is not 'false', let's see if there is a work tree */
> 	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
> }
>
> But I couldn't find out what is the dependency of is_bare_repository_cfg
> on the_repository yet, but I decided to keep for this RFC.

I suspect that by the time setup_git_env() is called in the startup
sequence from setup_git_directory(), we know that the repository
knows if the repository is bare.  So one thing we could do is to add
is-bare-repository-cfg bit as a new member to the repo-settings
object of the_repository and record the bit before the
setup_git_directory() callchain returns.

Then you can teach is_bare_repository() to take a repo object from
its caller and the above may become something like

	int repository_is_bare(struct repository *r)
	{
		return (r->settings.is_bare_repository &&
			!repo_get_work_tree(r));
	}

perhaps.
