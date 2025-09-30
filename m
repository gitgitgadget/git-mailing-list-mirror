Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981835949
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260048; cv=none; b=Uuq5I0luqXqwik7WI/kAIPVjPHP4YH3vmdcfoIdiz8rht+zaaERX4mShHPGmizuDa30jAfz7F+URtXw7ypM6uCE29JvQA/NMOK68LyoqWjeUiJEIfzV+Ks8pmIAinOxestGAMUpv6hQv0+7J/cWnUl4YJoBD4nwtLLDsGkvofus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260048; c=relaxed/simple;
	bh=evoCRQacawDZ1aEWj14QV5rxNF+yJFoHoYZFg4D4teI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UQImGOs2GKx5Fxtvh1FhZo/u7mCd5hZcrvzcGtLcbxFOXQMQkSdeyrvy0OrA/lR9gx9z59TNbo3/EnJWw4c/ub8gSfiUO9hzUPw3RBCZcbmrGSmJbAPp3G6T00UTmwjmMfbINCJ5y1Ym2zwec8E01uaDg8CDX6FpwEKCVHso1fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=WwW3JzXK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BblKRIBd; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="WwW3JzXK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BblKRIBd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 690A0EC02BF;
	Tue, 30 Sep 2025 15:20:45 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 30 Sep 2025 15:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759260045;
	 x=1759346445; bh=o82g7aS9VzOGoJ4V22PG/H66A4GUaA/uT9ExeU09Cwc=; b=
	WwW3JzXKj07t6uTizegAZQCU8ILb1UfekuqVc3Y82V45KjaCAwIyagYhOE5wyiDv
	nylMT4Y2Iezp97sShb8IZMKEOoK+R3JUP6i0117WLfmwyDPr9fvIRDCvstC/z5Ez
	tw7bTT5IE8s8uPT8CAY8ac54HGU2lmzP+sLV9PMELhiD3h0w771YBKG/542FMa1/
	Ppaq31O9ELQ46Jp0SzGN2ZQnabmTtSmLi3YOxMwy3gDs5YN9Yx6Q54TRfgT+BVA2
	UrANzH23A4ykr9DchAsicrGe0ueDfx5Q++gbYAkGkoiP+i5XQMHHAjjHCmnmsocb
	CaRdJupqxAiKQ0jKCLGqKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759260045; x=
	1759346445; bh=o82g7aS9VzOGoJ4V22PG/H66A4GUaA/uT9ExeU09Cwc=; b=B
	blKRIBd/n/vSs+BstnivHxZf/u+zJEW/Xh1fgMmRg7sumKb+KIbQHYOORc9N06o9
	uoGnpB0K0CDcbsIiJW3q4bYePV8lkwWEOC77YK+CTwBfwDaZYRV7/q465CsM3cyw
	ktLc/1Lb2NQTnwNq0a6jdoKb3jw+ne2t6NY8FPSF0nmo1LhAwys9Osz2w6K2jKRi
	QCJNsM2kx0SWysSc0nKObfFwWosJzGrA/OQmTjU1e8HTcpDnmMMBbfGhzbpSie8A
	gij3FMDCTXo8ZZqraOssvE+/5M+BpLkRGMpaSKDuC4T0BwxvZ1tUTsmwfKfK/1Vg
	p6EfYE26Pzyxok7hQZl/Q==
X-ME-Sender: <xms:jS3caNDLiljzQTZf4ab0iAQk3QBC2xc6JuJEdcZyEJcG4LgSJjRvGw>
    <xme:jS3caGV7hIVFQr0cPsFKXwnZdi5HYOde4PK6egBCwdHKClPxC1LOIHECtkRSqugTn
    XieTD4QvzbUO24FVW-ejQ2nfxz6nslcm66UirMv1xON-JegUcp7Zn4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    fgveekudeviedvveeuhefhvdetgefgffdufeeguddtkeegtdeltdevhfdtuddttdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrse
    hjvhhnshdrtggrpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:jS3caKGclhcf7x-n3tVyw8FuPaS8F_k44P43nm5PaKWW61cHpa-Uhg>
    <xmx:jS3caM2A5uP31y-eWeogc43lx6aethKnOUXjrpbtfXWmMmSEyhAZWQ>
    <xmx:jS3caEPC7tiQV3xDcY75mkn5QYP13hBjwivu_Nv4drW2s7mbZubh6A>
    <xmx:jS3caD5C8RMZwYYEMDjvruOdSe_sCnVJ0RuQHRHIIpsb4cXF2rg2yQ>
    <xmx:jS3caGaxXTtxwSfHXbFcTFbJV-aZSoOqXDS3CYN7hGjFPU--tpiniDRS>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1733F78026F; Tue, 30 Sep 2025 15:20:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AiyWxa7EEqz3
