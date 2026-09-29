Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB6394788
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790647214; cv=none; b=TcXibQqkMw3ftDvJuhaHE+oP3PiBlMsQRrRNPcbIX9Kg5TWpHGUFXDP7KSblqbV7yaK9OKuXDtgbJtAJSakjYIYwep7ucxtI/MG4XGf5CAe8LuMbPPj82IBeKiYGh2y7iTMqzc0PctXOJ8O1nhiy1xAOwdhfoO0tKR+yaHeHJqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790647214; c=relaxed/simple;
	bh=wKLI2S2uyhjVw4cMl9QzOZo/Z6e1VpFJ8UaEnJfi3/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ghPimnNerw9BlIlOELXpX659fjbfLUVypS3hVj4LpFrXq9Fes48PT/R9YOvI7iA3WMq93uC6KYTGXGzbHD9gYYH/5PHs2eshK2zIoJHSs+9JZktoCEKxfjIzMP3OQlxEOukjLIvjm3JAgpQVGTg4Uii+iwlriO0YILzDB4/HoHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U721cJmU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a0V4o6Dn; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U721cJmU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a0V4o6Dn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 898D5EC01C9;
	Mon, 28 Sep 2026 22:00:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 28 Sep 2026 22:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790647212;
	 x=1790733612; bh=LDN42+RvDk0acPSnxlcrJjpzf99GbK5uQPsgDSQ1/XQ=; b=
	U721cJmUltpwh0JyjSxQ1FYy1oSs5MGkBPrs6MZZ7+In9TMuPQG3AnN870HDY1VV
	8GHfHO6kyKx52I2/YhfP4grsQdVIooVIDTJbzlcKQQgIfNo5W3TYM7HJJHJTePgV
	seGjorBeFNgQkO4tPCMdSQR1jSDjcc9VuI5n+m26TP4kWlPM+YQeczPMaiFniRdK
	8mmWD9MNyGuSo+uY/dpO6HsY2wEtxnuLtt7iYQUWn7r5oGrRcpBK+IY6qtBfRdZB
	W1IcjvAHhRfpNjN1Go0e5d/nEGfn27KUfD55N/auM2h8SED0Pt1ljcbsObCubbl2
	2J8Z6Xyoj+mPOf8Xnw87ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790647212; x=
	1790733612; bh=LDN42+RvDk0acPSnxlcrJjpzf99GbK5uQPsgDSQ1/XQ=; b=a
	0V4o6DnzUHdWMOucT/qIOPom+y+dZBOLaV2Jdzh8f5LQFfamabb8nnWnI5w/ZYt9
	fA3GOjIhVR7gula9ElRR2R9TwCMI7MUNKLE2R7dGaDfqeUDdqeLjKNn6Arr+OBno
	QPAJd8JXxG8uXo3o5kXtuysxlpicfM9fGh8DUWRT4gEwnUCIiYEHTJBpOHPYfvqD
	JT81M3R7MWQxsmRzUDHdNHK85qAuXgq6bxBDj4frPzTX00qHM5kYx65OkX+DsIbF
	MxiWojc3oQNDO/3l9cRYAyEviVd7Ym5INJ8pZnQKgg69nf1xoFONUeUdknyal4Gl
	58hmyo74uQ7o929Icc9jA==
X-ME-Sender: <xms:rBu7ajVSTNNummkPKO_Trnl_VGU-wgMoRdGdh_-a-P3Ywai0sN-UcQ>
    <xme:rBu7avTfpz9Px2ZdNLSaGcySQgZAK0QoHkL0t5AaalV_Bo2WQWwd5xBfy8CJonJp3
    Mldgm7YgJWuAJmlC-YGqvP4TgVdYERdZEuC7NYjo3KH3kcC1vGx6WI>
