Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0153093B6
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685937; cv=none; b=gow4YmSIFzl2+K8QpZBXqPx4aMN/904bZ0Iygq8zUGcl60UQhKP0bQCJB+L3gNSWHyl1gD8njh48wmJT7zd24K+HOLIBYCogGtgvGiJLvZy/9NM8vdXDBhRDiwiaJqkHqUmI3HD8L11MZzXTL0YEvlDbCLGO2+1wwP3p4/QiQb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685937; c=relaxed/simple;
	bh=/WhCAMvPNMhRdzPch+1fUpuV7zrEdF1cwJ+Ylbf0gJg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fLxZLBVyteCokONSawfIjO0VdEl7/x7KWB9vIYvITrTKNYiMpXPaDFb1VQOGJiNPT4jlwv7kwtH99IkdcFy/6rPHH8wvGxK2zfvMGWdgALHqd7RU2J4Rczt72/fhTe1kcNuTnzADh41qlkkDTg9oIrRf0fArhQZbC7tmpp5F0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=YUQs4HHW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gwqYsQBj; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="YUQs4HHW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gwqYsQBj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 717EB7A02CB;
	Fri, 12 Sep 2025 10:05:34 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Fri, 12 Sep 2025 10:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757685934;
	 x=1757772334; bh=+zjei4y8HRzhbQywfuhSrB6dnMT2ECLbCeXTydhi500=; b=
	YUQs4HHW+gQ93ykDZoFvC4Vfcw1rtGam+TaO1rpLz6bNCRm59Ova7TnMeIgn5aQO
	3CE7JnkFM6CmD6S7MKHpzXO05W2ZN0/jEMcWP6adKDoIAhAMs+Nx9e2ZyPVzxqLj
	4xiZS5DMjXCe2x2wHfQnVkHXYWB01waPV+3zJUo2VtpBMZkUigUN4TrKOz3efMUj
	AOrPUTpSH9uRRZ3Q87yBxpBJtj7wFncqgCHCZ1a7TrZFCo3+xmaAx8h9D6EJj1zr
	6oMYdJ9q/Q8y7LvvndxYYdBz+QKLw6H/nkUx88pgVTE8TKHR2PfrzGjPgv9KwFnW
	OY5r0PY9/wKjV+W7rYv9rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757685934; x=
	1757772334; bh=+zjei4y8HRzhbQywfuhSrB6dnMT2ECLbCeXTydhi500=; b=g
	wqYsQBjSZgISmX1uMMx6RoKCxSAkwpLn8OAjrehq6oFqmTxF3UApXOX9kDZUhSbx
	BTsnnwHGWysoLesJS735wGzs/I2PpSOkbBrEPmcFr8JAxn22RU9KTUUT4n71AnF8
	0H+BnNoweZ/AS1YGryNx9sOQv2+wVShJbHB3Yfd2lOPRoRiTk8Xi1qypoZ1tWdEf
	4lazrFqii+Xf6VZKhstrNXUQUyanxecm0MTWxedhF6mEvpZNONUuocKmLtGjUmhk
	/4QxHpCD8czxcN145mR8pZqFx7970CYwPbnIA8WmE55EhSu27HCtmq/1E0eTukho
	fOgWrzvtgd7bZLk3EbJ1g==
X-ME-Sender: <xms:rijEaJ8zvrs9P-PftqETO30_JFdNbSVjaea6fM_u0Pi-NQEu-CtycA>
    <xme:rijEaNvw5pKeyyprSGyG3iGTk8kkJxt1WFUZ-zWs644ZuNMmoHScjbpDuI-1lcgJE
    f-_K8DqiWHIuO00C28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvledvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    ffffeiteefteeukeelveeukedvuedvhedtgfdvgefhhfegtdetgeejhefgveevffenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtqdhstghmrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirgesjhhvnhhs
    rdgtrgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rijEaKl_D5nFpAPk-31Vz2UXhAlFK-VkIyxQ1NRuCHfY2J3cHagUIA>
    <xmx:rijEaIuseMDZYlhDZYfusxZc_9zpZNZX4n8Ct4qaft739EpIcgpitQ>
    <xmx:rijEaFnaGwN5393sgNRytrgaVqe7J6lsmvp5F68m_jit1fM5Lk3w6Q>
    <xmx:rijEaLv35j7otz7P9sGUCHT-MrLGq2pybhQ2rRmJUnF2mCpmvJ2Xtg>
    <xmx:rijEaEh4BtZpTKTCUGTTRyAs0SMtvtoTkz7ZV0gDJh_xeIAmiDFDNwRU>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F00CC780271; Fri, 12 Sep 2025 10:05:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ8O7vPh7Xgs
