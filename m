Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A218A6A7
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275633; cv=none; b=pRw6pJo7hA6hB8/3P1DM5AT42shOyP2jbMeG6IIyC8Fg6mZ1sBkJRZg38dwRt/OII56Tr+qfsfntXin+GbEms8XQ7ZslgjnMqlmVHuA7I1kSTmcHmtyJAS4QPKCWciozfngodFqv0l4VGtojW5BAJO6aY9MOiGl7h86OZ1oQfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275633; c=relaxed/simple;
	bh=7FBXyCkUNxh0yDJiPzXOHQ8VrWurBq8fOt6WsZozBpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sxko9YCDi6MvVHDoOyrg5Wd/Wn0DyYJ74RrDzsnC/FayNAKVaOfhb1p17DZmgtJCjDNmCnjKahPan7aTS7DWpJ0n+EmpbZhQLWGgemHsxLg1BTwX47q48BOlIFGbj/1aa4rhCzQ+uy2YQk6/wizqCtY3lRLV02Y9QTeL4ky7/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A6lv8aL5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iP45cLU3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A6lv8aL5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iP45cLU3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 969571D000B1;
	Fri, 15 Aug 2025 12:33:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 15 Aug 2025 12:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755275629;
	 x=1755362029; bh=miw1te6uBxkgYYuFzHByN0hri0zWTVUPUXwfcDJ322I=; b=
	A6lv8aL5rXQN+A1P/O53dVk1jK/3JImHek59mZDK76gtxCFEnh3Z0wEjyg1TWeyd
	P4CDIZfO2m4P0J+wuVNmuZaTDl0eLfdsdU2W1NwBwVFkdz0Jy1xSuumAR3tloFqM
	PMNY1rjgV3616iKfVJ/4MGbpHXmzb6GxgYjAvsC50MSUNCapvmiqmNZHjNu96MLR
	WQfbB6ogQRu4PP57xNHGjfBjsASx1rVHPV7B7mUqv/zl4QzjZ/NqLEKiD5Fc2tJO
	blb/xmsPJKPkzUcJjmHDaXZhL9Lj+d5m8uS3IiiFEj2Hn/U/QjweP3d87rcnY5N0
	tjvS5j9RopGUqqYEFZmb/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755275629; x=
	1755362029; bh=miw1te6uBxkgYYuFzHByN0hri0zWTVUPUXwfcDJ322I=; b=i
	P45cLU3BaV8/vbzEwtYnU/AzLDVRL2g7vI02wo8dmSGEMDLUimzEb+7W/6Hi2uD+
	ygtK5RsOh9rh/A4BdqNNbqRaE6qmlHPQCm1ted3hMpM89/dSIS4C7X7G4oirRc8x
	TG/ZC+vCoOBWhSUSP2I5eqsk4Z8K1KeJN8jkLBh0pZQPYM2Fi8pSWzgSeQnCxSqt
	U6ATm7WXav5qHenzakgWU3JQvp5sY1Z7bjvFnwMSsiSB8b/jxkYt7PxYQU/Dc0tA
	LXwKlqX+bHDLXkyJdkDs8RECud34Hfwg6mWrbAlgHvS2QlAa6Ea0hy6HJX1tTa1I
	JfnSifnkuEJOgfsV40pZA==
X-ME-Sender: <xms:bWGfaPTBVmhpPsqlXDJ-Vm8acYhM7vQq6zxHfe2m_PSqVFbdIzex5g>
    <xme:bWGfaOWoZa_3brUQx-6ypbq61m-nzt7AUEsmnMe7WVOa2plVAHYqD6-YQPSKOG_Jg
    KfJb22YEvz6YO9sww>
