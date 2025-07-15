Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D4C2749C3
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567600; cv=none; b=qAb+iZcryr8QGCs8Q1ycbSJWZCexjSVdnaIWHm7/A6UprOyn/Xdek9eQqwXlc4IhePnlIX5z+OSuWi6J6sTa3C7jV+yKBnC4eCRpbS+6iFxcW9tHpQxLwTLGWupdzl3/FWWSNF3U1SY8IA2KMrJ6HR0o0bgfKkuX7C6x+r53oDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567600; c=relaxed/simple;
	bh=51kx1f86fdA5ewkzFN4PcEBqLkjgVQE1tzMHCO6W/uk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFrfWIkJQBXygTkkarGRTqvhObw3n0CDBSXGe61EIdm/m0wLsoIyEso3buMjWUVbhmEwlSICgf9zzuAalbJilZ4Iv6N0cDMRuvFCyJCLGtiVLJ2ZvYVSZh8M+NQwAX+g4dIhAKEkkPsGRKT8cVMixQgiK/5sYEdsTetUBxnuKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bh2I1RVt; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh2I1RVt"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-532f9127978so2270735e0c.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 01:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752567597; x=1753172397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/wWqvDGszfOp1/cXK2Nz5rtU9iM803UcUjnhUSrnyg=;
        b=Bh2I1RVtcOUQBjId8RBo631ljfM1wu3GGHg5K1Chq1pcuSo3bbLhSe27gKMOt8Q/4n
         sBXuHM6WXyeRQdIFsRAjFmtLHC2OyVcyALEw+9M1fO7KyITzDe8aW7wo59EkwbB02o7e
         FBOe4U/wmzKRL6ALSZzK1J1/vaAAjHv4gB4xnQG3yH8MdSFlvtiTIPfZRpaY5FkXrOID
         ld7X6rhOfV3R66dmXM7lqDj2oNr5YgP2URlMlxU6UMe0C9N550S+gktZ+vOSmo0DyHlM
         CXVeFWrxrmWoBgXbAsVc2Bp6ld+t+xnHkLv2Y7VMSCuoglkIYY/iiLRK0HIVA7zzsjs7
         uWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752567597; x=1753172397;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/wWqvDGszfOp1/cXK2Nz5rtU9iM803UcUjnhUSrnyg=;
        b=O720+7VAn6hWM6R9ukaa+msPxpQRCTwMjdC1/on5kVKngmxJfTbuFTri2Dr48AbaJS
         D02ZYjMIec6VH5ISecc9oV3HXrJLZBkfHAFyiNvqSS/aibDm9kCSGFwjvWK29sUMPW30
         d5NJDv+VmdonwsMhApm1NrnGtS28ePY1jOe+RwUlcuncist7tB5irUGi2ZoUqVjZ5Zt5
         cKd4n86tFdyY7mgv3COSOfMPVQMrNI0rRbMeAJT8UayvwYP2pPfchkqnCSlF3Vicj45E
         NlhVhGVQKFJKdJEWqEf3KYSSELormfNH7qwHVqT/oDKTkYCcRtdBSnrlmbPta2c50jS9
         9YBA==
X-Gm-Message-State: AOJu0YwCoOYVLaIbez0I20MJRcvkXv/H7qRrICjKR5Wqp36pAiYsl0uV
	ZqSX2/j+5W9CNnL1RPCIQQ5T+mxUsPd0JiN7idEJYa/UIZmbp2hiJSaCntMYp9vDqqA3sCl5qcy
	+cY4DqRA6bOkYnJ+E8c8aKoSs+xfT+RI=
X-Gm-Gg: ASbGncsthTsVh/ry3RlMRhkU8OSOGuK+WqAb38xEifI7LF9jQAzzcsgc2p0th0bqQVl
	B6HyHZpq/ggaFTJDiQVanCqxBDxjkw0dt6n7zBoyWPqPEvKKwaogftTDLA4eDrS6EIZz8EMvG2c
	EqGglkr1d/hdS2Quh1cQx2M+tuiCcjKPs3FndVr10hw07TUaCSTg6nU+TLNJalnhk2i+wHh/kpp
	11tWlUUvC8th6P1868zv8gi6cbvBGARFunL52fAYA==
