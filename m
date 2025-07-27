Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D669123AE9A
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 22:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753654887; cv=none; b=uOALiJAjdZr24d9f5tNyyPCdWXY9mscxv8hgWqt0ohejEZvx8SIYJpz1r/ivPm4vGTrE61sgxkJsJog8HM7gBihAyKFpupNgyKV7SUcEfdq5x/wx93sLlgyrwAJLhsScoYIk+toGVtcuVce7EOxJM1Jq4RZAJXjXfzfifNmkcxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753654887; c=relaxed/simple;
	bh=iBdGMMHvgt2VpeNiaV3iORsb2NUXGrSLRtoAcWhg724=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jSp8OyaYXFzMK9xszFq1ZFBfwp0EnXhFMAy10sF0zGAxJg0wmSpNwNfbIMpJf2AcIMV/qG2FqMiLJVQxGBuQ8awZxS/X44jSucKTGD7cf/tSrbKtc/uf+0jIAFEpV2ydZClbAR4PMi5541cc61WFbf86ix+YwQpqMDGfP68kln0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z/czBqTR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a5nqBc0L; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z/czBqTR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a5nqBc0L"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id AEB251D00168;
	Sun, 27 Jul 2025 18:21:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 27 Jul 2025 18:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753654883;
	 x=1753741283; bh=Kiawahwky07A5nyMjRGXyAEngiS+AXRdovEi1jZys6o=; b=
	Z/czBqTR9/e/eZMnJSTmOpe0mHkxoJ0/eQPixTVGv0HiiSsGPTW+o32SLtQ+5i1N
	ifJuzhkBua00Z+PkSory/p6g0D/BoMn6uDtS1oB/bcGB6QAKupI67xD0aVHH7eGK
	Jn8lbjn8v6Y0F5VoD8EHp8ZLapa0wZfTXn8DOs7lJ3x85AFdNizQeSce0XKRuQnJ
	msi0v/Ya25Ggh8P3+dPrtl9tFwYEqmH460PM1qQAWscdsKGMtjgUOKX5AbDTBQth
	VK0Nu3hKQVroQYVtUE+67VTuupXZWuaOSzLLujP89VRakDOk3oQe8INZuTUsWEs8
	3RCIE5VSMwYEE8TSFU1vrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753654883; x=
	1753741283; bh=Kiawahwky07A5nyMjRGXyAEngiS+AXRdovEi1jZys6o=; b=a
	5nqBc0LKu+XxwFtzcfnRODcxL8PYe+XHPcEuoQyrvQaOJl11qxvWhgfOEP01AcE2
	RSUq6U6Vwy5FB/O38GH5BQJfr+4zVGWvkJ3W+jNoqBTnx89utSikv97mcFtWZb7D
	b7OnJY7M6C8DwW0vvXhowWGG/fjb6OXH18MsKrtiKHh++9K3Rl9bFwEyGnrXM4/Z
	OXxYBBa4WwKdrarVXkWv85MMglwPK5qDxJIrwIbCOBzMiUqSVrgd/JD0VNQMXe9p
	riqTcIOD3N3BTEQAGIXfphOoojIS3e0CR0+1+4NAEUK+h856m84++EHMD9WKrJe3
	IJ6YUJP8DOGzgiPfrcIzA==
X-ME-Sender: <xms:Y6aGaDC4uW5xVP1tyK8G_pj7PBgA7IvMM72S-bTd1gge7kgJGS8WRQ>
    <xme:Y6aGaEGauNpx7IxB0JWTAF2GgFqCPRdpsoEJXRxsZqiruoWGxanBbIQ6rRvaKKpYQ
    BfCVVrWTXetPfjduA>
X-ME-Received: <xmr:Y6aGaLIhPGYB9nx1WEQhDt-DCX0AxS6fHnbZ8CDvcc_PwgS2uN3fsg4Bvto>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeltdegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufhfffgjkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeeikeduudegffeiuddugeefgfeltdejudetveeuuefhiefftdefleegjeef
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgsvghnihhtvgiilhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:Y6aGaIl6Oac8wunBYxMl5xdV28kXGhstX-5pG31Cu8yCntTn-lbAJQ>
    <xmx:Y6aGaDSQcurBgSIJJHrnkCQTmwL4U9bBgJtO1U9m3YpibiPPYXWjfA>
    <xmx:Y6aGaKIxMVBT5VXHb_O-4NDMnoSOD83djstW9bVqgvzTeC5_jWT7AA>
    <xmx:Y6aGaJCUDrAuVWOm03vF339gwwy7C-GeX1PsxVoQhVLPEhySe6jTcg>
    <xmx:Y6aGaPyhcRvfeJ5KBHaOb51zGaUVfZEaB9QqhK2hwxk7QjVuiVzrnTp5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Jul 2025 18:21:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Nelson Benitez Leon <nbenitezl@gmail.com>
Cc: git@vger.kernel.org, "Nelson Benitez Leon via GitGitGadget"
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH] completion: new config var to use --sort in for-each-ref
References: <pull.1946.git.1753627773304.gitgitgadget@gmail.com>
Date: Sun, 27 Jul 2025 15:21:19 -0700
In-Reply-To: <pull.1946.git.1753627773304.gitgitgadget@gmail.com> (Nelson
	Benitez Leon via GitGitGadget's message of "Sun, 27 Jul 2025 14:49:33
	+0000")
Message-ID: <87bjp56zs0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Nelson Benitez Leon via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: =?UTF-8?q?Nelson=20Ben=C3=ADtez=20Le=C3=B3n?= <nbenitezl@gmail.com>
>
> Currently when completing refs, e.g. by doing "git checkout <TAB>", all
> refs are shown in alphabetical order, this is an implicit ordering and
> cannot be changed.
>
> This commit will make the sort criteria to now be explicit, mandated by
> a new config var which will be used for the --sort=<val> of for-each-ref
>
> This new config var will have a default value of alphabetical order,
> so Git's default behaviour remains unchanged.
>
> Also add '-o nosort' to 'complete' to disable its default alphabetical
> ordering so our new explicit ordering prevails.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so".
   There is no place to say "this commit will"; instead, give order
   to the code.

in this order.

> Signed-off-by: Nelson Benítez León <nbenitezl@gmail.com>
> ---


>     I've not added tests because I'm not familiar with the test machinery,
>     hopefully this is still useful.

Tests are required part of a new feature to become part of Git
codebase.  Otherwise you cannot notice if somebody else later
changes the code further and accidentally breaks your feature.

You can of course ask for help (i.e. "I'm not familiar with the test
machinery so I am not writing any" is *not* acceptable.  "I'm not
familiar with the test machinery; among those who may find this new
feature worthwhile to do, could somebody lend me a hand?" is very
good).

>     ... and I don't want to activate 2FA
>     authentication just for this ...

You could do OAuth these days, I hear?
