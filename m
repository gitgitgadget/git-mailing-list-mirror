Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D9D41440B
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798355; cv=none; b=J+L6S3PgsgK/fy0zFSP+KAPNNLa/Q2V+rDUR81VPap3OGj3m19uPYSNO31gswEe95wr3Ot0ad8VjBE8zM7uezbzhfJAH7VXFe7oAoybf7bnKdX/G/dJHxiI0uJ+oxgdbF95O0m8OPXwZY5kjgpu/C0IgI498CanZRPiOkZHseN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798355; c=relaxed/simple;
	bh=FX/C41yZRE8Jew4jCX1V+4jK45If4j1PTxsO1jb+8lg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dIWEjIubSDR8ni5x0C4t9n9ePVcG7qS8hJ+PHjbu46PqjtRVUINcZ5a1TstV8Vwyiu1TPbbr2TPCe0dDi2SLCheBdg+P4ZbpFJ4PNiuFBsheKRoWrvZsinGl6cwV8qJuxQwJMgqoaMjjEovVD7rLBsp/HZDkjAMgDN4YFz07HyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bZ/uUOXb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VmhfW9OC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bZ/uUOXb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VmhfW9OC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 15316EC02A7;
	Wed, 30 Sep 2026 15:59:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 30 Sep 2026 15:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790798353; x=1790884753; bh=h03DYXzozb
	9MuzBeu4EDpNsHdT3sM0uoaC3uDKEnM20=; b=bZ/uUOXbb8lEOHq8/44PejDD0d
	dnQa5SoXdA5W7DmBu7l+y0LkigxKfV1EF2zUgHhrIIuAlzIp8IiWYN0TNpJ8jH2g
	cRWOjgB+IrKED/lH9B1dH/N2BK1XZ1YOks/nB8XRu2etSjhxPCwVO4B7aJKc9TDy
	U0nD/xSbjrLvYPf2nVntqOqtSThAWZF/d93cBPBX+GqWp701KT971614qEQJX1WC
	UKqxh4Da8Zq/bmLgkl95lyPuKdWx7+A3w9LGvQAAzfAWc/kswmUenkWPbK2zVwpa
	Iycjq1zrSkwOj07dYoU5FFqXyagpfkUwTbzDGXsI57C5h3LIM2GQr4RjCwWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790798353; x=1790884753; bh=h03DYXzozb9MuzBeu4EDpNsHdT3sM0uoaC3
	uDKEnM20=; b=VmhfW9OCdQf/Ljdom1bvIVFHS0MFrltj1V+V2Fszus1grSj9LJ3
	TGHuuZNsgHt7uw+36sh3erA0CPxnczMdxpwvC8pTj3OyAHE0PvRqaOBiqaYoX6cH
	b2xEGrrZ75Ot3kdZBRADjute0y7YMjNVVipnIhF9EcIulCKH/B0WgrUJvKarFD3l
	VSPexPCBCLX1CVBGvM24P3J+TP6dI91YfMptEbPz0XKL6Ae+y/Px1dFIr1xv8X39
	HRj8NHBF8GXM5+7P4xp/nuBvYbUDnnKfF7jwFgeEG+87WfLwjIDBpqvgZlPgsgc/
	QsCKy56oYwF75Q7QI6rwFUtItZGZm8PNTGg==
X-ME-Sender: <xms:EGq9akxuMiBNJytirwSEM2H7w-A53u9rVGxdNVupQHPaMJEU3TQ2ug>
    <xme:EGq9avIkzrWGpu6JiIewkrwco_MZ1GAl18LjUFMP670W3dgs4hqanSK8gDpgkAYVi
    0fTuBzH9SmkthRCPvH_0UJ2a0nlRPZ4k0tNFA7lO9mgHwQqG568ys_V>
