Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6402F22538F
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760205477; cv=none; b=FCK1NEa26wNI5LGGrsz7veCjSHOi+ck7MKc5eF46tpBsCbwF2m2ekqxRG8ViYpRii1JZRR08XFEwbaysMEMJHSsyKnBIYvo5os1+lNQOqnra+dQW0q0vLEmytMqESUaiTuVEk+zST/4C02mPbLJGv7KXtpIjjk3vLVBVWtO/zqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760205477; c=relaxed/simple;
	bh=x5BXN+Q78Wj6zBOpCrN6TIV3TZ/5OE1Dhwgmh4pDbTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UwwfgoqZubDTXNfkLpc+xiOWmoOwkheod6uGxmMRhewN1WJpHhR2VJHpoIYOW+x3DlahuI0IQ9mgBh81hD872VE3iGihHeU58Rori8tm3kKc++Vjts6zXM39OTHt5REBHRs7fpeT+Qrvqg+dZgs7DJdYgJJekYOkw3EZ0HinCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ah4OUOpD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tt8WgugP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ah4OUOpD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tt8WgugP"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 7028BEC0188;
	Sat, 11 Oct 2025 13:57:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 11 Oct 2025 13:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760205474; x=1760291874; bh=GhaTWxzgMC
	BSF601/Fru9tJOZvtqAAeKepViq15LoFQ=; b=ah4OUOpD5Yv2dGR/8NZqL/9cJg
	EEETIO8luEwh7YPU1bIBVTw7K/C2Py+AAXMOIFlW+3TpZK4IVjERaSOGJ9itvy1H
	gf335GtFrpMe1RK6Q+64QSYqg4W9HLvzuf+2KWn+CFlW+CH3Ckb8tqbHUBVFcDJz
	BjrV0Gm0SHUj/HsK1ooeQ/cHqYIAhVinxQ1NlnZCFgkf1N8LPo8Hd8RAd2VpGk+X
	eJj4M2OrsULVNMlGvsR3ekuw6XzkzZGBKJ4L9Vn2If8DhP3eegqP2MWd1tahvzer
	XfN4C92bqDH6GUHtyonk40f8uDeHgfxkUXUt+Jpw1SrXBMBSIp8S/vDNDZZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760205474; x=1760291874; bh=GhaTWxzgMCBSF601/Fru9tJOZvtqAAeKepV
	iq15LoFQ=; b=tt8WgugPOEZuhA/t+HZoaDVt4XXA2ofAnWM19dIcORkPYgWbnWc
	UrXt8kzLzHNscpygVBylKZUrJmteJlwzz8H8XH4Xui0u3yq7yhCfKrYQXkQ7O8HS
	m18F6hBd1uoDkOuF/8ERpkT0P/aLrph2WOk/zAC2EJ4iXEfcQ1Fs/rBC66o+gz8o
	xoilTXqHdbJfgniEAd34Nmu3jnfUxDMdM/bT90EgARfgtCbKz1/A3gumk0AGz8V0
	90czfWU+XJQixfLd5Pj3cY9FLDY2pt9dCxLeOPY43SLOkQQ2V008YXF8iutbd3DY
	ibzMRDvZ6g303cqz2ssOAZOSRNjKAR2Cwsw==
X-ME-Sender: <xms:oZrqaE2V_w7onV_RPZUkeWsFMLbYb-ZrCcmub-THqpT2bxYpn1gMkQ>
    <xme:oZrqaG1DvFRtScI7jcP1SncOQ_CHjj-9XI8DKMFcooTFch6AG-FUr_O8RckksBpIb
    -r1j0p7yoyXcePjm8mFFAGnmEdg_5hY8X-OHsF1We4rtRK7w3UPAH0>
