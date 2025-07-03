Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D427E265CA6
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535654; cv=none; b=LNPH/kVHarRDqIzcl1aLcjdAw2ZcEqOGFx2jN55Ap6HqSQcndQspTHqivdd2W4kNZ3g57IJRVXTfs2uWOmdGWmZ6ypx3q77EjyHKcLHyMzWT4Yw6j8GYvVC2rHOqaK9Xua96ekaOKToeKYqGSPe8j6KBSu/HwqX1VO4brI+41w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535654; c=relaxed/simple;
	bh=e3Xmvn0n7KSaQMCqwOpoHVCfdPf7MiAuSMz6fRPKC+E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBm7d7lClJMOl8SFFiJn3Nayx/WBeQ2BOUHLtUNckKKwVLfO234ceuunvFCHrcGjWCqFFUj1czm8By14ORK15/5jUoSxxxhfx8wxdkmS4Jhk4dwqrgNPa17/zNlnDb6aAIU/tpVUTVzbpQ3R6M46rGx0qnxhvBpdw98DaWCPNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfxNX5pK; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfxNX5pK"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-531466622beso2431684e0c.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 02:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751535652; x=1752140452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PbsurVBGrmUtK/LELOhfag7+m3egReUKYgSDDAbI18U=;
        b=hfxNX5pK9RG2vmp3Uf5hQLN58QsRT6c23InM+qFfzyjImOVPL2rDaWIQtr+diBBEPt
         1wU/3CgAChxLZPy0TPlx4JsUgMkpkKbZjnpn1imE9HMXfgHyls7DmjJ89FQDZB8QDkEJ
         Y1DQVW7QleYxlyNMVHgbNBzconZzL1Mk9BuMMRyG6/ywznc5MX4mVVZb2PEyCX8av9Yt
         EFd+VVcFIbn/ftvvbd4hYW90rGyZ+1CC2/rK7mpAOBCh/+L4Mtogut0gdQEdvvsbKvOw
         dzQT52CE65gU42p/Mu6ntRvXHvyMEdkHR3VYHqPPbJ7Nsc8IlUmKNX33xns8vYV/hcJA
         P3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751535652; x=1752140452;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbsurVBGrmUtK/LELOhfag7+m3egReUKYgSDDAbI18U=;
        b=fW1m/qjZvxsNwmWF4dKxrwz2BFejKtFMRSnaGlRpB771i5GW3rRHiUgNHeQLdk/k9n
         SpMj8iKGl39ZU4EbXM8tCJYRnFBbFFezvBm8/GATjMWlMn9VxwScPMZfVoOND5BZAb+S
         K/VmwnUdgwbQpmIF8A/+w1HapZb3Yz6ZzoezPRrHloc3pFzgKIz3mDBT+0Bdw+jafEBZ
         Of3tVjwbgIegGfIPOcnHQuMVgpUOBDOCD9l7sLwdOGlc55WBzF+CzKbzGNI6NNIpKED7
         hzIvu9LmXe6ywjq40wS0zEVtglv3DBc02QBczVBjV7iGZKUtCw0FoJIfNZSycsIbHEUx
         sRWQ==
X-Gm-Message-State: AOJu0YyTUtLKt5e437aCQFZAjQvMJ7WRX0qgWlI+QIMDnmQr1G5mTn19
	CXKsv9/SyWBJApAeyrm0x3kDLC/yda7hQ2MaCtxPbLIBIASWnDNMPI6l8PZy38Yc2ofL2LOPJqQ
	U6q/nVFQVf2LIY3LVNeLztU/24jBTPrU=
X-Gm-Gg: ASbGnct0kTA0sGiae8IdEY/RIr7QC4/4ffCgisb/0UTY1xRcwqQgN1rpXSHFmwepJHg
	nQiTD7f1HfEySEWsOG42cfvZiVy5jQtq9wwlTqTC2sfl36cmtqodn/D9ajbIAiLosKcMlEb9D7R
	m7wrrlUxCThcgO2Pgc7tZ+QWTHEJG6+g5Tx2MWSuXoLn2N
X-Google-Smtp-Source: AGHT+IFkITc+V9/5r+vr72f7Swqz13qMy7Gi9PT7u8p8sF+4I8R84E7oIntfLDADmOCUkwlkOCwh0KHEt/ywiMMMpXk=
X-Received: by 2002:a05:6122:378d:b0:531:2d55:7f54 with SMTP id
 71dfb90a1353d-53458081f9cmr4554282e0c.3.1751535651674; Thu, 03 Jul 2025
 02:40:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Jul 2025 02:40:50 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aGYbUpC9OEd90J4N@pks.im>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250701-306-git-for-each-ref-pagination-v1-3-4f0ae7c0688f@gmail.com> <aGYbUpC9OEd90J4N@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Jul 2025 02:40:50 -0700
X-Gm-Features: Ac12FXy4S7nrswUpVmH1Kmx-Vy6c3-R0LhU5KI9ZRp6Hg7kathVNy0wIGd-jmt0
Message-ID: <CAOLa=ZQU7s2N+GqNKLQeAZVFGVXFKjVSeCLC35FGMqMZwt4zaw@mail.gmail.com>
Subject: Re: [PATCH 3/4] refs: selectively set prefix in the seek functions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000054891e0639032cd9"

