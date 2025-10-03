Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46A2DC760
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515841; cv=none; b=FOfmkfD4zJvt7jZN69m7FP6sUi3FgbbX4LAzvL5F4A5LWGfUVP8ADT3/eHB1EXTcxYKNZN59GRaV1aPsasNt3myybxqTMr4V2Z+7lM2NNnLP5uW8sy+p9cb5MkXnAV0Xu0a+nBlDoUb0tMx9N+vI4+q/Q9Qt6PZgUP37tIFPx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515841; c=relaxed/simple;
	bh=jyIYI9c8QdMhwKRs5Mhl60ePMMJtIXaUeH3vKEzYd5c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hlOZxLNIu2JGi4IB6YDFw6by+ZPMyxufVy3asNuc/QiwySPqprzn2A5GKWSJb8g5wBYLCIez+ARbtlpOoF4wRKUIlTsXIb2DuFAJW7lH0vQUzI1wtYQYTH2rMgSUFDEwmPYGqci2HvbB9EjzWyK4ldV28D3AASaWRhXeCawMWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=l38SzrwA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tSxIAhk/; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="l38SzrwA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tSxIAhk/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BC33D1D000BB;
	Fri,  3 Oct 2025 14:23:58 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Fri, 03 Oct 2025 14:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759515838;
	 x=1759602238; bh=jyIYI9c8QdMhwKRs5Mhl60ePMMJtIXaUeH3vKEzYd5c=; b=
	l38SzrwAIzwS9agqfrwW2E/XpcRAIJriO1HE4IOf+tNEGLjfuxSJD30aoDm/j6Jh
	k8eKP4cy7V46ZFgGrpA/HDCR1oNbXLneWLdCcwQ/81+Y/t8ICEfqjBS3TnhqM6n7
	IbjsM8ixwwnc2zhyiagqots5au+tXw5RDEpCDq56GLaKtUfJm3NAseTTIzTTMbyL
	bnpijCYR6D69BKt2inp9eLXjeJhm5B4fSB0AgtIpGlsGmUHZFcnGdlfgrMWOgjgE
	sfTiyMEsUK8xsR1oKkndvCH67q2CcUbuWyqgZsbNxT6vRqLypf+1jqOud6z8Bfzy
	whAUesls1UOnWCMJFPHyRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759515838; x=
	1759602238; bh=jyIYI9c8QdMhwKRs5Mhl60ePMMJtIXaUeH3vKEzYd5c=; b=t
	SxIAhk/bjjAX9SeUNjW/wB69pmcHHmKd/0hQNutSwRwOgSucieXMuvLGKfkpHDSi
	WOrqgI2hfutyjqEq2OmAzDcOA9DWQGHuQFh4urwifpCE3/OdNbn6Tdd1EOqiQf+M
	eHYGOJVcgAoXyA75mTrfc6SOCp5HLfTqsbjk0ZD4fRR58y5f0sd4oJoX+vW5UnU0
	z8+huUe/4b/B30rrWNUx2nKrmfj4t4+cPVTSGlGNYdt60K9eiEBLKzjjFfGhAfjj
	eDmPztMMbTqK6/VMS+r2Ga7Ec0ZiLIv6Vmh7YEUcN2ITxXpQFR+LaTRCc4Ekv90T
	xepuiS9NxfGkIR3gZV0WQ==
X-ME-Sender: <xms:vhTgaKUBAN9JEwwKtLcAdRBaNsYuKzIM3yG9RwuH-Y8JmMkYGBm2_w>
    <xme:vhTgaBbFJWpfT77HNJJRp3whNdrSe0Jppzt0HBtMJAJ726NdVZN_TdXhZ9bgfgQwF
    JSSYe6zU-9mtY9jAMWYNryK_nZIw-3S-A0b3GY2is6nSaitQ8IoaHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleeiudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:vhTgaH51b_7DSt_F_JeZqp_0OlwVoih9ve2l9vu4mNtY3fTnXFX4XA>
    <xmx:vhTgaOZkzZIz8aoq-EfWDpMp01E1x8uI_UEzc30mHj6GpN8EdsKc0g>
    <xmx:vhTgaOhWOLdBLlzZ_06B3ysX6NH1zfP898PoDYbZGAHd5Qyup-vH9A>
    <xmx:vhTgaH_K7fKqp1pKGalAOo_eUhtCF9-MvZI414PvngyvkdvY4tDCjw>
    <xmx:vhTgaINgbtukW2ux165s4LpAweVcX-W8OliuRIH7o2TQDA3vcs7LCmAV>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4F77A78026F; Fri,  3 Oct 2025 14:23:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AiyWxa7EEqz3
Date: Fri, 03 Oct 2025 14:23:38 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <a5757e8e-9b9d-424c-a576-1e70af3b7795@app.fastmail.com>
In-Reply-To: <xmqqtt0j33yq.fsf@gitster.g>
References: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
 <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
 <69825d46349e55dd1b17444ab4e6d542fd44f371.1759262314.git.gitgitgadget@gmail.com>
 <xmqqtt0j33yq.fsf@gitster.g>
Subject: Re: [PATCH v4 2/5] doc: add an UPSTREAM BRANCHES section to pull/push/fetch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 30, 2025, at 7:39 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +You can set an upstream branch explicitly with
>> +`git push --set-upstream <remote> <branch>` or `git branch --track`,
>
> I am wondering if this confuses beginners, appearing as if the
> latter does not need any other command line arguments, as the former
> does say two pieces of information needs to be given.

That makes sense.

I tried to read the documentation for `git branch --track` to figure out how
to give an example, but I found it very hard to understand how it's
intended to be used since there are so many options for `--track=`.

Usually when I'm creating a new branch, I want to set an upstream
which doesn't exist yet on the remote, and I couldn't figure out whether
or not it's possible to do that with `git branch --track`.

My best idea right now is to delete the mention of `git branch --track`
here if I can't figure out how it's intended to be used.
