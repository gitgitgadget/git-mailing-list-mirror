Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106E433AD
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758928072; cv=none; b=MG75vfix2XFsCEIotEhgBXzKrH4JAK44H7PgHryvef2SWqoZ/rZZSW5ADRu8CpxyMoYCwbKuu/CYs86rbtj9b0ulSw9Iw5cA3to3AbMaVzMNzPkO7Tgoc+pUi4JDdtvi5fVPsavHDY85eVFvnUiWGsX24M8vZCnWfcEmDbM1A20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758928072; c=relaxed/simple;
	bh=+IHjMtVnZscQLS099wZdbaWnGOAaJ9M7k0WG+bH9e/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BY2QN/61hFNqLcRdDUYz+uHqB6hrnnXOQOHwo3yDXupaqN62nhiGNpkiwV1eUWeupTtS0pSKTxlHUtZq24UCMEfplOLYZJXHnrBIC4EbK9KR5JNTFLSIzs9vof0NLX7J0zZHNufkuf2yxjoO9lmRbj8v83jKxuzK1bUTLm/WAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Abl6V1jX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b4y5z0kU; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Abl6V1jX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b4y5z0kU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D1D581D000EC;
	Fri, 26 Sep 2025 19:07:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 26 Sep 2025 19:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758928068;
	 x=1759014468; bh=aiwL5lJvOAxgFp2xMSEEpeONqsURAtvvSfl++1CAQEU=; b=
	Abl6V1jXYOwW1FeYmzdFOFQxlcMCMuEBKvOf51PDkGk9v+1Ddt+HqJ1NCTY/WbTu
	j0larblFsr8IzmqCWO29SegQiuhJA4CszsMhteb1csNurWbWEHEw8pJ7iRu4h0Cd
	TdgM1ykOYD4KHJddNHnSKve58dgtj33n8xmuFnOTycB15MgoRJ2DocInWjRM+jyZ
	f4RBkcQ5kUP8q0448xsAdPNd6kHeHndqn8O0S+ZqJiKjwCGoKui5apKHKYqfwy0T
	8PEttIeiQ/01GTScy8aXvFajy/LOY6BmUKKVdj7uc1euAmYXGjpxMiAjvVJfZO58
	BSRWPKuy5jCmok/u3nQ5tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758928068; x=
	1759014468; bh=aiwL5lJvOAxgFp2xMSEEpeONqsURAtvvSfl++1CAQEU=; b=b
	4y5z0kUWOtX1kOp6j4QxsjHjqybc0nCP53acB2MGvGavuPDpKQ9tfBdgJ33RqjbD
	XEL+Tl1oKpi20vPI2rAzRup6D1INH7QxxmkxtrNq8mOKsgSrLr2Sz4emn0HCTGS0
	OLJGWAeKO+ilGqYiMjvqmuEEpIeyZWQm4vDQunNvNYuONfMX8zoUXPyjZJZmrkGe
	APUykOYg0/WTsLe6P8+JOZsKHJaXNjFm0xVzZ/u7Uec5PpitymFQdak4g+Qlsr56
	Sm/qFuQqqpyO0uU+AWcE67TCQyoiQ90yIJDB8L3v+PzjDrfl0L6doYUsNbNJxTxB
	fd0Q6DRG9F8ld+Tz1QzyQ==
X-ME-Sender: <xms:xBzXaG0Brleqc2CBfBe9hZVM4On9jYMIcQ6z3SI9g8n6AolamD_oMA>
    <xme:xBzXaMzKS3gcqEXwLWunin2mu7ZKxaDeR2l75U4e2u_5JkvXOWCSHWNEC5YJO1aeJ
    TSinlrEcvJkWwy_J3P9rmUIwnL7kcEoL_xui-YB3GhNSfHLi44j>
X-ME-Received: <xmr:xBzXaIv7S3U_XgNsC3WjVuYInWL_pHGWNHhh208X_dpVA2d674CGEQC5WM1J4lZ6s_W0mSxodub6q6pXjBQtFQnCyQ59pdyTSPaB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejtdeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffdtfeffgffgueehlefhgeffvdevgfevkeegvdfgheeljefghfekudelgeel
    uedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpuggvfhgruhhlthdrrghsnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xBzXaOxraoc1BbXt9G2yM4hryYgsZREm0KKNqvWspfeNtsiX4TilRg>
    <xmx:xBzXaLDKS9EcUf-f0GfMO95XaIMa425bYDc0LQpGTAQX-x25G8b-fQ>
    <xmx:xBzXaMeLzz5M6835x8rkCDxSFPJCfc52tKKHmIO-ZHD3W9Jc9gnzbQ>
    <xmx:xBzXaFnEb7ESGSGKNOy5Ph9_q6IDnAbnYtQwYrhgDvYosFSfofNrEg>
    <xmx:xBzXaNaqC9YS9VDetbJp4w4mMx2UpaIxSdAMtGzyQ2hrMIx_9TuhJspU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 19:07:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 4/4] doc: git-push: clarify "what to push"
