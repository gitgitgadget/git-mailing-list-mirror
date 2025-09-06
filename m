Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762B18DB01
	for <git@vger.kernel.org>; Sat,  6 Sep 2025 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757134624; cv=none; b=BbkTTLcOi+ZSE9YP+fbicNWa9nZb6LfdSa5VgBcvoq2lXZJCW0zDB28Dc4MVpstnasAr5frOpBoMEqb87F8P81CQPtZSf5PLw+8ciyBJUm/Xb/OTm/xlav/n8fTjN471JoomFhACPVR/zxxX6GH2C2fww1OFzXmRcGr9HlpzCas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757134624; c=relaxed/simple;
	bh=pvMooT1zF/3FwUyd3bf6sZJYUmT6BkoUtjlua6hB6IY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UDDbrZufHCwUOgm42IUJ6Z+/ecIqVJGqRyI2UYei12cOXdAcVN1+/Bv75lkHNMLGGvvtmC+dwbAu4JBMHev54jIDS4Kc2gO/E5yUKRBBBkUz+C9hcqe+qYgLkUd9Th/mcJ/JeGlziER9ISzW3rybgjrqLWl2kJcVtan395kxwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nMIlgIkm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ot2Ztti0; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nMIlgIkm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ot2Ztti0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 962EA1D0005A;
	Sat,  6 Sep 2025 00:56:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 06 Sep 2025 00:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757134619; x=1757221019; bh=yC6YtaZB5s
	KJvGCKOYW9Q+ETvGXg1CGhfi4adFNBu/g=; b=nMIlgIkm6hKwccC4r+bPa8DVFr
	DB6LXCSRtuI8ZxzLmH2oXe2B9Kzzf2tX4kaPdEs9ZepCLNhkdTdZzIEtuV0DT1BS
	H0QOeq9Hn1TbqCfJBJlsU7Tb6mEyPktzdsFjYr8bmZCuSrICUKznAw46B8Kt961V
	I1HvURuSaJLgcS50VZJ9RkbUZt/MqkICBKJtCOM+TmHggFDx+JieU7zE/5lgdk1p
	pCwvrBJ6FkinE3JPdwGDHS2ldVrntTFAcHSwnt0yjBss+4uLm/4fEand5SpieUrU
	dFZtV/DvqZcvFuWKgWxj4Y4hpTEX1UDiuSNfWz/g0E4E8XUTNEdfMHN97h0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757134619; x=1757221019; bh=yC6YtaZB5sKJvGCKOYW9Q+ETvGXg1CGhfi4
	adFNBu/g=; b=Ot2Ztti0FIItyXsZCsEWtTdZTkTAL93Dz5MIU92zt8SLk17kkcQ
	E+099gDAFwSoiULHcWiXI2EodUzYv4yRIpqEyUWJoBoX+PdZwgI8sPGizkHoTU1r
	tSmgmniGm0Tp9ucn6NsfqGWbm4tUW/Y/3qDKj0vFdvh/mNxHniXBgeTj6RloNP17
	eOXR7nA7b0GHOFFqBN1ObhTXwOFmwD3rEF2/wPY88Sf0hnF+dI3iG0cQ0r4J4R8E
	VWRFOKKJdcomYiYvKkBIf1RwgJCrzkUEDbecHUkpfKP688MmpVa7Feho7u/svMwK
	qZoSJYVuAacR+fd6rNUUvMQZbpUb56scgmA==
X-ME-Sender: <xms:G7-7aP6ovgU7hS7Zcy0wV_Aswuk9zx12OAZx51KzsROys_3RF6awyQ>
    <xme:G7-7aIIwqAB5T4KevX3VH76_4-XIaM0BBbBPE_MYRrciXJbegynxZyFROtjHuOzBw
    NVgDb3SfDE_Nrbkcw>
