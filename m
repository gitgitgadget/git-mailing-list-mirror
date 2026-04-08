Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC463B19A1
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672621; cv=none; b=gGmqRa7OHYeAIjLlc6j/QhEJLPSQhCJ0tQH+X098iX1p/ZbsKmZSGmKN55QiLPfB1yhW21oIFrko4TcEL2eNaLOG7drOrRIAexP8eQIP+ndzYqeH2dheAFm9wEL/rdmnV1MbaPfjQTwv9zY0ppmM9YCH0kc8iCvanHajokponlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672621; c=relaxed/simple;
	bh=7Ls0TkXF8t2h5BvNC+ULxNPo72LkYtpmO6vV8Yro1ME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kB39GcHtWCfK5tPGakb1p58CTCrBJiqyxCdeHojbHBwzaGOjQDaFCM0iv0hMdoia7JZySRYiLgwUzDmu/kam5SmMCSGft2I57+baGvl3NgRL8k0uXmrN44axaEgGKrDcwRBmhtw4h6wVo2389Z/+DVRarpyR3NfV7lM/bezkKUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BwaHa1VR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hGDfpQOp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BwaHa1VR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hGDfpQOp"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 41658EC0412;
	Wed,  8 Apr 2026 14:23:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 08 Apr 2026 14:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775672619; x=1775759019; bh=rcfQruCMO6
	vBCgaWmit9g3nk7XvhvGOZM6U7KOeG60s=; b=BwaHa1VR78r6E6oUIsIY6DprLY
	ksWWlHTNmnU1cvTGPVmV72ro4h1feAd6KQWQcWAmr5x4dHm+tGQGN2uGuqOO4fLx
	UEHvIqsLZiZNGRQz4QPYvtmFfu6Hk4leG4ICF2gTHORFhZXX8QqYEvEn4BQak+fw
	JHzYxEsxC8rzxLUMdS3Ay6UOpL28fpxHMvDS07jTkrSNznAgZtPJf0xrhU1tGiiD
	cTeuS0Xl2TuCbP9IS/1u3VauwU/yneizj48MaJ25PyiL0McHmJoCCRten/nJQtp3
	QhggyEdutfI8Vo51/uuehLTW+0h0g4dPBE2dm7qf1jKsHhqUaZCj6oU+CCpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775672619; x=1775759019; bh=rcfQruCMO6vBCgaWmit9g3nk7XvhvGOZM6U
	7KOeG60s=; b=hGDfpQOpaw6n46YbSTzJ13cPp4xKsTkex0oZw/TbAxX+rXHzh3a
	o+AW5/PrafjMlg6umUZm9TDTNfDX2MVz/TIk0nyoE5zzpkTh6tE+aX5q2zdoSq0L
	Pr1ZGWTCHIq5vsebT1wNcSNPISPiNPN6deOYsqCAZX14IWY9qxueUOzbgXFEKD68
	2NKJxkyg9/51TmEUwI9RQwwnr1njrVVQ6e6eo2h6/zkDTFBcOCztQC/7RDkV7eck
	++6hY7EDqFIixTnetI5WjP3/WAlcS+W31+O2/9fML4RxehsYdOAATqZFBWohfrUk
	0ixtvC6oQk0ms1lo1wegt7ai/nJEzoHqEHg==
X-ME-Sender: <xms:K53WadtIPOfzdWnlqDew8F9MLGkDpZ740mynhwa64EWfieNN9zPJVw>
    <xme:K53WadeHMhWYF4WIISdg7wb1VKOhgfT-fWekJ25AcTNMMoxkhWH5Fo4uqUirhHjx1
    gKs5crQzyuVlqownK7xTpRnYePdGIUfOp8Zq-SaaLtFJwLndjNzuA>
