Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8015D1
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758913417; cv=none; b=lPpZ2qcktCayArGrL9WaIwP4/hc34y4R78X0ig7FpKb8C8EB20APp/kpa1+fZ/nNp7Ojp+1yEcTQfO+dIU6kJryLtjXUGeje57Baipy5xnYUgJn0D4GivRwdsp5d4cTnfMq4SWGrzapS4ENREMEh0bExJG2IVI7SsfJwg9mi3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758913417; c=relaxed/simple;
	bh=AY4L/ZI+7sbdG6M/cfHGjHCoiVCN5yN+bKONevEGFlg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rFb/yz/70M1YJ79yn5qUChpiccM8BlFDewVXBDwvCk7Zt4NdzjMne0at1fNtsAXFwwVtqpLPciUbHbdw/As9pnZ/D8f+nHBAN79H2P9p7Kz6Lu24uVPg5sWGIMXpHjxrrgzpO4j8fkGrsDP/x/LgnUjHRLxrcq5xB1MbsOHAVKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dgZeJu92; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G6TCKlLP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dgZeJu92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G6TCKlLP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4AFC27A00AD;
	Fri, 26 Sep 2025 15:03:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 26 Sep 2025 15:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758913413; x=1758999813; bh=5Xtq5jqZnM
	XRx3+YJ6djri469yaB152ond8VPw3iPHk=; b=dgZeJu92OS0/7pOeXnVozIcUzt
	FfRvrzEv7S1dlwcFzcsqeVP9iS1kuXUYuOThdQN8z/sd3SYVDbdzjtnMGoPpG+Rw
	BSclxy2/PWe3tmrNY1OPmu5fwkLOyXihmAPw5d8wMtsVa6mJHhhIRGGAbxW2RUtx
	Zkd3/c4t/1xcMBtDnInzKp++TCs5qsPX1WCsZFUixBBR6OjFBARGAYsbBiQatLD+
	4RbqMH/CvcFoOx1lfaBFVyri1DtRajiZZU8XYDJb5lfAQiZDWxICBVm5+NbcFYiz
	dGwa/DnBTcDa6ir24vmUsuUA35T8NtLUWfCoyzwdG+IndP33KMP5uYXkrmOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758913413; x=1758999813; bh=5Xtq5jqZnMXRx3+YJ6djri469yaB152ond8
	VPw3iPHk=; b=G6TCKlLPYuf+vQR29uYbVtKaXb8kqU15dcZCDiJgs7tYz0pTndf
	XfkSpmHFB/RcJ35QD8WCQiheCnz/ce0meVwb7rlrlb5ycJSCIVZ6DwMdmzjf3wz5
	9JnYjs10JBZuQnP1qnQvdhhKd3mWoj3XFP+wHzCNzce7m2SvOKkkejn06eZLHXsE
	pOzB64DoUjLkjq1jadciaicUrWSIuzBtjArQwW4cTWOXyUeaOyUqzsDzp1l8t42h
	j4RDPx7guQgX5LS4XqCaECwBUSEVDCkzrzab0/BkqRBJumr76Y7ePwwcvK8fK9QK
	AlGvdSJtQJcfPvlp5nlWqdm/2TYleXgK1AQ==
X-ME-Sender: <xms:hOPWaLZXj7gVvRqAolNI3m7DNeABxNE_rkHzAhePqulbdZj7wBx_lA>
    <xme:hOPWaOEdDwXDq4INGSKeCvRU5ecR6uE5MZJWZCrvzuNJKtbKzy9vMr35nMYDmdpVU
    ZhX9sroYIzbFhNpVzPyg6idss3GfPQlQPMbwQPHrzHmxtf6GYs>
X-ME-Received: <xmr:hOPWaHw5d66w5qo3OAb3Us3zNSe4Z5uQCugOvZJUF4iY1myHRD3q2jFj-WerVikQxwIVsKH1yIz3mLhTK5l_FiWErWiLhVyq9QHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejtdduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhulh
    hirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hOPWaIlRptC7TF6xL_SIOdMch2MqhfFqlAsQjSXN-GtnCafNn7MM9w>
    <xmx:hOPWaImc06Irmd0ajLcIRJWYzB1TnQUSWaKcLID-IknT6VSr_Sv5PQ>
    <xmx:hOPWaCzbOB43CMNELSwTpU6N_xHDIacWtdorThGbjZ6wpV_n3VODVw>
    <xmx:hOPWaFpQtzXvkTHycAz4yQ2Tvc1Bfp-Vx6o_DVGg6JCS0rammELO3A>
    <xmx:hePWaO_lYeU3Lci_qkwTxvVB5bGUGUcgb-jcqXTaeWCN8015kfkNE0Ys>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 15:03:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 4/4] doc: git-push: clarify "what to push"
