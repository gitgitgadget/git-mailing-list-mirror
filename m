Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F0917D2
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 00:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783901184; cv=none; b=SYUacumoc5UC1e8SL+VsLzW1spNthxC4v5sKchKfXKnT6Fs768pBJE+SpzKPPT3HZKjhbJcJjveqnl7CQZvFfAofLeLz7mnuXxItbLFQLDYW4dDRW96D/GNBXwkiF6Dw6g+8CAOZoUknfjaDiXlnqAlkBxRo2yutVgChzpcJ9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783901184; c=relaxed/simple;
	bh=RPtX6p921Qj7W1ILIMXccxJ+7dP2pjEv5375n69E1Jg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nrH8Qrp7R9y5HQB6xcaoSNwuYs/Ws688JJrlnxWmTfn36Cu4XAvC+7yrdP7xZRo1HVYojmqDg1QoaQbJ+uI+ZnVKYzCGvn/9MLLgL/YKrmEQBsqH9xt/kG/WZa4ErF43+He5qGay+5Cj0+KD0hscYnvEf5cQn+ckHzLi5FhAVxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cmkKov9K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EuQZ3lGt; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cmkKov9K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EuQZ3lGt"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C888E7A004D;
	Sun, 12 Jul 2026 20:06:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 12 Jul 2026 20:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783901181; x=1783987581; bh=UYLt2sOv3Z
	f138m0R4sXGh9fVYLH9GAJ4c7/uQPW0mY=; b=cmkKov9K2apJUNIYOk6QZE1hFI
	aBYPvTbmzVFQYbci1LBmn+HfGUJxy2Y9IsGipfaM86Up8+cMXsqIDjv1zM4Zwop0
	5XdHsPOOD/kWQszcKRwVr5CQqVsmKP2oMjzY/P98a8yGFQJakfLTYkB54JYVqkGw
	UiUcA1jrMFmP7DbfN2FriieiSkZx7652dK7e0Odu4bMa02KCEQcwEZjz9lMFY5J4
	nioSL49qRXUzsbVskqcpbgF54ZR8OoK6INvO6O2Kp27FXYfrz6tyO5QM0MZ/TReL
	8Cusbg4PFLlIKkKXNJUXo1bJ74Yi7BZ1j3DUIXX0N7ytMQy4Vl8LYfkUq7+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783901181; x=1783987581; bh=UYLt2sOv3Zf138m0R4sXGh9fVYLH9GAJ4c7
	/uQPW0mY=; b=EuQZ3lGtnYRNz0zC6s8IgjuP0Y9ctzI/Q+L9z+MB1K6KKpbqQfX
	Nm4nmoZalp7gjCbhkJAYwPcVe/pKP2asrInvqr0PWo8f3EJ6zFTPqYRI0+ARKGlv
	BfwlpdKqJRbmVchHa7jHTUk6tzWwLBGa5mB8Rd5/J1hHvbRyOhWQBIFHfZCssmgW
	gjFd3XHS+qQXWuvVdJ2k6+1/PQXP/pVJuEYuH+mCinyRdDXzVTahSlUpvQXsqLSL
	szisxi3iDxICd1K6LnKHLHX/4BWj6owFpTyQ9k7SOFbr1gRer7AWD9K9uLPf08hZ
	3FJC0AQxjSohpPWBfZ+93O0NCOXrCoFg39Q==
X-ME-Sender: <xms:_StUahTYG3YjtUENnUgcdxVHpn8JyC2isV4lpipcFjhkJx0_6P2QGg>
    <xme:_StUahrfmfMKb9tMRwmLho9tkXenUTzc1uRobjduOz7VDamj9dqsuuB-ocKd4nDgw
    JVyNxYHRqHZpIELKGWz1ECR-_-WxCPD1J6tbWTb9swkFk24IJ_JKw>
