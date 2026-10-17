Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81A3D333D
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 04:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792210209; cv=none; b=qYFMqLYXW4D4u+8yNyLXd6uDWT4OPXxP+hVzOX6Er7R8R3kuTVfXcSmao17RwEN0mNioL26emZVdwhoRLPwOj3PAp8QFJCdUg125331j82I/FCneh2UhKoyRDol33MubHiXR8hxSZfHbWHSE+eCTR3V9lDPH5HV3ibYzjrwlpNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792210209; c=relaxed/simple;
	bh=sKMXS/BfQoBRce/F7+L9MKDokXrB0uQ+hUojuDGOaOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NxqDfvoGgyQ59lUUx8m5rHLRtRMi8l7VGu8Ab5BNfIXevaSRRWSiKB/XtbUk0fmdjfK95lJks1STqO4vdeeEwaFvqd3YkGjWiHkLo6wKS5uDFQivxGiDHb/cM7Q/VgweiJRQhFf2F1JL4c1nMeVT9fcCx3EVe2IRVCeLiM4k3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BDLzPjsO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gwfef7rr; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BDLzPjsO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gwfef7rr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 88B4C7A00BD
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 00:10:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 17 Oct 2026 00:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792210206; x=1792296606; bh=cSTajN3j28
	fPsE1nSrLbmaebG0drsqSiNkS98jMpeNg=; b=BDLzPjsOjDJUBKDVSteEeo5ZXb
	DRqIrHIrWGbHXmP3ey0EIubvXYQ2YXjjuS9hzwCWs/D7KkKWjAfrV/WmN4ZXbzIP
	bX560DtvK5v1ohA1+1/MsllrEkwycTtEhXCorLdCEFJ+uBEi+TEEwN3TZNlcEQ5+
	YOCtexwYUHaOeNDNleUiSklLJPrcsTRFUIZzceJjA7WLMMy8jiUQGJHI3V6kVOQ2
	tltnm7rVttSHXjjKynQyTXUq5UyiWD4ZimdEOTtFp0S3gZtummDeQCxPWnK/8oez
	k+/9WWZA/ivK1qCYzxiEF5Gl55K6VWPgk9SPx25pn+dkPl11Gow7jj0hmnOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792210206; x=1792296606; bh=cSTajN3j28fPsE1nSrLbmaebG0drsqSiNkS
	98jMpeNg=; b=gwfef7rrIwWTrMw93i4l2D7U2xd/UfnjRppQ18dOtzBJfyc9L64
	gNlejJNz0OHodJorBcJClaLTrl3Pv6OKJNJPrVnnCwUbS/W+yurwRQMmOTm+D76F
	LE+Fjkg97RVwePi5hTmXgO9rZvczcYVdFNtBy2mJp1OJcni2/BxxKPkKFxkfw5Ep
	X8CC1J1BL1Li+TQetCsvGzkRKfQJhfuQa3TvE5VuiXmjHhx/0GVvnRf61PGXoY9J
	kzc3WtgiubjXylvk2fR6iyRtUfpFSPFtIt5t49Vf0wDEwqQyVKa4a4JAjTzUsIIW
	VwRcZGZIYjTW5k+kq126g71WzKtbis/bEIA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792210206; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ckX9CDkVI28Dp6pglpW7AFD8ccKwopu+payszWLF82/b4a5
	UZzRC1J5JLi/R4nPtoaPrxNqFdQeLj83WWZcxtidgwgTF8mK7g28l3+PZrzU6Q/0
	dCaaMFkVVIaMDwuwO3JdfU9KQeKjCG6kqaRRYg8eqJYBrR4l2wmX4WOBHQ8uwJRD
	IjOZpY5dOm1Gg6EfQtoAL4X1dHrk4gAw7cNttS2Hr9iuBMDJ7YDb8o2ryM2FViFB
	3S83rnJebPtDOiKzkTfRY4bcxUpVDfMmyrecPC0pifOLMMWOgi2zUsX+JQwRVn7z
	0rQQUNsRcIRkA/EiGaW364yL/fCHDzT/eMqQ3ow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Y3pJc4nZXJgcfzsgQFM9STJ0KA0pLl/0wVmF3FnGlaA=:sKMXS/BfQoBRce/F7+L9MKDokXrB0uQ+hUojuDGOaOw=;
X-ME-Sender: <xms:HvXSalf44YcySJPaGkvzx3hc5G6c9V5C_lFwU6H82aUt5ZfmAim76Q>
    <xme:HvXSam4o-jktJwC27Pl57gW7rZEOJKJhJZ2YryZ2zPNKemJX7XZzWM_F6Cd0NvFW9
    1CNWR3xc0azGSh3Y-JN7kxW2_S5DsXsZ0WVxPZgh1VrxHxdF7u90F8>
