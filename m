Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C9DFC19
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717880579; cv=none; b=LprCOXZZ/P2FYAlIUxjD4WGMwGNtXJC3Ih0vvfFHTZQdNl8UyngLOVEp0OM8GWp5UHODOv7bKJHPHZdfOqKf0zGp0TWCjnzLsVerkWW4stjCmMTraH5hxiJQJx+YUrWs5AH8SKnxLy6EwU1dXGEa1x6yq7xQPfQx6sxY6Oq1Vgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717880579; c=relaxed/simple;
	bh=7D05hsjr6ScOV8Gc8hbXy9YzlKsrN9R6yCZOtpol8GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSQ8FaBtmMA+9PH1rrsuEStTiJrzT2ZSa/JmOv14wJgFCyz9LNXaIRojNsn0K4k7ks3kZPAAOrMhO3W1Om6qkz2Y7DYWsxymsGap3I676pGIuzrlbUuR2iADTmPAdsI5rwsrJqoTK39s9944h8yQvqHGk2g3omh04QrDxyoUO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=7Neg5NDI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c3Vffqjg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="7Neg5NDI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c3Vffqjg"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 68A97138009D;
	Sat,  8 Jun 2024 17:02:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 08 Jun 2024 17:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717880576;
	 x=1717966976; bh=jdJzsRca7DT9vaR5pHOuyK6ySMQX5u9nCOisFt77hMM=; b=
	7Neg5NDIoLLgovJ1oT6u/UgtjgwEHbP00QBdnInMcz+BqaUb5+b6NtoXI5QEiEFh
	VZ7rIvu7Q2pGLEFGtKqhPQRyXZZdpxOpCXQ5lTNsBgv8lC8H2JUiy53MK9CUUSgU
	caqX/sClixpvku+dUJzXrdsf/KrlTWcsW1PDWozg6ufS+vdMn3vm2L7eO5fZz95D
	PrQ90lNIKQuKyPK7gHXfhbMRVk6JO5PkxlziVYsTB1nX72ss/08mO7pvNrvWhYZW
	4kGlCbUViQ0/u5tVreGZpnyimzIr0VOTq2Fu6FKhWsp87TpEm0yip7D8cnrqO3Hj
	+/eO/CAi1YEKWaQcDkMnnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717880576; x=
	1717966976; bh=jdJzsRca7DT9vaR5pHOuyK6ySMQX5u9nCOisFt77hMM=; b=c
	3VffqjgzIP28bnqzRPBWJRATJE5aU3a648OCQVII95FrdfIkdNiWLQec3ztxHqNE
	kAxJ9f5+5T1tIZRTnO+3JmbkqGHoPArvq0qhKz72bwso0vqdew+5zyLlDkpFArQF
	TbGvbubmmn+aLnnAgB8bSNQBe2Df9MvHt1AlvR3CE78HlW5G+D+jKZAoYogbtgQp
	rSmrmWPbOPjvABPQQjqE0VgOQXBfoTymtjxuGE5KgM0MDJXzt6n9xPKeyOvK2wix
	iDJeRyw22M1i1XL/q+pTYHkzwuLJqjtlIT7oaIFkXYz5Of/MZ2qMud/qt1/O/dUS
	qRtHpspycxg2qwmibCWMA==
X-ME-Sender: <xms:AMdkZsr3FEeilqmabsxty-0oC3o17OSFHrmNrYKt52lhWps1L6cDpw>
    <xme:AMdkZioZu_xc7uEhinoHyc0o007D3vLB9OIUF1j3YI4P2kYKKP8xaVIFoUQNBjmZM
    V2HEj8K_CU>
