Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C4A189518
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486122; cv=none; b=OVbFWO724Vzol02s80QocwGhfpO4NiPE34s+c3G84R5xZDuNnlqjZNLqxhRhQOnCMYy00CVuuXB1OrnWTfuZ0FybF2Z/yFx2J3lsydEhxX5vpHNbuh6mrUPBxZMVonK51MK18mTSqFpupnSvH1mFBOZU+YJWQ4Vn+amN6J5mjJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486122; c=relaxed/simple;
	bh=1Semz3EU+Bm1GGvGnEqBMT2JPpcnSvJvhST4JLxNFX4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NibHgt+JnRV42DYjmbqJBatLXg8WH2AUH1L8SzuaWNK+iqhC88rSmIuMc3NyVZHCAHBCqRsUCxu160aKMJl3cmQVLpn1mw7crHrI/KyjqM1zAGEDZkXgG9T80czTI515sDKcBZlW4TyuK3MFUzZlY+FAavm0hikMDs4Jgqz7sOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=H7WWpvNM; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="H7WWpvNM"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723486110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+DwRRh3ZQrziw/P20DBL/9YQhjB5yf0OxTUQnxRHM8=;
	b=H7WWpvNMPEuRsuCw6y0m3XF6L3tlmmK3or2sVZDPJoq8Irbqcb5UYkya8zMQMIKPGJQ7oG
	wBnID0spfNHhKbJaqsDYTRiIsOg6GIgea6uUNAU666KHGdtSVu0fwNqP7rIFZ7/zjDXZxo
	tKz0K+V6btrSERjHOifJem54ZUXm00ybhw8YP7TCGacVg98Smj2xv/kvKkeG+VF5sytz/w
	7tMWhcQFSN3M2noAwa5TUX4fnUL6aC7uRV0btEimLNDvOf8G4FqsLyC9mHmbIRjq75aw2S
	B4+Tm/if4zu2ZTf2mxr1mw/H+DD14Ze8LI3rqno6zNLKRGaHJxkOWw82eb8IFw==
Date: Mon, 12 Aug 2024 20:08:28 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
 calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
 emrass@google.com, rsbecker@nexbridge.com, mh@glandium.org,
 sandals@crustytoothpaste.net
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
In-Reply-To: <xmqq5xs688cz.fsf@gitster.g>
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com> <Zrdn6QcnfmZhyEqJ@zx2c4.com>
 <6398d60387a6607398e4b8731363572e@manjaro.org>
 <CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
 <xmqq5xs688cz.fsf@gitster.g>
Message-ID: <3df4270de4e37121084aafcbce1c7450@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-12 10:15, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> On Sun, Aug 11, 2024 at 1:27 PM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>>> On 2024-08-10 15:15, Jason A. Donenfeld wrote:
>>> > Still the same name for v2? Cmon.
>>> 
>>> Yeah, I was also surprised to see that.  This _isn't_ cgit.
>> 
>> Josh addressed this point in the v2 cover letter by saying:
>> 
>>     Known NEEDSWORK:
>>     ...
>>     * Bikeshed on the name
> 
> I do not quite consider it as as "addressed this point" to just slap
> a NEEDSWORK label and doing nothing else, though.
> 
> The original iteration had this:
> 
>     * bikeshedding on the name (yes, really). There is an active, 
> unrelated
>       CGit project [4] that we only recently became aware of. We 
> originally
>       took the name "cgit" because at $DAYJOB we sometimes refer to 
> git.git
>       as "cgit" to distinguish it from jgit [5].
> 
> and then now they as well as reviewers all have seen the tentative
> cgit name, saw the reaction it caused, and now know that not just
> potentially confusing other project _exists_, but it does matter.
> 
> Reviewers already have spent some time on suggesting that "git" part
> should not be "c"git, as well as "rs" part may better be "sys",
> etc.?.  There should be _some_ response, even if it does not yet
> propose a new name.
> 
> If it acknowledged that the time and knowledge reviewers gave the
> topic were appreciated, e.g., "The proposers of this topic saw THIS
> point and THAT point as a input that we WILL need to consider when
> we decide on the name.  We acknowledge that the name "cgit-rs" is
> not ideal and needs to be changed.  But we haven't reached any
> concrete alternative name yet, so this round still uses the same
> name", I'd call that "addressed this point", though.
> 
> But just a dismissing "Bikeshed on the name", as if they do not care
> to be mistaken as saying "those who complain about the name are only
> bikeshedding and not worth listening to"?
> 
> We should do better than that.

I really appreciate and support your response, Junio.  Brushing it off
originally as "bikeshedding" did leave a sour taste, because it 
presented
the conflicting naming as a non-issue.
