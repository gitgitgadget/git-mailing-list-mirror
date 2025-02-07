Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34287189F39
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738916440; cv=none; b=okjB4++7pzwbXngDAZpFgmL10j8vk2kTJfpWTtLPNo4Pg+6MF/QlosG66m0ybcuIy31IV869F8ecSV5bXlIDnu+6grpWFTH7+5hlJsv21y0hUUfyY6ThsjTvoRmY//Aao9RR9FF4dP1IL8/4fH3bnfcq9Eb/h5EOenE7KkkWAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738916440; c=relaxed/simple;
	bh=8UHDfxkJ6Q4B/Sv/4HMo+bx+4cy8zzxE8iOCxmKwkRY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQWz4W0NgEgHMUVIE/uXCM530/5iwwGmgr5xrLojeEE38SVhzHm8Ao2Cl9mJympHJVe3cRQIE4jkA83n5HcMU61F2YPJYX7f7Kx7yXyFYQqVmBHI02zciE31SqmrSDdngbqKQWjEX+tf7QYMN4I0MktVLtyzpgD12UuODS3gEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlE8yaL0; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlE8yaL0"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-51f2a445df3so442541e0c.1
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 00:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738916438; x=1739521238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E3tkKR17HYxycPx1PnU1C6JZoj1hgKpRZaQpZtNPY6U=;
        b=XlE8yaL0IC0fATdn9rJEtGQ+aKyxP5gDc0ai67GLvZSEA+RKKi8BKGF3dDylJQSqLy
         ktrXX61T+MWGImYlt+1z5jQmJAE5lEopyJ01hjKvhoGwWNxlA+2W35ljSwsSAY3Xykzi
         GK5dp3kspGXC3psqBiE8rxWaJEKRqxnzxjcQ87ofAlSqjkg/+++VLELyIQwJ4ZJWVO9Z
         YJT9Ztkt9tXbYUY/KO1QJ/PCqeIWm6xqK4N/eUevtPIk588t9oQChnJx7oN2AYfDgzcl
         l72qlMQLb23W0Y7QtYRi2RsP20GJF8HJqgmhXxlN6mYXB+HmvP2oXKRuykZvQZcD+4Qo
         Ajow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738916438; x=1739521238;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3tkKR17HYxycPx1PnU1C6JZoj1hgKpRZaQpZtNPY6U=;
        b=bpvDjiWtC1yu/A7g+U92pZqE1CcYIV9kmiRq/kcvB5i6JdFphR0LVMUhOJQbupiVl0
         PH6lbnbcQtvqyI4gDO9lvNGyS8eoJ0F5snKkBNB6uYq/MeAwxvvjOynEx6bcoIVQficL
         pf2h0mV+rsrH80ZFrmp27G28T55hRjGx0b8TRrXw7hKbA/0bwlkkmuWIgvbVCNQzWTIA
         KJUBiRBwAp+1c9gnKzSaEacKg5RUpo1ij2F1t/hNuX8rNEDURwu3aAi1vvoyGoe9v34B
         7H+8/QNqQijyw0ITk98IJZOaTSDUyytJkGxfAWdalCopJu2cAgtDg0Il/PrMloIo3HQi
         ngQg==
X-Forwarded-Encrypted: i=1; AJvYcCXalwQvx6+Gts7no+74sTSERAJHlpbp8HRb+klK/AXwG7CXykaVSGBCZB/GGP6lNhTA7P8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3ljUbxxtGvuShHJajU1BHo9PHWpKfCn+fIe8gulCgVTyeox3
	hzkQUR+JfWdoAYBjqMzb2+iOLijle2UWg8E6EStGJYINERQYpVgPdFlCajJWB9C7WwNDIH0DeYI
	stge+rqjOaY/8Oq/w2JlDo1qKDpE=
X-Gm-Gg: ASbGncs1MvsMbX9TzmN1+FwWCQj2Pc59TKd4GQ1J16dxs3MCiYGG7WYtfzdTQbb2PRp
	vP3u5xJileg/TfNGMJKmX6sDHm+vmkt5fef9H0yUWieG/vAJaPRHaTksoHUJr5tX5JFWAgk3Gt1
	gag+vAu0WX/nykpPO7lNQ43dDLQRIbS9w=
X-Google-Smtp-Source: AGHT+IGy8QudwOKZH3wdRZ603wx2RR5Heujv5zxNNaV1DIMCJxSK9eHJrpYnv8HuvzPiD3/9lvsXF6qBs4iX0weIdwI=
X-Received: by 2002:a05:6102:149e:b0:4b1:20b1:bff3 with SMTP id
 ada2fe7eead31-4ba85efdc86mr1203066137.16.1738916438036; Fri, 07 Feb 2025
 00:20:38 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Feb 2025 02:20:37 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z6SGjSik-rRsAGUU@pks.im>
