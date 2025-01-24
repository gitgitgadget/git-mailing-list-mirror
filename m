Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2C2248B9
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749941; cv=none; b=Jp1kVsw/feOX5J7ibIBFmhGq0DiPs7nidrAejuQahEg4Eq42trEMaC16n5BpKi9or4WVSJLjYMrg1OWPY+2h3g/WBlJo6PU70I6AkZVOVpz5Wo4Zye2/MEImk/gBZhGwQbv760ty6MYHJT8zk3P5/VRgQH4Hl469RyTPvMedNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749941; c=relaxed/simple;
	bh=5BqF8opRBPyjFwRGvL76MQPFcEsz6QSdwOMiVuaqjW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nbEFJwDYnpOjz9owT+NFyKJo/6Ff2yLVydWviXEOdV/Y3DRljL9tgMbI68vG2yESG/+oZnpd8ybiGkmAoUCWfqAgTE50JttBYu1o8hlSuHYBnoK1AmCxz9Q/9d25d7PmdbLoZhHNaHAe4s68SYNAEU0w55ji/ujJxkvjDcuKb+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GBfd34OX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UXW6VkSy; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GBfd34OX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UXW6VkSy"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A28513801E9;
	Fri, 24 Jan 2025 15:18:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 24 Jan 2025 15:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737749937;
	 x=1737836337; bh=g9mSeBK3QeVTnsN4zUa+sue2+Xp2hfpTuITCp7EXhe0=; b=
	GBfd34OXIZ5XpojA7kqqMDIiIUF7Y6oBN6QlolXlKONhP5uFzTj1V1rrbzB+TlX1
	ROTJwcnyaKuNUiYi+cty5eb0UuFQShSEiBRiA5j4Cw9+mNK5C/eGkEDOMnqOeUKQ
	+4i/T4VHtePajVeIhkmleE/2hiXYEBtGTFwhljQTq7XX+L0OvoiRNt39HCZOtkd/
	8FNtbrWI62vtRoHhOYnqa9NRxXzSv6FAyScLH9h+fjnq1vAhPBG9CuhWFnTuWgeb
	P8yMF8m8dCUO6SDLVW0atV3zC31RoaXmo4YkSzAl1QQ2po/5eh3YBbTcXlbzWV6n
	1jXBW5s/fMH0gs6+Swd+7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737749937; x=
	1737836337; bh=g9mSeBK3QeVTnsN4zUa+sue2+Xp2hfpTuITCp7EXhe0=; b=U
	XW6VkSyACTHYLYEBZyAb9pLP2ZUBhUx8rtT3rTQ3WNhy+M5cqpsGx6OZL7DwGCYx
	aMKAMys6xg0No904vewyLoZqQIXtqhYEyj1gZspoW/FDkJOO7QZyVuyto34adZ7i
	q13j9jt8b3Pzef6t1oxIF9AtHKFX1LTV7pVJfZ6YXh4nXOZv5YgmjaFyx6f95q6g
	vcrioalKlaBWAL9tUXIm9trLiVoVHnR+w7jLDd3NDjtv+Uvl55rOYY6RlKd2jBxs
	gwf1+rlogBXvXCY39AQlfD/ezPFJULlCS9F+gMjnoJN5fppRWAjQY0fpwYwS+4Ix
	qVHW2LGHZUyHMFRXGBozA==
X-ME-Sender: <xms:sfWTZ_cLtqgDlY6ERSKA9XNHSSglB9einKG0N9gIS4BMz-8y1En9dA>
    <xme:sfWTZ1Me7eW1bd-J30_VCJK5uIFjknA6xqq6fBlzEqWWLt23MpKVWa9RsiJQHttgc
    Md9GPkFB9UwoEiCXQ>
X-ME-Received: <xmr:sfWTZ4jTGNUnEzXaf0GeKFVv1OrTs03WU7jif4jBTmwCCA4DLg4e8zKQ3JhOHtEMrP1MScZadY_XtgToiLs7jrmJbIINky9XcFlz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgheeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehpvghrvgiirdgrrhhonhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sfWTZw-t4T8klcXO-ypOw7qnQ_lkxTm6qYxFFXjLThJbH0wCRi7azw>
    <xmx:sfWTZ7vtqbxZDIoRyXUJemWIzMdy6Kj9PGtEnP4qIFswwhKumeoVQg>
    <xmx:sfWTZ_HWOtMFZPgviXyaCoSgHgWiL6IhWhfpZzfGgvNYgL81yXFd6A>
    <xmx:sfWTZyOc82PLJwz5i8lYx8Z6W9_Q5sFjI5_6ElJGG-7wnqUWNYKClA>
    <xmx:sfWTZ7LJkms-uj3HxqtneRZ2UH5bd1v0xlFzoO44dVK6KrGKH4k13qhV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 15:18:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Perez-Lopez =?utf-8?Q?=C3=81ron?= Ricardo <perez.aron@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug report: parallel fetch tries to unlock SSH keys over and
 over again
In-Reply-To: <CAL_k5jZkYG0evQ2L+bCNvPAnePj=WdU-36GujfjRDwm3iX8ynQ@mail.gmail.com>
	("Perez-Lopez =?utf-8?Q?=C3=81ron?= Ricardo"'s message of "Fri, 24 Jan 2025
 11:46:58
	-0800")
References: <CAL_k5jZkYG0evQ2L+bCNvPAnePj=WdU-36GujfjRDwm3iX8ynQ@mail.gmail.com>
Date: Fri, 24 Jan 2025 12:18:55 -0800
Message-ID: <xmqq34h8x8wg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Perez-Lopez Áron Ricardo <perez.aron@gmail.com> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)
> git fetch --all --tags --prune --jobs=10
>
> What did you expect to happen? (Expected behavior)
> Being asked for the password of my SSH key, then git updating all of
> the remotes.
>
> What happened instead? (Actual behavior)
> I get asked for my SSH key many times over, and the fetch does not succeed.

It is hard to tell without seeing how many repositories the above
"--all" expands to (but I'd assume it is way more than 10), if they
share the same credentials or going to different site that requires
different SSH keys but these keys share the same passphrase, etc.

Assuming that they all go to the same host that wants the same SSH
keys, and assuming that you are using ssh agent, if the symptom were
the fetch *does* succeed, but being asked for the passphrase to
unlock the same key number of times, then I can sort of see why it
would be problematic and why it might help to wait for the first
connection to successfully open before starting the other 9 jobs as
you instructed "git fetch" to spawn.

But if the symptom is that the fetch does *not* succeed [*], a
simpler explanation of the symptom may be that the passphrase given
was simply misspelt and/or there is no ssh agent involved that loads
the passphrases and caches them on demand.

FWIW, I push over openssh connection to many sites, but as far as I
know, I need to say "ssh-add" to tell the agent what keys should be
cached and what their passphrases are *well* *before* I initiate
anything that requires ssh connections like "git push".

Sorry that my response is not an answer, but I have never dealt with
a SSH setting where the AddKeysToAgent directive is active.  Others
may have better ideas, but I wonder what good would "wait for the
first one" do, as a general "fix".  Git does not even know what
relationship the underlying SSH connections to these other 9
repositories would have to the connection to the site that hosts the
first repository, and the first one might happen to be hosted at a
site using a completely unrelated SSH key from the rest, in which
case it simply is wasting time to make the other 9 wait.


[footnote]

 * ... and since the command line is using "--all", what does it
   really mean that it does *not* succeed?  Some fetches but some
   others don't?
