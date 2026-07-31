Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3265735C6BB
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785479333; cv=none; b=c0UTRAnKCCxXZAlgHXPhuzaxwCRxTK9MdF6G8w+AaOqviZ5OUV8cScMSgZUkiCtyqJqHl4DtaRqxeSkbRgXelJnIA3vZFWMsUeiBsRaljAQ/6P4v7qt5imXjA14SWwPWFIe+3Nyofmvf1KsU+nl4PiiEYGvefH0KOT8vDPsWwnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785479333; c=relaxed/simple;
	bh=Y337RFPIp8i5q7ZCG60ZptaQ/Sw+rKAvND1+JLIpRks=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=iHRYXegEs6v3qhO/bnvi7kdLw46BXivjuHORdFBaNMoWQE1bXQ3yDRlsHAXvrBth9hRcZGJtfooiTA0c960YiB/Qi8GrwnFM1Q89fZuyHqeVwJRNCnQVE+pJbhgonmxanaf9n0JhvdTFnnUOwXQyfSkS5bp3t7PPesz0x6ZbEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=VsIkjSSR; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="VsIkjSSR"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 43AC460905;
	Fri, 31 Jul 2026 06:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1785478824; bh=Y337RFPIp8i5q7ZCG60ZptaQ/Sw+rKAvND1+JLIpRks=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=VsIkjSSRaU5MOA0Z9pKwnXJRsuiq/X5sFVL7Xj15P+WU11Y5qRlO/2Q5k3YS7X5Fn
	 8aLsw7JON2OaF/DVB5UcidkqdrwZcgmackCmY37lPS3cenN4gf0FN71B1vMqjGy0cN
	 POHYZvg+KPmLv7kbcbwg/FGnj06igrSbnnfuJAF0=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 02:20:23 -0400
Message-Id: <DKCJF4116DLD.3B078238N2B12@lfurio.us>
Cc: <git@vger.kernel.org>, "Harald Nordgren" <haraldnordgren@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Phillip Wood"
 <phillip.wood123@gmail.com>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: What's cooking in git.git (Jul 2026, #12)
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <xmqqfr15ruw7.fsf@gitster.g>
 <f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
 <xmqq1pclc210.fsf@gitster.g>
In-Reply-To: <xmqq1pclc210.fsf@gitster.g>

On Wed Jul 29, 2026 at 10:18 AM EDT, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>>>   The experimental 'git history' command has been taught a new 'squash'
>>>   subcommand to fold a range of commits into a single commit, with any
>>>   descendants replayed on top.
>>>=20
>>>   Will merge to 'master'.
>>>   cf. <DK1KIF2OI8IF.11188A3YEQV1C@lfurio.us>
>>>   cf. <DK1KIH6CXW0X.1U2V3GU8L6HB7@lfurio.us>
>>>   source: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
>>
>> Oh, I'd missed this going into master. Has the implementation received=
=20
>> any serious review? I've seen messages from a couple of people trying it=
=20
>> out but I can't see anybody reading the code.

I believe I was one of the last people to comment on it.  I _had_ done a
read through of the code, spotted some things, but appear to have
missed these more nuanced interactions.  My last "lgtm" message in the
thread really meant to say "these latest fixes sufficiently address my
comments".  And as someone who doesn't have much history on the mailing
list, I assumed Junio would weigh my approval accordingly :)

I didn't notice this had advanced to next either, and may have spoken up
sooner if I did.

So given all that, assuming I had come along and looked at these
patches, but found no issues in the first place, I probably would have
stayed silent.  Should I be more careful with such a blanket "this is
good" message in the future?

Sorry for any hassle - though I don't expect you "blame" reviewers for
this sort of thing.  It's a lot harder to demonstrate correctness than
point out some potential problem.