X-ME-Received: <xmr:G7-7aP7207_knMz2an2wXf7KIsYwTjhgPOXHJphovNmBVmuFQg0AspBCQ8dU5TOVQmVJSeAbNqsnI8kvWaNpD3oFjbyXvIClL8ZWV1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopeguvggsohhhmhgrnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:G7-7aLzZsX1ciToFpb0NfTGAn84Loxd6DoLlVl3iAbeTAyPdD0STOg>
    <xmx:G7-7aDYeOhqPzR03HM7pnq1dhtn7ftZ12yIGbMrkaICXT2rC6FWRtA>
    <xmx:G7-7aNRqfn09MAbY1s5suq2iIUkUO8bJONmyjLr9Eo_mEBsq_7eTcQ>
    <xmx:G7-7aNy0bLlwZ3b6tCMtQjYd5HzRS80C7EKYs509WoXcSYfkVwzuVw>
    <xmx:G7-7aIybix21xaTKOm1uRMlDzFNBv1DVNvKOPqeg_bp-2GSYEOlW37aI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 00:56:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: David Bohman <debohman@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git-2.51.0: Fetching tags does not work
In-Reply-To: <CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com>
	(David Bohman's message of "Fri, 5 Sep 2025 17:30:40 -0700")
References: <CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com>
Date: Fri, 05 Sep 2025 21:56:57 -0700
Message-ID: <xmqqcy8418me.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Bohman <debohman@gmail.com> writes:

> This is into a bare repository:
>
> git fetch --tags
>
> The command notates the tags it will update, but they do not get added
> to the repository.
>
> I reverted to git-2.50.1, and the problem went away. This is a
> regression in git-2.51.0.

The following is my attempt to reproduce ("rungit $version" is my
way to invoke any one of many versions of Git I have installed).

First let's create a bare clone of a repository "foo" in bar.git

: git x; rungit v2.51.0 clone --bare file://$(pwd)/foo bar.git
Cloning into bare repository 'bar.git'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (3/3), done.
: git x; cd bar.git
: git bar.git/BARE:master; rungit v2.51.0 for-each-ref
dcd3daa27e4c2f5182cfa80e5097fed4936b7037 commit refs/heads/master

So now I cloned from "foo" to obtain the "master" branch.  There is
no tag, so nothing else was transferred.

Then we go back to "foo", create a new commit, and a tag.

: git bar.git/BARE:master; cd ../foo
: git foo/master; date >stamp && rungit v2.51.0 commit -a -m "second"
HEAD is now at 2ec78a8 second
: git foo/master; rungit v2.51.0 tag really
: git foo/master; rungit v2.51.0 for-each-ref
2ec78a8e44a74213773a96f6c870b59ae2bfc7f0 commit refs/heads/master
2ec78a8e44a74213773a96f6c870b59ae2bfc7f0 commit refs/tags/really

Now we have an updated branch plus a tag.  We go back to the bare
repository that was created earlier by cloning "foo".

: git foo/master; cd ../bar.git
: git bar.git/BARE:master; rungit v2.51.0 fetch --dry-run
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
Unpacking objects: 100% (3/3), 252 bytes | 63.00 KiB/s, done.
From file:///var/tmp/x/foo
 * branch            HEAD       -> FETCH_HEAD

Without --tags, we would not fetch the tag.

: git bar.git/BARE:master; rungit v2.51.0 fetch --dry-run --tags
From file:///var/tmp/x/foo
 * branch            HEAD       -> FETCH_HEAD
 * [new tag]         really     -> really

With --tags, we would.  After seeing these two dry-run results,
and making sure ...

: git bar.git/BARE:master; rungit v2.51.0 for-each-ref
dcd3daa27e4c2f5182cfa80e5097fed4936b7037 commit refs/heads/master

... dry-runs did not do anything, let's try a fetch for real.

: git bar.git/BARE:master; rungit v2.51.0 fetch --tags
From file:///var/tmp/x/foo
 * branch            HEAD       -> FETCH_HEAD
 * [new tag]         really     -> really
: git bar.git/BARE:master; rungit v2.51.0 for-each-ref
dcd3daa27e4c2f5182cfa80e5097fed4936b7037 commit refs/heads/master
2ec78a8e44a74213773a96f6c870b59ae2bfc7f0 commit refs/tags/really

We have the tag fetched.  Note that this bare clone does not have
any fetch refspec,...

: git bar.git/BARE:master; cat config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = true
[remote "origin"]
        url = file:///var/tmp/x/foo

...so the master branch hasn't been updated (the new value is only
in FETCH_HEAD, which is expected).

As we can see here, my local copy of 2.51 does not seem to exhibit
such a problem, so you may need to narrow it down a bit more for
others to be able to help.

Thanks.