X-ME-Received: <xmr:EGq9auq5ISxMfPmDN2ARZxMSM73J52cfDdJ--LMaApRUtqjomqK2D4w_spmFnM2Jrzb4Uy3JsOPiyaCulWQJ_AyY9MHW2uTowzaE>
X-ME-Proxy-Cause: dmFkZTFKhAnucwuYRd5cKkJvchQlMWJCz7n6oZmgEqROljux9NWklt36jcE0YC3XsSskRQ
    OwcgkAfP+Iwk9ihqsOwiyHKWopPZflSMrZfZRHohD0JHiN3jMsz9agWGRxnVxHh55DSb3M
    xgSIKIuyq1fxejXRpumur4sQl2OUupkDtaf/xRRMwqp7NEaGqtpnhRanrZC6BN/1hU+jcD
    ij2MZOVA0RnRm5QF9o1UElYlDq7h3uF+xh+oAJIatoIHo0Bdq8mVCudTUJJ5cOIuf5rvmk
    mO11Oyo9E1F8jnv65yzKqDDwNZ8GXHH8MH4efIUUnWulvhGRis04xxDLCoOlyV+Fj2YOJ5
    tCYQlK/kARe8abnYTuATqBWGMgovlxs3xtWg+DUsD9ZoIjnlw5mgnvEMEIvOYyx0jyecJJ
    zngkRcdhcLnurtKKPdMI2yXUN11s3oCY/FI8zg66hQ/Bp31La3QWlZyo0tXhNuaI3s2LFp
    jeQk4j+fZ6JdegL2z+5dSY/1+CftQw+rZIV/pGbftOMH+d4TSJKiBReKzkHe6rVQKagpYW
    jAN3hco04X5uOkOouQY8WaYCFVzG61FsirrUItb/DlZNiMX3nRtXbh6DOnjf9NXrrBlGK1
    joGeGi5c1Iy2VrQqpKzw+JjLRObxVnKze+T37KcrQWRkHLME+t+ZTyjZE7Ww
X-ME-Proxy: <xmx:EGq9auKOvewS5PbmQ8NfhG7RgCDy2eLiOAa7TvB2tjvb5gJGdc9ZxQ>
    <xmx:EGq9ajSfggRLpF_mB0Q9zEnjmXfNql0tJ1-uxbl1a1AAdNu8J6DzXA>
    <xmx:EGq9atvakiaObc2537L-cnmKFbZdpqVWhLjPaqzUmSj7Ife5hsf_Sg>
    <xmx:EGq9akY5RV9OztR9M_z_ogkuLSEzzjo-QPGlaQ4yTFKrx3umH73lOg>
    <xmx:EWq9aqoB6G9OIru8OTZFpPaK0W4Ktcu-cT0XjbMhJtKcKuh_LOh-f8Ro>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 15:59:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 5/5] xdiff: NUL-terminate buffers read by read_mmfile()
In-Reply-To: <ar0rp1cSIKuCMZyQ@pks.im> (Patrick Steinhardt's message of "Wed,
	30 Sep 2026 17:32:55 +0200")
References: <20260929064935.GA1276867@coredump.intra.peff.net>
	<20260929065504.GE1697497@coredump.intra.peff.net>
	<ar0rp1cSIKuCMZyQ@pks.im>
Date: Wed, 30 Sep 2026 12:59:11 -0700
Message-ID: <xmqq5wzma4ts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Sep 29, 2026 at 02:55:04AM -0400, Jeff King wrote:
>> Since an mmfile_t is a ptr/len pair, our read_mmfile() allocates exactly
>> the number of bytes we claim to store. But in many other places in Git,
>> we add an extra NUL "just in case", which can help avoid read overruns
>> due to off-by-ones or the use of string functions.
>> 
>> I don't know of any path that would benefit from this, but I noticed it
>> while converting ll_ext_merge() to use read_mmfile(), since its original
>> code did add a NUL byte (even though I cannot find any case where it
>> would have mattered). Let's teach read_mmfile() to add this defensive
>> NUL; it probably doesn't help anything, but nor should it hurt.
>> 
>> Note that the matching read_mmblob() doesn't need the same treatment.
>> Its buffers already have a NUL from the object-reading code (which uses
>> the same defensive trick).
>> 
>> As a bonus, we can get rid of the hack in read_mmfile() to handle empty
>> files by allocating a single byte.
>> 
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> This one is obviously optional, which is why I put it last.
>> ...
>> -	ptr->ptr = xmalloc(sz ? sz : 1);
>> +	ptr->ptr = xmallocz(sz);
>
> I was staring at this code a while before I noticed the added `z` at the
> end of this function.

I had the same reaction yesterday.  The proposed log message never
said how it added the extra NUL (or for that matter, it wasn't clear
if it actually did the adding).  The usual imperative "Add the same
'just in case' NUL by using xmallocz()." would have helped a lot.
