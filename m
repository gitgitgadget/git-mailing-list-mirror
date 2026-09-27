Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156013793B1
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549924; cv=none; b=ew1rvaHgeBA9hDfW7nxzBiWIFtziWbwyrwxBjAx5AnBe3El6cM0zpeBT1W2iF9DadlcmARVNX2bAhFADm64INTQdTZEhTMdtY59iMdP7dk5RyVzx9m/niC1c5gplOejJzid+PxzhfoYIPAFwMENXhSnFtUg3afcJ7T5chI52iSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549924; c=relaxed/simple;
	bh=julfnRYM94LgEX+BJxc2s2FaXgHc5Lp8Y9M+2Fjzgsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d48+QVkirjHN9gqPPK7JMKTjYXvoI8ExJT9wH6ezkHsLx13ZbjU3ZrZ37kRi+lW2/SzYAqQm+nPse1ypff0Lvs5/89knjSvoOGpYJ6GHx+e4h3LW1ynf+tK3KPoRHMnM8zy05YtIi2JAAZy426bjINlihmLqAYfQSGK8AJzp3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N0e2rgws; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UeRsC043; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N0e2rgws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UeRsC043"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 109B0EC0084;
	Sun, 27 Sep 2026 18:58:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 27 Sep 2026 18:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790549922; x=1790636322; bh=UidYwKMx5x
	C9bFegZ7pbnJf060bd2lxpZHA6v8fZi8A=; b=N0e2rgwsJuZu80+t6ysXxYrLA8
	kL+ZHJ/BO8rFVpxZVhNZS8MnxU2v0vHGk1pxuMt55+6tpWAbx5QDkRjrLms8s63L
	jS/j7wZ03U/w8i2+HG3C4jjIGebqH8COWUrIN3OsghPvoPbmzdI8wsd+LXY4wkeF
	uIDcVM4owmkminR4CQri4HxwbllEkksM8igECXqW9fn6/FAvUBkMU7aPj9CJDwVA
	DNdqFcXrN/wqydR/Js9wS8YIlce0jVlVkeiNZELPZ8NnZeJ6iu5g1psBQVKMZ672
	hvxm5MN6rvf4YzfzZA56BC2cq2iEhbiD85hrs3xEH4JvhRfdnCIL03lzS+qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790549922; x=1790636322; bh=UidYwKMx5xC9bFegZ7pbnJf060bd2lxpZHA
	6v8fZi8A=; b=UeRsC043xZCr/nCZbIQ3xuO3K6TC2MklIbp/igWaP4aMBkwPOei
	oNktWvsJwaYvJw1Cb2+bUOliomEjQXS8VAbDutN2AA6LTOVRr0iCGfVhJtCX6cwF
	X8ay7muQFl/M1R3Om3mG848BeZ54bhEqMP3QObJ7UVjCTimbgyLAx12zUafb/Lal
	6IMQF84O79YYf7X+PcW+jnWJ0NQjgnfXvvbm8KOb04l2sFFHG8f5fEQJSYBcVfLu
	LN0iXYsLtXL2IX1wkGcB7uKtUk/HV30XtFHCITDwKvnZXkAHfNoSVDV0muHSh5rf
	eEFK5LkdWBOWG37yiw8GpAPl7cElFT6IctQ==
X-ME-Sender: <xms:oZ-5aqHoPVQuax5gUKgzyp33afN3Jfsp8X8J23BEA63u91tnT3yh4w>
    <xme:oZ-5aiVz9_J_K1QoaHODoD_enx97tpKLvPMbM2vaMY9rZDDdyXxrAWJAHwJuW1xCi
    mtKOLYw3ghs25A2FDs61iYPUORLXMWIs9eqqFzErHn3Bu5lSWRDFXo>
