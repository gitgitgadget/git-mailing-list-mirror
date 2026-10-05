Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6554CB8A6
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220925; cv=none; b=Kdlc6qShFvkC9rEbrMJ1k1Jcr2GNSEiQwEGumslsmnkRGr6+e2kkspAaItGR7UIHS1de/C2q6M4claBsB7dvnBrZQfqhTLZ+TpUafBaUawUwThonsc3xK/PM6jnCJ+jYwJ4hvLdJWbemnw5CG2/YHVil57Bqns13TmuSV6kGvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220925; c=relaxed/simple;
	bh=cEtXgnjgZd8Ds2TLqJdPVvLF1Ag42BFRco+09lnYG5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nn/yPVlbTuM+8lEv8Z9vC8c0Q6wo/7104eG1MxCM0GviSpYNOfx/5/QnO9nY44qiS27/NNQYfN8XqPuM1E4S++kH9Bc1/37wplrWG8SOhwgx9mP7QFiL9dSxSz5ZUDfy7ia4BHT0/MKEOgd6DXCJXbsMNg5KiWWULxLdjPg2JY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dqm+lg0i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JYV8+oVV; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dqm+lg0i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYV8+oVV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E6993EC0916
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 13:22:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 05 Oct 2026 13:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791220922; x=1791307322; bh=8l+4MGivcc
	e01+lB8diJkz2e/PI4mGeoutT3e7Y9b0I=; b=Dqm+lg0i0ACFYLdpGgLwzNhBvE
	okWGozU1nY2vOWBMNYTuv40uwDXXdbd+QzbMZ/IeRTungP8+XzL8VbVMB6TELCQO
	vBAuOlRuQKHYgu4dy/h3Meg8crbCtmfCogHhPlfofNOvwmAcdQDQZhGrzI/95vli
	TCDCbZLUrgdGqciC3EZRhZIeyYwjkI3VHc5NvbRQnV24rd87OgBeuzJ4z81biH2a
	dd//ZfO8IBepCd5WXOMSLMDwvXbvXpsJYwCZ5D0R+0gLHIKIzkczojqrU3NAw58I
	6ul+az/x0xGGAQlgOIqh45gNoBgZh0w3Jpip91mhtLRdZCgIKkZftm/RWp/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791220922; x=1791307322; bh=8l+4MGivcce01+lB8diJkz2e/PI4mGeoutT
	3e7Y9b0I=; b=JYV8+oVVNcyx40RdnMYoCrAQcZLE/WrGogEZeq+ntH3TA+ZGI+9
	m/pMScN6MqHLDu9wirEmaxIq4IBksZ033twwl7exEuZa0L/9WMaiCAMYn9JeyQ+e
	EfzTo7+cFV7E868hmhaGTycZ7F4/TaKqyY2+lXu30dQwkZAvfU+r5Z54JRlwdotQ
	CyjQa73Wg8mxs7COpBJMJgAZieVdtgRSPGi/81iJtlbM8PciHUUZUF/pUFNs6Jnc
	6uhpHX7hZ3aw6CedqEZlzEJmShU6UfhX61QX3xzbi20AEr0uD8bhYrtkdQofsuhq
	aqad8hHItmVx9j5wdS39/qgMYeuy21g7K0w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791220922; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:etyDlJp/G/OposY3nirn/eAeJEfU7wCey/2zUuFnQiNJ64a
	9yrAz4yD2NHOVbeO//hFUD5PhJwTZva1hX6OOH1tDZUGpMvJclDvGwldEZeIP+GN
	4lopks5iX6ZVYuVpWlyqZ7AFsDlTt0WFeOvOAG7MN7AiV0YDyMTSKjUjVWzj4vyp
	4owsR2a/lTNbj+UPFSegzUl6sKaa+mG/HwsONf7FNAXfYChXb6TSa2k5qMtHzaZ2
	KOhliS+UiGyUmUsFhSWw7PrJ8BKZW7RXlHLFFBPQpCZoecCIevy6DE2wdGS4DA66
	fRZvjPHJx4yOM54QvJJBuj/GByeFtZB05WzQdDQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CL1+cV7aBkLhPnq5vugvQti6g++Qr1vBc8/01IjfcZ8=:cEtXgnjgZd8Ds2TLqJdPVvLF1Ag42BFRco+09lnYG5Q=;
X-ME-Sender: <xms:utzDalr41Py3Sxx9n-2WSf49spWpiqaWLzKKMPxTkoiD2npT4RPa5w>
    <xme:utzDauiA8xdft8LjisnBQhHCQfhIHO-x3JKI8OVesS2ulN19nN2Go-cj4AnO53s2Y
    00IOSmKsvXPNlaptm__ELhPnL5gUndcTSnx73WlyiP_xfFLcXtPfQ>
