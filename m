Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3EB27735
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586048; cv=none; b=fXrXjxJVUWwqo+9u4plIlnf1kpLg992RBi91SEOxW2+M/ubVOD4FkTin3AdwfvPNNYF5DgcEzbx1LRt1AHXpq+6GOKs2cHkPXY7pWRvg534HOb1qD0TOS+1jGB9RchUhlhLk2/+VY2HrPlIqT46Ul1bJA+COWRJEEltP36wFQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586048; c=relaxed/simple;
	bh=dnXrTVUKX7j+3nigVBqoa04gUenp2SmeW/ilYL1JXr8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TN9wTaN+lYIDmCNYb7uuICXX2uSmAY+7lQA+3gXPyq9XwqvWGWV0xlHVb6hLAzzGqdD2vy407qvTHVh+9AT72eE2eRSRhfBE61U4lXiZhVn9jLVJ37nJ71TTVsRFjLRxG6GXCBk78ea6cBWrmQclh8+bUVMCGQXrQQHsmsXOByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1CrTpkH; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1CrTpkH"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d592e3570so1567924e0c.2
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 01:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729586046; x=1730190846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SeHHWiwYfBWVvuyNe8O7KnZ8XbHZ1+ABgH14Zmiiu/8=;
        b=k1CrTpkH4GiNC7Ifo2kgfsD6MYmK9zqwpQvZHuZUlHt9LtfHCaiEDMkqFNngw0ljhP
         XOAfmoAes5RftfwNUScyiSPG7qjRXzp5kfFZMe/lnXsu0DuFMmqLE1dgnkWIh7tg7AvE
         6GLGDTdK4opc8LfdA4Bp+ru+t11wTeIPe2r3keHmblGdVkY5QSuoUcUCNpNNCYPONpeL
         h4FQvDQao6YmHOg7OBjRuLMglXaK0hP+Ojeal53BGOmnZikhDael1XokilXqD3oAOYye
         fIWB3nDfjQgq45GTLCUB+BxLv4+RUfI75JPkecRo7nzrBnYa4Ao2Q2YF/ZLDNmQ6f1Qx
         Oekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586046; x=1730190846;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeHHWiwYfBWVvuyNe8O7KnZ8XbHZ1+ABgH14Zmiiu/8=;
        b=w3IZfDFbc3ucv5dbmkMjdfDB9QieFJDTyUqJEMl4aNK5osyzl193BivuVfI+HZKDMV
         s3UYyo9AG1CwrfldD6iVWa5QHs6UgAifU4OXxCe5rKnXm62LaQVaN+LQVOU+2LrzsimO
         T36VPThLzLThQuJByMh6hTpzIZII56Q1msSl+IeXkwBYNMs9DkxEoDKsygsNGSLnGfQX
         q3TcudYlp2uo8wte9tqrGmCUT48kM9un4o/Ua4gRQYfqinzdsrUY3Xx1wcUcaYjnhhB/
         WahdnHT7II6hpsbTjguzLKLg4z+KLn3643g5PkJ0OMRELdmfvD+aB/foQ2w6JyzogQjc
         XmBw==
X-Gm-Message-State: AOJu0YzksynlZhVFzgEFAFQf382kJMrBVmGwsE/qxPtx6X+dERC7wg6y
	whth5zDgTkXaS7RPX+tLawTUTj4e9v/Fo9waQnpUdFGTR2NS0RLjL41aSzGnXQcbFmF0CCvY7yL
	hkt9a1bcKaUMxi1F2nzDtINGbo+iaY+P2
X-Google-Smtp-Source: AGHT+IEGa62mPSSZ4reRsV7oy/ROLLabrMzhM+nLF5rsZkKLNxdm6DPAq6JV8AbOxVVNiyuoEmk2tdECKP6L9OY+Y/g=
X-Received: by 2002:a05:6122:90e:b0:50d:8613:6830 with SMTP id
 71dfb90a1353d-50fb5e4b319mr1856691e0c.5.1729586045654; Tue, 22 Oct 2024
 01:34:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Oct 2024 04:34:04 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZxZP01C-9RngukZy@pks.im>
