Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A817E3D1A98
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838474; cv=none; b=iv5PBEorhtDCurgZSpKNLBmDWnVefyNAAuywNEfIWoFLs/8fG2+ToJOCBQaboAzxVzWMQf+GRhZ0df4lavHOiZ9SumWSGHKnF9avrF4NjAQToikHcVijNOhwyWXUbpyQVOrYNJbzDG8+rrInG0JsVd9eVCEMbPz3k9CNiUnOmrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838474; c=relaxed/simple;
	bh=rGC6R8AblBVWIPtVEih/nmNzrg7hsvMjuriS13kAl7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l4wFvIHLY0trHWYcgYSTQTElv91bHyCtsSpxXXH/JpY3KUkKWfBDzFTKVA/co9Yfw8aIZODeg1lgAznMN2cfYUasRvhBMvvNC05Zji2Ywf4Eh5xIGSf3U6L03ySYTup303ROyIkdhOP2+rlLNyYQzkFPuEh/51tVZWMCJRPBnvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JwQZOJQf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=beoqnrfp; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JwQZOJQf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="beoqnrfp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C283B1D000D7;
	Tue, 30 Jun 2026 12:54:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 12:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782838471; x=1782924871; bh=oO6tdcubfu
	xTmIV/5IxikgBR56qwPV/qIqNLPgSpjvQ=; b=JwQZOJQf4a4PWPF608SnW3/Zsr
	D/atvhh8hB7qQxjAjILG7zS+Fly9qjp3/gOim7CXa7iF65McUuRG32EGc3W7TljY
	LlZBu1FSSPEugW18BXX0MJVccYjY80/L6oCUDF2Cz2WEZd7lrumrkxYVC0KLJJ8H
	z3MYHrIEvz1aO0E8Qd/xcqIZkvFROcTFjkafz7qYr2qfMaLzw4LQgloFTdUP6hMQ
	2SoPKO7dkBJv9V61NE51Ei3FE8AqGK4LQ711lckB/qCoq0KZYhtB9gqObAqLQ9hO
	mHPuNDEDHVwmvx3SJPIHq9c8qBi2Hhw7QnX6LVTdEz6wQqChV4HjPyORG3zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782838471; x=1782924871; bh=oO6tdcubfuxTmIV/5IxikgBR56qwPV/qIqN
	LPgSpjvQ=; b=beoqnrfpz8xP2po5yhzavITq0dMfLwR0Rsa5nM1j6HmEMEh5Q5h
	vevqQPthK97t60nuGVz3yOyh005HIW6UqVu4kVA+DU7he8PWhSWM/mpYiZLL7Nhe
	kVk2NrxU8kzSIR/XCmphiY+d21aZhxLeBP8mJdjONMDm/aPGXcX34kPltnUGSdVo
	0Ljv6ePFAHGK3cJ7CrQLLqKkYpa3F5j0vRLaVrPpUjIGw+mV/Zq4X4Pltb43gBll
	ZN+EBLfU12VCOlJJEEzpPoPV1155pF6E0C8icghsXkYRQ7e3HlvNJ/fmQJiXc4fx
	cC9pQCY8c90qkb9D9Z0RUV32Mgfs4XKSAUA==
X-ME-Sender: <xms:x_RDavOKJjiKOsXO7xNTjKOB0EmK6jDEI1ynsPQG9L1ebkxba3Wu0g>
    <xme:x_RDag88cr7dUKoRZ81nAiPlRpkwXW7BzGUlcXVrwrYUiyerrHKkpERhCkYWuANNf
    2Jb3slSL3m0VXGdghFYdHiZPIg0eCmKLUwfBun8VEJ9gCpMbrM->
X-ME-Received: <xmr:x_RDajQaV4ZMicXTrWYzAzpumRdTnF1-6DXLAg_QzbvwTsTyrmQt44bA1oVFel3Vel-O2vcjJJZYPuWkFArR6OUYiva8LKBX6FzjDWg>
X-ME-Proxy-Cause: dmFkZTEx4/r72Se9Wbi9GQ5Rz4gqL3aRK2q/qfQZREhIrZjAlStQiRgkYygJjwBdJkW6v2
    BSqfJwxv+ND41+0Yaswdn3mJobIbxfYNULJoKV5RYk7piwsocaLQ6LcZ8ZUWULME3FxJ5T
    PfgZYwoi1J7TIRVHb+LLCTYTCffeu61eoBtX1N9e+FJXin6YmMUwZPU37HgPXx9nhpGrk2
    22tCAZKppR4V+LQ2PJm7tX3z2MHz7fN8b0bicr+xnEtgSAk2NPSsdrBAV9Pn4adoFglBMj
    uQtMgqW4uW4+2Px8H8Sdnz3+3nGFwnFU02MELjcEd1vYrCVsnp6k8Kh+yKlf9NyLNA31XM
    eID2ojtD0BlORczZTneKEikU18SI7b9LJab3SG/apXduri7fScZOKmUu9/x2SPoOsQ+l9q
    nlwHWDRH6YJcHKi3TorHQB+Rig4rCr6rQDsRNnyiqR27dpMJUVnF7H9ahn80dkjxAZfl7X
    OmjFmBaL9TJnvwGemBc1WjNjM8n+CP43eoZCu2BDfluZX+eS6w/ilBy79wVNem/Vc1jtRv
    EOE6aLFZPTrE6E3smbospaXGMrn+J+Ay1BMGbOk9NJ7N1+3EOYOCYBq3OA8YTiHApt6M9z
    uEK+wyV2IadAlB/WVwk2wugJ5w27DQ43B4MMp4JLbTjGVtPWcoqI0ddQhNyg
