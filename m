Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B414276
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710541160; cv=none; b=gwhnrAjh9WwtF3ozQxLrhVnnYJ5gCcarwbUfrQOVWj5SvfXTuxQWjs3/qQYubhbD01NgTIK6JWOCIczFA1cBjpMAIdu1SaKgJK3ktbv+qNWWIEuj08oaWNfXCA4iZbzIdqJr+BMvlYG/Z8nlz3D4GxfWVaOptUAbFSk8qftdL0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710541160; c=relaxed/simple;
	bh=fIpZMfyJuCm0zQ6DX5fEmekjF1eqHRUYShAtUW3josY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmECRO+if6u3dPc13Ni88E0eMJC1rcvvAZhivMP4nJM0LUwPToKgxVZv+pLUYU78gcIlzUx1z4Ogg8hGxeMRE5bm7jzTlw/FOtNbmtqGjlcdOBQbnZRkDOHj5kZaKCTyiE48FHrBnpl4Vjd6clLjPgyNbjsWFXiR4TMBzVQo0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4TxJZD37Yhz5tlB;
	Fri, 15 Mar 2024 23:19:16 +0100 (CET)
Message-ID: <ebd073ef-4ba4-44df-919a-2adefb40e3e7@kdbg.org>
Date: Fri, 15 Mar 2024 23:19:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git is not recognizing some merge conflicts and just accepting
 incoming master version
Content-Language: en-US
To: Kai <k.vongrambusch@googlemail.com>
Cc: git@vger.kernel.org
References: <CA+XMOBuK1_BNqgQRfCne8dVXKGPt+iQ9wt4iZqz0PgEqZ5UCtg@mail.gmail.com>
 <606fe3fa-a5a0-4d35-a4a0-59521043dde4@kdbg.org>
 <CA+XMOBskofgsmCbcchmPYo9rF9+Cdtdj_m8VzQrLbGhZPm+mrw@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CA+XMOBskofgsmCbcchmPYo9rF9+Cdtdj_m8VzQrLbGhZPm+mrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 15.03.24 um 14:22 schrieb Kai:
> If this is expected behavior, this is a big issue in this case, as I
> cannot trust that after sorting all conflicts that my code will work.
> In that case I would need to manually review every diff. Or is there
> maybe a stricter mode for merge conflicts, to also highlight these
> types of differences?

Brian has already explained that the result is the expected one. For
Git, the text is just lines of text and that's all it cares about. But
for us (and the systems that use the texts, compilers, web servers...)
they are much more than that: they carry meaning. Git doesn't care about
the meaning.

It is correct to some degree that you cannot trust the result of a
merge. It will be correct on the line-of-text-basis, but it is not
necessarily correct when it comes to the meaning of the text.

Yes, you have to manually review every (not diff, but) merge result.
That's the responsibility of the person doing the merge, who at best
understands both branches being merged.[*] It is of utmost importance
that a merge result produced by Git is not taken without thinking. It is
never a no-brainer.

[*] That is where good commit messages shine.

-- Hannes

