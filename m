Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9F212568
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045750; cv=none; b=NqkcDNe9GkMCn22asAtacaxtJfQZuRhw2osGyq2jif1prWzTIg5jbcROhT4h1tiZGCdogwg+2WNh3UIY6rurjtm7DDVpsEo7/rRC8Iv1i8U3BgYWEf6tfv6aRcOkGy91wweqjD6RIvjq4HYAu54NyTlddsGzoo9U4n+e1ugaTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045750; c=relaxed/simple;
	bh=gyk+fLVartD5W+TlvABJmlaAaJVsU3Olw9hSkDMgsnk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qQjfG277CddZNu5QMuHrb7GegSvD76/mmjptvbvnHYnr3BTLFKPaMhBaROYjG+PjshE+wXLW3m+ky60eY3zXPlClZq33w2YOCj4b0GRmZt3CqEaI0lr2ySRiMACCK/Lpu7PrWmlXB/lJ1ROlHy5mu5p/Wv0fkxoj5AvvZUwx+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=R5PUtvB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MsCakUlU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="R5PUtvB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MsCakUlU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A3597EC0011;
	Thu,  9 Oct 2025 17:31:50 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 09 Oct 2025 17:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760045510;
	 x=1760131910; bh=qYOajFDJZMtSoKH0mnVAGR1zdJnW1CXYS8puZV2OzjU=; b=
	R5PUtvB8pRT16pApsFZ7zmNoIFZ+oTWX1b/qKCvqT7aOXotk7EnEX+aoX2IGz7gj
	r8wIJWXwSp8hiwQw329H+pIH5V53AlEajMGCuVn2iSoh9LUPIz5oDETuSTmCaoeX
	HesDseqVzxr0KsWwNl9CppxVddbwvraBRBhXMLq/Zh3lqAK6uqWO7LPEWQQIu1+m
	VgwcUv5FyeFkmG+Vr0zm3cTBnL0k4dNidxumzMoxGuRF/WnSsaa6B/bmkjm0q4sa
	0CcIs5CMxfQ3yqYXExStF7utXHFAuMlqtzSHcjTnZqWCqvMrvyqKrgZzCGgSk1jd
	86iQ2M4lOccpqZg/KI2sfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760045510; x=
	1760131910; bh=qYOajFDJZMtSoKH0mnVAGR1zdJnW1CXYS8puZV2OzjU=; b=M
	sCakUlU0f4qYkO81vBtkLfVzmx7lsGXYLhr29TjSOtmpHW5ZSP+qcRXOHH9JHw9d
	kLRLADbNm6CvDHci7KKsbtB2Wt7VldDPCAPtiSujz9boU5vPswHAMQEPfBY2CU8/
	r5VpLgQHLSsXDBZulUST2tlhjZGLZuiwvqOZpLDEX0agwJh29ZQ8NdvzXz+bb7t+
	lesQ8OSCUIy2OnT8hJKhm4LDAMRt+wixH5DAF5LvJ61FU2vOqwljtz15d/1z8K0n
	hvvSHcbEAsGIMcncc1nDtZ3oODgadLoeXZuel3itIiZdoteTmzOxQ72CCllcrSOh
	TvtH9iiJIli/6PDB1VK9w==
X-ME-Sender: <xms:xinoaI8t2tyBgCKmsRp4kP8SDmbrT9s2H15ML7WExICDJ0by3g98mg>
    <xme:xinoaLizNus-gs6wcmf216gBDIo_7bxwazRZKvjpKcbDi8RXYJSyych7iVCGuPc1C
    dA4KqdeXPn-UOm17LJ0ZdUZ7cxIYKy68DQjQjcFTwoIOlTClKKjObg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    hhrhhishdrthhorhgvkhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xinoaHihc_QkoG3cYgLm93TChKtZ-nhIhmfRE3VT_QV6hHZAxiNe_Q>
    <xmx:xinoaFi6jmjXQ8e-yFUuivYkECH4I3rgUpsf6nMbhDBYSxryC767pg>
    <xmx:xinoaHIkZg7HiCjneM16jqpR-ZqQLkHMHd8pyvDC9BUjgumiaQgQlg>
    <xmx:xinoaEFKUF9z-Azdgie6J6kM6V_ocT0qdv6Xb-OhM35yoRMPZ1iuSQ>
    <xmx:xinoaP2IqZOcj9A71U1dXmtbb-mdhvryA0PVxoCbXyxMqxXe23DC88-n>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 60155780076; Thu,  9 Oct 2025 17:31:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATtqAgZ0pDEJ
