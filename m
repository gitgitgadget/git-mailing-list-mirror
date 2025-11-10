Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80118318146
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762801812; cv=none; b=uTvdQBcrTGzIOxvT7FuLI+yQkU27TQ3vFjENWH3Hz1Fy1lTcVxfrnaFiq1jXYdzEctXJdC1yG5z10Zj0Tvf8VZ7cniQPn+9c4mp6KHGgL/Oo2h8L0L1ejD7PvnIzDqQ/1juzpQAAqaKaKqzNH9ltQuQovHgac62SzrvllG0F2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762801812; c=relaxed/simple;
	bh=VDD0TS8KydbcLrXupK8eF3gNxtyJwdvZASTr6uWRdWk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mfxAY9//Vb5Y5ftbW7xKk+tPiLQG7d/L4+dZORoc36n2Mn2LkIsPQM6Rzp+JPiHUMWw3Z9KgK6ANH/stvvQbIeJNpZ4iEap4XkZP+XrNNt1aG1MKeBYP0jGPRDLX66RO5x5K05sFv20eXMwGnmiYZBEJfFslgx4PE1f8phvl4Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nszPPCtd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I+mBesiQ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nszPPCtd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I+mBesiQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8391C14001DB;
	Mon, 10 Nov 2025 14:10:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 10 Nov 2025 14:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762801809; x=1762888209; bh=Far/LlZ7jS
	E7IPQYj/P2c5sdCXt5gRuB+lkWoC1tk0M=; b=nszPPCtd1kyQ48bKD0NvcpQikv
	2oYocVdBGgzuK3jFs3Wf+aEy5qRoPgQIT+qPUOOMqAKym3XaiowBRrsG35IZWtcU
	wsYNviiMHXt86p3LeK2LkO9Y4uU8mnsbWQYXpMINe6hOuCt6Peod65XOvv/A21rk
	fO5z6OvzCGrH9LGt0mbHDBY5oruUVlFAbgIrW59wtgdcyuAJnOamf1ZmLOu/nDQn
	b4Z2BA0ebdRxfGpSXpvMusxMnwqMC3fztFj3LclJ313f1Ck7X5Y8PpB/oOAKdx0E
	l3icj15DejXpAM/mONrefFuKBtbq1h9Ho7krzMhevSPHW8z5d+JcXTXnf4gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762801809; x=1762888209; bh=Far/LlZ7jSE7IPQYj/P2c5sdCXt5gRuB+lk
	WoC1tk0M=; b=I+mBesiQEHoJWQ8QVqlM4X5DUiNWHkUZyjHki4iQRbrTnaGiEdL
	tPWH8M/tAPOm3xLRqHto2BS1UyWM4nVW0Bc+M1aEtbq3NGHXQKySvpgEYnxpRtSl
	5UVog3e6OuaeoDJug2xqu090dxvs2kQPwWdUER6dC62CY4c/7ysCdwkB79uF3GfU
	EJ4lf6pjaRXkg23ThrKb22u2xCXurp+RTb+pFYqXaR8EFsUZu76xUiMG4tXlxj2I
	KUDczdDTJtfck/zFc/6Q3UWaXbSzw1tEp3S9yYIz9Vq3XU+aDCtzrmTRHi6zYlA2
	+en7XYr7JScoqtUO1/Oy9Gi/BwFf+D3UWmA==
X-ME-Sender: <xms:kTgSaXYX8L6zAQx4FYK3VXIJGby3D0BG9nLHSxKiZ-uOFhSUOwvJ9w>
    <xme:kTgSaSNsR7Mu4neAFTbRCTqq6H-uqEdKzbdWvG673K_sFmq17iAImhnOzUKqO_hfB
    hGQUJMrQG2i1-TQjxsQsbmuBaq-sBJHQ-7h594vFnfiX516Yo2Z>