--00000000000054891e0639032cd9
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jul 01, 2025 at 05:03:29PM +0200, Karthik Nayak wrote:
>> The ref iterator exposes a `ref_iterator_seek()` function. The name
>> suggests that this would seek the iterator to a specific reference in
>> some ways similar to how `fseek()` works for the filesystem.
>>
>> However, the function actually sets the prefix for refs iteration. So
>> further iteration would only yield references which match the particular
>> prefix. This is a bit confusing.
>>
>> Let's add a 'set_prefix' field to the function, which when set, will set
>> the prefix for the iteration in-line with the existing behavior. But
>> when the 'set_prefix' field is not set, the reference backends will
>> simply seek to the specified reference without setting prefix. This
>> allows users to start iteration from a specific reference.
>>
>> In the packed and reftable backend, since references are available in a
>> sorted list, the changes are simply setting the prefix if needed. The
>> changes on the files-backend are a little more involved, since the files
>> backend uses the 'ref-cache' mechanism. We move out the existing logic
>> within `cache_ref_iterator_seek()` to `cache_ref_iterator_set_prefix()`
>> which is called when `set_prefix` is set. We then parse the provided
>> seek string and set the required levels and their indexes to ensure that
>> seeking is possible.
>
> That solution makes sense.
>
>> diff --git a/refs.c b/refs.c
>> index dce5c49ca2..a4220d3537 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2669,7 +2669,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>>  			if (!iter) {
>>  				iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
>>  							       DO_FOR_EACH_INCLUDE_BROKEN);
>> -			} else if (ref_iterator_seek(iter, dirname.buf) < 0) {
>> +			} else if (ref_iterator_seek(iter, dirname.buf, 1) < 0) {
>>  				goto cleanup;
>>  			}
>>
>
> This is quite unreadable, as you have no idea what `1` could mean. Let's
> make this a `unsigned flags` variable instead so that we can provide
> meaningful names.
>

Yeah, that would make a lot more sense. Will amend.

>> diff --git a/refs.h b/refs.h
>> index c05be6d0ac..c5e08db0ff 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -1300,20 +1300,25 @@ struct ref_iterator *refs_ref_iterator_begin(
>>  int ref_iterator_advance(struct ref_iterator *ref_iterator);
>>
>>  /*
>> - * Seek the iterator to the first reference with the given prefix.
>> - * The prefix is matched as a literal string, without regard for path
>> + * Seek the iterator to the first reference matching the given seek string.
>> + * The seek string is matched as a literal string, without regard for path
>>   * separators. If prefix is NULL or the empty string, seek the iterator to the
>>   * first reference again.
>>   *
>> - * This function is expected to behave as if a new ref iterator with the same
>> - * prefix had been created, but allows reuse of iterators and thus may allow
>> - * the backend to optimize. Parameters other than the prefix that have been
>> - * passed when creating the iterator will remain unchanged.
>> + * When set_prefix is true, this function behaves as if a new ref iterator
>> + * with the same prefix had been created, setting the prefix for subsequent
>> + * iteration. When set_prefix is false, the iterator simply seeks to the
>> + * specified reference without changing the existing prefix, allowing
>> + * iteration to start from that specific reference.
>
> I think we should detangle this paragraph a bit.
>
>     This function is expected to behave as if a new ref iterator has
>     been created, but allows reuse of it

Sure, let me add this in. Thanks!

--00000000000054891e0639032cd9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d77403dd68408d87_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1obVVDRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meW4xREFDUTQ2WWQwaERJRUFzUkRWMFZ4M3JhNkhYVgpsOFNjemg5Y3Mz
VWFLMjNnZ3RmVHRQTENvd3MxWXp0TW92TTlGU2ljbTZmN0FvVzhmNUhtdVR4N29hRWo0YUxKCnBp
WEVWSUs2UTJrZ3ZiS3duOWtXaTlKVVBHUjdNWGRtNHVHWklVY1VKVS9UZE00NFFYcjVNVW4vMEdV
VVpGaFgKVXpmeWgvQmp4T1J5QXNGZnVLMmlCa09CQTQ5V3VGRmlsR0FkeDg1M21tckFPdDJaa08v
MVFmbVNWV2EzV0dqbgphcFZyZTl2SUt3dm5Eb08vRFB0YWFBMDBTWTcrVnJRTlQ5ZksybVcxWGdT
Vmt3TndFcUgvbW1qdXFPcnVTdjR3ClE1aHpXbGM4KzMyZkMyRHJUUHlDZGN2em5xT1Rwd0ExQ0lB
NjJUSVpBWmNNeHVTL0pUM0s2c094KzRsZ3pid28KVmp5cjJmZG56WURPTDhhSVBaN2k1ZnlYZERn
bUJ1dVZsTmlzUlJZY3BGempBSnhpRVphREU0V3ZFMnZDK09BWApBdUdWUEp0bkltVVZJSG54WnU1
cFdIYlFLbEVzS0JJVTJmSEwyaTNiKzdmci9QUnpxbjNMRU5laDVMK3dZYTYrCnA0d2pCTnJUMlN4
SUV6dWFrRW9Xcmp1bmRIR1A1V1ppUjViRDR5ST0KPTZXR0EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000054891e0639032cd9--