Date: Thu, 09 Oct 2025 17:31:30 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Chris Torek" <chris.torek@gmail.com>
Message-Id: <b432f1b9-804d-4249-bc1a-4f3629aff50c@app.fastmail.com>
In-Reply-To: <xmqqqzvddqon.fsf@gitster.g>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
 <pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
 <122774d4cc8fa4e9184a0f82e9b6e562363ea433.1759951536.git.gitgitgadget@gmail.com>
 <xmqqqzvddqon.fsf@gitster.g>
Subject: Re: [PATCH v2 2/4] doc: git-pull: clarify options for integrating remote
 branch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Oct 8, 2025, at 5:33 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +Integrate changes from a remote repository into the current branch.
>> +
>> +First, `git pull` runs `git fetch` with the same arguments
>> +(excluding merge options) to fetch remote branch(es).
>> +Then it decides which remote branch to integrate: if you run `git pull`
>> +with no arguments this defaults to the <<UPSTREAM-BRANCHES,upstream>>
>> +for the current branch.
>> +Then it integrates that branch into the current branch.
>> +There are 4 main options for integrating the remote branch:
>> +
>> +1. `git pull --ff-only` will only do "fast-forward" updates: it
>> +   fails if the remote branch has diverged. This is the default.
>
> Technically, you can pretend to be the king, the center of the
> world, and occasionally publish your very latest to the remote by
> pushing there, and it is technically possible that the remote to
> diverge from you by somehow acquiring its own commits, so the above
> is not wrong per-se, but the way it is phrased is a bit awkward.
>
> The operation fails when _you_ diverged from the remote branch.

Thanks, I meant to fix that earlier. Will fix to say
"if your local branch has diverged from the remote".


>> +2. `git pull --rebase` runs `git rebase`
>
> This technically does not integrate remote branch into our current
> branch.  Rather, the commits on our current branch are integrated
> on top of their history.  That may be worth noting?  I dunno.

At least 2 users who read this also commented that they find the word
"integrate" using, for perhaps a similar reason. Specifically, one comment
was "unclear if 'integrate' is a technical/specific term or just generic".

My assumption was that the word "integrate" was meant to be a generic
way to communicate "combine the changes in the two branches in
some unspecified way", and that's how I was using it. I'm not sure what
you mean when you say "integrate" (is it "merge"?).

I see a few options here:

1. Try to find a different word that communicates "combine the two
   branches in a way that you have to specify". I'm not sure how
   likely this is to succeed.
2. Instead of using the word "integrate", instead always say something
   like "merge or rebase". I tried this but I found it a bit unwieldy, and
   I think it might also be confusing for users who aren't familiar with
   both merge and rebase, they might worry "do I need to understand
   rebase to use `git pull`?", when of course you don't.
3. Keep the word "integrate".

I'm very open to hearing suggestions here, maybe there's another
better way I haven't thought of.

>> +3. `git pull --no-rebase` runs `git merge`.
>> +4. `git pull --squash` runs `git merge --squash`
>> +
>> +You can also set the configuration options `pull.rebase`, `pull.squash`,
>> +or `pull.ff` with your preferred behaviour.
>
> This part has two orthogonal things, each of which has its own
> default, which may be a bit confusing.  (1) which branch we get from
> the remote integrates with the current branch.  The default is to
> use the upstream of our current branch.  (2) how the integration
> between the remote thing and our current branch is done.  The
> default is only to accept fast-forward updates.
>
> Perhaps it may help clarify the flow if we said upfront that we
> describe two orthgonal things?  E.g.,
>
>     First it fetches.  Then it decides two things: what to integrage
>     with the current branch, and how to do the integration.  By
>     default, the upstream branch of the current branch is what gets
>     integrated, and by default "pull --ff-only" (described below) is
>     how the integration is done.
>
> or something?  I dunno.

I think I'm happy with how the two different defaults are being
described right now, but I'll run this by some folks and see
what they think.