X-ME-Received: <xmr:kTgSaVW2JVM8xU_oUoLd0m6HpgJehaFsiiq26_woHaDLCOK9hUihWzsHqJ3-_Emq6Q4qEfQDKN6d1R9rH66-D9wZxCMT29MKYLa0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeluddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsoh
    hrrgdrtghomhdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghmihhlhi
    hshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehruggrmhgriihiohes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:kTgSaXI96UdBMRnAy59GeTJNngxTHyNO4Zatss7iQnYLGmQbsfB1Tw>
    <xmx:kTgSaQosJvM_4uohY055ZOfld5m8msajFL6P17Gvm81petWSWwmSxw>
    <xmx:kTgSaeyNCEN63_1HiSSlpjV5c4kofpT-Tpg28BhPVvg8cWIE2i9Msw>
    <xmx:kTgSaUuDT4FTWsi4VvhKUtVM_y3MfvK3nqmXcxSwpBCYYLjn1cKz_A>
    <xmx:kTgSaaXoUgPheQC73Hv0DEPJVmXtBX-jomfDJjmOVS5WpDz4M1ed3bIa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 14:10:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Aaron Schrab <aaron@schrab.com>,  git@vger.kernel.org,  Emily Shaffer
 <emilyshaffer@google.com>,  Rodrigo Damazio Bovendorp
 <rdamazio@google.com>,  Jeff King <peff@peff.net>,  Jonathan Nieder
 <jrnieder@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 4/4] submodule: fix case-folding gitdir filesystem
 colisions
In-Reply-To: <87ecq5ke2m.fsf@gentoo.mail-host-address-is-not-set> (Adrian
	Ratiu's message of "Mon, 10 Nov 2025 19:11:29 +0200")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251107150547.3272180-1-adrian.ratiu@collabora.com>
	<20251107150547.3272180-5-adrian.ratiu@collabora.com>
	<20251108T182050Z.vbNv4y2kizC1@fnord.qqx.org>
	<87ecq5ke2m.fsf@gentoo.mail-host-address-is-not-set>
Date: Mon, 10 Nov 2025 11:10:07 -0800
Message-ID: <xmqqwm3xzots.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> On Sat, 08 Nov 2025, Aaron Schrab <aaron@schrab.com> wrote:
>> At 17:05 +0200 07 Nov 2025, Adrian Ratiu 
>> <adrian.ratiu@collabora.com> wrote: 
>>>Add a new check in validate_submodule_git_dir() to detect and 
>>>prevent case-folding filesystem colisions. When this new check 
>>>is triggered, a stricter casefolding aware URI encoding is used 
>>>to percent-encode uppercase characters, e.g. Foo becomes %46oo. 
>>>By using this check/retry mechanism the uppercase encoding is 
>>>only applied when necessary, so case-sensitive filesystems are 
>>>not affected. 

The .gitdir name munging is a local thing, so it makes sense to do
the casefold mitigation only the filesystem is case folding one,

Your code seems to compare directory names textually, and downcasing
the proposed name for some reason, but I am not sure why we need any
of these complexity.  Wouldn't it be the matter of actually trying
to mkdir(2) the name presented (either "foo" or "Foo") and see if
that fails?  If it fails (most likely with EEXIST if case folding is
getting in the way, but for any reason), the name is unusable and we
need to "tweak" the name to a usable one at that point by retrying.
Once we find a usable name, we can remember the fact that we already
created a directory for it and reuse that empty directory in the
code where we used to do mkdir(2), no?

> Maybe we could derive a new path automatically (eg foo2 or foo_, 
> suggestions welcome) and use it if valid. This way, there is no 
> user intervention.
>
> Do you have any preference?

If adding 'foo' and then an attempt to add 'Foo' will automatically
assign a name that does not conflict with 'foo' to the newly added
submodule, then the users would expect the same to happen if the
order to add them are swapped, wouldn't they?

IOW, I do not see why the code wants to treat uppercase and
lowercase letters any differently, and suspect that it might be the
source of additional complication.  Also, if there is an existing
module with a funny path "%46oo", you cannot just encode "Foo" into
"%46oo" to avoid crashes with 'foo' and be done anyway, so it feels
like we are inviting more bugs by special casing certain paths (and
not encoding or checking others).  Don't we have an issue similar to
"case folding" in macOS wrt UTF-8 canonicalization, too?  An
identical Unicode string may be canonicalized in two ways, so in a
presence of a submodule named one way, the other submodule named in
the other canonicalization, while their names may be with different
byte sequences, cannot co-exist in the same directory next to each
other.  "Try to mkdir(2) the new name, and see if it succeeds, and
if so use the resulting empty directory" approach would cover that
case with the same mechanism as you need to use for case folding
filesystems, I would imagine.