References: <CAPpV+OaMcViVKok5U0-4HaYyPMKEA7BBzw4t113uAaMndjs5Cg@mail.gmail.com>
 <xmqqh65b2ci3.fsf@gitster.g> <xmqq34guzi0f.fsf@gitster.g> <CAPpV+Oaq3d3oNE-V3pnpQRNrGCoZr52uY91QtWYxcu1tgG_QXg@mail.gmail.com>
 <xmqqseottxld.fsf@gitster.g> <Z6MLOA3mJGbPFBae@pks.im> <xmqqikponsk6.fsf@gitster.g>
 <Z6SGjSik-rRsAGUU@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Feb 2025 02:20:37 -0600
X-Gm-Features: AWEUYZm1DB9tAqFXJ7Jcjp23RjJrnt_obov9nNDskfyQ7Y5XUn0ALLdhwOt5fX8
Message-ID: <CAOLa=ZRz0dFB46y6RtxMuwAdY=u8xh1msp2pscT_4hwUuBk7Dg@mail.gmail.com>
Subject: Re: Usability issue: "Your branch is up to date"
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Manuel_Qui=C3=B1ones?= <manuel.por.aca@gmail.com>, 
	git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000956bc4062d890805"

--000000000000956bc4062d890805
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Feb 05, 2025 at 10:40:41AM -0800, Junio C Hamano wrote:
>> If the user, on the other hand, is interested in keeping track of
>> all these thousands of refs, "git fetch" would have to ask and
>> receive advertisement for all these thousands of refs anyway, and
>> at that point, recording the no-op update would be a very small
>> part of the problem, I suspect.  Besides, we have reftable that
>> would make this kind of problem easier to solve, no? ;-)
>
> Yeah, I was pondering whether to bring up reftables or not :) But
> indeed, with them it would be way more efficient, at least assuming that
> we write everything in a single transaction and not via multiple
> transactions. Which we generally don't in git-fetch(1) unless the user
> asks for `--atomic` because we allow for a subset of the updates to
> fail. Consequently, even with reftables we'd end up writing N separate
> updates, where N is the number of advertised refs.
>
> This is a known problem that we actually plan to fix. Karthik is working
> on support for "partial" transactions, where it is allowed that a subset
> of ref updates fails without impacting other refs where the update would
> succeed. With this in place we could then refactor git-fetch(1) to write
> the update with a single transaction, only, even in the non-atomic case.
>

You've played my hand here, I've posted the series now [1] and agree
with everything you've said here. It should really help with optimizing
reftables.

[1]: https://lore.kernel.org/git/20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com/T/#t

Thanks

> Patrick

--000000000000956bc4062d890805
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b15179204ba7ec08_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lbHdsTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNC9IREFDaDFUVHJlMHljYU52eTVmVTAvSlU2ZkZZUgpJenZBdHhZTlZy
MFhHODM2VHFldUxCZ1V0WmE5TDNvMkhvNjh3RXRsWEFhb3A4SEViNS9NcTdzZjNqSFFsM05TCkFp
YVFiMnB0R3BybTgyUld2OUJQRUR1Wk40aEo2RHd5ZlhKUW9qUlQrOTJnNDQ2THdiNnI1Q1E3VWpx
eVB3bGYKS1ovSTJHOE92N2ptN2ZRZzljaG1QVTBiamlUck5GM2RuQXJVb09QS1VmYnp4SnowQlVi
OENUOXE2WDMvMHIxbwpFN041NnNCYzVYWGJnS052c1pxMmYyZ2VDN3RxZHJPNS9jVVcyYVMyUEhq
VnFyTmZFZFIwajA1TnE5cHFnTy8rCnlhWkZORUJPUkpYeDFJeXlpNHVZcDlaSUdwZ1hadTVoZy9X
QWNLZTVzSXQ4K002M082SVlGVCsreWZXYzRVT2gKVUg4c3g3QTc1eFFHdGVqZXZzR0NIWWxlMko1
dkVuYkVBb3BpcmdoR3hha3JnNmQvaTUvQitKWHpXQngxZzQzZwpNRGFxRndpUXBGRGg5YXpmK0or
UnB6dmpkVG9tVXREcDZlV1VRakRpVEtSSkE1SXg1OVJrRjI3RlVJcytZYytzCktWbHk1aVJxNWFq
NWVqWmlUcnRRWE90MC9zVlZ0eWxLcmdFU2QyMD0KPVkxWkEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000956bc4062d890805--