X-ME-Received: <xmr:rBu7apPtYkPKUbfWsaugX_TfjJuOCH3GOM8KiYu8C9UyyBvQ7Kqw1Cj3RMoVo4QbUubQ3tO9UlFdG5s4nlqFvcfPDkA3F5UTiIGT>
X-ME-Proxy-Cause: dmFkZTEDn7gONnxZxd58pnTYVV3VUNQz+sm85lWjAunHY0fziX6+K/zl33l7kqr5ITGHQw
    A4ajRsZLMb4HTS2JTzDtBZCmKCeqCU4Ji0cg/GHgSafSICg7eBGfMxcPmE0TQt6EbTSOUd
    6dVn53wYr2dNdq2RmxSuzm9tn+GPPzUSDB1AKDZ3A3IgTOYMIOMCD3VAYJxrDwgAOcpKBT
    N30WQLgcLHPm7SmkbPu8zUGj8+DxU1LCTnZXqsqqqmRaeMAf6BEMptjIv3EB0pDHD69UXR
    Kx/rSlQZpegtgWdv8i9AQJprEElOe8115nEGxq/ZOyMWbnNU09Rvi5MNk+XdfYnT6//KUV
    3/CYuPWjaQVIvhBJNBZhSkiiu6zpCSIPY7czAqI5fygKfAnyFX2xwdssGszQGqQ2FT6S1G
    mHtUYq9ifoeT8PAIqcOjwL7ewgTJoSNAA9/L9N7p47/MMB80XTJan8vZALQondD0opCbdD
    PZhK6ut0G/HAUoYXDbtNrxyxD6IGsScEu2pFJzy1g+qU+IwMG0L6RQApx9NK/l0UkCjrSV
    4EbC9BPSYyd1kVMFPkwkZ4dxHXV0f3zkyq+yfFE6IElCOkqleIzeAgVv0trikz52qLRwQg
    bOWaY1rqlrQyd8lMu6KzifLm4ITqce5y3H7BmM02EFmxSRjE6Kr+gw2qZt5Q
X-ME-Proxy: <xmx:rBu7alSpAvTjGdxjq-Z_-1E33-QOgfkvqXybh0zPhS0LJ6ymOsulQg>
    <xmx:rBu7avhfKaGRqsxajFtQIbEoGGglEiD5qEo7oqthVEv1fJrcKZgz-w>
    <xmx:rBu7am_LpuKLJh1htlJab2h6ZdoyPlpmVx6SzLxPJA9YzqKEsXrRVA>
    <xmx:rBu7auHOJjZ-c_j40HOUc_DlP4F3eGdzJWjDYo_ceMIhEHn5rEcvZw>
    <xmx:rBu7ah6qdZgMwSkEaOwQlPFf9zQyMt3HyDNpkgPXXtpXLPXyjkcZf5nP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 22:00:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH] [doc] Use `man git` to teach users how to navigate the
 docs
In-Reply-To: <CCB1855E-759F-4741-BE49-23FC6DD402A6@gmail.com> (Ben Knoble's
	message of "Mon, 28 Sep 2026 17:02:24 -0400")
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
	<CCB1855E-759F-4741-BE49-23FC6DD402A6@gmail.com>
Date: Mon, 28 Sep 2026 19:00:10 -0700
Message-ID: <xmqqo6dgkead.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Mention `git help` instead of `giteveryday` for now, which does a better
>> job of giving an overview of everyday commands.
>
> [snip]
>
>>    I thought about mentioning git help push and/or man git-push, but (from
>>    a Mastodon survey I did) git push --help is the one users are most
>>    familiar with, it's most similar to how other Unix tools work, and it
>>    makes the description really clear and concise (-h for short help,
>>    --help for long help).
> I appreciate the concision.

The survey result that says the users are more familiar with "git
cmd --help" merely tells us that they are not taking full advantage
of what they are offered ;-).

> I think “git help cmd” is quite a bit more
> useful than “git cmd --help” because the former supports
> aliases, HTML formats, and various other documents.

I agree that "git help cmd/concept/guide" is more useful for all
these reasons, with "git help help".
