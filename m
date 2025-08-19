Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7319007D
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621239; cv=none; b=RBkgsAfL5XtV8fZCLtRjshn4XMaW/qhw6xOHICd3AfLsFUQZpotAKs/XrZGjam/9V06SLhgF6oGvT4qEZWLBqEJDfup2eSn/5PdoISdY+MXNNIlfLlsNTXB90NjUr83xeScPkWaEhF2iR/HCDewxH8J+2BnJTwMFS1jd1AuulAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621239; c=relaxed/simple;
	bh=bPq1Pbqz4z2UX2OKSQM4kmcwBI5XGeqggw4DSRb/x+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vhx5Y6d4/xij5fPSaDOvKOMqG5sw5SJGiqKNIr3IIN1UeDB6QVkiqAUOXx2QKZyaGpHqUMpfdamFJRmtVdIfUzDa/uwiyBps8fBmvoSudN+6a6IOPgV0duwsbm27lcOXWtT72a0ZAYxNFesLslQPQ3OqgNfLeiqVIW2t9Se/pGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=inSFwHeO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=isCzpgK3; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="inSFwHeO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="isCzpgK3"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E0A9B7A01C3;
	Tue, 19 Aug 2025 12:33:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 19 Aug 2025 12:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755621236;
	 x=1755707636; bh=RUhS1BnkoIxp8F7D4Bx+hB2apZexEkawFl/toGCK5Qs=; b=
	inSFwHeOdqi+/vQRU8TrwDeulpK+1qsqK+iIFLPKQ1AYWXDFtFD7u9dPmqRUCZrC
	OtqL66luEUZnFKhq9RFReUK3YWbGKoyr8XTZBXHVyDeysbCUOYvkjjp+nxzHAdGM
	mZCLWhfILvaCMMRB1vJnj4L3aFNDUC3n/l45/RI+TGYLSEM7Kj06h3tLL6+hMHbA
	aSzKGqglCNZKElN71eg7Kbdk7kGIuBJiPFJW/1O9t3FJtVyhB56WnhKynVfrC1Tj
	pREtcuTYknai1uMIyHNjEsBYqbpQASjXUcckGN59HAYxaKo/zYGZUcTvwPRnuahB
	c2ZYPMqcsEbEWQTihgd0bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755621236; x=
	1755707636; bh=RUhS1BnkoIxp8F7D4Bx+hB2apZexEkawFl/toGCK5Qs=; b=i
	sCzpgK3FGBtthL1h3D4vLW0a2Mkp2jC/8N3fl2ypVucQYVRlsUHjsvhADvEHfqI3
	PxyRSei+T1m/88iwBonQLCP61yGeOZ8iavXHENWwInMQSliXXy82xeNxJxfs0PMF
	U7cvozGVfS2FIoTKmBOlbkypvF/5HySrcUWfH0PVvTSKl4eHXvahbHnZ7SVG4Y0m
	B47/aZbd6ebcDS9glMYzNoKnC3zflhUc3mc2fDHHn41QlYG8nldQHfTg/zicOZcw
	VBdlniTZrp9KYtdl2J2mkSjKl28yoJH2v+k4CWUluSnq5OquTZR3Ynkd5oDILMsq
	Y9XAiQ1cRaI+Tldy7KDQw==
X-ME-Sender: <xms:dKekaI3_tUwtzl1AQ2cwdtDYoOLJR_DhvwrNGaEdZWs_4fDnZkbEVg>
    <xme:dKekaAM6KD4lVmW-3P1fQE4oLWSe0bl_NSuHW-UlFm55V-xtf3iy0i3SDLFb3Q1Ky
    FDxZyrLv7VNHvrAwg>
X-ME-Received: <xmr:dKekaP6-_7P-1mybulyeay1EqJS3iZ4-ILIG-IWwuNhA9K3D2nJOjVFcXhTd0zv1FZX-xBYVxB6cTJNKkJ4NKzogo38I2KkfeKKbhJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghrnhgusehpvghtrhhovhhithhstghhrdhprh
    hivhdrrghtpdhrtghpthhtoheprhguihgviidqvddttdeisehrugdutddruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dKekaC3O3RWmr-Hv3NVch4qMdmm6nHMiH-7saNEGamIG0aH9_DcOpA>
    <xmx:dKekaIx4mqXzDJDXdn5uR8eq5_4SHUbpHPHe9HgoO6spQ0XCuTEZbw>
    <xmx:dKekaEt25hy3E5AK-cgb89DDYt3x3L5QzITJH0mghzT7ypR28txaew>
    <xmx:dKekaKwveVc4ae4reEB9EKbEJiW86Q_pPZ3-kpmJ7PtBF9W2eqH7Qg>
    <xmx:dKekaP-FOg0kFCjvIhJTnd-Aixu-MAW42YXMlVsrWXDughOgydMy9b92>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 12:33:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc: "R. Diez" <rdiez-2006@rd10.de>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: Graphical tool to merge and reorder commits
In-Reply-To: <260a97ce-2ab0-4920-9cea-078369c42f74@petrovitsch.priv.at> (Bernd
	Petrovitsch's message of "Tue, 19 Aug 2025 11:51:42 +0200")
References: <4398af77-3183-4ac5-9a25-aca6289d8c8f@rd10.de>
	<xmqqplcsiimq.fsf@gitster.g> <aKQws631-giQS5Qr@pks.im>
	<aeb06554-77b5-4f07-a659-7b6825d6f3e4@rd10.de>
	<260a97ce-2ab0-4920-9cea-078369c42f74@petrovitsch.priv.at>
Date: Tue, 19 Aug 2025 09:33:54 -0700
Message-ID: <xmqqplcre0el.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Bernd Petrovitsch <bernd@petrovitsch.priv.at> writes:

> On 19.08.25 10:35, R. Diez wrote:
> [...]
>> I guess some "git history squash" command would be useful too.
>> This is what frequently happens to me:
>> - I commit some code changes because the current project builds and tests fine.
>> - I start the "compile all projects" process, which takes about 1 hour.
>> - In the meantime, I commit other unrelated changes.
>> - After an hour, I realise that a silly mistake in the first commit makes compilation fail for some project.
>>    I fix that and I trigger a "compile all projects" again, which takes 1 hour again.
>> - In the meantime, I commit yet another unrelated change.
>> - After yet another hour, the build process notifies me that I made yet another little mistake, and yet another project fails now.
>> The commit history looks like this:
>> - A - B - fixA1 - C - fixA2 - D - E
>> I only do a "git push" when the 1-hour compilation process
>> succeeds. Before the "git push", I want to reorganise that into:
>> - A+fixA1+fixA2 - B - C - D - E
>> I know I can work with branches, but branches make everything more
>> complicated. A linear history is easier, especially when you are
>> working alone. Besides, it is not often that I make such silly
>> mistakes. ;-)
>
> - `git rebase -i HEAD~11` (or so;-)
> - move fixA1 and fixA2 under A and change "pick" to "fixup" for fixA1 and fixA2
> - save and exit the editor
>
> And done.

I hope we all know that ;-).  But the question was if there is a GUI
tool to let you do so without knowing how to move lines in your
editor or how to edit "pick" and change it to "fixup", I think.

