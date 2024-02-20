Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3377650
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452272; cv=none; b=ChFuyVL495UDAtoz7Kxc58ht7n2gCEEgJCImt3ibvGtmDrRloVpk3P/jBXDNUq8N+Wu88qVPr+voNoQ/Zr3YWsxE5K0Uo6rzhh+i73EcB+57E58fX1NfSZyCmR0EbTpRIm6UlmOl3DRAtFVHUr9mTKBctjqYt7yWx3wVDZPAUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452272; c=relaxed/simple;
	bh=68z2Yk54GaH57HHSQPvQ2RZc/6hEb4QZC4fB1LdPddE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aXz/FfbeyaN45y3DHsXEYxFFXFaa0P5IXfjsHkbhGpU08BIUpjxK+BrU28Udu13vJC32lK7n961j+nivA+xrw9ofGRiy7VAcG+O1rZZlJX+jE8CFUGoQs4U/zWa0x+MNyJm/XELUzhuA66UHc1Fp693HSVSjSBlJMzoraoKy9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mt4emXXU; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mt4emXXU"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4019A2CE3B;
	Tue, 20 Feb 2024 13:04:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=68z2Yk54GaH5
	7HHSQPvQ2RZc/6hEb4QZC4fB1LdPddE=; b=mt4emXXUY1VX1iVoqam04ExUye3E
	WOwBpMAGNKwdv1EznU1LTJ8q9CXr4UJVKu6XGg3uVhYQ4hHS2H8mu8sKVxQPWZ6h
	U9T8osAD1fn2OwngcW77+pzjh41jH6/JrBeKp/cncFPvM59elVDABvXKWF+TqL3c
	Kzyu7T5CUtwG+Ag=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 384902CE3A;
	Tue, 20 Feb 2024 13:04:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CE3D32CE38;
	Tue, 20 Feb 2024 13:04:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,  =?utf-8?B?Tmd1eeG7hW4g?=
 =?utf-8?B?VGjDoWkgTmfhu41j?= Duy
 <pclouds@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] Revert "Declare both git-switch and git-restore
 experimental"
In-Reply-To: <920a0f61-d30b-49f1-87b3-fb947cb3c33d@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 20 Feb 2024 12:36:10 +0100")
References: <20240220092957.1296283-2-matttbe@kernel.org>
	<3523e325-98bf-4d2d-847b-28e5c4a85ec5@app.fastmail.com>
	<95eb92cb-7954-41c0-b542-5169ed5f9892@kernel.org>
	<920a0f61-d30b-49f1-87b3-fb947cb3c33d@app.fastmail.com>
Date: Tue, 20 Feb 2024 10:04:25 -0800
Message-ID: <xmqqzfvvovva.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7C53343A-D01A-11EE-966F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> The only reason why I ask is because I was vaguely aware of some
> discussions (don=E2=80=99t know how long ago) where someone was skeptic=
al about
> changing one of the two experimental commands, and then someone else in
> turn expressed some frustration about this concern since they are after
> all marked experimental. And the context was some UI/UX problems with
> the command.

There was a discussion to further make "switch" deviate from
"checkout" by taking advantage of its experimental status [*1*], for
example.

Being marked as "EXPERIMENTAL" allows us to redefine the behaviour
in a way that would break existing users, like changing what the
"-c" option means completely (so that folks who are used to say
"switch -c blah" will be surprised next time they type that command,
but they cannot complain).  Once you remove the label, you no longer
have such a freedom to even imagine departing from the existing
behaviour (I wrote essentially the same thing before [*2*]).  Are we
ready to paint us into such a corner yet?  Is "switch/restore" perfect
and do not need departing changes anymore?


[References]

*1* https://lore.kernel.org/git/211021.86wnm6l1ip.gmgdl@evledraar.gmail.c=
om/
*2* https://lore.kernel.org/git/xmqqzg6eocmi.fsf@gitster.g/
