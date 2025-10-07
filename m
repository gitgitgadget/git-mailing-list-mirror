Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C7423E350
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759872075; cv=none; b=lQ33Wzyco0a9ptjkUkeXZpL7v+Alz/KvOQ2r0DzFTvtnkZ4kmlkDQIwPBjCzK6mZfyubby+1eaosNN0QGRBduOpn1PdYTCoChN9vePy4oAVoCYIhTMNGWIsH2qaeECun+V6lUmSYY6gUd1ngZvBb+blKfBxAYI/NeXX7BgvurTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759872075; c=relaxed/simple;
	bh=BERzd/JExp6SUrTDKMPVTEpJwI8/A6HwvTFxB+iLe+s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Qg9voMKwB4u5PWbiVTb+j6sO6X1yu4P3l22322TJKxPFjAQqTZlEU2bpZvN1BTcC/gklUq0otcKEy+NIDy/sbgCDZcMsUDCXkJPK2uQyy/g2gqfZdWbiDZ/dNSY3sJsManJjpCOuGAT1Dc7aQc5ubwlr77F5oqBwVF+P/050E8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=MEWudcIP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ey+Z/nrm; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="MEWudcIP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ey+Z/nrm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1345EEC006D;
	Tue,  7 Oct 2025 17:21:13 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 07 Oct 2025 17:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759872073;
	 x=1759958473; bh=APdQ1QqwBJYf0+5R7vxTkGQdb0XvsFhyDAPxyYGBjbQ=; b=
	MEWudcIPC8jjuLPEqVGfDIA8d0nVaaA7WTeeGWiWkeulvVa+tGujbsxOwHYwne0L
	7a0U0vgBxuqefKpGMj92lfdcCDU8bfwxh8xuFP6JEraOgl+FymKAbPmoB9M9QKAh
	0yjaGqeOnV9MOA9X9A6HVf/UCfS5aW4VV9b/ShuIQlt73OXih0P+YwdKCs6wE23o
	1+Cta518oNeHW4zlkx4blW+n/o/ZR+xDoE9D8ZI16S+Gaz21/pW+QQTy8bHBYfHl
	rj55wbP/XnKMB9BVMb6TdwaSPRVpnRTQiovTpSqB6fhAi7RT1TN8Xl6RdKoT/pXA
	QvNE4m1NAfrcnG++t6Drlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759872073; x=
	1759958473; bh=APdQ1QqwBJYf0+5R7vxTkGQdb0XvsFhyDAPxyYGBjbQ=; b=e
	y+Z/nrm0738esecwuhciiVX5mfx2LByd57JpDzwMjVTsBjmpaELyQcB4AtV5TDcX
	2+cN8B4+0EdLCzNoh2EVTryEeozz/SF0ek092ZWf4lZo0FptlIQuxhrVEgDw/Pwd
	sspo5Sj5Gw6PKZbT31nbis/NVG5vMl25emM6em+6ahCkg8F8vN7fOxhd08h4tiEr
	ofw8TqddOZnvNu7WxDiNVmOXaFStURgLdxAlMMJryvBeWsUwZoNtQjX2Ob8B6hIx
	+eJ0gVqgiZ9T9XXVtQvhAE0DxxZ110AMITjr4wm/viEGIJyuiII1Fbj2cRx/uoy8
	g9LzRGoGxtq051dsZAS+w==
X-ME-Sender: <xms:SITlaBR556rvSVW9H1cwUAm5tNlbRRPCeN-XKGwAVOC538lKv8GKaA>
    <xme:SITlaFlZVY03uqgRQI44bM_gnx1qKP60ip6OR3za_oaL7x82iu_JpwJik1ulALjBZ
    9Of3tVngtMdeZ75pA-h7DhGNCRyOpAZOvcyulPhJSAsWZKHYeNxnLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddugeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epveeludfgiefgkeeuueegjeelhfffheeitdejgeekgeehueeileeigeelhfelhfdtnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SITlaMtCnirLfX1gFRTZDkmztA8cl2IvHxeiEr0FtPDDKO2Oxyn5wg>
    <xmx:SITlaBNWU9vAMylXDJYpIx9IeRQHNo9z0kpdxzxBUu8Qw_pd9DmSsQ>
    <xmx:SITlaK0ztn9gKNkcAm8QiiV5oqeqDhEdjEpqgc-_EsopNvYkOvr-gg>
    <xmx:SITlaNPvDsdeeArx0cEp6PplorxVW80NWGFydBvaDnODV3iI8Kg_zw>
    <xmx:SYTlaAPxhevsHU-ZYeHFMU98yJJ924Zw1VIvRv1JPijlLkSOnApQYFFv>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BB30278012B; Tue,  7 Oct 2025 17:21:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AiUY22aznoKg
Date: Tue, 07 Oct 2025 17:20:52 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <9091705b-e575-48d7-95a0-5e2835fb9edf@app.fastmail.com>
In-Reply-To: 
 <CALnO6CCQhTR77nvjPM-fhTm9o6imjw9Erk0NMWhLMYrSAWW8hw@mail.gmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
 <f69d2e6fabbace9ae76cb3822b063a3f19622138.1758656702.git.gitgitgadget@gmail.com>
 <CALnO6CCQhTR77nvjPM-fhTm9o6imjw9Erk0NMWhLMYrSAWW8hw@mail.gmail.com>
