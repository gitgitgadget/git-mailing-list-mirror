Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DC881ACA
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770102784; cv=none; b=B6sQovkOAKbBxqvjoi6O+Ad3ZJxiwr9QNFZQpf0g4ES96eVRZ9lSnZ5fom8HqIrWctGjuqO//GSbDDIInZbXtOYRIHKtZlKd+0EJA5bEGUOewe1s5MjahIu8+Q1h2Mum50ehyblBdNgSawAEFcDLgj47TkSo68LMkfsWek19ngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770102784; c=relaxed/simple;
	bh=ZmexR08XlTPIbjux1mbrVIpRxEa4wb09d8wyTP/bA2E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S/SmD7u+CbJsa+myZqtO3tQugqRuY8hQ5Z2vDmMVm66yTIWaRHEiFe/E8AU1gzU4DUZrL6U0JXDbaQR3ToKCrpegim6kWF4YF9lidGRP/j+Dc3nE8j1KNaDETmxPAc775ce+GFdjlj5qmQXYuZGXojEAKp3JlR6kjWq7f7TKlLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=P19draAs; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="P19draAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1770102770; x=1770707570;
	i=johannes.schindelin@gmx.de;
	bh=KMn08nEXMeA0d86HaSCyoZvg4d/o1vEhO3XbyQ7c5Bc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P19draAsbSX1BUwJ/FXh4VEiJfzY4grDYvSDCdblnL/iC+lep/cAz5TRsSAHqYa2
	 zihdvIhhLuJSWW85Q1xVwNG2x9I6Pz16c22II5G5yzilpez7B/JEj0ZdVBGXxsJz+
	 dI7DLzM/GQp/S0tozUiZWOBUEj4Y19X2vveXdUQo8TToDlKqdU9jtr7DbrsU7EuBm
	 b02YYsI+YckxMTTcI4Lh+lm0yj+2dqkVzDXvrZGzP5KMuCb/0mewfIZJrZNXwo0ir
	 dDpYztBpY3cgkHmv4r62GzyU/Kmvsybu+TVT0l70T1j6p6E7XSWCA/yIIBSJjcPYf
	 IJb0FbJJZequxgxtOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.112]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McYCl-1vGqRr1MY1-00ZeqV; Tue, 03
 Feb 2026 08:12:50 +0100
Date: Tue, 3 Feb 2026 08:12:47 +0100 (CET)
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
In-Reply-To: <xmqqo6m6vdf8.fsf@gitster.g>
Message-ID: <22d81c06-6ef8-dadb-5f1c-cd9461bb290d@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com> <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com> <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com> <aWD2x154F5f-c3pL@pks.im> <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
 <20260115211448.GF1053259@coredump.intra.peff.net> <aWlz-0AOlsFLaBO9@fruit.crustytoothpaste.net> <xmqqo6m6vdf8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Hdgx4m6cUuVzexyyguflUoDkkLGmr69y1dGeftWRTe6mN/DXPmd
 XcQA5lkw1FdjKnHBNWvRaj6+SPs6Qmr6iLBa8CXlB3AG88dBYe6nbD8nbzd3w62s9mGznLj
 HohcaCdrUEAfMErQVTiTXB4CcFVAtD2mSvKYHKNCPZNkHNbnmTf2ruvgp04qxgiqAxXvDo+
 ZwYvQkL3cibESGYrqdFTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B5umCn6IHEw=;r+XPftw8fdlKKdcALwFv+mHd/RD
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 3 Feb 2026, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > On 2026-01-15 at 21:14:48, Jeff King wrote:
> >> Is there any reason we cannot introduce the new functionality as a
> >> config option but _not_ enable it by default?
> >>=20
> >> That gives people the tools to protect themselves if they want to bea=
r
> >> the potential cost. It just feels a shame to deny them the tool becau=
se
> >> we can't agree on the default.
> >
> > Yes, I think that would be a fine and reasonable approach.
>=20
> Absolutely.

I disagree with neutering this security fix. Let me explain why, and then
propose a compromise.

CVE-2024-52005 exists because Git passes untrusted payload to the terminal
without sanitization. The terminal interprets control sequences sent to it
(it has no way to distinguish between sequences Git _intended_ to send and
sequences a malicious remote slipped into the sideband). That
responsibility falls squarely on Git. Shifting it to terminal emulators is
not viable: they _cannot_ make that distinction.

This is not about one specific vulnerability (OSC 8 or otherwise). It is
about the principle that programs must sanitize untrusted input before
passing it to an interpreter. Terminal emulators are interpreters. The set
of exploitable sequences changes over time as terminals add features; the
only durable fix is sanitization at the source.

Now, about breaking existing users.

The patches I submitted _do not_ break pre-receive hooks that emit color
sequences. Color sequences are allowed by default. What is disabled by
default are sequences that set the window title, query terminal state,
move the cursor, etc. (functionality that legitimate hooks have no
business using, and functionality that is ripe for exploitation).

The concern about Japanese ISO encodings colliding with control bytes is
theoretical at best: sideband messages are prefixed with the ASCII string
"remote: ", so any such encoding would already be broken today.

Here is the problem with "off by default".

Turning the sanitization off by default means CVE-2024-52005 remains
unaddressed for the vast majority of users. Providing an opt-in config is
security theater: users who do not know about the vulnerability will not
enable the protection. That is the opposite of defense in depth.

Fedora's decision to ship with sanitization disabled does not validate the
approach; it reflects their reluctance to diverge from upstream defaults,
not a security analysis concluding that the default is safe.

That said, I can see a path forward.

1. Turn sanitization _off_ by default in 2.x.
2. Document clearly that this default will change.
3. In Git 3.0 (the next breaking-changes release), flip the default so
   that `sideband.allowControlCharacters=3Dcolor` is the baseline, i.e.
   color sequences pass through, but nothing else does.

This gives users and tooling (and support engineers) time to adapt while
committing to secure-by-default behavior in the near future.

I would appreciate hearing from anyone on the list with security
expertise. The principle that untrusted input must be sanitized before
reaching an interpreter is foundational; I am not aware of any credible
security guidance that says otherwise.

Ciao,
Dscho
