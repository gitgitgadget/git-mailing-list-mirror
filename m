Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAC61F8907
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737499141; cv=none; b=R92+/WraiyY0P3kJjdfobn8ZRkgrlimuygBKd5pS4yh3ztWIwMjZFrM1egupViC9da2R4WXqrzZj2C82da390v/BSLQ8ql2dFzl+cAJAhv56pk57iaYb5xISAn8iJi+ooX+rkk2VI9vxYOXuzGq7TNru6nerVqLHV+VdLuvCuUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737499141; c=relaxed/simple;
	bh=qy6RhbevPz4aIqpqQLxbRawAwCtRE+RR8PKLvut2iGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XyrJ1i/ILFW9G7X4Y3nvi6+vgQBNMFe/qim0FfnYZQl46Qmxus41/Zz3CdDuFW6hst5XsL4FAcO8dOGxmqFdksYrejwxWiozq7QSiQ0YRqZJTgUoXm32nLzTM1h7ah0nznONr8ndlIrTU69iQhNr1bZ0zYu3Gz3k0UULVz+zpNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FMjTCS1h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s3c5ACkE; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FMjTCS1h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s3c5ACkE"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9367254019F;
	Tue, 21 Jan 2025 17:38:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 21 Jan 2025 17:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737499138; x=1737585538; bh=fauZKib6wa
	lj5zUIDCL5QzW8j91F/ifAVg/rnSFLMtE=; b=FMjTCS1hHl9CVVJcL/+QZvYoMN
	gE3Lh8hoZnudsu/geEtWuOSHl/e5dA0vJeSE7Ao8ry6q4bW8CM08mdQoxt3xjTAC
	IULJWh59hGTaucByukKlZj1ulCZaJTdZnlSwa5NQpDlweVK+21rpIL1XJCjqU3zh
	GywH27Ye9/CqeJrz4qo/cZWlfVlsF01CFBsfBs6a9mIKyYjAa2endtcHtE1/zOdQ
	K8Ad1H7WKiSHduLvnpqsLPqvsaO/ZEXjIhXm1koEEqw8RBdythmie065LDvbYn6c
	gGBZM3fok+yBHawtff1s/Rzy6cuODrK5b9axmvpWk6vpBTDpM0zF8tTTya2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737499138; x=1737585538; bh=fauZKib6walj5zUIDCL5QzW8j91F/ifAVg/
	rnSFLMtE=; b=s3c5ACkEDwustgcKbyIH4RZU+RqG47qBoloRjtfkQL0awcldODE
	W3rcTu9FgiCjP7rQmiiqcQv+BAQKp2HXXJBSSU0hqS4MJbASf84hTYwOIX8hwr+N
	ZqJdDNF6hAt+/+fPuFA3Z47YRKyg2FixHk5EhvqY9qWpBcCUtJfUPkfLn2aaNFLp
	kE7TK+4cfgS71D7ATYmXDvh9m9OGgpi1F9En5Ul+5+0yDrfAULqLLqsbEosFVC40
	8tiYmwQ4qS0u8lpMkDElSHg0fu3Jt/KY+aN1UWvdC9DErWaXb4MR4kzh3b+yRVVU
	KDB4g7YtsWm38za2qO8h+W9HFj3J3s/Hpvw==
X-ME-Sender: <xms:AiKQZ6xRCM2Psw-RXlXbfcbyPo4kggoqNruHikFmYO3cg380WPw9bg>
    <xme:AiKQZ2RqcYCSC_LK_zXQA7ttkjnbvXr4uhmBQ8aGjVjpKq7dD77LbfoE2TFoEh9to
    Ad4r2zRgzjR5O8fUA>
X-ME-Received: <xmr:AiKQZ8V8cFkhRZ9aQ-_Go6WjLG-QhYU2cG08XFOoCWwoRi7Ypae4DPI4UJFkkp9lWt1pORKoaNYbUbxax8UqmXFdrHC_KPOBbAbB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhr
    ohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueff
    teeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthho
    peehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtoheptghfjhesjhhohhhnshgvnhdrnhhopdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:AiKQZwiKfUWywQoOn6f09cJSatUJFS0sDrT1V4-Y2bTJnsbtrVTCag>
    <xmx:AiKQZ8C5Gsx5ZFsJ7pKJs_asaPHyXp9EvPeTgCZh6G7J5pNIR6HyxQ>
    <xmx:AiKQZxIzKiiN77RKBA2AnKbbNryAwtqvixDwPWEGhJRTiqazJNCseQ>
    <xmx:AiKQZzB8DycFt7RNHKfTR_pz0B7WwOhZ5-hvLt5ESBKOP1fWis_vqg>
    <xmx:AiKQZ75chTj_fEvvxHGsy4RUScUXG_iIOkhm1cCHuwDxqP-2uBULd7o7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 17:38:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Emily Shaffer <nasamuffin@google.com>,  Christian Fredrik Johnsen
 <cfj@johnsen.no>,  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature Request] Allow batch removal of remotes with 'git
 remote remove'
In-Reply-To: <CALnO6CAEaOUNwMpOTF8wKVd7LAv+UiU5W62ZCBc0U-K_JhHU-g@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 21 Jan 2025 16:32:04 -0500")
References: <DB9PR05MB110863344D3776D13B436F563C1E72@DB9PR05MB11086.eurprd05.prod.outlook.com>
	<CAJoAoZnecm5y8243R9JsGjRDuv-Mb=UAwa+Hbj5CKDKNPBLB4g@mail.gmail.com>
	<CALnO6CAEaOUNwMpOTF8wKVd7LAv+UiU5W62ZCBc0U-K_JhHU-g@mail.gmail.com>
Date: Tue, 21 Jan 2025 14:38:56 -0800
Message-ID: <xmqqikq7yepr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> Hi Christian, is there a reason why opening up the config (`vim
>> .git/config` or `git config edit --local`) and batch-deleting remotes
>> from there is undesirable? If this is a solution you believe only
>> power users need, then I'd posit a power user can both list all
>> remotes *and* remove the offending ones in a single editor pass,
>> rather than having to run multiple `git remote` commands, anyway.
>
> I'd posit a power user can also do something a bit like (Zsh with GNU
> or FreeBSD xargs) `print -N my remotes to delete | xargs -0n1 git
> remote remove`, or (portably) `for remote in my remotes to delete; do
> git remote remove "$remote"; done`.

Having to run "git remote remove" 1000 times for 1000 remotes you
happen to have may not be the best use of machine cycles.  I'd have
to think about "git config edit --local".  If you have 1000 remotes,
the chance of mistakes may be too big, as it is likely that you
would not notice if you removed unrelated things by accident.
Besides, the remote-tracking branches are left behind if you only
used "git config edit --local".

> I couldn't find a comparable command beyond `git branch --delete`,
> which _does_ take multiple branches.

I do not offhand think of a reason why it is a bad idea to let "git
remote remove <name>" take more than one remote names (i.e. making
it "git remote remove <name>...").  Even though it may not help if
you have 1000 remotes and want to remove all of them in one go, at
least your xargs command line invocation would become less wasteful.

Thanks.