Subject: Re: [PATCH 1/4] doc: git-pull: move <repository> and <refspec> params
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Sep 24, 2025, at 4:17 PM, D. Ben Knoble wrote:
> On Tue, Sep 23, 2025 at 3:45=E2=80=AFPM Julia Evans via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Julia Evans <julia@jvns.ca>
>>
>> From user feedback:
>>
>> - it's confusing that we use both <branch> and <refspec> to refer to =
the
>>   second argument
>
> Yep.
>
>> - one user is not clear about what `refs/heads/*:refs/remotes/origin/=
*`
>>   is meant to be an example of ("is it like a path?")
>
> Also yep, since the deleted text doesn't contain any pointers to learn
> what a refspec is.
>
>> The DESCRIPTION section is also doing a lot right now: it's trying to
>> describe both how the <repository> and <refspec> arguments work (which
>> is pretty complex, as seen in the DEFAULT BEHAVIOUR section)
>> as well as how `git pull` calls `git fetch` and merge/rebase/etc
>> depending on the arguments.
>>
>> Handle this by moving the description of the <repository> and <refspe=
c>
>> arguments to the OPTIONS section, so that we can focus on the
>> merge/rebase/etc behaviour in the DESCRIPTION section, and refer folks
>> to the later sections for details.
>
> I generally like this: it makes things a bit more consistent, even
> though "options" isn't quite how I think of these (optional!)
> positional parameters. Still, I generally jump down to the <arg>
> sections (like in git-push(1)) to learn what I can do with those.
>
>> Use the term "upstream" instead of 'the "remote" and "merge"
>> configuration for the current branch' since users are more likely to
>> know what an "upstream" is.
>
> With the upstream section, great.
>
>> diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
>> index 48e924a10a..50af7fde81 100644
>> --- a/Documentation/git-pull.adoc
>> +++ b/Documentation/git-pull.adoc
>> @@ -27,17 +27,6 @@ and then depending on configuration options or com=
mand line flags,
>>  will call either `git rebase` or `git merge` to reconcile diverging
>>  branches.
>>
>> -<repository> should be the name of a remote repository as
>> -passed to linkgit:git-fetch[1].  <refspec> can name an
>> -arbitrary remote ref (for example, the name of a tag) or even
>> -a collection of refs with corresponding remote-tracking branches
>> -(e.g., refs/heads/{asterisk}:refs/remotes/origin/{asterisk}),
>> -but usually it is the name of a branch in the remote repository.
>> -
>> -Default values for <repository> and <branch> are read from the
>> -"remote" and "merge" configuration for the current branch
>> -as set by linkgit:git-branch[1] `--track`.
>
> And we don't even mind losing "--track" here because we cover it in
> Upstream Branches (e.g.,
> https://lore.kernel.org/git/3ecfb5c3a67723f160e8161e212d77f95964539c.1=
758649472.git.gitgitgadget@gmail.com/).
>
>> -
>>  Assume the following history exists and the current branch is
>>  "`master`":
>>
>> @@ -77,6 +66,24 @@ pulling or stash them away with linkgit:git-stash[=
1].
>>  OPTIONS
>>  -------
>>
>> +<repository>::
>> +       The "remote" repository to pull from.  This can be either
>> +       a URL (see the section <<URLS,GIT URLS>> below) or the name
>> +       of a remote (see the section <<REMOTES,REMOTES>> below).
>> ++
>> +Defaults to the configured upstream for the current branch, or `orig=
in`.
>> +See UPSTREAM BRANCHES below for more on how to configure upstreams.
>> +
>> +<refspec>::
>> +       Which branch or other reference(s) to fetch and integrate int=
o the
>> +       current branch, for example `main` in `git pull origin main`.
>> +       Defaults to the configured upstream for the current branch.
>> ++
>> +This can be a branch, tag, or other collection of reference(s).
>> +See <refspec> below under "Options related to fetching" for the full=
 syntax,
>> +and DEFAULT BEHAVIOUR below for how `git pull` uses this argument to
>> +determine which remote branch to integrate.
>> +
>
> I think these are covered in Documentation/pull-fetch-param.adoc,
> which I only found by looking at "git help pull" and searching for the
> URLs references, hah.
>
> Anyway, the existing explanations are far too late in the manual (Vim
> says ~46%, 960 lines down, when rendered with MANWIDTH=3D80). Moving
> them up is a good idea, but maybe we need to do that in a way that
> jives with the later "fetching" section. Hm.

That's a good point. It's a bit weird because (I think) `git pull does u=
se the=20
<refspec> parameter after passing it to `git fetch`  (to decide which
remote branch to merge), so we can't just say "to know what the refspec
parameter does, see "git fetch", and we can't just copy the existing
<refspec> section further up.

Rewriting the <refspec> section of `git fetch` so that it addresses both=
 the
`git pull` and `git fetch` case seems like it would just add more confus=
ion.

Duplicating the content of the <repository> bit and then referencing=20
the second <refspec> section below is the least bad option I can think of
right now, since most of the time you don't actually need to know how to
write a refspec.

I'll add some internal links in the HTML version to the <refspec>
and DEFAULT BEHAVIOUR sections so that they'll be easier to find in the
HTML version at least.
