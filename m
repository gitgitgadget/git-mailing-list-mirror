Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DDD163
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278750; cv=none; b=WizLGsFIbDUU4ouTiqlXAGaROTtyuteTQvgECvc1YP4uSmu6kVnoINI44JNGGULJDXgSkqxkMrp956Ll6UwlVEKvpqzdwKRrzs0kalzN8KkmHTRvxAd2m3ZrRzousmA/ItzGLiiYiJ6MkRid7nJ1O505cItd8zfyFWnsZBKl9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278750; c=relaxed/simple;
	bh=Dd1WWWad7FzRmnX2TWLoRWOhc4VbES7Uwl3BNTthAgs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oyohQWh0JeGAak+2g55+yKl0qGPgHHeiPrxPdx0kpVZU5lJlcA0c6AnTpJaoBjcs4hvhD4l7yMD57rHNPk7SbAHgZcPT8x20SkmJr5i9Ys3QmFpW4J97LFm6k2LXlxX+PF/vFhK87B2nBTY2ZFPJNxIxqeIaG5uZJofx/dTqsLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZVXiC397; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eO1XtmyT; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZVXiC397";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eO1XtmyT"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F4BD7A01ED;
	Fri, 11 Jul 2025 20:05:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 11 Jul 2025 20:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752278746;
	 x=1752365146; bh=j2cC38MwQ/C/9i91uyURHeXXdD7RnZX2nwTeUpSsXpM=; b=
	ZVXiC397LHhfly3IJ55KMnVnB4bTyfPrdPUT0dF8PmOmz9aWsaD7BJBfxXuzsT3R
	cyjSHV6UsuF7vMQgmznAIBvsbFPi964gfFwXuq7LupC1nayiqD2tMAz+bC82KvBs
	rb6VJ1nTJ7AM736kLr0gwkpt0/fP9p2/77/yLXhJm8KU3BFTyXFWtd4EJh5hHGvl
	aoFREiscsvh4/gFbqcT/KtbYLoH6fwvFuZn4QIUvMYQ4VD0jTAXV0Ng1mzeFex2Q
	uJ3vKYwSassO11gRwP6dCOBsplA58qU+TvCvlLpL35EsRtlsJeXV76xuPg2Xc63T
	+t5jOv//qDcE2Sjlv9veEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752278746; x=
	1752365146; bh=j2cC38MwQ/C/9i91uyURHeXXdD7RnZX2nwTeUpSsXpM=; b=e
	O1XtmyToRT3is6cfm8PiJL5HdW9nWnxcjgFYyt0cvSNb3otP/arLTCIZQ830tPsJ
	uKLpRdMsiRtZ8V0sI4GLckQPW0Kn0o1GoqTW/stjXZ533oP+pW5QN6iTZdC2PiPB
	YwM5x47WqDPUpafpnaBZDin/CfC/HONn3ygAeIE/QV86P2rTQ4XX+8FtMXRHwt0N
	1oFH+TS23ip7OrkxlonXNFNw2uxKicBvLF1W+NZsdA/Ve6jGil0A0EALZWxhMJUN
	byxgwxgR+Z1NGId9t9kjFGBGQTaDtjmyO0rbzB1p5jM2oxE4DYUGe1oFPdJ7h3me
	o4gHYMqZqjSZLll/EUgmA==
X-ME-Sender: <xms:2qZxaDB-hd8hmsbFETEPn2DYjwT6hkxls2qhkabqLZLus0C_Uusb4w>
    <xme:2qZxaMzi80N1KWhNKMV1vepZmyfzvhIwTTp8Z73R4OQ_6SLGE01T2Qs0XpCHzJ3so
    0khO0jz7CSWzsvBBA>
X-ME-Received: <xmr:2qZxaIBcdfFzJ8g13gMEaGEX0Q2ya62qp-7EK--4En--USXVt18IKVDd8PbRLHs0sPlwhXzBqmHyxN7kC3aoM19ePdZlmieGEApfsoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhoshhssehmrggtrghrthhhuhhrrdhiohdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2qZxaBbedPDVLjSMqmdVBzy_K7l5eE3BcOzrsY4nX_HVssMc3gjrQg>
    <xmx:2qZxaIjUIzyU8IBp0lUrAwlJnrHJ-NztA8YMfNkE8-r5k-TcHoAkeA>
    <xmx:2qZxaL63ZhdXDmHqiDdpweeQYVVhCWrdXkH-0qD3S3g7g9PYK6RevQ>
    <xmx:2qZxaH6wJ8rLvHDoiQeqo0LWOuinA6T8sRSCH9GJoPSCTwUk3nPDZQ>
    <xmx:2qZxaLMwJ_QJtJJApG-WmFY0xzXspNVn-pUynNaGyEiptmY5gBu3i-Gr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 20:05:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ross MacArthur <ross@macarthur.io>
Cc: git@vger.kernel.org
Subject: Re: [BUG] gpg.program: '~' not expanded to home directory
In-Reply-To: <CAF1X4d7N1xdZt9JkVZytbEU1=7q3X_F_nqm4EG82B8-cVa7g8Q@mail.gmail.com>
	(Ross MacArthur's message of "Fri, 11 Jul 2025 17:04:02 +0200")
References: <CAF1X4d7N1xdZt9JkVZytbEU1=7q3X_F_nqm4EG82B8-cVa7g8Q@mail.gmail.com>
Date: Fri, 11 Jul 2025 17:05:44 -0700
Message-ID: <xmqq8qkuxoh3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ross MacArthur <ross@macarthur.io> writes:

> `gpg.program` treats a leading ‘~’ literally, unlike other path
> options such as `core.excludesfile`.

I think that is correct; I do not think gpg.program is to give a
path to the program, so comparison with core.excludesfile is
probably not so appropriate.

It gives a command line, e.g. "mysign --compat=gnupg", where the
program "mysign" somewhere on your path can be told to behave in a
way compatible to GPG when a command line option "--compat=gnupg" is
given.  We further append our own command line options when we
invoke this command, like the "git config --help" on this variable
says.  When we want to verify GPG signature $signature in a file
$file, for example, instead of running gpg, we would run:

	mysign --compat=gnupg --verify $signature - <$file

> Expected: Git should expand ‘~’ to $HOME.

So this expectation does not quite hold true.

I wonder if letting your shell to handle the tilde expansion would
make it work, though.  Continuing with the example, it may look
something like this, perhaps?

 $ git config set gpg.program "sh -c '~/mysign --compat=gnupg \"\$@\"' -"

