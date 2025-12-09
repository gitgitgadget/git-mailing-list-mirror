Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C5323EAAE
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321359; cv=none; b=rO9qcrLF25OYn9G+dZ1GzRQWiE+3+iruJDPNxoNWpQp31f0gAiNJJOr2Zke4BHAD9SmvTf0PM2ioNTfDCVl18W4VTONBJtJ6kP2qx8uHAU+y7RfYoVjpYBcwnrAjooGiCpGPgZHKSt7tBre6xl69KgEVVlOn9j3TYe/OAtF5Vu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321359; c=relaxed/simple;
	bh=KP9htklFH48+fmxmQofhq0skPf5/nqjpqtqZMfnRZmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JYn3krjFXSjebnzSsJjKxrjDBZhbdEgN+uL7uCXk8qykf7kzb0WE7A9hNr8dFP3jGPsAfFk16RZMVEqfvRLgzMi9BAaVgieiuuQ96NdrFaSlJZpPHNl96ehFdhyq5i42eh/NDbOhjqEN2YGiIwz97gs9+d+ZoO6dw2N5wpIHyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QOnmdD1/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=en5B9Qfw; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QOnmdD1/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="en5B9Qfw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B42D41D000B5;
	Tue,  9 Dec 2025 18:02:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 09 Dec 2025 18:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765321356;
	 x=1765407756; bh=luQ+8TXx5Qv/cdI9brEx6YAq79gXxZje4GKMF2ySeS4=; b=
	QOnmdD1/lieRes6SUqSlk5wgIf2xEaxKXFqV6HCoh9DS/ayw66Ttxo2+rryx6vIZ
	9gydlDwNIinqWoiXF9VTtm94ly0bGMKvzsR6qE4DAc3p0oj9XBsGLd7xl+tBxHp2
	MYJx2RPkRqudbf42dR3vDXTkkOS6C9dyINcg3Taj5ICNAJJhzsrKaiEv7EIUEZoK
	2qRpP36S/dw8dnJ8WFdKjT54bngsjPFb586L99kirRwZNa8AyOpxAbVf5ro9Oblq
	qJJ4HUIVGleCEOyBRWqGbn4wxmgqsZ15ju/vH20YMxRPTuvTXplV4uxAHe7r1F/H
	0lbTHH9mHt92LwEe3wVL3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765321356; x=
	1765407756; bh=luQ+8TXx5Qv/cdI9brEx6YAq79gXxZje4GKMF2ySeS4=; b=e
	n5B9Qfw67RhXjOGeCGK16/PUk8swc3Oc95Es2oulFF6tf+D/YKF6yhoxGE+mS7RM
	GE4pUzKquwkvxBuokAfWsynT6xzntEufm7A82ybxnpvFXjXoA4LnrhXqW6GzC/II
	5JBmgk/loMmMmfRkmsCw5fBnc0XVJZ0eRyBRtNs/q+6kEFqga7YprhvFu3PzPFIs
	rvmP/D3opXlymt9UoqoaXlCRM8jiRtoGv/L4kk2PjsbHNToY2fc4DYztBuS9k4AR
	farYMaZC/yzXGOGHXyBI3XN9ik7noMjGENLenpvx7XfnnrQByLjA9To+aw95ytRA
	CtXdFT4BRqmFxwnw2PIlQ==
X-ME-Sender: <xms:jKo4abkK70OKwO52Q2NYz3FDSpjWN6-Zvkob39MPvDT__xijvHFgdA>
    <xme:jKo4aRHLw_-YJG7309W7EGNuDQUJmR1i8JlDrXtQ-XlSiwAnf-D2unVoIrzUgj9dL
    YLCBgN9WW-KAtQbObxCTY9Aq3sCHQWEGx5c_ewr5ZyIkHD_U4faEw>
X-ME-Received: <xmr:jKo4aT6Yvqub-0xxCy8P9WgYwCfSszZKcWTA5AgaYGnIHzcvb3Lw4dfACBYEO3n-eEB8uZC7fwDFb3eqelOoxpytwb6vUDdDHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtph
    htthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrth
    hhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jKo4aZn0xQjqcerFVfyuhz6O4eYJbOusg5mOLU3WY2eScrAPMZRlOw>
    <xmx:jKo4aYpvywgmI3OKqnTLiamboAUp97hi3TTCjfruQ2fOCBICtdD2dQ>
    <xmx:jKo4aYvZWVZy_w7DSHPwpU5U3m2U0Ou-FENxqjBaI-o3FXyXgQ4IfQ>
    <xmx:jKo4adHdsgfj5NNvpU1TUHa3fVPtSApzXpdLUyD8aW_P3cKRKawK1g>
    <xmx:jKo4aY7JdC0WWCw-b3OzJPaDtkPoriL8wXWU_95zADwWyRXSRaLJeoHs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 18:02:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
  "Christian Couder" <christian.couder@gmail.com>,  "Elijah Newren"
 <newren@gmail.com>,  "Siddharth Asthana" <siddharthasthana31@gmail.com>
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output
 on conflicts"
In-Reply-To: <753daaa4-e675-4d28-9c13-4f5ede0f3b47@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 09 Dec 2025 19:05:02 +0100")
References: <CV_replay_conflict.101@msgid.xyz> <xmqq1pl6lzt6.fsf@gitster.g>
	<d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
	<xmqqms3tkux8.fsf@gitster.g>
	<753daaa4-e675-4d28-9c13-4f5ede0f3b47@app.fastmail.com>
Date: Wed, 10 Dec 2025 08:02:34 +0900
Message-ID: <xmqqtsxzi7hx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Dec 8, 2025, at 13:41, Junio C Hamano wrote:
>>>>[snip]
>>>>
>>>> All looked sensible.
>>>>
>>>> The second one looked a bit sketchy, but that was the phrase used by
>>>> the log message for c4611130 (replay: add --contained to rebase
>>>> contained branches, 2023-11-24).
>>>
>>> How should `--contained` be documented?
>>
>> The text you added uses exactly the phrase used by the log message,
>> so the author of the feature apparently felt it is good enough ;-).
>>
>> It just felt that "contained in <revision-range>" is understandable
>> enough.
>
> “is [not]” presumably.

Actually, s/It felt/I was unsure/;-).

>>     master..next?  If it is the former, is it because the topmost
>>     commit (i.e., the commit pointed at by the branch reference) is
>>     the only thing that counts, and it indeed is master..next?
>
> It’s a somewhat complex case compared to what I think is the usual one:
> a non-merge range of commits without any patch-id-equivalents on the
> target (fingers crossed). And the setup without merges: two topic
> branches in the range gives the output I expect:
>
>     git replay --contained --onto=target2 <range>
>     update <top/second>
>     update <bottom/first>
>
> I think the original phrasing is understandable. But we could add
> an example.
>
>     For example, if the range contains five commits where a branch
>     points to the newest commit and another branch points to the third
>     commit ...

Alternatively, you can explicitly refer to "the tip of the branch";
that phrasing will be understood by people from both camps.  Those
who considers that a "branch" consists of the commits between the
fork point and its tip, and those who thinks a "branch" is a fancy
name attached to one particular commit in the DAG that can move
around (typically forward).  Those branches whose tips are within
the range are updated.