X-ME-Received: <xmr:AMdkZhPLXUodBj8vn6svR5QCpO6jaAwVg82sDQTy-CsRLWklaZePGNFQQKkL3D9FOuvRUdBcYJsXHON-SKT3KDFzkUhM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ekredttdefjeenucfhrhhomhephfhrvgguucfnohhnghcuoehfrhgvuggplhhonhhgsehf
    rghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpefffeduieefgeejveetkeeuve
    evleeggffftddttdefkeevieekhfdtiedvffdvleenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehfrhgvuggplhhonhhgsehfrghsthhmrghilh
    drfhhm
X-ME-Proxy: <xmx:AMdkZj71yeIhKW4IugSE-zZzaiqOjGh1Op37VdU_c34c347NoKhXlw>
    <xmx:AMdkZr7jvheQGcvBqkydeE_71O0UF40UkIrH2o-TnA7duGERUrrpbw>
    <xmx:AMdkZjhI8tSQHNeCxgtOWGAnxwNxm2e6Pa5FtldVldQO4sbaqNputw>
    <xmx:AMdkZl6hSO7ztZtlsqua3YJ1rJURyOfm9VjPPn0b_2fvxOFHj2HOow>
    <xmx:AMdkZu29Hd3N3Eu8wnvb9GKtOtoLGlwMczjvIvca5or5u_Mf-nBqbFfU>
Feedback-ID: i08fc41ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:02:55 -0400 (EDT)
Message-ID: <5247e0cc-ef0e-558a-7e06-5a7425a52329@fastmail.fm>
Date: Sat, 8 Jun 2024 14:02:52 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: git fetch --prune fails with "fatal: bad object"
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
 git@vger.kernel.org
References: <16919-1717194882-875013@sneakemail.com>
 <xmqqplt1d0k0.fsf@gitster.g> <000501dab3b3$51779400$f466bc00$@nexbridge.com>
 <xmqqo78kbqwo.fsf@gitster.g>
 <20240604104437.GD1781455@coredump.intra.peff.net>
 <876fbb07-210e-128e-5289-57ab01761750@fastmail.fm>
 <20240605084718.GD2345232@coredump.intra.peff.net>
 <c2a02982-40a9-6629-05c2-c8de3335f35b@fastmail.fm>
 <20240606011453.GA623737@coredump.intra.peff.net>
 <5469592f-69eb-b1da-1218-abeae88f7303@fastmail.fm>
 <20240608112033.GB2966571@coredump.intra.peff.net>
Content-Language: en-US
From: Fred Long <fred_long@fastmail.fm>
In-Reply-To: <20240608112033.GB2966571@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/8/2024 4:20 AM, Jeff King wrote:
> On Thu, Jun 06, 2024 at 01:12:31PM -0700, Fred Long wrote:
>
>> Yeah, I saw that, and I think I know what's causing the problem. First I
>> create a bare mirror of AOSP with "repo init --mirror" and "repo sync", then
>> for all my different source trees I use "repo init --reference" to share
>> objects with the mirror using alternates files. Running "repo sync" on the
>> bare mirror works fine. The problem occurs when I run "repo sync" in one of
>> my source trees. Commits and refs have been deleted from the mirror, but the
>> refs are not deleted from the repos that point to the mirror. So it all
>> makes sense now. Still, I wish there were a simple command I could run to
>> remove the dangling refs.
> Yep, that all makes sense.
>
> As I said before, I don't think auto-deleting corrupted refs is great in
> general, just because it can make a bad situation worse. But if you want
> the foot-gun, here's a more complete script that you could run. It
> _just_ looks in refs/remotes/, which is perhaps a bit safer.
>
>    git for-each-ref --format='%(refname)' refs/remotes/ |
>    git cat-file --batch-check='%(objectname)' |
>    perl -alne 'print "delete $F[0]" if $F[1] eq "missing"' |
>    tee /dev/stderr |
>    git update-ref --stdin
>
> -Peff
Thanks. Here's what I have been using:

git fsck |& grep "invalid sha1 pointer" | (
     while read err ref rest
     do
         ref=${ref%:}
         echo got $ref, removing .git/$ref
         rm .git/$ref
     done
)

