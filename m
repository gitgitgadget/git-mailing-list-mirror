Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE472DA75A
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768518781; cv=none; b=swjYl1wFazO9E/6ZonC54x8sMxDBFIyG2u5epLhieH8krgZapayXYT+PEkrLDWVOLqZAkJJs9/fvwrXx+IdAQwOceUcySVaAR+cH8lDQMDDOTLjjxLQ57LWTrgRS6qMAM6u+qV0Q5osjLCKgEIECC6nIn16heOK+kGXH0vBKr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768518781; c=relaxed/simple;
	bh=f+sO0GL5wGvglbqjX2zDya4/WCIJ4UveUyJTpd6XJGs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AONOofXKEZ/FHvwXUKAIr5EoCpdf6gRox/lTvKL57yUmwjuYmCS0U6EXS4weW5jytf58vW8ULqGq0bvb7Qp4ngEPRCk1SS7OnIQcNpmsE8wHIDZojgG4nJHg4AHjyW2zc+f41kdSNiXU+kIrnI5adNtTlThc1C8cxHylb59tPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ZHZASPTe; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ZHZASPTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768518770; x=1769123570;
	i=johannes.schindelin@gmx.de;
	bh=f+sO0GL5wGvglbqjX2zDya4/WCIJ4UveUyJTpd6XJGs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZHZASPTejX519Fj3dPaj7C1lIebPzRMLwz++5kX91bP6C9cWGQLiI5KkV7pIGMFb
	 HoOI9gpLLk8pNZRWgOO9RBpgIOyfJhxunOBvxRab3q7s0sWj34kHl0Jb/CqdIoOn1
	 v2oUEPLdSDPJ9XAFJDB5G/VUqW+CaY5Jt6ZPGIA+HmQTJYLN9NS8GSt1IVvNlsaes
	 Tn6+vlOx6uhtaaTq2dps2FgJOfG2tszrmHp4nbMSAuHIMuhaQJl2cuK8Z3xo/FADa
	 21GTGaUA3fv2NDSOnuy4s2Gx+SbGqppCrOqlgi4QH9qWzdFS6Q+pWL1Gpq099hBKK
	 plCNnJHPQ4AotSJPjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.21]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVN6t-1vHOaM3GgJ-00XURP; Fri, 16
 Jan 2026 00:12:49 +0100
Date: Fri, 16 Jan 2026 00:12:47 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Jeff King <peff@peff.net>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Patrick Steinhardt <ps@pks.im>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
    Andreas Schwab <schwab@linux-m68k.org>, 
    Ondrej Pohorelsky <opohorel@redhat.com>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
In-Reply-To: <xmqqa4yeblsx.fsf@gitster.g>
Message-ID: <c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com> <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com> <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com> <aWD2x154F5f-c3pL@pks.im> <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
 <20260115211448.GF1053259@coredump.intra.peff.net> <xmqqa4yeblsx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RCPKgguHFqj0bZdbZ3oEf6JA+rPGJM9IzlYck12Hxz+afq0hF4n
 8fAWtVlM5hClRfOPCF2D9v6Vve5sKIuTN0TbMV06wJGyQ2NpTLLjWgAu7ulhJR0Jb1suMyv
 XOnwiZJRSZNW9xgqMAefyeWgoyAQhx9wrUE7jT2cnc5d7ZEljI7Oyd6fu++fn7h8qJ/z8qT
 VAuphLvSUnOqFKn+nZlyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wPhxA9uOJ2A=;CWKE9PV8SShDIHf6pXx+UNmRNYt
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio, Jeff, and other interested parties,

On Thu, 15 Jan 2026, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
> > Is there any reason we cannot introduce the new functionality as a
> > config option but _not_ enable it by default?
> >
> > That gives people the tools to protect themselves if they want to bear
> > the potential cost. It just feels a shame to deny them the tool becaus=
e
> > we can't agree on the default.
>=20
> Yeah, I like the suggestion---making it opt-in would have much less
> chance of breaking set-up people are relying on all of a sudden.

Can you help me understand how these existing use cases (which are not
actually in wide-spread use) aren't broken by design, given that they have
no chance to ensure that their ANSI sequences go to an actual terminal
that can understand those sequences?

As such, it looks to me as if they have a valid goal, but go about it in a
way that is easily improved: If they want color in their sideband output,
then Git has to be taught about it, much in the same way as bf1a11f0a10
(sideband: highlight keywords in remote sideband output, 2018-08-07)
taught Git to highlight keywords in the remote sideband output. That is
the actual correct way to do this, not by expecting Git to pass through
all bytes to the terminal without sanitizing, which is a well-known worst
practice (not even GNU tar does that when listing the contents of an
archive, nor does cURL do that, just to list two of the command-line
programs that sanitize properly what they pass on to the terminal).

Given that those use cases are rare (none of the popular Git forges
support this!), and that it is a security issue, I still think that the
default should be as I proposed: To pass through only a small subset of
ANSI control sequences that you gentle people already agreed should be
safe.

Keep in mind that I already accommodated the concern that has been raised
over and over again about _a few_ pre-receive hooks out there making their
errors colorful, by making the default so that color sequences are
actually passed through! In light of that, I am a bit puzzled how much
more you want to be passed through by default, it sounds as if you want to
turn off all sanitizing by default, even if not a single of those
(uncommon) use cases that have been raised need anything else than ANSI
color sequences to be passed through, and even if passing through control
sequences to the terminal completely unsanitized is insecure.

Ciao,
Johannes
