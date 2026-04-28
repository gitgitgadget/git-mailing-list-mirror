Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DF1224AF9
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340807; cv=none; b=MfJ3hmNZxHv/onyTk7Eqf4q4yYSoWjYPxfNLRCocvOnzocB358r4uR3qnGyY1qHAW8co6Nw7o4EnHNngqMZO2qzxpzGodtXNc/syON3loRyQbL2Hlmp6wTrkHH5jItxzCoTVkskKejHwaNbYC25qWUuXUZOYmRokYkar8oY6guI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340807; c=relaxed/simple;
	bh=2yd3KCfLZ/IF1cMBrgk4eSY39i4CX77doIp8Z+mRoTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PCkWUjTASYQ/nNvtEmpvJZhUUGSk+kkWgnGcZ8esixbfdbHQmRRJvpa+onRh5edJONn9ZEuCKdeLMgpuUPhm5S29ebE8MwD4Q19tXm8tuU3OHdVwaxdnwLG9YRuH5wWmJp+oV1KU+kyt7ZWs4PcFIdtXB7DE1/nrtNUbbJDXx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e1Kjmve/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UvA7ZPyR; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e1Kjmve/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UvA7ZPyR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9602B1D00251;
	Mon, 27 Apr 2026 21:46:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 27 Apr 2026 21:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777340805; x=1777427205; bh=yy5bYt20EN
	qSkujUDP7mVDkKnaA+AI4tU5d1TCeQ07w=; b=e1Kjmve/VPZpJE6cXhuMBTLZ8z
	DLPyaCdyKwrEVy+WLzZ4mXGvKd1SoiQHuyTzrHry3u6VG28Uj5jTdgklUCpqno80
	cQjDRpA2tzTcIVBspotKkQE/SId50OR2Wyy0+CPSI5R1Zh5DBr3KTRbaPj0AwjpP
	D1ifm7Y7XJZd2mGUMmGUSp5Udia3JdfSdajgY7uYW57CR9wddBKC3w+iP8tMftzc
	JZ4tEQDQ18AJVwqnkm5hiY5Ftla4Ay5DHzR9LYvCkWCyWDkPDvqBdD8UZL+9Mmd/
	DOXn3PihB7WNaw8jcEjP6fUf+FUVBxkMpZXkxwwZywJvacG2jxzvX65wjhPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777340805; x=1777427205; bh=yy5bYt20ENqSkujUDP7mVDkKnaA+AI4tU5d
	1TCeQ07w=; b=UvA7ZPyRQgiDtcAwUUO7dZlWAZw2YIDsLCsDSMGfqTTUg+1GHwL
	XNPUPU9572nUJhBv1QTr8St7/JorSUDVfgZHnEFKRsBGkdv83EXFOAxBqK/n1Qse
	krYpM5zso00NCh09Myo3c9rQ5TWcjbm2Y+CV+dOQ2fjK6dl7SKqEd59TSxnt2Q2U
	qna6scNIL3nPSOjYiJsgB6ytbVB88Y95M84KmNlHkOkKVmkaabuVh+S/EtHvcxDw
	HXTjoC+w7aEexiavbMPIlqYxt2N0DjRwZblM5eViVC34PhNtHMPaxl5m/g6HhfDu
	xHzE1mYujDGF7UjrcBioCbD2N8cHoJeTYQg==
X-ME-Sender: <xms:hRHwaTz-FJG6wAeU4M_hjEqCLU-SVq8R8rIY2frarzoyWRCEG-XLsw>
    <xme:hRHwacxRS4-j1wdPG7fbJnuhthzT-XfgHMyRxSNhg4MuJlFhFuBoZrt3ycPdPZcBX
    vM_tjjF22QKnB-xf_q1aiZLm0eAQ9mgVo3A443LOpkCpAPYguba>
X-ME-Received: <xmr:hRHwadbYtDMGMxa9C-xW8PXZwDCgXA0_7mDgR1_PusmqFfNMrkvkzcdptcSRpQ29jaqgU7fx7GDPbMrbpOZolei64QZYqvwEFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgsrghuvghrshhfvghlug
    esghdruhgtlhgrrdgvughupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:hRHwadXwFPzOgT2kB6O9cHD_jRPOygjWuNYO77GpqLdj_3G7Gbo2SA>
    <xmx:hRHwabgw3zXPfkYiHfUlD3-B_4vaapd8W9zCovgpYwVoRxi-4ju0KQ>
    <xmx:hRHwabtP3uZLeYan2fWUW7v7L37FYmlUHqI4fnqy924-xb-olaEVYQ>
    <xmx:hRHwaU5Pcfv5MrH6kGcALl8o_IHzhwzG13W_tb1EEtFbjw36B8QxEQ>
    <xmx:hRHwaRCA_o2nir9_V9vsz4psu2bMF91my2hhMOK8KRmVEURAOSEZ0Fec>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 21:46:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Scott Bauersfeld via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Scott Bauersfeld <sbauersfeld@g.ucla.edu>
Subject: Re: [PATCH] index-pack, unpack-objects: increase input buffer from
 4 KiB to 128 KiB
In-Reply-To: <c19a0e29-1218-4239-a362-df514153b5ff@gmail.com> (Derrick
	Stolee's message of "Mon, 27 Apr 2026 08:36:40 -0400")
References: <pull.2282.git.git.1777058098756.gitgitgadget@gmail.com>
	<xmqqldeb9w8e.fsf@gitster.g>
	<c19a0e29-1218-4239-a362-df514153b5ff@gmail.com>
Date: Tue, 28 Apr 2026 10:46:44 +0900
Message-ID: <xmqqecjz26wr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>> The difference between that and 66% is coming from where?  There are
>> inherently short writes that do not utilize the new larger buffer
>> beyond 4kB?  If so, another number of interest might be the number
>> of writes smaller than 4096 bytes, perhaps?
>  
> One way to reword what you're asking is to measure "number of writes
> not using the whole buffer" which is basically going to be "the
> number of flush events from the application layer".

I do not think it would differ between the old and the new
implementation.

> Every time the
> application intends to flush, the current buffer is likely to not
> be exactly full. I would expect this number to not change between
> implementations in real experiments.

Yes, I agree.

But what I was trying to get at was a bit different.  

The application may have produced only 2kB before it issues a
"flush".  Whether the buffer size is 4kB or 128kB, such a flush will
only write out 2kB, and the larger buffer size does not help at all.
But if the application has produced 90kB before it issues a "flush",
the larger buffer size would give us a great improvement.  With 4kB
buffer, before such an application level "flush", we would have seen
22 = floor(90/4) calls of write(2) to flush the buffer, plus a 2kB
write(2).  With 128kB buffer, we would see a single 90kB write(2).

So the apparently lower improvement than I naively have expected may
be attributable to the fact that many application level "flush" was
not large enough to benefit from 128kB buffer?  How much of the
total number of bytes written came in large batches, vs tiny ones?

> The improvement here comes from the reduced number of flushes due
> to buffer limits.

Yes.

> I see that this can be measured in the number of
> system-level events, but what impact does this have on the end-to-
> end time of 'git index-pack' or 'git unpack-objects'? Is there a
> t/perf/ test that can demonstrate this improvement for a variety
> of real repos using GIT_PERF_REPO?

Interesting thought, but the number of system-level events (or the
number of write(2) system calls) is not reduced by 97% because we
apparently are issuing too many of them, and the reason is?  I
suspect the reason why we still issue too many write(2) is because
we often do not send enough data between application-level flushes.
