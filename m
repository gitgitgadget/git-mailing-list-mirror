Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25CE1FA3
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468608; cv=none; b=lYZViT3JIthKzbysWVAQmucFD8xPot1e37DZ8jGDAtZJ8DuU4v8yTAvKTFxvR7DvLWED1ALFdGP1nBwnU+2asxESL6FUnx75apW9eA8RE8iPPQkoaQa/yoEAqUGULMPA9DDJP3cX77NEgPB+dTUUtvWo++/Ys+EZ4XQLS6MLo10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468608; c=relaxed/simple;
	bh=tcPiBzywSZQEDaCHQviEkmVPtUsVAOPH7WsfwnLXQN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XvioVecNy0+uqgLYJWcdBzwIOmWxm9oGNPPsZKB3+9o2Vt38NQTP07Ui0Ll6IkXlP73KPwwmNKkZOCpxJMD1eYhD/dx5FMH4Kc/VoHE0R0vQ0ScHYkRBLFcfnQwpcT8usnpiOefnF7eHOZZU6Btrq8sjsZjCt9YSSmTdp2WG8kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yUAWjOA3; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yUAWjOA3"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C2FA35D81;
	Mon,  8 Jul 2024 15:56:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tcPiBzywSZQEDaCHQviEkmVPtUsVAOPH7Wsfwn
	LXQN0=; b=yUAWjOA3pzrPzketvgzVQUKUp9X50mOfP9noy72hnVJb82wwakQ7+w
	dTfPrNTGvalPNtuedb/AKTWZ8vzolSTIcsjc+fHgCJqSdSmj83kYbre/lBJoigS9
	GqnEdt5+465PKCrEUDQRaP+X+cA3KdRw7zOUhy0GQvQX00xOjcMVk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 642EE35D80;
	Mon,  8 Jul 2024 15:56:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E42F035D7E;
	Mon,  8 Jul 2024 15:56:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Nathan Royce <nroycea+kernel@gmail.com>,  git@vger.kernel.org
Subject: Re: FR: Provide Out-Of-Tree Building; Provide Cross-Compile Parameters
In-Reply-To: <CAPig+cTaH+TiD9Ut5Q_BPinqdAirW51J56R_tUTSnL=XGzxvfg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 8 Jul 2024 15:08:35 -0400")
References: <CALaQ_hoDqD6CXEDy0YT8no3SaoJSqV6toMtyRHdJr6h3RZUiLA@mail.gmail.com>
	<CAPig+cSB0d7aAwMpToLCa+6Be5JFqLAr+0pvBXQxg_=DEk7p2A@mail.gmail.com>
	<CALaQ_hr2Hzri6y4KwYOPmGzfvM8EjJpddvLL7CQ=d3H4QLCzJw@mail.gmail.com>
	<CAPig+cTaH+TiD9Ut5Q_BPinqdAirW51J56R_tUTSnL=XGzxvfg@mail.gmail.com>
Date: Mon, 08 Jul 2024 12:56:41 -0700
Message-ID: <xmqqjzhvejye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 32C3A842-3D64-11EF-93F5-C38742FD603B-77302942!pb-smtp20.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> I'd still suggest and prefer that git (and zlib) follows what others
>> have settled on doing to be cross-compile-friendly.
>
> I can't speak for the zlib project, but for this to happen in Git,
> someone with an interest in seeing such an outcome will need to submit
> patches.

Sure.  

Somebody unknown to the community suddenly coming here and
suggesting a feature alone would not achieve anything.  If there
were infinite engineering resources and motivated contributors, and
if sufficient number of contributors thought something is worth
doing, it would already have been done.  And "cross compilation" is
one of the things that is so obvious "isn't it nice if we had..."
items.  At least the offer has to be a bit more, like "I'll help in
this and that area (e.g., organizing the effort, keeping track of
progress, researching dependencies, ...).  Any others who want to
join forces?"

Thanks.