X-Google-Smtp-Source: AGHT+IERC+JAsGb0W17QmPxCb6zjEqT4Ox/zvpYRzACDWx1wpsjL7gyG2HpkhEoyqTsDTEUmqRMHCNaYdBqbtKWM5A0=
X-Received: by 2002:a05:6122:134f:b0:534:8213:af78 with SMTP id
 71dfb90a1353d-535f49022c8mr8225034e0c.8.1752567597353; Tue, 15 Jul 2025
 01:19:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 04:19:56 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 04:19:56 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD06KKF0A0WjBSw77A7fKp_pGJGVyw-OPd8-X92h=RSF+w@mail.gmail.com>
References: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
 <20250711-306-git-for-each-ref-pagination-v4-3-ed3303ad5b89@gmail.com> <CAP8UFD06KKF0A0WjBSw77A7fKp_pGJGVyw-OPd8-X92h=RSF+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Jul 2025 04:19:56 -0400
X-Gm-Features: Ac12FXwSpacXLxniDH9VlakkvcnUA2wfwa09efEq03kHUtahj9gaH2yzauYpgiA
Message-ID: <CAOLa=ZRgrfs8vip20QuNNkx9CmpUK392EV0vBkqu3HCyn4fXxQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] refs: selectively set prefix in the seek functions
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="00000000000015ed830639f371ca"

--00000000000015ed830639f371ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Jul 11, 2025 at 6:20=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index 03f5df04d5..90de7837f8 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -353,11 +353,12 @@ void base_ref_iterator_init(struct ref_iterator *i=
ter,
>>  typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
>>
>>  /*
>> - * Seek the iterator to the first reference matching the given prefix. =
Should
>> - * behave the same as if a new iterator was created with the same prefi=
x.
>> + * Seek the iterator to the first matching reference. If set_prefix is =
set,
>
> s/If set_prefix is set/If the REF_ITERATOR_SEEK_SET_PREFIX flag is set/
>

Will change, thanks.

>> + * it would behave the same as if a new iterator was created with the s=
ame
>> + * prefix.
>
> Maybe: s/with the same prefix/at the same reference/
>

Changed it to

  If the REF_ITERATOR_SEEK_SET_PREFIX flag is set, it would behave the
  same as if a new iterator was created with the provided refname as prefix=
.

>>   */
>>  typedef int ref_iterator_seek_fn(struct ref_iterator *ref_iterator,
>> -                                const char *prefix);
>> +                                const char *refname, unsigned int flags=
);

--00000000000015ed830639f371ca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dc5c45cd0ffe3dcf_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oMkR5c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOU8xREFDVGg3RDRSMmVob3RwZW8wM05ES3I0ajdlVgpDblQ1V09GL2ZP
eTdXRVgxNThJLzhPVjJxY1pPeDdOQklDUS9zMUMyN3k1Y1lZeW9uZnJ0SGsxUDg5NlIra3VZCnVJ
OUVSTzJlYktXalFJVDd3eFVya3RtWXpPemZHcENNNDJBMENHS2JVRTNyemRmQjN6WHN5ejlXZ2cx
M3BTYlgKZy81WnRxUDF5QkhPL0N3eTRGVlkzdjJMcE1WQUI3cHIrUFU4OFBvNVp0TmwySXhNWHJQ
SUVjM1VuQTNjbW56egptUTdyRUkwdTVIY0JPVWtKVFExQkNTUWdWRm4ra0l1TzQwMWtkVGFpTzhQ
NVFwb0lDMHNPZUs1cTFuREtCeW9FClRhcGhYcktoWlFKRjJLSjQxTEM0aTBrTXliaUpUeUhCRnFR
SS9ZZWdJRTB5NWlydUpYWnZUR1hQd0F5a0VTNTEKUDAzK0RYNTdwRUxWV2ZDYXJkZzlvY3lBRkMx
SEdWQ2U4WEhES3hBQk9OamN0aCtia0RqbUpKVno1bHd3cXdaSwpXcVNkOUtjaEF2Z3VJc0c2WHVW
ZlFGTXBvQ0NEdEhyaXpCOFFOb2p2UHpNZGt6ZEJHQUVQZFAxWEpIVzEwZDFXCkhCaTZZYW1HQURm
cmwwMnpQQ2lnN29SMHpJdllBMktvc1d2dzZ3az0KPWxackQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000015ed830639f371ca--
