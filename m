Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0429A376BC9
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475318; cv=none; b=QhmCuSut1fNaIYOajdriNmqjX7SFxr+J4MTgaEwOHWOKD8Cds0oGaqArbs93eaSetUDJ8TXm3hgKxKdUJuPahuk/eFC8wvG10TM45G/GwqW/q+1XFVZA9iZB4YDwvEJZbNQObFAJQqFUMWFgTD2ieH8vxxOrunDXUPnRG+ltmIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475318; c=relaxed/simple;
	bh=PH+i6VtQRBrrMG9ILs/7eemB7KSWLjKFkryHjnmBY+8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXpwXEPVm1shODARdE1C4xp8QPGZOK2hnfCrFOoMnqyDIoUdbXdXGpxf+9bwMjDl3+UyHI4j/FtvzcBczH7/N4+txSDW8OytBbKmYXWHDg9GmYcMu05+Z2o+zXa+38S80epszRFcdjN4AwLQE8eh9TEXVIZYZPmkpeUqLFVvNYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUrCniJZ; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUrCniJZ"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-93f63d46f34so251535241.2
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 03:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768475315; x=1769080115; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pl+gVaaHfHKG2ODLbgI39I1WqXVMK14tdOX0Dt7r/CA=;
        b=eUrCniJZtSg/XgBDKS9WroIfYsOgSVEGOms5iKREKVEMCQGdSGmZVbdSTkdPVT6wNq
         NCZu6JRYWTJ9nLPKheMLJrzJS/UQUBV2PGRgqc6NGG2RIEqRRt4qejoukXu4f2OsBIrs
         wj149KuRc91Po1rK1VIXn/8M0N7lLJiz+dGTbZu1fRf3i0EorvzBoEDmgs39j0ICEFgB
         /OEuNGnosDCpyPuIB30zdRm86RUBQfFPDXXZMRoHdkKR+WU3O8+73yMTkU9z3BG5CvSc
         gVg2/SMojfk9bl1vQWSZzzPRfEEyltZFcolwXGRtPgPBCgtJ8P90P+z1ITrBODOL6J6a
         fCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768475315; x=1769080115;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pl+gVaaHfHKG2ODLbgI39I1WqXVMK14tdOX0Dt7r/CA=;
        b=ATHxHEfF+z4KWW3XSqeIR+99sVg1fLBGr9CEDqEpY3Bc08t+GZ0u8JyfpOVLi5Xxcm
         2vXLpJCqaBd64ajnvTVTAQL0o1PMh0X/dCEcZeOe0WVan3n4DevkICldZV+KJErcMS5Y
         dW4L6CbCtigfUyl9a5OYksvusPzBLi34rHAiXd1dw7LILCUfue7gTZKpvPx1ypP3g9sQ
         eYd+QWnuZCqjBnO04glyZ0SRUS/Iz0yh+cRZXt8oMls3zqjyG+Mlg0I6XDPzqNAp+zFR
         fsJ/bA8UMWuKryv7IkNRucIDCrOnTNwTeMgXLhXmZ0Dfb2F4fqFIsuGY7nJDRHgjgm5g
         UVTA==
X-Gm-Message-State: AOJu0YzZisZ8Ob6gIxvmOQ6mDYTYd7DuNC8xwWFJOG7aG1GLOvpBZl53
	/dQmM2U2hnycq0yfG3Qlzs/xMd3NXKwNCpvRjGIGbo7fN377GrYwE7MKff0xgxPEdgHUEb7Leh7
	xb7ujQaT+lkTBXuO0EtBPZzYoVK+6qo0seA==
X-Gm-Gg: AY/fxX4SXoqHk4pLkljtQKcBVxc6wQdoxh5GozxsRXcSoxdiaRnEZM3Sa94egwyyfHW
	xow2QTS0LYixaq+ohqu7N5QEuYjKIOizQRxg/80A4/BEAuMnpfqxg8IDKE6KC9vxnwF3t9Zxexg
	A3mfyXzpmWLVvsO1zZHDXiE/d8zKhbCSdTD89Xc3mRDG78d1KHeGxVpSNNzxOIvx/5ow5ItcLRc
	LkD88fmTumsFROGh9y+jMa9Mn/5IRSJUrwkEJchBvpCS1h2NRYeP+M0BtgVAh485JN6UA==
X-Received: by 2002:a05:6102:1612:b0:5ee:a1e5:6504 with SMTP id
 ada2fe7eead31-5f17f65c006mr2182670137.36.1768475314613; Thu, 15 Jan 2026
 03:08:34 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 03:08:33 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 03:08:33 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260114175558.GG885771@coredump.intra.peff.net>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
 <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-4-f5f8b173c501@gmail.com>
 <xmqqpl7cf6kf.fsf@gitster.g> <20260114175558.GG885771@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 03:08:33 -0800
