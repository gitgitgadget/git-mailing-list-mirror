Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1435970
	for <git@vger.kernel.org>; Thu, 15 May 2025 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747305102; cv=none; b=WqdPpf2g9EciX7OdVUZIfY4rO0bM6fYSaNDX8sVBrXd9rU51rjOD09ATa29Yatakow32FQba5ViSVpNyMXtp+mb8Yf2juhXUQ7TvyCDj2TRUMex/tHdUvyc6ajZ4fCq1FTx2SvRFS+YckQcsMQcN/sdCH50hCCuPK+SnkhHOE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747305102; c=relaxed/simple;
	bh=QRokAHKSuVhBUaAneA868bW+SKHmsr8LE8HvfCWuuik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUv+LumqTRdcoE37vvUCb3MY8gdjF3MGUj8VE5nZvZ/dG6f+HdyFNAvajlcjkDOO+/0AXapeSnhevyo4wx5W48k1TpxecyPa7yoaihXpeRlVgYIvqgs9mVkujAVn8jexTsMpo0ImU3l+LSHuAQmbxggpa6rMCScQH7F6kd0BQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=uEe9ZhTK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="uEe9ZhTK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747305089; x=1747909889;
	i=oswald.buddenhagen@gmx.de;
	bh=hZ4hBo+kbUH63rfMBtpO0j3XMxF+9Iq3lmqNQKDRJPI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uEe9ZhTKIbtqqOIFMcM0koO3HL+lmLFG3wRAIwngdNXxQDpYZCpwl2ZN8NbQHeTF
	 +5fmHlusCXihaxaZ7QxLnR2MtvIGx/uqv3cQx9dtAUyTVFLbluyqJNKYyMMoJTJQC
	 E3cj4Pie0AvSswEyzST4A1PZBQRIfqpjuz0h0w3Ge0R9c+67mVf8M1qVuiFfOQGmx
	 oGLl+kD5HCFfq86xVxWC6l/zDx7HoKT9wDhhM9yZBiI0w8Yh+cuhPwQx4E5PuUTw5
	 oQuT7WKVi88Rbx+6nFmnlXhwCQpo0R6iTGvXCICTmc6+Gwi5Lr1OB0/fWrM8vAm5R
	 aBooLJBCSp6HngrgGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.101]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHnm-1v8rLn1ljm-00wGHh; Thu, 15
 May 2025 12:31:29 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1uFVs8-HQ3-00; Thu, 15 May 2025 12:31:28 +0200
Date: Thu, 15 May 2025 12:31:28 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Martin von Zweigbergk <martinvonz@google.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Nico Williams <nico@cryptonector.com>,
	Remo Senekowitsch <remo@buenzli.dev>, Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <aCXCgKYpEqxWxIT_@ugly>
References: <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
 <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <aAgWytQNqtLzg2TU@ubby>
 <CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
 <CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
 <CAESOdVCKTnUbVuXq-=F3df4i2T-GcDpJMENr8wwm-ZXR95+59w@mail.gmail.com>
 <xmqqtt5pu5g8.fsf@gitster.g>
 <CAESOdVD-8j9k2Dq9WgiR9WWO09mpfR9Xxe3pMUWg-KoTfELG8w@mail.gmail.com>
 <xmqqjz6jb6kd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqjz6jb6kd.fsf@gitster.g>
X-Provags-ID: V03:K1:EdknSK1/qrc3h/xg7tBJzkE+6F1UL4iGjzSHp46G2oOEkTnnWWB
 +GP6kITQ6GauDj2fu9WexeAi5mTq1Hrm+ujtFrtgFCV7iIJsRg0AhWhD4G2g1eozxmcHwjo
 g20jibf5CXli+19JRT1NTedkFWBQzoMYQg4UfI6g3rglSYXzFZ6CxVzyvreRR8oqCJpGuL/
 SGU/MULSyPdeu7BgSPKgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:r4v2fHOFJuQ=;goNNBsH7GWXm5mKn+80eMZ/U/bF
 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
 7NnqhpydjZhStrBKthsbu+8RI//uwW9oFm
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 07:38:58AM -0700, Junio C Hamano wrote:
>So I do appreciate that the wider Git ecosystem like Gerrit and JJ
>are talking to adopt "Change ID" with the same syntax and semantics
>(if they all can agree, that is), but I do not think it needs to
>affect Git at the object level.  From what I have heard so far, it
>certainly does not fit in the commit and tag object headers, but
>more like the usual trailer thing.
>
but it doesn't really speak against it, either. it's a rather subjective=
=20
call whether 3rd party metadata should be included into the commit=20
proper or bolted on via the commit message.
this is really quite similar to rfc822 headers, and no-one would=20
seriously argue that "auxiliary" meta data should be stored somewhere=20
else. in fact, the current recommendation is even to omit X- prefixes=20
(rfc6648).

it certainly seems valuable to at least have an example that proves that=
=20
git doesn't corrupt extra headers. however, that would be obviously=20
insufficient for "proper" support in git itself, as creation, editing=20
and display of these headers needs to be reliable and convenient as=20
well.

the use case for change-ids is addressing evolving changes (be it=20
locally or in online review systems), which requires a one-to-one=20
mapping with a commit in the active working set (sans the fact that a=20
change can exist on multiple branches). as such, the ambiguity that=20
tracking the complete evolution of commits would create would be even=20
actively counter-productive for this use case.

by extension, it is sometimes necessary to make a conscious decision=20
which change-id a particular derived commit should have. for this, it's=20
quite convenient to have it in the commit message, because this makes it=
=20
easy to drop one (or both) change-ids when squashing (or splitting)=20
commits. however, this could also be achieved by having a defined format=
=20
for editing metadata from within the commit message editor (this can be=20
already achieved by having prepare-commit-msg and commit-msg hooks, but=20
it's messy and lacks standardization).

one argument against change-id trailers is that they are eye sores, in=20
particular in small projects that don't use trailers otherwise. this is=20
in fact a common argument against even optional use of gerrit for=20
reviews. having a more "subtle" implementation in git upstream would=20
certainly alleviate this.