X-ME-Received: <xmr:HvXSaoVlAWISeBuV2BcE9sxH02Wtm6DRWGfJo_caxIugn1kKHJ1_TwA4Dwwv8LFjMz84OLnnmnATRayws8naGPFSRUjoATINoNg4>
X-ME-Proxy-Cause: dmFkZTF8gd8/vnWd6Bs5zdwKW43KrQ5Xa12DPWj9pD5q4lePrCBb2LDcsCoFba7ONiXPpJ
    0oENsKoX5vZW28kyDJqNUceyPkVeXGS0//Mq3bIMeS4e+LmEPdyBv0clzSFCiOcggMOvvb
    QzQoy4vyBs7nlSE3UP/WFP0ATUF3OR/4DLJb28JG29+Z0I8o3xnXqexZECwXTDxk4vOAiI
    hqnEGA/9yFXyIOoHjnmq/6Hz9hSgT6+CgfUMNULYTgMouaiChJse1TwHG90LB9cDi9hRf+
    m1kAhwjPD+O/0yRTTUNntdrxU7VlVrP4KZA8j2E+Qr4jXIsYYdRm1CRfa15tKaUUx+6wsY
    MB6T2VmPWrqXmkIxnWsArH/8XgwgzjPECPYZsx4ske3jK8/dfbZdfjhPBqHfxTQnhK2ecI
    XUrQSpQJDjbfBq4+IUtCNGRBtJ9gOjJCakVO8gj6ralxlVoKKytuGHr5R+G8UEgDvz6f6e
    EW6FBEf1LGa/IS/mvAeAVMZmkZHguvHjxldMspcuLm/iMRbaYYguMaI7lakqN2KY31wJ+d
    +E/x1g9eV/PLCOb2T65e8O6SRvsswBXK32RPBFNWyqIG0VmptZYPPc18nas9h+Wb9UaKzB
    +4JV/+tD3ZNi8ym9fYREraEYasftMerYwxUvbfFyAFrKoANg4nBKJ55JwbNg
X-ME-Proxy: <xmx:HvXSal4nV8yQ_C1YbmC87bNMJNbOMQUurElqSlU-PznF1p90VLBM5Q>
    <xmx:HvXSajoGmIO3s7CVWHqpDDzCAgF-Ur8HVKQ0_HE7cNvfQNtmz4-jeQ>
    <xmx:HvXSaonh-jWNzAXyc3IYJ3JmTgJa-C8p75yS8IMeZQY5xjC9ZZd9EQ>
    <xmx:HvXSavOTxyhbozZCplNrRg0CcbNlcZERRmFNX3TZtMKdZWoOQVhWjg>
    <xmx:HvXSatd6Jy-MDXAWLszURmgtL2D0e7GTFxU5zdyT8qok9L21KZKmU0nr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Oct 2026 00:10:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: Patrick Steinhardt <ps@pks.im>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/5] http: use `size_t` for byte position in
 fwrite_sha1_file
In-Reply-To: <395b47c0-6dc7-4a1b-b547-e5e68e7356f5@hogyros.de> (Simon
	Richter's message of "Sat, 17 Oct 2026 09:18:41 +0900")
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<70a909de18e8cd8d282439fb51a9399baa8c7be8.1791958171.git.gitgitgadget@gmail.com>
	<atHiiye4oi_lF5FP@pks.im> <xmqq1p9pk99q.fsf@gitster.g>
	<395b47c0-6dc7-4a1b-b547-e5e68e7356f5@hogyros.de>
Date: Fri, 16 Oct 2026 21:10:04 -0700
Message-ID: <xmqqwlrharxf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Richter <Simon.Richter@hogyros.de> writes:

>> I agree that changing the type of posn from int to size_t is the
>> right move.
>
> It is a position in a file that is being read as binary data[1], so 
> off_t would be the best choice I think.

Hmm, interesting.  The function writes out eltsize * nmemb (both are
of type size_t) bytes, so the total could theoretically exceed the
range that fits size_t.

But the thing is that posn is used this way

		ssize_t retval = xwrite(freq->localfile,
					(char *) ptr + posn, size - posn);

to offset into a contiguous in-core region that starts at ptr.  I am
not sure if (ptr + posn) is still valid for posn that is too large
to fit in size_t, though.

To put it differently, we are writing out what is in the contiguous
in-core region and posn runs up to the allocation size of that
region, which should be measured in size_t, no?