Date: Fri, 12 Sep 2025 10:05:13 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <236a79f4-e9a2-4335-bbff-79ae0cc67e9b@app.fastmail.com>
In-Reply-To: <1629C205-700F-4A8A-84BE-302D172416F8@gmail.com>
References: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
 <1629C205-700F-4A8A-84BE-302D172416F8@gmail.com>
Subject: Re: [PATCH v4 0/7] doc: git-checkout: clarify DESCRIPTION section
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>> * Rewrite all the commit messages to try to take a more Problem / Sol=
ution
>>   approach, from Junio's review and thanks to help from @nasamuffin in
>>   Discord. Also change the cover letter format to match the style in
>>   https://lore.kernel.org/git/CAOLa=3DZStgwBN0fMK3YxoqeR+1i772f621sup=
va3Kvr7YPq4g8g@mail.gmail.com/T/#m8c99a3144cbdfb445e04f8f83a79364bfe8d79=
7d
>>   , which hopefully matches the norms of this mailing list better.
>
> This was pleasant reading to me. Not sure how it felt for you to write=
?=20
> Or if the convention was just not spelled out enough to get you where=20
> you wanted to be? :)

This one took a few hours because I had to backfill all of the "Changes =
in v2...",
"Changes in v3..." but I think future ones will be faster to write.

Re the convention not being spelled out: in the "my first contribution" =
guide, it says:

> Edit your cover letter again. Now is a good time to mention what's dif=
ferent
> between your last version and now, if it's something significant. You =
do not
> need the exact same body in your second cover letter; focus on explain=
ing to
> reviewers the changes you've made that may not be as visible.

The key elements that I was missing from this were:

1. it's actually probably good to keep some (most?) of the body from you=
r original
  cover letter, so that folks don't have to go back to remember what thi=
s is about
2. It's useful to flag which review comments you addressed and which you=
 didn't,
  and why, not just what the changes you made are

(I might have gotten those 2 points wrong though!)

>>     +    Make this section more accessible to users who don't know wh=
at the terms
>>     +    "pathspec", "tree-ish", and "index" mean by using more famil=
iar language,
>>     +    adding examples, and using simpler sentence structures.
>
> Without re-examining the individual patches, I see that 2/7 and 7/7=20
> (possibly also new 1/7) lost pointers to pathspecs. I think I mentione=
d=20
> this previously: I hope we can find some way to direct folks towards=20
> the glossary entries that describe them. I would consider pathspecs a=20
> power-user feature, and they create lots of useful affordances. So it=20
> is fair to more gently introduce newcomers, but I would also still lik=
e=20
> to make sure it clear when commands accept pathspec =E2=80=9Cmagic=E2=80=
=9D :)
>
> OTOH, I=E2=80=99ll take a look at the docs after this series lands and=
 see if=20
> it feels like something is missing. It may be just fine to have=20
> pathspecs in the synopses and add a sentence somewhere after the gentl=
e=20
> introduction =E2=80=9CFor more ways to specify paths, see=E2=80=A6=E2=80=9D

Sorry for not mentioning that. My idea was to just leave <pathspec> in t=
he
synopsis, and then folks can look it up in the glossary if they're curio=
us.

In the web documentation (https://git-scm.com/docs/git-checkout), the wo=
rd
"pathspec" is underlined, and hovering over it will show the definition,=
 which
I think will help with discoverability. Of course in the terminal versio=
n of the
man pages it's harder to build in affordances like that.

Do you think that the concept of a "pathspec" is especially useful/power=
ful
in the case of `git checkout`? If we're thinking more globally, i wonder=
 if we
could find a Git command where more complex pathspecs are especiallly
useful and then include some examples of using a complex pathspec there.

If we include a compelling example and then a "see X for more about..." =
(here or
somewhere else) I think it would be much more likely to motivate users t=
o follow
the breadcrumbs to learn more.