X-ME-Received: <xmr:utzDaqjlcKFAXZDrxQYlgEjImglYKvTiBTiO38tJkgeaoDPClwVF2cBE8Eo33yZC0sg-8vzj1rsRchia_L28cog3dZWgKEIKYB2w>
X-ME-Proxy-Cause: dmFkZTEPVT7GBVK9yLxTp6AUis0Pg0kyk3VPueBScq2so1wpTxEaeQul0xBe5NcrHvZ3U5
    lfOrUfxGeGNAKPBfL0yOjF2+Hc7epdXnsPWQvpaeh6Z8Rs1NvYmveXJmXWf8MOAZzhxDiR
    wVN9Bupe42y9xcPyTVS60t+rS0Bo87Pm7nphiqOl/LYBaxQKhzwdipT+W0xavbnYbdeLSY
    IF1vnVUl3kRB1SDtXBh/jIQCPOdc5uNgsslG+jT+NAXb69xlNAK7/+kS3qzfZUEIA52dX9
    wp6vX0Yw2/uFTmnMjGG+EbK5dtPUpRUuKShJj75COR8ztzGxsCGPo1V7/HMEosOLHoG4jm
    w+m8NDEs3omVpb+RDfiSu7lRIjgkt2G0d5e10FMd4ZTZl79V5IRAN1XJvHWP+c7nLdew8n
    LrAWPiRE7+p1IqxytvQVwsba5EzQvEXk0kokt8eoMx/gP+dQAsTdMAts/QBOl6WULPzqRt
    FWPU/HmeQHSGoU5eFyWT6oZi3JOEuUq35n8bGxOokdwo8QKul0Un517mANGDpxQv3rFTHm
    3Icn5bw3mOEhqW3FD4wULc6mKH3kcGzXmUppCpT9qFRPdLCji6ncCiDQi9FQO9IjVAoXW8
    /QvyNQ+CrV87bIs5hojW3QCO9ck3rP5v5jcQGQ1qWMBzrK645f4ZKulciQVQ
X-ME-Proxy: <xmx:utzDasji5xefmbyaBlO_53DIZt_gCizUfgQqHuPPzOWM58yZn3-EuQ>
    <xmx:utzDaiL88DgdMyzjhA03pb9YMb33bWR2NbtGn2kedPYzftxyjNBdHw>
    <xmx:utzDajFAdrDta3KgPQmsJPZZ_EJMgcVmAUZaU1L3qtG9G-4pgxbbxQ>
    <xmx:utzDauSiamHYOEOgYxJX_A6JVwGRLzAlGLb00cV5UIygDrhNc-N1PQ>
    <xmx:utzDavyO6p5JDq1nJypxJNT5f2yQJoETlvStjCeYCEwS3BkFfS8k7fNZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 13:22:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Patrick Steinhardt" <ps@pks.im>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/7] [doc] Add new gitmergeconflicts man page
In-Reply-To: <e593f3ca-4a03-45a7-b0cc-6295a3a4939f@app.fastmail.com> (Julia
	Evans's message of "Mon, 05 Oct 2026 12:54:03 -0400")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<ad4853dc36cdb883c9a8dc6bda747a5ea318e7a8.1790261062.git.gitgitgadget@gmail.com>
	<ar0MVRV5X8zgZfLy@pks.im>
	<5ba2088c-4919-465f-8892-4ed0685f81ea@app.fastmail.com>
	<e593f3ca-4a03-45a7-b0cc-6295a3a4939f@app.fastmail.com>
Date: Mon, 05 Oct 2026 10:22:00 -0700
Message-ID: <xmqqik3gjc5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> Marie and I worked on the OURS AND THEIRS section today and I think it's clearer
> now but also longer (instead of shorter which was my dream). We added an attempt
> at humor at the end to hopefully help things a bit.
>
> 	"OURS" AND "THEIRS"
> 	-------------------
>
> 	Sometimes during a merge conflict, Git will use the terms "ours" and
> 	"theirs" (or "us" and "them"). For example, `git status` might say that
> 	a file was `deleted by us`.
>
> 	"Ours" and "theirs" are both commits: "ours" is the current
> 	`HEAD` commit, and "theirs" is the other side being merged.
>
> 	The first part of a merge conflict (between `<<<<<<<` and `=======`) is
> 	from the "ours" side, and the second part (between `=======` and
> 	`>>>>>>>`) is from the "theirs" side.
>
> 	----
> 	FRUITS = [
> 	    "apple",
> 	<<<<<<< HEAD
> 	    "cherry",                      <- ours
> 	=======
> 	    "banana",                      <- theirs
> 	>>>>>>> add-fruit
> 	    "mango",
> 	    "orange",
> 	]
> 	----
>
> 	During a rebase, it can seem "upside down" because the "ours" commit is
> 	from the branch you're rebasing on (for instance `main` in `git rebase
> 	main`).
>
> 	These terms in Git all mean the same thing when dealing with a merge
> 	conflict:
>
> 	* "common ancestor" and "base". The files from this commit are "in stage 1".
> 	* "ours", "us", and `HEAD`. The files from this commit are "in stage 2".
> 	* "theirs", "them". The files from this commit are "in stage 3".
>
> 	If you're confused about what something like "deleted by us" means, it's
> 	often easiest to use some of the tools from
> 	<<tools,TOOLS FOR HANDLING MERGE CONFLICTS>> above to get more context.
> 	Finding the commit that deleted the file and seeing why is usually more
> 	helpful than trying to abstractly reason through what "us" means.

May I ask what is in scope for this effort?

We previously discussed updating the conflict markers (the 'HEAD'
and 'add-fruit' labels in the example above).  Doing so would
require code changes, which goes beyond mere documentation updates.
But if a minor code change like that makes the documentation much
easier to understand, I think we should consider doing so.

Along the same line, if git status stopped saying "deleted by us"
and instead used a different phrase, would that help reduce the
"upside down" confusion [*]?  Is it acceptable to bend the code
a little if it helps the documentation?


[Footnote]

 * I suspect that the "upside down" feeling is not really about the
   terms "ours" and "theirs" themselves.  Rather, it comes from how
   one conceptualizes what 'rebase' does compared to 'merge'.
   During a rebase, we temporarily pretend that we are working on
   the upstream branch and replay our local changes on top of it.
   Once the user adopts this mindset, displaying the upstream state
   first (the point from which we start building the consolidated
   history) followed by the local state (what was done differently
   by the local side) becomes consistent with how 'merge' displays
   conflicts (where we start from our local state and merge the
   incoming changes).