X-ME-Proxy: <xmx:x_RDainusI22rXfOoHPL_mMENxFJkUYQfT8xpex0YsI26XJ-CyqakQ>
    <xmx:x_RDajRzWxPKDxBP7l1Usjm0pBxVjKKQJKeV3Itt8d2eUiDz80jLLg>
    <xmx:x_RDagMT9wEn13pKfU305_Cm2u7hpSpjkWMZMDBFyQLXaZ1Iop5omA>
    <xmx:x_RDasXd9nnaGZxUT20ouIICW58tflW_ezzqpFhvcllNcl_nq84iaA>
    <xmx:x_RDajMJXzOLszM1p0hTikZiJ_AyRX818cFGO4RzeJEZ29EIU7AnwsGi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 12:54:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 3/6] odb: add `source` field to struct object_info_source
In-Reply-To: <akOod6X1a2axIXKZ@pks.im> (Patrick Steinhardt's message of "Tue,
	30 Jun 2026 13:28:55 +0200")
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
	<20260624-b4-pks-odb-drop-whence-v1-3-8d1877b790ac@pks.im>
	<akKtc4ybxFRVJmNv@denethor> <xmqqmrwdul8y.fsf@gitster.g>
	<akOod6X1a2axIXKZ@pks.im>
Date: Tue, 30 Jun 2026 09:54:29 -0700
Message-ID: <xmqqv7b0rmt6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jun 29, 2026 at 01:47:41PM -0700, Junio C Hamano wrote:
>> Justin Tobler <jltobler@gmail.com> writes:
>> 
>> >> @@ -1424,6 +1424,10 @@ int packed_object_info_with_index_pos(struct odb_source_packed *source UNUSED,
>> >>  	oi->whence = OI_PACKED;
>> >>  
>> >>  	if (oi->sourcep) {
>> >> +		if (!source)
>> >> +			BUG("cannot request source without an owning source");
>> >> +		oi->sourcep->source = &source->base;
>> >
>> > And here it is set for the packed backend. Looks good.
>> >
>> > Naive question: I understand that some `packed_info_object()` callers
>> > may not have the `struct odb_source` on hand, but when the `struct
>> > packed_git` is intially setup, is it not always known the ODB source it
>> > comes from? It makes me wonder if the ODB source should also be recorded
>> > when `struct packed_git` is initialized.
>
> I've addressed this comment on patch 1.
>
>> As with your reaction to [PATCH 1/6], I do share this puzzlement: if
>> the source can almost always be NULL, what is it good for and isn't
>> it something that can be computed from the available information?
>
> It's not almost always NULL, even though it looks like this because we
> ended up adapting more callers to pass `NULL` than we adapted callers to
> pass an actual source. But in the end it's rather the opposite: there
> are very few low-level callers that don't have the source info
> available, and everyone else instead uses `odb_read_object_info()`,
> where we do have it available. But those callers don't need to be
> adjusted, so they weren't visible in the diff.
>
>> Perhaps it is the naming?
>
> Yeah, as Justin pointed out, calling this `sourcep` is confusing.

OK, everything makes sense.

>> I am confused what the above quoted code actually is doing ("if you
>> have a source, then grab its base and set it to .source member of
>> the struct the out parameter points at", makes it sound like the out
>> parameter sourcep should be pointing at a structure with .base
>> member, not .source member, or perhaps the caller should be passing
>> &oi->sourcep->source as *base to be assigned to, or something).
>
> We have to return the generic source here, not the specialized source,
> so that this interface can be used by every implementation. Other sites
> would end up storing their own source, which of course would have a
> different specialized backend.
>
> So an alternative to write this would have been:
>
>     oi->sourcep->source = (struct odb_source *) source;
>
> But by assigning the base we avoid having to cast.

Yuck.

I guess it may be OK as the caller or whategver the caller calls
later may have to downcast this pointer the usual way to access what
we return here anyway.  As a pointer to a struct object, when
suitably converted, points to its first member, this upcast should
always be safe.  And taking the address of the .base member is far
more explicit.

While it hides the fact that there is such an upcast involved, which
might be confusing to readers not familiar with this corner of the
codebase, I am fine with the way it was written.

Thanks.






