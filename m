Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947D2FBDF8
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226786; cv=none; b=U0cZSEV1CMGkg7Vk6eNJx+rLYLgflPV3mE1JjiDKAbFKqnBJAucdNpEwfWMebDZyk5qrq1CzaZi1zrsCkYYbfzwsudaOEFKm5Gqmxz/+fl2iJerLKZx5spc+S6I+lDaUXVD0b8mExSVM3lHUCugCpiTk8JpT0QnvFqDHeVSorAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226786; c=relaxed/simple;
	bh=sMqJl5opL8vwMKsnDlX5Pk4R176yZbv3ogY1qrIAH0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KRLBhNj7r1cRMySEeZA79O9BCqQOTYw24HhT1qj0QkzsoGmZov6SZNMXqT/qJATddWeIfNoOtmAVzzHpFu0Vwaeu6qOUEWBaiXcoEZGQ7JS9ShdpPVRgE7AzTVFTXPK4+F8Fmrugq2nNThH3EMNPf/cDz0Rnzx9O6jUnoDsLBBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fEtyig6O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=USO5WdUg; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fEtyig6O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="USO5WdUg"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 57EE8EC0339;
	Thu, 18 Sep 2025 16:19:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 18 Sep 2025 16:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758226783; x=1758313183; bh=sMqJl5opL8
	vwMKsnDlX5Pk4R176yZbv3ogY1qrIAH0E=; b=fEtyig6Oeip75Np+qRxjPcHJ/2
	O5UGFwVJP54ZkaFZCmKOiAwBAyC9V27Gd+0VMYc3YHF2217Sr0Cur/rIDdvGyBbl
	Nxqd5CMzhgD6o0DvVA59bPBOzrpoX7zFt4S8TYrytqWbKAkF8Ib+QiW6AbH0BYB6
	B7oLXVU2vb4LdIjRUuGnkTcFAzbxh2DkTTf8cqvT876x+kwcjA4mLW8vEVlRYsWe
	+4124dwCoVvjewQ/JxQW16t2y5POgwqrNYpZgl7SiVvAJ/GAaEIDbZdNewOhxT7k
	W886ICuTa5iRhhO8Tehnu0StE6Llyk+PlTyTdx9vWMcVd/ndvYpabspHj1Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758226783; x=1758313183; bh=sMqJl5opL8vwMKsnDlX5Pk4R176yZbv3ogY
	1qrIAH0E=; b=USO5WdUgK22UmJ/elCMBGK+iUSrOZ0yLQN57pUCEEPfXxTDx9Ag
	FezSqtcTUURQYJzbk/LRkE7LMq3qNVid0ZOG13+Mmz6IDS61+e06Ju1nRHLKJ6FD
	7L2nkmMnrtrDJ/Oi4pzaIFERF81xQDgGVKSHclGcCJN1u7BH9sEB1bTaJjaoCW+s
	qbmVTJLKiLMqCNyYhxY/ejRnWbHwM9pQ0R5u4kj7hPqYS3omIdUNYkjQF/u485uq
	1fCM3xjJZEV2JyX0izC0e84RMk+3yyzJZynXn22PLjyPxDg1fJzLDfoiPPSAtUP4
	3YAA/BB4zLSwBK/rSHHuLMJUmkQvKX+vrbw==
X-ME-Sender: <xms:X2nMaOixZA_b6Hfn5EEtMvKwUkBO5rmHKP8sDeocTwEhRM-XYk6qnQ>
    <xme:X2nMaJk9gKWfzAPX0Mi-GPYR1Jqc7wD9kQFYG9xEIeqE9Hi9eksiX1bkv4udsSgZR
    jn7xjQMggAKzoBEKg>
X-ME-Received: <xmr:X2nMaCq-Hf-2BD4EOhHDLKGtY0BxoJEHq_DQdUeMOBkVgKUfFT_FasRF-gWcpOVabSv1HqzMSC2pr4VtzXTDKe0IXjG200CAprhVYxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepug
    hgohhlughsthgvihhntdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:X2nMaKHpfMAoVWI0NhfmlGObynIr4Shf14VINQ8IIy8DAkJKpONO7w>
    <xmx:X2nMaGxtGHwGt4tl6E4J27b0HLl7o8gAfnRkr9kBiGyg0DqWEe9jlQ>
    <xmx:X2nMaHqyMNgfb_o1WazXAiveeM5YfW4W79KEZmm8fT-y7kVJd88Shw>
    <xmx:X2nMaIiAujyR-FpAq5i-XqUE9Pk_bQxHltQI7M4t-aCN6n3hgpyNtQ>
    <xmx:X2nMaBwK9xvObkV5MkUuW_nY7N3dfECS284QGvjps-hp9HvpRZWh4aK4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 16:19:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: David Goldstein <dgoldstein0@gmail.com>,  git@vger.kernel.org
Subject: Re: [bug] git check-ignore returns the wrong exit code with -v when
 only a negative pattern matches
In-Reply-To: <20250918182545.GA1184978@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 18 Sep 2025 14:25:45 -0400")
References: <CANavNqpHqVgHshUaToS51OGVuvx5FqxROP2PssHW9OELMLeBQQ@mail.gmail.com>
	<20250918182545.GA1184978@coredump.intra.peff.net>
Date: Thu, 18 Sep 2025 13:19:41 -0700
Message-ID: <xmqqwm5v7btu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> AFAICT it has been this way since the inception of the code. I haven't
> ever used the exit code of check-ignore. I wonder if the current
> behavior is actually useful, along the lines of "exit 0 if any output
> was shown, and 1 otherwise". That would justify a difference in behavior
> between running with "-v" and without. But again, I've never used the
> exit code so I'm not sure in what circumstances it would be useful.

I very much agree with your assessment, as my understanding is that
the command is primarily for debugging your .gitignore pattern by
eyeballing the output from it (as opposed to a serious tool to see
if a particular path is or is not ignored), so I am not surprised if
its exit code handling is buggy, and I am not suprirsed at all if
nobody has even noticed it is buggy ;-).


