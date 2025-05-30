Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7C4430
	for <git@vger.kernel.org>; Fri, 30 May 2025 04:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748579364; cv=none; b=WTGfFLW8Wfc2lk3Zxa382cmlBzG6+nFUUFAMQEQ9DVlRmNHvQEkjNkdG8zDFe52+pecDJSmEjvrQRAC+vZtD/oJrf9D1REQWBItOqdACNoUcMRkNJ919ngnB5jaMlN/w6G8LzN0Jn6oLsDi8q+P2QlSC8+P9nLsM+dmPr9MBnV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748579364; c=relaxed/simple;
	bh=9I19+WaqRDrqR2g/E49CTJWZslQ6jLbC03DcAYhEdL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F5IxSFPXB5Qr7YVbg9YoUr9E/J8whHJRxF3OuLuiWZ1jf0A5o1vjnHtfNlw1us88tHLRGSjIUyxz2eAGqRpMPJufmoWuJeF+7mvCyL919GK93QC9EkSWHd/R+bHK4v2zEGJW1JTEhf0ngroMTNQ88r1sl3wB363GYahZkXXQZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=il6u2uuz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W0QDcFOe; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="il6u2uuz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W0QDcFOe"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 16BCB1140142;
	Fri, 30 May 2025 00:29:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 30 May 2025 00:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748579360; x=1748665760; bh=Pp2rQqxy6o
	ecJQR7qosymUUn/ZsUj+tyHDZwHVPovD0=; b=il6u2uuzvwDT6wAl4//5TaAXSR
	SeshxYM93XaKZvcw+k+Y/x5bpGSA0Sf5UDJZueqf+Ry41a0wp+c3ebI4YhyTWeY4
	qrPAq143tDpswyqlAmh7ApGH5AlST0iL7gJGEqfAwfi/nTBbVYB/L5MfgwW8DbaZ
	FXwR/DyQWSM3cZx0TYcjZpxtTFWGXtCIAdVkVqpoj1cdHDT23gk05mhCO7Bqu0EL
	5ORkjyFpjttgBBrtcR8Qu7/IZwYJfD63Dta1Mx1iqxYzOR+9jwFbATZQxKHFO7dY
	5sXIgIBWUok5dZEpFn570jXvmyb9kMFWZg8B8Pq/ouW/7yAF3neG2a4hswlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748579360; x=1748665760; bh=Pp2rQqxy6oecJQR7qosymUUn/ZsUj+tyHDZ
	wHVPovD0=; b=W0QDcFOehiJiGWX1ffrX29p4a7ZkElHpjVgYQkn3+jz5rpLQgUk
	Ley2yUcmxWy2ZlCDQV6ICitPe13nXtb3MXYyADS8fGcLqfhvZN8DUDrJ+LDi3vSV
	w1D0SxyfruHcDs8xpTt4Z+lhCsMqpA4g/Sa+P7CCUJck4N2AiJxJjsXNjaYLafF1
	Jd64R/+Dw7LM20h09o58h5s6FMJsxNaJpF/iXJVcrMuRskbOyK/3NAtPKaVdWsvK
	YchYp00/BSFmsAqJ/Nn948f6ciBgQfR6srO2UFMDErq/0A3tM6PgtCGqY3aFAjaw
	b89I6kHTBjcQdBla/4Q4AFoASGECGqtLdzw==
X-ME-Sender: <xms:IDQ5aMZbPtgznrDBQ1dGD9a0IHeCsS3OWAGCT7R2hLA9tS45bOIBbg>
    <xme:IDQ5aHYTf6-a_wPqPUoz9fq_8GXnbtsyT_BvQQat-E-CTH1Q6Tm2hmY_lEFSpvQTE
    Viu9zgiwXdje0kYcQ>
X-ME-Received: <xmr:IDQ5aG-lvyANACQo-zJuBo7xaFfoH-2f46-tKSDeiTA8iOr2XWOW9cl9GGxgqewUauaWrZlI-Djap6BzRZbQOitLyBvDcvW5r0fyQuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkedtheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeehtddvtddvgeeffedttdeh
    ieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:IDQ5aGqWcikIGPNPCQhybmyKVcO8OAuJSwbaodV-1GdTUd5TDCYVig>
    <xmx:IDQ5aHoL6WrxtKZ56NBBi7zpc8lonVFNU91WDaMcjDj3dCPpjA1JFQ>
    <xmx:IDQ5aEQb6MYiyBlLNFN3QSi1qbsySmraFdmUmQBqcgqDyI1CvpXUwQ>
    <xmx:IDQ5aHpFoMYAcc5YzJ1ryqNFjrTHvCM4XOV4LxYiSVcUO5P3zFPBPQ>
    <xmx:IDQ5aFRrQeOTIaEMofcwdM-i_iYMBYioC8TGxfEwN9D5VNVEz2wFOGPB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 00:29:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v2] sequencer: replace error() with BUG() in
 update_squash_messages()
In-Reply-To: <edd4d392-f124-4e97-b4a9-6cf3fde1e804@gmail.com> (Phillip Wood's
	message of "Thu, 29 May 2025 14:39:46 +0100")
References: <pull.1964.git.git.1747226641249.gitgitgadget@gmail.com>
	<pull.1964.v2.git.git.1748168353204.gitgitgadget@gmail.com>
	<xmqqr008peil.fsf@gitster.g>
	<edd4d392-f124-4e97-b4a9-6cf3fde1e804@gmail.com>
Date: Thu, 29 May 2025 21:29:19 -0700
Message-ID: <xmqq1ps6iuw0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> OK.  Or
>> 	if (!is_fixup(command))
>> 		BUG("not a FIXUP or SQUASH %d", command);
>> at the very beginning of the function?
>
> Asserting the precondition at the start of the function sounds like a
> good idea

I am of two minds.

I do not know if this is better for longer-term maintainability or
not.  Such a message at the beginning of the function declares that
the current implementation does not want to receive a command that
is not either of these two.  Such a message tells the next developer
who adds another caller to the function to make sure not to pass
other commands, which is good.

But I do not know what it tells to the next developer who wants to
add support for another command.  After opening that initial gate a
bit wider, perhaps to

	if (!is_filxup(command) && !is_my_new_command(command))
		BUT("not a FIXUP or SQUASH or MYCOMMAND %d", command);

would they make sure to handle their new command correctly in the
if/elseif cascade, from which we are removing the "error()" with
such a change, and would our reviewers notice if they forget to do
so?  I dunno.

In any case, such a future change will have to be done with a good
understanding of the entirety of this small function anyway, so I
guess either way is OK.

Thanks.
