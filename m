Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E82FDC26
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770474395; cv=none; b=nvNqzM+vb91txsyg6MoBEZycfYNn55wCoEWZipspVJoNApeAsCZyM7LvV9HQO8RVUc0U4nC+StQqxJqQC+jBvNb+lUhL8pZ0Dt0gWEvITNjh4hLUrSIQWqbZLc/PZ0zSwnblup4eAHwJ8vGG3GrPSjZdXwl5YaPWXocVpCjPOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770474395; c=relaxed/simple;
	bh=nNAbm0L3UoTjSB31NBUcnNyXkzwyeHu7w7931GS03Tg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MGWGKJsw/2Q048hcmkq0dbxKvWj/sH6bHb2qWBrGDdvAk1XmI693XOg/kfAcm6PN44Ilw52robRMjdIzVVvjPUUaDrXGCVjs5toXLlPgb2GvuFAFQkV5jDrL3sIZfbMA0h+fx2dpOklErV+Mjeg/kmYpWWzOsB2B0e3MgIfiv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=sZ+I9pfn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tik4sX49; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="sZ+I9pfn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tik4sX49"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 768D51400174;
	Sat,  7 Feb 2026 09:26:33 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sat, 07 Feb 2026 09:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770474393;
	 x=1770560793; bh=4y4B+H6Rt2zkkSRBOta/1nA5dOpqGxys5Gx5oxpj0no=; b=
	sZ+I9pfnaHunP775M2Kqbb3NF4dXFrH32OblCCfPbPOgPdyLG85veuo8NsqNl0+T
	SpZXLqWhsOS39PqxITL+4d2uH+0/hqYxhH/OGpFwzB0zpcXxHUE6HOgFdTu0FTad
	zQ0/foilw6jca8lwd5m4F9YW8/oekXBU4YfPCFZOBB5WTZcu72gT6WKZfovgWWn1
	GhRIxNuunaSt10Hdfjz/qdejKxEu3A8VyCr8kgFfPCzHRQhb0mcbB0LIzdzDlw84
	ZC26KygeeuX8MkLi8IfT1LirjG98GgrYCrzrouww3VTsLEY9jBpevaG+Q3Ef1zDM
	JQ4Qo6UdyJ+4LD+uV6FIJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770474393; x=
	1770560793; bh=4y4B+H6Rt2zkkSRBOta/1nA5dOpqGxys5Gx5oxpj0no=; b=t
	ik4sX49qGyzn6+1PupfG3keV3180y4NGwARiHdNuas3If8VUq19b8A6dd1kYuXWf
	r6YNbHVhtVNdXl6/glWGnlYW9Gv+pA8yq2S9jbtjezt0ps5HVHREgXHeZWwToXo+
	mgtIU9lqwmyw1ksm86mhyX8w1NkDsLMJuz/y63VdQeZAIYggoggCn5/jaeKiRTya
	GwQEj37zD97b/LUoY4k8z80eH2TfYkyw+iXSILKYW7TPEpoCk0VeG/EMa5edNOnk
	HKMMRntO6rJUw7BB4BfKSI3dgDOL1WWXoIpMNekF0O3IiNMBvH97zRnoFKnE156L
	h4b+P9AGqW5zQJxRVgZ8g==
X-ME-Sender: <xms:mUuHacTX7DGV0S_O-xVMmLQiINxc4CdKckLVARI1PKqUzgQMS_Xdg3o>
    <xme:mUuHaUnK8MfrJhE0KzB1fiKpiaZ2KxqOZNPx37wmlN0R2NNFKZ7j4c5uL2hUV5GQN
    mji9wmK1l2VXDcoqd9aTzNoIJK5zkuspXU_TrrNVozIWDP34RCikA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleduvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:mUuHafvX2CBhtkGwnTsaaieuYfnhrhdFAjDMoUkhLCZWsB4KaZHirQ>
    <xmx:mUuHaYP7jXz3bEGjwKq8ELAN95FG6elhK2PhNzT2XwQMS0rBpiqHgQ>
    <xmx:mUuHaV1EkXmmIfmFlOKR2YqyxyhBvFJk5dMfv3sV2Z-nDKMJ9GoKJg>
    <xmx:mUuHacMqk_zMmE489Zhm6D7i3xtRUjW5NHZJL1JNDAqqRgRGIMZrZw>
    <xmx:mUuHaUIln7ZLp2jPEYLdwZVv4Vtmlgu_qV-nymGqUqZvCtx-r7-3Te94>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 439421EA006B; Sat,  7 Feb 2026 09:26:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AXMcA4Iy85D-
Date: Sat, 07 Feb 2026 15:24:05 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <879fc9f4-e1a1-4b79-9086-b7278de5a1fb@app.fastmail.com>
In-Reply-To: <pull.2036.v4.git.1770351146.gitgitgadget@gmail.com>
References: <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
 <pull.2036.v4.git.1770351146.gitgitgadget@gmail.com>
Subject: Re: [PATCH v4 0/4] doc: some more synopsis conversions and fixes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026, at 05:12, Jean-No=C3=ABl Avila via GitGitGadget wro=
te:
> This time, git-show and git-submodule are converted. Some mistakes on
> previous work were also spotted and fixed.
>
> Changes since V1:
>
>  * fix mistakes spotted by Kristoffer Haugsbakk Changes since V2:
>  * more fixes Changes since V3:
>  * again more fixes, origin and HEAD
>
> Jean-No=C3=ABl Avila (4):
>   doc: convert git-submodule to synopsis style
>   doc: finalize git-clone documentation conversion to synopsis style
>   doc: fix some style issues in git-clone and for-each-ref-options
>   doc: convert git-show to synopsis style
>
>[snip]
>
> Range-diff vs v3:
>[snip]

The range diff looks great. `Documentation/doc-diff` also looks good.

The only thing is that =E2=80=9Cthe HEAD=E2=80=9D.[1] But I did a search=
 for that phrase
with something like

    cd Documentation
    git grep 'the .\?HEAD' -- ':^RelNotes'

And there are many hits throughout the docs. So I think it=E2=80=99s bes=
t to let
that one rest for now.

In my little opinion this series is ready.

Thanks.

=F0=9F=94=97 1: https://lore.kernel.org/git/4e15eb56-a6d6-42da-97ba-8636=
7eb9102b@free.fr/#t