References: <20241021124145.636561-1-karthik.188@gmail.com> <ZxZP01C-9RngukZy@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Oct 2024 04:34:04 -0400
Message-ID: <CAOLa=ZSBg9Ji5g10M9vxC7UzMG=rHsNS31Z_obpznfAM7RHrXg@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: discourage arbitrary suffixes in
 function names
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000dc3f3706250ca16b"

--000000000000dc3f3706250ca16b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 21, 2024 at 02:41:45PM +0200, Karthik Nayak wrote:
>> We often name functions with arbitrary suffixes like `_1` as an
>> extension of another existing function. This created confusion and
>
> Micro-nit: s/created/creates/
>
> [snip]
>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> index 30fda4142c..b8e2d30567 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -621,6 +621,11 @@ For C programs:
>>      - `S_free()` releases a structure's contents and frees the
>>        structure.
>>
>> + - Function names should be self-explanatory, clearly reflecting their
>> +   purpose or behavior. To maintain clarity and avoid confusion,
>> +   arbitrary suffixes such as _1 are discouraged, as they provide no
>> +   meaningful insight into the function's role.
>
> Names being self-explanatory is certainly a worthwhile goal, even though
> I guess that it's a bit more on the idealized side of things. Functions
> will often not be fully self-explanatory, which is likely just a matter
> of reality. I mostly just don't want us to end on the other side of the
> spectrum where we go militant on "Every function must be no longer than
> 2 lines of code such that it can be self-explanatory".
>
> And yes, I'm of course stretching what you are saying quite a bit, I
> know that this is not what you want to say. I'm merely writing down my
> own thoughts while thinking it through.
>

I agree, going the other way doesn't help either.

> So, that being said, I agree that we shouldn't use arbitrary suffixes,
> as these are quite hard to understand indeed and typically don't really
> provide any context. So as long as we interpret this rule leniently I'm
> happy with it.
>
> Patrick

I tried to keep the wording to also not just say "it is not allowed to
use such suffixes", but mostly to discourage it. I guess we can also
iterate on this as needed with time.

Karthik

--000000000000dc3f3706250ca16b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5ddff5d972a486b1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jWFkzb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1ZsREFDajFpYTU4d292SWpZYnVJVnNnRklHZmFQdwp3TjZxMkZpNVRJ
bS80TjZLZlorb2hXaXpYNHh5ZnJaNjRvbXllZGZzRFdyUlVac2ttWnlQUUVIdDlreHNOWFc1Ci91
c0Fwd1hJL0IxZUVjL2d2eHFEbWcyeGVOVTFpeFlsUW9rWEo1RE9OcWswWlRmSStBbDBHTnZUMmM1
WUs1NFEKa1JPR3hpdkVKVC9yRGx5N21OOExsM3hYMlE2dU85WEhSOG5NZE9WRDl3a2ZCK3dYNWxo
UG5STFJQb1NPdW9hcwpMMSsraTQ3MjBUd0YyaXFKK0dWTE5yaEIxRFM0MkpkbHpvUXRwL3FhSlpz
UEF0VmliSStkc0prZllZcFNySWJBClg2RXkxNHowYUpzcjZyUUp6MHZkREZCVmpKbWFLblhKWmFJ
dVBGaVJHTUNqSkkwSThTaFNHY3BERmdnRXFMWFEKbnhNK3ZiYzJ6UlZFVXI4dGkwVGgyRjA5T1F0
b3hVUEJLWDluVDRuWlBYSThPcGVpTnE1Qk96eHVYbWJuVWxuUgp2cDllZzJnTXJ1NmdRWmtCQ3Jy
dzFZNitpYmVEa00xRDh5RjNDZE1ScUdsUG1ObkNlcEpGaDdVa3lrVFEzYmJWClNMMVY0d05CWnRW
cXkwZnp6cnFxS2xoS0lVL2tCb2IvcnhrSHg4bz0KPXFWT2cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dc3f3706250ca16b--