In-Reply-To: <2b8193d1-f492-4cfd-b568-107d68112d9a@app.fastmail.com> (Julia
	Evans's message of "Fri, 26 Sep 2025 18:27:00 -0400")
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<be6453d010bdc9d2b49988d6841dd7e7f9bdf1f8.1758649472.git.gitgitgadget@gmail.com>
	<xmqqqzvvk4bj.fsf@gitster.g>
	<2365a7b9-3d22-4406-876d-65822822655f@app.fastmail.com>
	<xmqqzfaidyil.fsf@gitster.g>
	<1422594f-b0a8-4a7a-bf78-940693757224@app.fastmail.com>
	<xmqq348admuo.fsf@gitster.g> <xmqqwm5lcjvy.fsf@gitster.g>
	<442a4f25-7d7b-4f34-9e2c-ce396277e7be@app.fastmail.com>
	<xmqqa52havek.fsf@gitster.g>
	<2b8193d1-f492-4cfd-b568-107d68112d9a@app.fastmail.com>
Date: Fri, 26 Sep 2025 16:07:46 -0700
Message-ID: <xmqqecrsak3h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Julia Evans" <julia@jvns.ca> writes:

> On Fri, Sep 26, 2025, at 3:03 PM, Junio C Hamano wrote:
>> "Julia Evans" <julia@jvns.ca> writes:
>>
>>>> In other words, the push.default=simple mode does not tell Git to
>>>> push to a branch with the same name.  Rather, as a variant of the
>>>> push.default=upstream mode, it tells Git to follow the same "push to
>>>> the upstream branch" rule, which requires you to configure your
>>>> upstream.  But the mode gives additional limit on the name of the
>>>> branch that can be set to upstream.
>>>
>>> I like the idea of explaining it as "push.default=simple uses the
>>> configured upstream branch, with the restriction that the upstream
>>> branch must have the same name".
>>>
>>> But as I learned from you earlier in this thread: https://lore.kernel.org/git/pull.1964.v2.git.1757703309.gitgitgadget@gmail.com/T/#m896f4a32ca462d69637b56f9bdfaa61e55e6b952
>>> push.default=simple will sometimes push the current branch
>>> to the remote branch with the same name even if there's no configured
>>> upstream branch.
>>
>> It was not me teaching anybody, though.  I was showing my puzzlement
>> and confusion.
>> Now, I am still confused as I was when I wrote the message you
>> cited earlier.
>>
>> Do we ever have a case where, with the "simple" mode, you have to
>> set an upstream?
>
> Yes. If you clone a repository, create a new branch, and run  `git push`
> (to push to `origin`), Git will complain that you haven’t set an upstream
> for that branch, like this:
>
>     $ git push
>     fatal: The current branch testtesttesttest has no upstream branch.
>     To push the current branch and set the remote as upstream, use
>     
>         git push --set-upstream origin testtesttesttest
>     To have this happen automatically for branches without a tracking
>     upstream, see 'push.autoSetupRemote' in 'git help config'

Hmph, that contradicts with the observation we had in the message
you cited earlier, but it does reproduce for me as well.  Puzzled
again.

> My best guess from my experimentation and from reading some
> of the commit messages/code is that the rules for how
> `push.default=simple` works are something like:
>
> 1. If the remote you're pushing to is the remote that `git pull`
>    would normally pull from if run without any arguments,
>    then require the user to set an upstream
>    (with the idea that the remote is somehow "special"
>    and should be protected from accidental pushes)

This is the traditional 'simple'


> 2. Otherwise, push to the branch to with the same name
>    without requiring an upstream to be set

This is what 'triangular' feature we saw earlier in the "git log"
output in my message you are responding to had a few commits for.

> That said, the exact details of how push.default=simple works
> (ironically) seem complicated enough that I don't think it's worth
> documenting in detail at the beginning of the `git push` man page.

Totally agreed.

> To go back to the original text I suggested:
>
>> 3. The `push.default` configuration. The default is `push.default=simple`,
>>    which will push to a branch with the same name as the current branch.
>>    See the CONFIGURATION section below for more on `push.default`.
>> 
>> As a safety measure, `git push` may fail if you haven't set an upstream
>> for the current branch, depending on what `push.default` is set to.
>> See the UPSTREAM BRANCHES section below for more on how to set and
>> use upstreams.
>
> The words "may fail" are definitely vague, and I agree it doesn't feel good
> to give a vague explanation like this. But if we think the current
> behaviour is "broken" and hard to understand and that we have to keep it for
> backwards compatibility reasons, giving a slightly vague explanation
> (perhaps with a reference to where someone can read all the gritty
> details) might be the best path.

OK.  Thanks for helping me think this through.

