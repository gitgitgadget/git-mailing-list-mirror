Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7FC291C3F
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808347; cv=none; b=HbYg4qXO3+VMfTK4WZxVzQQm/qahlNPtQrNm+uDyYLP1gC9jjxynMnZYlJRyaSA8WIFoTVLLn9TGjLb2V05mjt+DRx+G5pHnvJQ0YbPgs1skCq+L2brcb181J+0wrdBH3QZWQjOdFVrP5CjFfMJbZ3r0ToxXkkWK5AMrJ5TZfic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808347; c=relaxed/simple;
	bh=8l40AZIzWIxiAABdR8jxJLjHvN9q9p4yfu7vPZ2QCb8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Hq2op+ehIKrRTFFkoeXkam/HDhNL1nOKAoxQ3ZMzA2Y5GnYEMGSRyKFU/uaNQl5wHr/9oUMZ4uzSOg5cJb7IF1eG4ZFmfcgf0PPqHTCmSvBIPDaU2IKQM9JqT5sKh9QkJ0G50MKRVLB22scrrDN8JhdDy9yBBIjBScKNCV052QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dAF1wQxi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cLmKPKeI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dAF1wQxi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cLmKPKeI"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 747051140137;
	Fri, 13 Jun 2025 05:52:24 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 13 Jun 2025 05:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749808344;
	 x=1749894744; bh=TpMjfz8phBEVay0LhqDNdL+E9h1uz2QFXwlO95UBzqE=; b=
	dAF1wQxilR8FiIqmaZ7mQ8J1UdL8fejSILgQqvKrZAlZ+CT2H+tQBo1Mv2xOGU3K
	uYJyBDmYugg0tZbjtSK/6lhzKH6O5vhPg++wU3fR6+DvVDtUWpppPv6RGfRgARnz
	011NwFZYf/68wnXW4UP1UPzaZNeQvSupFCQLdztfUj4JLwx086mULv8EJtUXUstO
	y2yBpbkr2b5rzOPKDvUaThST7XisVAS+X1kIpXXK2HPcqvkw+8UVXXOMcpv1kJ1w
	QXhSbA6A/pkXnG15YxO8ujVOE4RxTcKmr5KYL1P/b4KfVCOwBDpoouHTkCzxTPSb
	M8F33WzZ9AJ7iWGJKlPZow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749808344; x=
	1749894744; bh=TpMjfz8phBEVay0LhqDNdL+E9h1uz2QFXwlO95UBzqE=; b=c
	LmKPKeIodbQdBF8LxEjPExXcxw5SR4ClJu8GYOwD1qWKei9/lEjs33fkThtWDJJS
	2RpdOeFMM8VW+xN89Jy1vOMQy70aZReOB0h382H90NGs3dUUCNTe4Sl1/CT00Lsy
	0lXDvRNiXe8gpQ8Fce+xHeJcp9sCEir6Cxon4LRYEEVuvxxEycneGVwDYBv9NJVt
	Ub/gjLMqQgApgFvErbDsWyldrTPa9mnLltBr4VqgeZmwwbIPyiG71jp4P9dhGeHo
	YPE03TdsORWBsIHQL8NDRlVr8VZOkl2jS17BYk3B3rxxWDZOINwQlnY/cv3bja6S
	LVNVUfQsyM+JX7iFija6A==
X-ME-Sender: <xms:1_RLaOn_3vg9iLpMSWnhXzv9Zl9jDX7JLRA1wqbSpqiMgb87MRwti3Q>
    <xme:1_RLaF1ooJE0UNFUWdRSO70vPtNJEwZ0Btdpt2MMdbI4GV9z-vFpEDWllAQHOEYiN
    gCGLesnHCWAaCcpfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghvrghr
    rggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:1_RLaMpVLPJrJ379Y07N7wrDu_Jr4dW8m64ML9MfrqMpU1Tws3FOoA>
    <xmx:1_RLaClvD3nar2ttULu82gh4a221TDuewXXQcRXgyuUXVO7nw5mVsw>
    <xmx:1_RLaM3ugK02HpnVnWCdkmKwDznvMohPQql6koi7xHf1nV3v-huieQ>
    <xmx:1_RLaJt3VCJ2S4EYON0qcmy7jju7lCua5Mq5zDjr3324xqhOn-PW2g>
    <xmx:2PRLaJ_UN8ieYq_DgTFBM6FyVU1otxfMo8kfPERkU4Wvj_hu7WVoL50W>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C00C91EA0064; Fri, 13 Jun 2025 05:52:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tce1dc134773c8027
Date: Fri, 13 Jun 2025 11:52:01 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Toon Claes" <toon@iotcl.com>, "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>,
 "Taylor Blau" <me@ttaylorr.com>, "Derrick Stolee" <stolee@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Message-Id: <12b49804-946e-4bfe-a1ce-e7f712363076@app.fastmail.com>
In-Reply-To: <87ldpw0yu3.fsf@iotcl.com>
References: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
 <20250523-toon-new-blame-tree-v2-1-101e4ca4c1c9@iotcl.com>
 <aDWWe6qCQXorPESd@pks.im> <87ldpw0yu3.fsf@iotcl.com>
Subject: Re: [PATCH RFC v2 1/5] last-modified: new subcommand to show when files were
 last modified
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025, at 11:34, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Fri, May 23, 2025 at 11:33:48AM +0200, Toon Claes wrote:
>>> diff --git a/Documentation/git-last-modified.adoc b/Documentation/gi=
t-last-modified.adoc
>>> new file mode 100644
>>> index 0000000000..1af38f402e
>>> --- /dev/null
>>> +++ b/Documentation/git-last-modified.adoc
>>> @@ -0,0 +1,49 @@
>>> +git-last-modified(1)
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +
>>> +NAME
>>> +----
>>> +git-last-modified - EXPERIMENTAL: Show when files were last modified
>>
>> Nit: we don't have the EXPERIMENTAL label here for git-switch(1) or
>> git-restore(1).
>
> But we do for `git-replay(1)`. Because I haven't gotten much feedback
> about the usage of the command, I wanted to be on the safe side and not
> commit to the behavior. Marking it EXPERIMENTAL would allow us to make
> changes on it's interface without _breaking_. But I wouldn't mind
> dropping the experimental status.

As a user I appreciate that experimental commands are prominently called
out as such, like it is here.  I don=E2=80=99t see much user testing (mo=
re as in
DX/developer experience) on the mailing list for new commands.[1]
=E2=80=9CExperimental=E2=80=9D in my interpretation means that I should =
be careful about
using it in scripts and that the developers are open to making changes
to the command interface.

=E2=80=A0 1: I mean specifically by a slightly wider user base; those of=
 us who
    might not be able to hack on or review the relevant code much but mi=
ght
    be interested in what the command interface will be like.

Thanks
--=20
Kristoffer Haugsbakk