X-ME-Received: <xmr:_StUavLs_9HttCL4tZNXAApm3B2sihNl_239por_-oG3uwvtByQ25UtpIF5bMy0hITkjHMLLaY2dLZAB18OiBOXM0SRNkfKIvQ5BTQw>
X-ME-Proxy-Cause: dmFkZTEdV7/RaBVtlcuXJH0XNnDmQscPw8wZ4tN84XYgSU+FT2Rqkgm1R1NkHaYJgPtTt5
    zlF1cmAO+B2ZPdMAK/BZEiYXpLDo0iQOOF2Zm71+1zslHCuWVXTOr/HpjKt9c2HPCZLnA4
    YFfMT9JA4S2ypOU9FWHrF3s71qTe6d3HNc2pclzlEbpL5eqyLUFqjGOkeXQQk9LfT/no/z
    lJIOGffXZr5+kGKLNo4aYOBaCWGuZCgphhvGrBYfMst0NFS82yccXnDZvw8Og9y+/yHiJ6
    yVcaB7+AQCW0JDIMdE1rxrlAe6oalnSyA7ohrOyRzBDFu7vibg5OHys4cBbvIzEGokVeDN
    IrK48nlxGcE/DFuf1RmaZ3jvjv96ZAu2INb5sq7281hKiSrUCzj4XqMYdRk+0ctnpRfBd0
    qzEyW+tEMjfEtPtM6YmuEEbSpIZ+r3M+b17yCf9oRGHN7P94jn38rfQQhl9epHTkOcwp9T
    u6NAcnXNjVGttsQrACISo+ygAgSCfFWL21pf5bxohRw2ly+XT5VNfyeqrgLvrFf5keAp0M
    bfIAKBMwQdlxrxV1tZUgJtn5PYfn0phC0/+T7idlsSJRhetrFrzPE1eunzR6gm2BKh5NdT
    jJnf8D0J+E3eY8cEf0TqWdStdNEbdGYIHOgROH/w7UN+ZpyCW2NBGvjE/yRA
X-ME-Proxy: <xmx:_StUakp5kin8qWgAISpKfBQUAOWgyjQZdkcNyH6fUx-1iXdCG6bl8g>
    <xmx:_StUanzdo310GvzZSsBPChrD3ICf-kcF53tPf1Jl1VimxIoXNgP8qA>
    <xmx:_StUaoMPD3IAT-9XURBrVgRdfyR9HfbjrxgXCEDglrs3xPKlT1JmBg>
    <xmx:_StUas6UVlXEBnY6QBh5GCDjMyCSQ9zNpLPqjkpulVNYeTJqJvWXcw>
    <xmx:_StUasq6g0sPf-s5agY5JyhEI7r_tIwRe5rpo7R7EqynqU62DfZViIa3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 20:06:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,
  Konstantin Ryabitsev <mricon@kernel.org>
Subject: Re: [PATCH 00/11] sequencer: do not record dropped commits as
 rewritten
In-Reply-To: <dce74d17-eefd-40bb-82f3-f6b3179cc2b6@gmail.com> (Phillip Wood's
	message of "Wed, 1 Jul 2026 14:31:04 +0100")
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
	<cover.1782833268.git.phillip.wood@dunelm.org.uk>
	<xmqqpl17rec3.fsf@gitster.g>
	<dce74d17-eefd-40bb-82f3-f6b3179cc2b6@gmail.com>
Date: Sun, 12 Jul 2026 17:06:19 -0700
Message-ID: <xmqqech73g90.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Junio
>
> On 30/06/2026 20:57, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>> I have a bunch of typofixes queued on top of these 11 patches (made
>> with "git commit --fixup reword:<sha1>"); please double check when
>> you reroll after seeing more substantial reviews than mere typofixes,
>> possibly from others.
>
> Thanks, I'll squash those locally and wait before resending
>
> Phillip

Thanks.

Just responding belatedly as I was scanning topics that are marked
as "Expecting a reroll" in my draft copy of the "What's cooking"
report that I work from.
