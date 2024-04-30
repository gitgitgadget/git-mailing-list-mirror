Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCBA17F38A
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502812; cv=none; b=BOK/f/Fqu9fxTxA4YXW/f/lIOjpV1zA7yWKNh5nzJz0Awc6BHmxMHGHfTnjuiPQw9PHZkSjvYQ/xd16cSZxZFSkuGbOyDOBrx0E1GvgXwPFR6GAZV99ITA9wjOngp1siK4B+eGDNNnwxPCpXeWJvlFC9Y3XNNr8WkSYWjkic1lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502812; c=relaxed/simple;
	bh=bQbi4GOzfJ8edehCcjs75FSptgv871Ab6HNhUgFtzl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sbv2/So1+VSNgtBOyvfBB1lILse6Pltvccd61hjJAppAA09Dp7PUXy9a7Z2QOii89tJlZodThtyLITAGbihlppngPRJaX0qEBwwDzDCzxZOmUJelPV6CfW30avgU33vIGWXrcmU1+88LbU7J86TnVIJLfpTC55zvNhmDHnP5jyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rSa3xu1b; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rSa3xu1b"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3601E20414;
	Tue, 30 Apr 2024 14:46:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bQbi4GOzfJ8edehCcjs75FSptgv871Ab6HNhUg
	Ftzl4=; b=rSa3xu1b1DwdKUnH2n/pNz/1I8NYLIsW9JUgv7ogVU+sPiGnTHzHqe
	LQduPNnrv+CRlXj40mLdIM6KMT+gL2c7abTIM53wXS7aWOjOT8ftfoGEbnmrj+ih
	DeHKtBr3sxt7J7mMRhUbWX+n/86D9TqT3VdVXdvJFa9KZ7Co1LxoA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E93220413;
	Tue, 30 Apr 2024 14:46:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F12720412;
	Tue, 30 Apr 2024 14:46:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Toru Okugawa <castor.4bit@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  git@vger.kernel.org
Subject: Re: Re* Unexpected behavior with the rev-parse operation
In-Reply-To: <CANHPH19FCWUAMZLFZEY+_+zv0KUkuVGNQS26WmEPjnPtjrK8KQ@mail.gmail.com>
	(Toru Okugawa's message of "Tue, 30 Apr 2024 23:26:04 +0900")
References: <CANHPH1-6mbWdt_FLsrDEB_XVb4r3yTYMLLPUyDrL6tmS7jZgqQ@mail.gmail.com>
	<CAPig+cQ39Z+WjThqkxCKgOUfkZyB6PG-6RhHBYhinp-ZY4dxKA@mail.gmail.com>
	<xmqqedap2ijk.fsf_-_@gitster.g>
	<CANHPH19FCWUAMZLFZEY+_+zv0KUkuVGNQS26WmEPjnPtjrK8KQ@mail.gmail.com>
Date: Tue, 30 Apr 2024 11:46:44 -0700
Message-ID: <xmqqedamzo17.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FECF4D02-0721-11EF-9D49-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Toru Okugawa <castor.4bit@gmail.com> writes:

> However, if determining the presence of a Git repository by checking
> for errors is the appropriate approach, I'm interested in
> understanding the intended use of the `--is-inside-work-tree` option.
> I had thought it was meant to suppress errors in exceptional cases.

    $ rm -fr mine
    $ git init mine ;# notice the lack of --bare
    $ cd mine
    $ git commit --allow-empty -m 'initial'
    $ git rev-parse --is-inside-work-tree; echo $?
    true
    0
    $ cd .git
    $ git rev-parse --is-inside-work-tree; echo $?
    false
    0
    $ cd ../..
    $ git --bare init mine.bare ;# this time bare
    $ cd mine.bare
    false
    0

When you write a script that you might want to use as a part of a
hook, for example, you may end up running it inside .git/ and it may
be necessary (depending on what the script does and how it is
written) to tell where you are in the working tree (or if you are in
the working tree in the first place).

