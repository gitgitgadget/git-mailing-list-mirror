Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9937081F
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034844; cv=none; b=daoGrJnqxVxnUpdg9V2qUgBFyXoAOxcwYcwgxkCyeNkRkMeRw9lW1RUEZ2hg0BxIwkTd7Ly+xHbTEFtUjgRI2liomPgXds0SDIr3YKFlz8q420xQx73CFXOjiiGxFxinHlmVQQdMaDmqM4FriKkWBlriIrbybu2N7gK/shXtHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034844; c=relaxed/simple;
	bh=fZC4B1CkPTs139iPOUqcruG/NE9sa4isTmWnuXEuXwk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fnx6+Zf87R6cSgFg4pK+vKmR1N0u2bDwk2OeVBn48Gu3xQJ0iYl8uRDcYa6TLZ8223Iy/87pvnT4CQcd8C6lKt/jF9WzalNSW3GfgHe9hUhSpHR6ITY/IPIE7QwfsvEoWVb3r1+j8Gu6YNu+O0pRBEfURjoLN+SP9rATruiGo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=FUUgCeZK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E3nLmazN; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="FUUgCeZK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E3nLmazN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A8947EC04CF;
	Tue, 12 Aug 2025 17:40:40 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 17:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755034840;
	 x=1755121240; bh=II8sB9DXAwxxV9qcJsk0Gvr3ELSqrTZCpjvHpMLcG/c=; b=
	FUUgCeZKauO+Se2s2YLrhF+KFMrGvzZNNHkrzPg6XE9N6ww+tDoKB/i4Jy5cAKWX
	zaHp74f/NhlwiL5rAaFbiMPa9WDEuAKY7AOwwyD3D6mI9zqU06DtonMu1izxlbxP
	f7bXOzJxjd0HHO9aUgj39Q/0QT+5CJt5LvsB5JzHdhdZ8FgTRwVV1Vd97Y+2527f
	13LDjiDlHA9g3PrYA6jZaQzQklq6wHVqAdP49MZ6WHRTuPbQGqO1HeTlujXC5cXt
	IXGywYjPB08OUShLOoCmNWdVQYxck1v4AREdOk8ea+OBnmPIVxUcu4Vh6Jr0LQ9d
	+E7j05jEsCjZyonNmq194Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755034840; x=
	1755121240; bh=II8sB9DXAwxxV9qcJsk0Gvr3ELSqrTZCpjvHpMLcG/c=; b=E
	3nLmazNggsiO4uiPN1tP6clSJeABfGKljRIitqoOJSmf5aQp/giArZ66lpJyFMK6
	ZW92SJoJ6g/sIGmnLRw8xytfXR3UEbOJ4Zz50J6c09EJNQDEeHJ5dVkE809Q6vUZ
	skinnFjkrvHf/ZipvArtJlEz4csXdJSEzOntndrldLLP7iQ41xrPuuLRas/gLsok
	s/qhUVMpt1qykegaJ0AERQWstL6DdB8PusSmTnQwF1dzXR1nG3c4Lw7HovpxzD49
	lT59hUSv3UPk7OlgeRpf0XpiUDD/leR1IsouCB7mtZa6wMuD/RbEt/JNsYBRlli0
	258sqpDn1pvuOhSIpL5Nw==
X-ME-Sender: <xms:2LSbaFrZRcRWjvLDF4bsgmvswIvJ6MhjAQoGtdY2dAQPTFazmsd_HQ>
    <xme:2LSbaHqD8gX4qvVzuYd5CXml8JG-LGE3JyXXhXjh8HTyN-gJ4BZS9eNYCM8PPy1gF
    sh8btxpcByrywlqq0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeigeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfluhhlihgrucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhn
    shdrtggrqeenucggtffrrghtthgvrhhnpefgveekudeviedvveeuhefhvdetgefgffdufe
    eguddtkeegtdeltdevhfdtuddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2LSbaExut3wsX3X9PochMvDW0bsC6fNjpilY3xAMbBBSu44P8H3aqA>
    <xmx:2LSbaPK5o-eQevufbR8SUQzLq5wbU5HJwQeHMDA8NOTYcXjxIGLNjA>
    <xmx:2LSbaDQZbwuOvIuYE6It0aDYMHuYMU1zhNwpWmNsk93LhXFqHKq-XA>
    <xmx:2LSbaPp8tXB0eG2RBvvVnlY3thASIkNtvoKvt-LH0lwYqf5BSMbXpA>
    <xmx:2LSbaFx13aNuPzOVWP1A7_S8Wfi6vLxI8r0-o1q8_ToEp9zdQAX-NlTA>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 69D667840B0; Tue, 12 Aug 2025 17:40:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T445d42a894a29bdd
Date: Tue, 12 Aug 2025 17:40:19 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <152d47a3-7744-476a-8ab8-43b7b52b67ea@app.fastmail.com>
In-Reply-To: <xmqqbjoks19f.fsf@gitster.g>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <310d2c1d8f7f68ae52ddd29f0ccb0a0364aba1a2.1755029249.git.gitgitgadget@gmail.com>
 <xmqqbjoks19f.fsf@gitster.g>
Subject: Re: [PATCH 2/5] doc: git-add: start man page with an example
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> But isn't it the source of the most end-user confusion that they
> cannot wean themselves off of the diff/patch worldview?

To me it feels very contextual! My impression is that what's important for Git
users is to be able to think about commits as diffs in some contexts, and as
snapshots in other contexts. For example with `git rebase` I'm usually thinking
of my commits as diffs, but it's very helpful to me to think of a merge commit
as a snapshot, because the merge commit does not have to be a "combination" of
the two sides of the merge, it can have arbitrary extra content.

> Wouldn't "add file X" confuse folks who still remember how other
> SCMs before Git operated (i.e. "file X is now known, so if I make
> further changes to X next 'commit' command will record it") into
> thinking that Git would do the same?

The point about Subversion is interesting: I would expect that most
people learning about Git's data model in 2025 have never used
Subversion.

So while I think it's extremely important to make accurate statements
while talking about Git (and I think it's very possible that this description
is not accurate enough!), I do not think it's so important to specifically
target misconceptions that users coming from Subversion/CVS
may have.

>> +By default, `git commit` only commits changes that you've added to the
>> +index. For example, if you've edited `file.c` and want to commit your
>> +changes, you can run:
>> +
>> +   git add file.c
>> +   git commit
>
> What happens when you did "edit && add && edit && add"?  It commits
> the two changes you added to the index?  I do not think it is
> productive to hide the fact that you are preparing a snapshot of the
> "next commit" in the index (or "staging the contents for the next
> commit in the staging area") with various forms "git add", including
> "git add -p".

It could! It's easy for me to imagine a world where the index
stores an ordered list of diffs, which are applied as patches in
series when I commit. I guess you'd need some sort of
patch + patch + patch + diff workflow to generate the final diff,
but to me that doesn't feel so different from what Git is actually doing in
practice.

In any case, I'll think more about whether I think this is really
an accurate description. I'm always especially interested in the practical
consequences of having misconceptions about Git: for example (and maybe I'm
convincing myself to change my position here!) with `git mv` I think it can
become relevant pretty quickly that commits are snapshots, because if
you move a file and edit it then Git can't always accurately guess that you
intended to "move" the file rather than delete the file and create a new one.

I'd like to be able to have a similarly practical example of why it's important
to think of commits as snapshots in the context of `git add` but I haven't quite
found the right one yet. I've noticed that people will often sort of "reject"
information that does not fit their mental models, and I think "commits are
snapshots, this is important in this context because of
<specific practical consequence>" is much more convincing than just
"commits are snapshots".