X-ME-Received: <xmr:bWGfaLQV0tvdUDKCUQVDkkL_GssVualJbdMi4UT93ZsNwQ3tRjdsCseDoGxBPxnPxbH1irUDSygE-AO9CvUWwbhUjkNhenrixcmWjl4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeggeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishdrthhorh
    gvkhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bWGfaAnKl7nOzVwBSAKR5v0Vu9yse6349yKZi921a2vFfQoHHhml2g>
    <xmx:bWGfaJ57vsWZ5NscWaz58lQ6OkDyERUQ3nv29vMCLS3FEMYqIujZIg>
    <xmx:bWGfaOjxrMLc3-4zyXYM8i_Vmf46ydyPMlPVEjCQMfPdzq_-Hiuf5A>
    <xmx:bWGfaOFqQgWSMuCJiof8vnQLHLmmOr1hStc2WzIOdlwezaq8KIcysQ>
    <xmx:bWGfaENxXnAB3FjuuFbNh8oafAXc7HTjPtkRYGouSiT8Ir9ohh78eNDI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 12:33:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Chris Torek <chris.torek@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 1/4] doc: git-add: start man page with an example
In-Reply-To: <5004213.GXAFRqVoOG@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Fri, 15 Aug 2025 15:34:41 +0200")
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<d041d09589b51734a8cc257f80cdaf210c6676e7.1755127218.git.gitgitgadget@gmail.com>
	<xmqqikipv2p6.fsf@gitster.g> <5004213.GXAFRqVoOG@cayenne>
Date: Fri, 15 Aug 2025 09:33:47 -0700
Message-ID: <xmqqqzxcr1ck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

> On Friday, 15 August 2025 02:38:45 CEST Junio C Hamano wrote:
>> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> ...
>> > +By default, `git commit` only commits changes that you've added to the
>> > +index.
>
> I do not understand this addition. I may not be missing knowledge, but this 
> behavior is not only "by default", it's the only behavior of git: commits are 
> made with the content of the index. Let's not make it more complicated than it 
> is already.

I'll only react to "the only behaviour" part, without "more
complicated" part.

I think Julia is referring to the fact that you can record the state
that is different from what is in the index (or, what has been
accumulated in the index by the past use of "git add" command that
is being discussed here) with "git commit [-i] <pathspec>".  You can
do

    $ edit fileA fileB ;# assume both are tracked
    $ git add fileA
    $ git commit fileB

and the resulting commit will record the contents for fileA found in
its parent (i.e. the result of "git add fileA" is not reflected).
If the last step were

    $ git commit -i fileB

then the resulting commit will record the contents for both fileA
you added with the last "git add" on it, and contents for fileB
found in the working tree at the time of "git commit -i" was run
(i.e. "git add fileB" was not required)..

By default, after the edit of fileA&B and the add of fileA, "git
commit" would not be aware of what is currently in fileB in the
working tree, and records the same contents as its parent for all
paths except for fileA, which would record what was last added with
"git add" to the index.

>> > For example, if you've edited `file.c` and want to commit your
>> 
>> > +changes, you can run:
>> Likewise.  "and want to record the resulting contents".
>> 
>> > ...
>> > -Please see linkgit:git-commit[1] for alternative ways to add content to a
>> > -commit.
>> 
>> In the original, this comment does look a bit out of place (as the
>> text around there does not talk about `git commit`), but as you said
>> that by default 'git commit' makes an as-is commit above, it may be
>> a good idea to move this sentence there.  `git commit <pathspec>` is
>> a handy thing to know even for beginners, and making your next commit
>> is what the user is working towards by using "git add".

And this relates to "more complicated" part of your comment.

I think keeping "by default" above and also keeping this comment
that hints about non-as-is commits made with "git commit <pathspec>"
is slightly more preferrable than dropping both of them altogether.
With only four additional lines, we cover basic "edit && add && commit"
cycle fairly completely.

I am also fine to drop the mention of 'git commit' altogether, but
it feels somewhat incomplete to not talk about commit when teaching
add.  After all, add is one of the primary ways to prepare for the
next commit---putting it the other way around, you want to learn add
primarily because you eventually would want to make a commit.

In any case, only having one (i.e. "by default") and dropping the
other ("see linkgit:git-commit"), like the patch did, did not make
much sense to me.

Thanks.