X-ME-Received: <xmr:oZrqaP8emlFymm6yAe3DEHCe7ceN_dYME9vpQolGyx7-RnBq2qjEupqsKK6EWDKaRgA-NgOhGmIYOlfGJzeqg_tjvrDJhnSYRJVz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddvheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhhohhmrghsrdhuhhhlvgesmhgrihhlsghogidrth
    huqdgurhgvshguvghnrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oZrqaL3NHfZSSs2jE9Q2rDrk8Nr7lh7KQN0t0Wr8H2vGa3aLbIRhjg>
    <xmx:oZrqaE9xl4-taCnURBa4-IxLhe7v6XjDTifni_8jHHfr41bcxwOZtw>
    <xmx:oZrqaDv5So1U9NvlYyGtLmHDU7VLmUMK6wph123eSysB3Fypw2YnwA>
    <xmx:oZrqaPAtJd8vJ-5QryGKcmf3u_zuSdg3Dwmj6ClArPhXIOehtoog2A>
    <xmx:oprqaIo1lMRwGFcsQLLQAbFFN_zTQTE0iAunibScjFHzK7dNY8fGY6td>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Oct 2025 13:57:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] contrib/credential: Amend and harmonize Makefiles
In-Reply-To: <98592a42-71de-d86e-a727-32115615a82d@mailbox.tu-dresden.de>
	(Thomas Uhle's message of "Sat, 11 Oct 2025 14:45:50 +0200")
References: <48d92664-41af-bb59-1844-7bb57f21924f@mailbox.tu-dresden.de>
	<xmqqbjme8rs4.fsf@gitster.g>
	<c7cd0568-8161-205f-7f3e-ce63808dec8e@mailbox.tu-dresden.de>
	<xmqqo6qe78lf.fsf@gitster.g>
	<98592a42-71de-d86e-a727-32115615a82d@mailbox.tu-dresden.de>
Date: Sat, 11 Oct 2025 10:57:52 -0700
Message-ID: <xmqqikgl5nj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de> writes:

> On Fri, 10 Oct 2025, Junio C Hamano wrote:
>
>> Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de> writes:
>>
>> >> Content-Type: text/plain; format=flowed; charset="US-ASCII"
>>
>> Please make sure your MUA does not corrupt whitespaces by sending
>> your e-mails with "format=flowed"
>
> Shall I simply resend the patch unchanged without "format=flowed" or has 
> it to be a v2 patch then?

That was more to remind you before you actually need to send a
second version (or another topic).  Of course, sending an email to
yourself as practice to make sure it won't come as flowed text would
be a good idea, but straight resend is probably not needed.  Please
fetch from my 'seen' branch from any of the public mirrors, and
check what is queued as ac6152f0 (contrib/credential: Amend and
harmonize Makefiles, 2025-10-10) is what you expected me to have
without your mailer corrupting the patch contents.

> Should I also rename $(MAIN) to $(GIT_CREDENTIAL_HELPER)?

I do not think such a change would add any value.  

If the original did not use such an intermediate macro, adding to
use it may or may not have added value for "not having to repeat",
but it meant that now you have to repeat MAIN over and over, need to
still make sure you do not mistype it as MIAN, burdening the readers
to hold in their head what $(MAIN) exactly referred to while reading
the file.  Makefile language does not offer warnings when you refer
to an undefined macros, so using $(GIT_CREDENTIAL_HELPER) that is
more prone to mistyping than $(MAIN), while it makes it slightly
easier to readers to follow, would not protect you from typos.  Not
using a macro at all and saying "git-credential-helper" when you
mean it would have the same effect.

So it smells that viable choices are only three:

 * if the original did not use $(MAIN), leave them as-is and spell
   the values (like "git-credential-osxkeychain") out.

 * if the original did use $(MAIN), leave them as-is, without rename
   it to a longer and more typo-prone $(GIT_CREDENTIAL_HELPER).  Or

 * if the original did use $(MAIN), spell the values out instead.

I prefer to do "clean-up" patches and "functional" patches
separately, and introduction of the install target is the latter, so
perhaps leave all the changes to Makefile macro trick out of this
patch and concentrate only on the new "install" target?  And then do
"clean-up" using Makefile macro if you want, with merit of such a
change defended separately.

Thanks.
