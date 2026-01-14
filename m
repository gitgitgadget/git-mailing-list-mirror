Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5643A0E89
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430735; cv=pass; b=ECpCj819qTBYeANPExiRn88jZ1m6N7U1Pt0EKT7pJN/UY0TX7+LOt+V736TlZGzX47ZsdtYHCEokwVx7EZe1nij6+mfenYW5nr/Ceq06xY2CfCK0tPWIDyg6y/I/tt1TgpF1ez3XqNCIINUI5DSfoAAqoPSECPnZAlOeem/EQwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430735; c=relaxed/simple;
	bh=REFvZrPckyMUQxxpqx4wL1liu/dj5kQcEyo/o910714=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fnYfynY3xe2m44ZGgTsq2tZOxiIwIGTTnrTo/vlyzZ1tMp20EQWyxLAPALmRUYmj3T2aDtQxaJT7wJdIsXrogNRVFXqAvq1Z3OqO7DcMjZDXllueo8336zc3HeYTE2/2bQnfMu9890oETYCxI/pD1q5CDa8Ni/ya082DKEfZCBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Si9uGrbT; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Si9uGrbT"
ARC-Seal: i=1; a=rsa-sha256; t=1768430711; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZRr9OBV+am+lVxFtaz5OBRwGKTSXyP77usqQiR1tN+I/u07qy2DzI4sFfukcfAzhZNZBuOjRJl+q2tk5J0mS2skLSlGTgSL6RtfMVWZtsSRGPcwAH47Fhn2EfxghMOJgljVEJWlCWJ+grlN2u8LLTaeLTCQ1tBqc3N2wcmUTCNI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768430711; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yT57LXmqLgF7sXbxXLZ2Vwpt2udVJN5uakogRAJPIn8=; 
	b=ElG5RwWtkG83f94Gi5N26EggHSMPbWtpYvtscA082Pz6i7FPDnfSACUFLoF4Rpxi665HfuvPMEvoWrF0XYIlVOPbGpRVDpNhwPgcQZ+wS1ZspyUh5+3XNv54ubl+o2/XJt0s0wc8kMzqebHd8wu+4dxs58YMZJjaoDp+ZqwkZu0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768430711;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=yT57LXmqLgF7sXbxXLZ2Vwpt2udVJN5uakogRAJPIn8=;
	b=Si9uGrbTpHCdVeBn6ZNGA68BEMFcJKe5J/YQx7gKCnsA4nCR0OwxCEBsblwJOCXB
	tWiP94Rhhhspq08Xu8KxDIcImgm30oB/ApKLMKW1W39vecwcEIBMi1LGDfeX7XdgFDx
	A5Z0YJvMN7Ox+zZ4zEjqlXQdonR10T084j28djpE=
Received: by mx.zohomail.com with SMTPS id 1768430709426241.05163176461804;
	Wed, 14 Jan 2026 14:45:09 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick
 Steinhardt <ps@pks.im>, Emily Shaffer <emilyshaffer@google.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Chris Darroch
 <chrisd@apache.org>
Subject: Re: [PATCH v3 2/2] hook: make ungroup opt-out instead of opt-in
In-Reply-To: <20260114212718.GB1010080@coredump.intra.peff.net>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260114185731.2381550-1-adrian.ratiu@collabora.com>
 <20260114185731.2381550-3-adrian.ratiu@collabora.com>
 <20260114212718.GB1010080@coredump.intra.peff.net>
Date: Thu, 15 Jan 2026 00:45:05 +0200
Message-ID: <87qzrrlspa.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 14 Jan 2026, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 14, 2026 at 08:57:31PM +0200, Adrian Ratiu wrote:
>
>> In 857f047e40 (hook: allow overriding the ungroup option, 2025-12-26),
>> I accidentally made the ungroup option opt-in instead of opt-out and
>> despite my best efforts to set it for all API users, I missed a case
>> which requires it to be set: the pre-push hook which regressed.
>> 
>> The only thing I needed in that commit was a way to change the default,
>> to convert the remaining receive-pack hooks which require ungroup == 0
>> for sideband output, so it doesn't matter if it's on or off by default.
>> 
>> Bring back the original behavior by setting it for all hooks in the
>> struct run_hooks_opt initializer, which nicely allows changing the
>> default value only where needed, in receive-pack.c.
>
> I think this is an improvement overall to what's currently in 'seen',
> and the patch looks as I'd expect.

Thanks. :)

My intention for this series is to fix the two regressions reported by
Chris and Kristoffer ASAP and not touch receive-pack (yet!) because it's
a separate topic which deserves its own patch & review / discussion.

>
> I have doubts in general about the approach taken by c65f26fca4
> (receive-pack: convert receive hooks to hook API, 2025-12-26). We used
> to use an async muxer thread, and now we are buffering hook stderr,
> which to my mind is a regression (both in terms of real-time output, but
> also the deadlock issues mentioned earlier).
>
> I'd rather see us continue to set up a muxer thread, and then direct the
> hook API to attach the stderr of the hook processes to that descriptor.
> Then receive-pack would just work as before, without having to fiddle
> with the ungroup flag at all.

I am certainly open to try this other design, especially if we can
eliminate the risk of deadlocks. I will code something along these
lines then send it for you to review.

>
> You can take that with the appropriate size grain of salt from an
> observer who has not been following the series (and is not really
> interested in it, beyond making sure we do not introduce regressions).
> But it is also an observer who has dealt with many I/O deadlocks in Git. ;)

No worries, all feedback is welcome. 

I genuinely appreciate your ideas and suggestions. :)

Expect a receive-pack patch from me soon, in a separate topic.
