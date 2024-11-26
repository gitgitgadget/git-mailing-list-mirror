Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8137A47
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 00:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579251; cv=none; b=h0x6qJSEW6bVR1QVwtgZ2tdW7MzdKhFsBmSl/yjszVHaIGNk8hcKce5d+eLa7ycH3VuzSOxqAKv1BDaXhMabZG8VwwuWkZFHZwc2oY2W0gga58SYTFKAlCD3Jp4CGpolnomiXPUIzPDFdEh3AgqekEozxPDd2JG5MUgGG5DFS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579251; c=relaxed/simple;
	bh=5GG4TcbLf5DmW2GT/YPrcnucxT/H+Sj7wRpMSYfFMlc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alwx7ZydAo/wqYBd6Qo85bEZ6GrRa/NInnHOHAmnFtsCAJ6/3S1qE2GE1rkTiW6kJkQZJAqFeIqS8P+Fytp9ZUH/K0aYSQTv6v/JvkZmbdJ5R9zNDzC/JiKX55U9Tx5SYPLks7tnyNLWIKRYbPVDjKPVpMpTOtb4s92yX8FKsEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Ys6if+a2; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Ys6if+a2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732579247; x=1732838447;
	bh=I1PeJtVqep5HNaY5rKEikwoa/UhGbzF3MH8XGY/K2M8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Ys6if+a2T7SYMdLJ2LjhrWgmmSaa8qNhl86C0gjgstl/Bp8P5WEnKggkZbftaZfpt
	 rT/c3QgWDfoJVdj0p6uoMjOPusODYJormftnivIVKg5N9cnBlErUM8v3Arw1djUfyS
	 ep0YZjyJAUqftSvN1aBSFSuvEmJ5lKmbBjI9pQyHmqGzWD5b9nE08+ijNmsI3zg1hH
	 /0o8GZYiow4WcnXatUoDlI85Btc4iSudGQx5M7k2RD/TRECL96bEDdvNrtiMkhK9eg
	 aBrl8tB1z6qFjdJPKvg3iaO9htUaHXbnsAMTgR4SAdmIJcrrWotlgJW45oGhU2/y5j
	 z0n0t9SHAgsag==
Date: Tue, 26 Nov 2024 00:00:43 +0000
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 7/8] worktree: add relative cli/config options to `repair` command
Message-ID: <D5VO2YCU3DM3.2DS3BX0F0NDW6@pm.me>
In-Reply-To: <60325a17-82e3-4a4c-a6fd-d3b597f1c2bc@gmail.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241031-wt_relative_options-v4-7-07a3dc0f02a3@pm.me> <135739ad-6722-449b-9f9b-31c0bbc9f9cb@gmail.com> <D5TBGJS8FWBE.3QYEZWZUS0C71@pm.me> <60325a17-82e3-4a4c-a6fd-d3b597f1c2bc@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 928c8d49dbd5403ce2a5c10cd983401802fce259
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Nov 24, 2024 at 1:27 PM CST, phillip.wood123 wrote:
> On 23/11/2024 05:41, Caleb White wrote:
>> Yes, there is an edge case that a file is written with the same (correct=
)
>> contents, but I think this is acceptable given that it would be more
>> complicated to check if the contents are the same before writing (which
>> would involve reading the file).
>
> That's fine - it might be worth explaining it in the commit message
> though (the same goes for the other patches where we start writing both
> files instead of one).

I can make a note of it in the commit messages.

>>> This works because strbuf_realpath() copies dotgit.buf before it resets
>>> dotgit but that does not seem to be documented and looking at the outpu=
t of
>>>
>>>       git grep strbuf_realpath | grep \\.buf
>>>
>>> I don't see any other callers relying on this outside of your earlier
>>> changes to this file. Given that I wonder if we should leave it as is
>>> which would also simplify this patch as the interesting changes are
>>> swamped by the strbuf tweaking.
>>
>> I'd like to keep this if that's okay.
>
> Let's leave it as is and see what Junio thinks - my worry is that if
> strbuf_realpath() gets refactored in the future it could break this code.

The tests will catch any breakages during a refactor, so I'm not too
worried about that.


Best,

Caleb

