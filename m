Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370481C2E
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009364; cv=none; b=kdgNVuV+yu4CMO53ueLR36iRD1zfSzQBjAiCalgfagJ28agokvAqIvzmSJgjr3JoBIqs/rDE1Jhk+aCjDTVV0lfK6wXCcnr4R0hN/tTd8XA9Zxx28+q57GiHe441g3vqOKwHUGXPiviBRNdp5e2DjyWhAjQEJq00Ai/Xvl/pEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009364; c=relaxed/simple;
	bh=JDROGS4oFgGTCNQkkq8UO8MmacLvnxEQcnJNTk4+beY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tGCszKA+QCwFub2ivVm8cM+qZ29SYyKY51KTUwXLwBIm/oUNB77nZC2Uk9bvIpCdVw4MOG4yHX3xo383+bGy7PqxX41m6R4xFB0lBuJj60NckGlE582/tFjbzoGw8W/E0wank6aLHaL8Jvp0IhrAOhYhfUsE/UD79vUayzNwC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QS+v9Rbe; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QS+v9Rbe"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C233B231B9;
	Mon,  1 Apr 2024 18:09:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JDROGS4oFgGT
	CNQkkq8UO8MmacLvnxEQcnJNTk4+beY=; b=QS+v9RbevboEnJ0d1a3q95TCRG61
	yTN64tZvzqMDRwY4CVqIzGg8C78wU/2owPbuh1gFIo0bUm4/yivkiWIjIfztHswK
	s0+tw9iSk0r0xvL2S797eXxLuCY3u/CUHZyYd390YPJ6nkMKbVMk1nY4C6PwUH7l
	d9mQaoDiIQyYuKs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B825A231B8;
	Mon,  1 Apr 2024 18:09:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5D36B231B4;
	Mon,  1 Apr 2024 18:09:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #01; Mon, 1)
In-Reply-To: <Zgskgeg6kXJsb3/c@nand.local> (Taylor Blau's message of "Mon, 1
	Apr 2024 17:17:53 -0400")
References: <xmqq4jckaoid.fsf@gitster.g> <Zgskgeg6kXJsb3/c@nand.local>
Date: Mon, 01 Apr 2024 15:09:17 -0700
Message-ID: <xmqq7chg91ma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7CB19DC0-F074-11EE-817F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Taylor Blau <me@ttaylorr.com> writes:

>> * tb/pseudo-merge-reachability-bitmap (2024-03-20) 24 commits
>> ...
> Thanks updating the description. I am waiting to reroll until after it
> has received a little bit of review on the technical front.

In the meantime I've dropped it as it interacts with tb/midx-write
and Eric's khash-to-khashl update.

>> * tb/path-filter-fix (2024-01-31) 16 commits
>>
>>  The Bloom filter used for path limited history traversal was broken
>>  on systems whose "char" is unsigned; update the implementation and
>>  bump the format version to 2.
>>
>>  Waiting for a final ack?
>>  cf. <ZcFjkfbsBfk7JQIH@nand.local>
>>  source: <cover.1706741516.git.me@ttaylorr.com>
>
> I am not sure what to do with this topic... I haven't heard from
> Jonathan Tan in a while, and the same from SZEDER G=C3=A1bor, who was a=
lso
> reviewing it.
>
> I personally think that the topic is in good shape and ready to go, but
> I would rather get a concurring opinion from some other reviewers befor=
e
> suggesting that it be merged.

Yup, that is what I meant with "final ack".

Thanks.
