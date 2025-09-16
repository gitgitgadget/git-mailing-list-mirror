Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AAE189F43
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038625; cv=none; b=QNfQ86s3c4bpsm+OThu7CRczf7RFjxEDmzxCkjcTyMoYUEHrg3rnKv8sKiqMdF2V1nl0DsYHwJpEvZ0GEwdhTfjcyXR+MmhrZd6/kwyOfJe2hfmVd+XLl8em5RDpz6xeMKj/zwb5gPLCeocDei8/U25Z7XduuSyUGC3D68qaupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038625; c=relaxed/simple;
	bh=L6cpEU9RoeK/t+TNLOZ1UlA3XMT4QRDa+dsACAciFBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wv4TzUNT7CZ5ZKYC/tNuVA83G5VZLM+VZd/3opTKMBHdRmljrFIeqGenHzqE2Yr80Ax4/WRZQf1oTJLw6AqCaZrBG1ysX9u8mbp3CkAFllg1l5AWDKHYBvkdE6q8DfuVb4i0PSrhv+S1Ag1fA8pkoUQEh7hSwSvZcBxk5abrpn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M2QSqea6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CpJEjbjC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M2QSqea6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CpJEjbjC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 96755EC0032;
	Tue, 16 Sep 2025 12:03:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 16 Sep 2025 12:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758038621; x=1758125021; bh=lPXDYVM4kA
	O4kR+7fOnSvmEXzlS+eYwIhT9k3m5C6qM=; b=M2QSqea6Lo1S6oBHEzCwBz2naf
	saqCAf2Pqau2ymLVxjNAfto411bWSI+qlZ+EjbhxQTdmoUC0XiL9Vl34Adz7lkNs
	kH7ZHq6LxdSZpTKq9TTtBzEuXnjpl34EmwW18JwogqcAv6srb1yTadFsUIEd+QWx
	YWbmr/ECvBg5M/OOca2GwrAyWF1UxJjgzFg3yRpz0YApLVENFphCZs1epbIXFMhY
	0tjO46BQGpfGU34ayooYYJGd+aVS+OnmxxoQ+hZCo7yrsnns9Eohyx8lzxlBYap9
	GkCVEvHPbvW5wJb3O1ZJ+dvEFZYmqP8a05t+9xaL3g25m8lmdlKvF+ywdUSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758038621; x=1758125021; bh=lPXDYVM4kAO4kR+7fOnSvmEXzlS+eYwIhT9
	k3m5C6qM=; b=CpJEjbjC4ogRnmM/EaUnrrP4miHrZg8XkSZMhkxu+cqijxtFIwJ
	YhnWfTzjmVszw/lFh4FvQxganZS+i4yuRsz4xKMjh+yVaXvNRyBq3YbXzDMOv1nK
	jigAKS2XcoRMaFLm/mM0qDIGQMP50tI3w90jKaWxh79YYIRYVspgN1lGqc5mPIvo
	vL2b/zC4CN7Vg37FkJd4NXSgxl5HiCEwO4EtTnx1yaw9pFUkqjt5gDxxsUdHeS3y
	DBfUkLxBpgdMXTFXKdrQ+4kmTQRIOgyLAeZIBRra1BkktmNGUE9jrs1WPcIPf0Wp
	cnyIvHIBtMcSPPLK7YQW9rhRFXvq/Lrc+pw==
X-ME-Sender: <xms:XIrJaLQaA2CVnxQEzRDEGk6bJyO06evI_S5fbm2DNMetMq1lwEue2A>
    <xme:XIrJaNjltcfodtk_IjywLt7E_mTmVFOGycZnJfR8VGq5mhpgd08Q08Bs-CZgvCinr
    xZgSNA7phYNANLFSQ>
X-ME-Received: <xmr:XIrJaM8LQzfyXkzRFdmP1fPSQOZqBqLv_7W72knAF69UE7QARPJ4OVE09h7sMoG6AHPv72oedkH8eXRbQB0fM2D5Oc2Ti8QsDMXoGvE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:XIrJaMF3BDcXynQOk3qm6BJ0E4nSTHIcAJdtK9I4uAVM7uZtx_EY3w>
    <xmx:XIrJaHlnODOFAbFASLWiOB4uvLkU_2fW_NxxCKqDJ9__SMFQk1wtBQ>
    <xmx:XIrJaIagyrjIXObcpILAHKp0d2DWWhIPvNW_N991V-aXcsdicq6rYQ>
    <xmx:XIrJaEErtnh27XUq6OtpSiF2QisgX9m3w7CQ32EInc4Z7KB1Ob8ejQ>
    <xmx:XYrJaOMPKE6tBTr7rvajM3FxvmiTXxVZtgW1vsulsaTxbJj2inf_HY4l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 12:03:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/2] add -p: mark split hunks as undecided
In-Reply-To: <cc2a8fa7-be27-48a6-8699-c500d894404b@gmail.com> (Phillip Wood's
	message of "Tue, 16 Sep 2025 10:36:10 +0100")
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
	<pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
	<3e2ec7b37f1935c5b091fc4b47b6209beb384d3a.1757950144.git.gitgitgadget@gmail.com>
	<xmqqbjnbhapy.fsf@gitster.g>
	<cc2a8fa7-be27-48a6-8699-c500d894404b@gmail.com>
Date: Tue, 16 Sep 2025 09:03:39 -0700
Message-ID: <xmqq4it2pep0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> To me, the current behavior is strange enough to be considered a bug
> but when we discussed this before you were not so sure and said [1]
>
>     Given our user base has grown quite a bit over the years, it
>     almost is a given that any change to existing behaviour is a
>     regression to somebody.  Certainly a safe material for Git 3.0
>     but I do not know if it is safe enough for 2.50 for example.
>     The strategy to leave it longer in 'next' did not work well
>     to catch potential issues for another topic during this cycle,
>     but we could try it out again.
>
> So I re-rolled using WITH_BREAKING_CHANGES. If you're happy just to
> change the behavior unconditionally I can go back to V1

I am *NOT* happy with breaking changes.

Either you cut off those who you do not believe exist because the
behaviour is so strange and useless (i.e. immediate "this is a
bugfix, there is no mechanism to keep the broken behaviour even for
a short period"), which is much better than that from my eyes if I
were to be convinced that the old behaviour is nonsense, or you
support them with configuration without any future deprecation,
which is also fine by me.

The breaking changes mechanism is to be used only when we are
convinced that the old way is nonsense, we are fairly sure that no
sane user is using it, and we have concensus that the old way MUST
be abandoned and any existing users MUST be retrained to use the new
ways, and only to buy/give some time to these users that needs
retraining.

Have we got that firm sense in the community that the old behaviour
qualifies for breaking change mechanism?  I don't, at least not yet.

>> On the other hand, assuming it is not a bugfix but introducing a
>> different behaviour, where both the original and the new ones are
>> useful depending on the situation, wouldn't it be better to give
>> users choices at runtime instead, with a configuration variable at
>> least, but possibly with a interactive command to choose which
>> behaviour is used on demand?
>
> I'm not really convinced the current behavior is that useful and it is
> such an esoteric use of 'add -p' that I'm not sure it makes sense to
> add a config setting for it.

If so, let's break it first and see if anybody screams.  Touching
the breaking changes mechanism is way too early before doing that, I
think.