In-Reply-To: <442a4f25-7d7b-4f34-9e2c-ce396277e7be@app.fastmail.com> (Julia
	Evans's message of "Fri, 26 Sep 2025 13:31:32 -0400")
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<be6453d010bdc9d2b49988d6841dd7e7f9bdf1f8.1758649472.git.gitgitgadget@gmail.com>
	<xmqqqzvvk4bj.fsf@gitster.g>
	<2365a7b9-3d22-4406-876d-65822822655f@app.fastmail.com>
	<xmqqzfaidyil.fsf@gitster.g>
	<1422594f-b0a8-4a7a-bf78-940693757224@app.fastmail.com>
	<xmqq348admuo.fsf@gitster.g> <xmqqwm5lcjvy.fsf@gitster.g>
	<442a4f25-7d7b-4f34-9e2c-ce396277e7be@app.fastmail.com>
Date: Fri, 26 Sep 2025 12:03:31 -0700
Message-ID: <xmqqa52havek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>> In other words, the push.default=simple mode does not tell Git to
>> push to a branch with the same name.  Rather, as a variant of the
>> push.default=upstream mode, it tells Git to follow the same "push to
>> the upstream branch" rule, which requires you to configure your
>> upstream.  But the mode gives additional limit on the name of the
>> branch that can be set to upstream.
>
> I like the idea of explaining it as "push.default=simple uses the
> configured upstream branch, with the restriction that the upstream
> branch must have the same name".
>
> But as I learned from you earlier in this thread: https://lore.kernel.org/git/pull.1964.v2.git.1757703309.gitgitgadget@gmail.com/T/#m896f4a32ca462d69637b56f9bdfaa61e55e6b952
> push.default=simple will sometimes push the current branch
> to the remote branch with the same name even if there's no configured
> upstream branch.

It was not me teaching anybody, though.  I was showing my puzzlement
and confusion.

When b55e6775 (push: introduce new push.default mode "simple",
2012-04-24) introduced the "simple" mode, the intention was fairly
clear:

    push: introduce new push.default mode "simple"
    
    When calling "git push" without argument, we want to allow Git to do
    something simple to explain and safe. push.default=matching is unsafe
    when used to push to shared repositories, and hard to explain to
    beginners in some contexts. It is debatable whether 'upstream' or
    'current' is the safest or the easiest to explain, so introduce a new
    mode called 'simple' that is the intersection of them: push to the
    upstream branch, but only if it has the same name remotely. If not, give
    an error that suggests the right command to push explicitely to
    'upstream' or 'current'.
    
    A question is whether to allow pushing when no upstream is configured. An
    argument in favor of allowing the push is that it makes the new mode work
    in more cases. On the other hand, refusing to push when no upstream is
    configured encourages the user to set the upstream, which will be
    beneficial on the next pull. Lacking better argument, we chose to deny
    the push, because it will be easier to change in the future if someone
    shows us wrong.
    
    Original-patch-by: Jeff King <peff@peff.net>
    Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

We did reject a "git push" (no other arguments) in an unconfigured
repository using push.default=simple.

We must have _broken_ it along the way somewhere over the years.

In the output from

  $ git log --all-match --grep=push.default --grep=simple

there are a handful of changes that touch PUSH_DEFAULT_SIMPLE in
ancient history; ed2b1829 (push: change `simple` to accommodate
triangular workflows, 2013-06-19), seems to have broken the
unconfigured case, which 00a6fa07 (push: truly use "simple" as
default, not "upstream", 2014-11-26) tried to fix it, and then
another commit e291c75a (remote.c: add branch_get_push, 2015-05-21)
further tweaked on the triangular (i.e. the remote you are pushing
to is different from the remote you are fetching from) workflow.

But that is long time ago; I do not think we can _fix_ the breakage
as that would be a big behaviour change.  If 'simple' works to
update the branch with the same name as your current branch at the
remote you cloned from without you having to do anything special,
such a convinience is something the existing users we acquired over
the past 10 years must have become very accustomed to already.  We
cannot break them.

    And that is my excuse for stopping to look into the detauls of
    these commits the above "git log" command found ;-)

> So it seems more accurate to say that push.default.simple will push
> to the branch with the same name, with the restriction that you might
> have to set an upstream, because the branch must always have the
> same name, but whether or not you have to set an upstream depends
> on the situation.

Now, I am still confused as I was when I wrote the message you
cited earlier.

Do we ever have a case where, with the "simple" mode, you have to
set an upstream?  You may have set an upstream in a way that is not
compatible with the "simple" mode and need to fix it, but otherwise,
it appears that the "simple" mode should always work for an
unsuspecting user who does not configure their repository and
remotes into some nonstandard shape.

And if so, perhaps we do not need any special warning/note to write
for a place where we talk about "git push" generally (as opposed to
where we talk about push.default=simple settings)?

Thanks.
