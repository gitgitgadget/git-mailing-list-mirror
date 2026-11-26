Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702599;
	b=Eq/UWi7/omAW5GJkHcLGm9tBqQBSNXfgHLVn/EwR2knJbrspxsDJLOnHaR2LLQCafD9P
	 vikNyM7pjQV4jwxF6iROP18OlIsTi+2CgPYJFjHGY1igHqn5Sh4H6mf7Ee0eSPmgEeQ2r
	 /Vi+lpGMiKPnT0FE9cHh3Gg1NMHJYBGSjZ0cjBqgMkAMGbMxUfS+qLK1EYLyoJhZ1Gm+/
	 a5rXM/gytuTK6pt6TPdOdaNIsfEmLfuDfOXvpHgr0U6qkkKj/9bL0gIYsg7uItM4Gh8jU
	 eNmGzqF+AaxtUaDxBMwPNaez66/REUOlqYABF1dQvfLS95P+yWXOjZ2GJMat/1NvWtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702599;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=PjV6gP+TTd4Vcs38+780YhdhFm64LSpI6jAM/hMRLNg=;
	b=CwtVKi5VpUfBjkjVdp1Zd+I3zKOEqtvetlq0e3QBDX8lkRee2TpEKs7l1EYaSlJX/U8t
	 u11xHUX9n6KsVxawEHKRsQ2R8E29T0QRlwvMGP63z64jbjgjlRIpm65ZcI9qBs9y2KWbL
	 KPQApwu4/cW0AvpKnCWTWIYt75iaRTtw3b8yh2g1wO1/BggviNMB0H/F4/qblPltY2PtC
	 2Ud66evMlM2VHE5jgS3o/GINTVlCv/srCCOkKqz/rbmwRxzqv53/IGU3LsZ4XeO8v33R5
	 DdN3A4pE789sjIVfWlY4IizdYF/yo9e34AnY6YecaHOG+YZ3dn/yJcSIoY01+HslYUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=da2C8MIU;
	arc=none smtp.remote-ip=95.215.58.207
Received: from mta1.migadu.com (out-207.mta1.migadu.com [95.215.58.207])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3238606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 14:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3238606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=da2C8MIU
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/Zd6Y1ovPKhXzdIY2bd/TIVw+w2sSj3ABadOQTX9J88=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795702596; v=1; x=1796307396;
 b=da2C8MIUZm2DlA5ICq8yIpUqEnhNIbDJtn6N0Zx1f4ThJHDzTzpxfjLLeVmU9TnWzMSIih1u
 yTVqxgjrP3302sKNn0+hy2wOJKl76KqPE60ib1pEu7MSh/MDPBTW+Sd8lkwQ9mX+GBLsmDhq/u2
 N5eudEHXs3hMFSJRwr3IZuIk=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id b0ed3ada31c41ade;
	Thu, 26 Nov 2026 14:16:36 +0000
X-Mizu-Trace-ID: b0ed3ada31c41ade
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] packfile: inline `open_packed_git_1()`
In-Reply-To: <xmqqwlq1lwdp.fsf@gitster.g>
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
 <20261120-pks-packfile-global-statistics-v1-3-19beb83b145f@pks.im>
 <xmqqwlq1lwdp.fsf@gitster.g>
Date: Thu, 26 Nov 2026 15:16:33 +0100
Message-ID: <87a4mvsmny.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> The function `open_packed_git()` is responsible for opening a packfile.
>> The majority of work is not performed by it though, but instead by its
>> `_1()` sibling. But this sibling really only exists because we thought
>> it too hard to handle errors properly and close the packfile's file
>> descriptor on an error path. So `_1()` doesn't handle those, and instead
>> defers to its only caller to close the file descriptor in the error path
>> again.
>>
>> Fix this design smell by introducing a common exit path that knows to
>> close the file descriptor on error. This allows us to inline the call to
>> `open_packed_git_1()`.
>
> I agree that this makes the descriptor ownership much easier to follow.
> It is not just the call but the entire function got inlined, but I
> shouldn't split hairs ;-)
>
>> @@ -510,55 +509,81 @@ static int open_packed_git_1(struct packed_git *p)
>>  		; /* nothing */
>>  
>>  	p->pack_fd = git_open(p->pack_name);
>> -	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
>> -		return -1;
>> +	if (p->pack_fd < 0 || fstat(p->pack_fd, &st)) {
>> +		ret = -1;
>> +		goto out;
>> +	}
>>  	pack_open_fds++;
>
> There may be a mismatch in pack_open_fds accounting.  If git_open()
> succeeds (so p->pack_fd >= 0) and fstat() fails, we jump to 'out:'
> before incrementing pack_open_fds.

Good find.

>> +out:
>> +	if (ret < 0)
>> +		packfile_close_fd(p);
>> +	return ret;
>>  }
>
> close_pack_fd() (now called packfile_close_fd()) closes p->pack_fd
> whenever p->pack_fd >= 0 and decrements pack_open_fds, which may
> underflow to UINT_MAX if the ftat() failed because of this?
>
> May not be a new bug (we used to leave the p->pack_fd open without
> nobody closing instead, so we may not have underflown but leaked file
> descriptor instead),

Yes, as far as I can tell this is not a new bug.

> but since you are touching around the area, we may
> want to fix it as well.

Makes sense to me to split out fstat() into a separate if{}.

-- 
Laters,
Toon