X-ME-Received: <xmr:oZ-5apJS1W6MezDt92Y50OyQH07Zl3QrPH3E27MIPskZJh_yfIPdYADCE796lDk3iLh_uPSPCHhMUdKEwXcwL6yPvRTo_2DYcZWK>
X-ME-Proxy-Cause: dmFkZTFCXrWy1E3EFfeHY4SCInzF84eJzgmx2Bpuxxi8Uz6y39CWdhCyLE1HC+vpzoMT8P
    W+5dRaHvdr1hzpQm+t8jlK8s8Va0OOKbC5CeA0ltH4780MQUi0YYuu6aEkN6pwSKgZREEF
    Yap2imunE+HqKlvlh3Vu5sYoEjk4mj66SMOQV8VX+qfqypWiKSwa4Ozk8bUAmysm0r4NuL
    DRkv2O6gxfyKLzdlDabogf/MifnYBA3n5v7Bw1wtPpLy+JUhXX6zJ4E3GXjfi2RNhowZ2m
    vADCxPTRLw+/ZnvGuUfNSngMM3gVFoPHvJLtaKmPjXeuFzpqyTm5LSZb8FwzdnnOIh5HOL
    l/dvhGFP8on7D54exbEafavYXT0RL8ZLw2Mgfk3tj6ChNsoEC9yHakcD8Evo+3fxC6IsQM
    PThhT57KCaN2h26myFAd2dCZItDUWmvhU55VwxbH4VnHHH3Y0IZJx5+XhhcTL9sQ8EQ5oi
    dpbFTxEEFoUVVyPorku7Ur4r0bTu2+HaU+2Szmh0iBHSQlE1NrqxHtgGJmSbvJRPcrNbSP
    GrUAF4K3cUPJS91M5MQsQr+8bIXG7H6WBHmOegrTDFbd0ytZYBBG1pdEbM0hJu/eKNEkeM
    UBB6eOIXUviTGbFb6KlE7b6uz6rJSkwt0TpC2IEVIAGwBVVjUVkJ3KbYfd/g
X-ME-Proxy: <xmx:oZ-5ai9iu2wUiI1Z53OtFHd64sj_jrGWfFsEE3rh58munS8l_-VI2g>
    <xmx:oZ-5asI9lJjVBuuPyETK9GzDGllJ553SxNC4qs723POgDjmhR32-mg>
    <xmx:oZ-5annlCKBMuUu-XL5_4ackVYUVg7YPD_ompYaJISBQlsiZP5ZxZw>
    <xmx:oZ-5agN-ayPKpiQ1x1du7BZdynQQ051YltTDHVsqIddRTODh2UJlhQ>
    <xmx:op-5ar6E7GUeQcA1wV-sLFV86Z8YSAasy30V_W_2KXG-q4_D1FZokzqd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 18:58:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: jyotish kumar <jyotishkumar725015@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] name-rev: update hash descriptions
In-Reply-To: <armZ28MWl9dTHDz6@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Sun, 27 Sep 2026 22:34:03 +0000")
References: <arkfFUpCskucD7Nh@fruit.crustytoothpaste.net>
	<20260927194602.86750-1-jyotishkumar725015@gmail.com>
	<armZ28MWl9dTHDz6@fruit.crustytoothpaste.net>
Date: Sun, 27 Sep 2026 15:58:40 -0700
Message-ID: <xmqqbj9iqp27.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>>  --name-only::
>> -	Instead of printing both the SHA-1 and the name, print only
>> +	Instead of printing both the object ID and the name, print only
>>  	the name.  If given with --tags the usual tag prefix of
>>  	"tags/" is also omitted from the name, matching the output
>>  	of `git-describe` more closely.
>
> This looks much better.  I didn't see any other instances of "SHA-1" in
> the documentation or "40", so this looks complete.

Great to know that somebody already did the grep for us so I do not
have to ;-)

"object ID" is the best one among a few synonyms to be used in the
description of "--name-only", as the "name" is about the textual
"name" name-rev mapped, and not about the "object identifier" that
was used as the input to the program.