X-Gm-Features: AZwV_QhyBWEvkahRiXrCbDfuIav1NitH_gq81ZuKGpkS5rilpDMLdktxMuEVelo
Message-ID: <CAOLa=ZQLPB2Tntvimpp2zt=6PiWhJJh_oDCrUk7F8v+pFhyyMA@mail.gmail.com>
Subject: Re: [PATCH 4/6] update-ref: utilize rejected error details if available
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, newren@gmail.com
Content-Type: multipart/mixed; boundary="000000000000ec08b206486b3e8b"

--000000000000ec08b206486b3e8b
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Wed, Jan 14, 2026 at 09:27:28AM -0800, Junio C Hamano wrote:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>> > @@ -573,16 +573,18 @@ static void print_rejected_refs(const char *refname,
>> >  				const char *old_target,
>> >  				const char *new_target,
>> >  				enum ref_transaction_error err,
>> > -				const char *details UNUSED,
>> > +				const char *details,
>> >  				void *cb_data UNUSED)
>> >  {
>> >  	struct strbuf sb = STRBUF_INIT;
>> > -	const char *reason = ref_transaction_error_msg(err);
>> >
>> > -	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
>> > -		    new_oid ? oid_to_hex(new_oid) : new_target,
>> > -		    old_oid ? oid_to_hex(old_oid) : old_target,
>> > -		    reason);
>> > +	if (details)
>> > +		strbuf_addf(&sb, "%s\n", details);
>> > +	else
>> > +		strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
>> > +			    new_oid ? oid_to_hex(new_oid) : new_target,
>> > +			    old_oid ? oid_to_hex(old_oid) : old_target,
>> > +			    ref_transaction_error_msg(err));
>>
>> Could "details" reported from the lower layer be less detailed than
>> what we are formulating here, like updating the value of what ref
>> from what old object to what new object, or what the err code tells
>> the end-user?
>
> I wondered that, too, but also: is this supposed to be machine-readable?
> The "rejected ..." output looks like something that could be parsed,
> and it seems to be documented in git-update-ref(1).
>
>   Side note: if this is meant to be a stable format, surely there should
>   be some coverage in the test suite? There doesn't seem to be.
>

Good catch, the documentation does indeed promise this format, so it
wouldn't be appropriate to step away from it. Ideally, we should only
replace the last field, but that would be a lot of redundant
information.

Overall, we could also drop this patch too, since the flag was
introduced with batched updates and we could better justice here once we
cleanup all other error messages.

> So should we just be replacing the ref_transaction_error_msg() part? I
> _think_ the low-level details will usually be more informative there,
> but not necessarily. So possibly we'd even want to show both, though I
> suspect just concatenating them would be messy.
>
> Plus the "details" one has a lot of redundant information in it (it
> mentions "refname", even though it is already on the "rejected" line).

Indeed, I've noted all possibilities in another response [1], but there
is some redundancy there and we could do a nice cleanup.
>
> In the short-term, I wonder if we just want:
>
>   if (details && *details)
> 	error("%s", details);
>
> That gets us back to the status quo, where the details are at least
> available via stderr. And then we can consider how to combine them into
> the machine-readable format separately.
>

That's a good compromise too. I'd say we do this for now and see how we
can take it from here.

> -Peff

[1]: CAOLa=ZS0i+YXfVHHAax699ME48YG7jXNZ3WOBYryS0hypMZO-A@mail.gmail.com

--000000000000ec08b206486b3e8b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e0fc082e96376695_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sb3lyQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meCtXQy80cCtNT05GQ1hGSTZybDAwL2dkdmdjci8rdQpKTkdmUzNlUk5X
ZWV6bkR3MDk0aTREemlxN1JQR1NLNHM0QXFGM0Q4MzFiUVRuNE5ZSk9HcnNRMTFTdnhWdDhRCkVY
WlNMN2RDNzI3aFBlN2JubUt2bHRhOUhNdVdRZ1ExR0NERFhqT0IwZjh5MXZsei9rNGdMQ2UxWlNC
NzVSeVYKZTZ3d1V2Zkh2SXJYSG9xMmlXMVlLSFNKaW5qVlF1OTJKWmIrZE1ScEN0V0M0dmRQMzRF
WkZTaFZOOWtjREdUdwo0UExCV3AvclNrWjRaK1pUU0pIalpMZkxRMTF4YWk4YkIrdjBKVktCMmRJ
dnFxaWdndERsM0NUZXNzb3hTaVJ1ClIvZ3ZLYzNSVm40aW9KK3o0bW8vOWpIOXA4R1Bjd3ByQzB4
U3BvNmtiMVdTQXVHb1ZkYTgzbzhUTjVsY1V4UkkKWHZJVFVrbVd6U05rMW5oRUtaOU1zdEY5NWxo
Zml2dXVQVDYwZ0FnR0lsbU9TQlY3VmFocDNRMXNPYVF2VUZDagoxb3pIZmVWdUpOMG9ndEhOUzNY
WmlvQ0JCOVhYeVRLakUyM2h6T3VjckFyZTdkOTZlRjZZVnVWRzVEK2h3a0lMCm1KUEpGZ2F5a0Ny
NTVoQ0x6TFBYdmRJb3QvMzhtbHF1dFE1T2g0RT0KPXNoaUEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ec08b206486b3e8b--