Date: Tue, 30 Sep 2025 15:20:23 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <74475ed5-9938-4cf5-a304-e78e5827e53d@app.fastmail.com>
In-Reply-To: <xmqqwm5nk4rt.fsf@gitster.g>
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
 <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
 <3ecfb5c3a67723f160e8161e212d77f95964539c.1758649472.git.gitgitgadget@gmail.com>
 <xmqqwm5nk4rt.fsf@gitster.g>
Subject: Re: [PATCH v3 2/4] doc: add an UPSTREAM BRANCHES section to pull/push/fetch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 24, 2025, at 3:51 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Since the `git pull`, `git push`, and `git fetch` man pages already
>> include sections on REMOTES and the syntax for URLs, add a section on
>> UPSTREAM BRANCHES to `urls-remotes.adoc` and rename it to
>> `urls-remotes-upstreams.adoc`. That's an awkward name but at least it's
>> clear what's in the file.
>
> You no longer do any such thing ;-) I can locally everyting after
> "and rename it ..." and replace it with a single full-stop "." so
> unless there are other things you would need to update this topic
> with, no need to correct only this part.

Will fix this (and everything else you mentioned in this email), thanks.

>> In the new UPSTREAM BRANCHES section, cover the various ways that
>> upstreams branches are automatically set in Git, since users may
>> mistakenly think that their branch does not have an upstream branch if
>> they didn't explicitly set one.
>>
>> A terminology note: Git uses two terms for this concept:
>>
>> - "tracking" as in "the current branch is _tracking_ some remote"
>>   or the `--track` option to `git branch`
>
> Should we say "tracking some branch at a remote"?  It is not like
> the current branch tracks more than one (or all) branches at the
> remote as a whole.
>
>> - "upstream" or "upstream branch", as in `git push --set-upstream`.
>>   This term is also used in the `git rebase` man page to refer to the
>>   first argument to `git rebase`, as well as in `git pull` to refer to
>>   the branch which is going to be merged into the current branch ("merge
>>   the upstream branch into the current branch")
>
> This side is fine.
>
>> Use "upstream branch" as a heading for this concept even though the term
>> "upstream branch" is not always used strictly in the sense of "the
>> tracking information for the current branch". "Upstream" is used much
>> more often than "tracking" in the Git docs to refer to this concept and
>> the goal is to help users understand the docs.
>
> Good.
>
>> diff --git a/Documentation/urls-remotes.adoc b/Documentation/urls-remotes.adoc
>> index 9b10151198..1138a5889d 100644
>> --- a/Documentation/urls-remotes.adoc
>> +++ b/Documentation/urls-remotes.adoc
>> @@ -91,6 +91,44 @@ git push uses:
>>  	HEAD:refs/heads/<head>
>>  ------------
>>  
>> -
>> -
>> -
>> +UPSTREAM BRANCHES[[UPSTREAM-BRANCHES]]
>> +--------------------------------------
>
> Can we have at least two blank lines between these sections to make
> it visually distinct from a gap between two paragraphs?  I know it
> would not make a difference in the rendered pages, but it would help
> those who read the document in the source form.
>
>> +
>> +Branches in Git can optionally have an upstream remote branch.
>> +Git defaults to using the upstream branch for remote operations, for example:
>> +
>> +* It's the default for `git pull` or `git fetch` with no arguments
>
> I think you'd want to finish this sentence with a full-stop ".", and
> a few lines below, the point beginning with "Various commands".
>
>> +* It's the default for `git push` with no arguments, with some exceptions.
>> +  For example, you can use the `branch.<name>.pushRemote` option to push
>> +  to a different remote than you pull from, and by default with
>> +  `push.default=simple` the upstream branch you configure must have
>> +  the same name.
>> +* Various commands, including `git checkout` and `git status`, will
>> +  show you how many commits have been added to your current branch and
>> +  the upstream since you forked from it, for example "Your branch and
>> +  'origin/main' have diverged, and have 2 and 3 different commits each
>> +  respectively"
>
> Other than these, all changes from the previous version look good to
> me.
>
> Thanks.