X-ME-Received: <xmr:K53WaVwOrYaVLRxBfEZOA9M8wkrAme9hm5oedbmZX96_2YRG-YKVgcSWfRIcg3tp750A_52ViSkUirkU8cJhH1cw_y4_qs_XRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepueeifffhjeefvdfhffekheeuteefke
    euffegiedtkeeguddvueejfeeuvddtvefhnecuffhomhgrihhnpehhthhtphgurdhshhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepvhhikh
    hinhhgthgtgeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:K53WaTHThbBlbNabfPF-MKKjrwxN7Dhlf7AfSSwK6sfBou4T6m44mw>
    <xmx:K53WaZwnJkGhtLq0tu-5rn-iCENMfBLhs6_vq-f9uQuSIO8n3tBtjw>
    <xmx:K53WaUtTOx98RA5XVL-IHAgKEuq_7pV32lIZFWglVFPFuuYBXnUpkA>
    <xmx:K53WaW3sJvT-jO1D-gECStJEFyIwwzaC-EiZbueSpdhhVq1GL0atfg>
    <xmx:K53WabjO5J4KhLPVnqgMKytUR7jdsuzkcTFyMlKnHJW6ABpRx2bYcgG->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 14:23:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: Trieu Huynh <vikingtc4@gmail.com>,  git@vger.kernel.org
Subject: Re: [GSoC PATCH] promisor-remote: fix promisor.quiet to use the
 correct repository
In-Reply-To: <fbe81fee-ef1a-499e-bf53-d6f1761bb30e@malon.dev> (Tian Yuchen's
	message of "Thu, 9 Apr 2026 01:48:59 +0800")
References: <20260406183041.783800-1-vikingtc4@gmail.com>
	<fbe81fee-ef1a-499e-bf53-d6f1761bb30e@malon.dev>
Date: Wed, 08 Apr 2026 11:23:37 -0700
Message-ID: <xmqqzf3dxqdy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> On 4/7/26 02:30, Trieu Huynh wrote:
>
> I strongly recommend you to run a patch locally before sending it.
>
> 	not ok 38 - promisor.quiet from submodule repo is honored

FWIW, I didn't see it fail in my local environment (both in 'seen'
and also standalone) or at GitHub CI (in 'seen'), so it is a bit
hasty to conclude that the patch was sent without proper testing.

I wonder what is different in _your_ environment (note, I am not
saying your environment is _wrong_.  It is just different, perhaps
the compiler I use and your build environment may align things
differently, or perhaps on-stack "uninitialied" pieces of memory
happen to have different values that the code is reading that causes
different behaviours---in which case it is the code that is wrong.
Asking for environment differences is the first step to figure out
what incorrect environment dependencies the code has).

>> +test_expect_success 'promisor.quiet from submodule repo is honored' '
>> +	rm -f pc-quiet-trace &&
>> +
>> +	# Set promisor.quiet only in the submodule, not the superproject.
>> +	git -C super-work/sub config promisor.quiet true &&
>> +
>> +	# Push a new commit+blob to the server; the blob stays missing in the
>> +	# partial-clone submodule until a lazy fetch is triggered.
>> +	test_commit -C sub-pc-src updated new-file.txt "world" &&
>> +	git -C sub-pc-src push "$(pwd)/sub-pc-srv.bare" HEAD:master &&
>> +	git -C super-work/sub -c protocol.file.allow=always fetch origin &&
>> +	git -C super-work/sub reset --mixed origin/master &&
>> +
>> +	# grep descends into the submodule and triggers a lazy fetch for the
>> +	# missing blob; verify the fetch subprocess carries --quiet.
>> +	GIT_TRACE2_EVENT="$(pwd)/pc-quiet-trace" \
>> +		git -C super-work grep --cached --recurse-submodules "world" \
>> +		2>/dev/null &&
>> +	grep negotiationAlgorithm pc-quiet-trace | grep -e --quiet
>> +'
>> +
>>   . "$TEST_DIRECTORY"/lib-httpd.sh
>>   start_httpd
>>   
>
> Regards, Yuchen


