Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89B18A93F
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753862131; cv=none; b=O1/g64Rdu1oJlsRNn7cHmCNDlv3/EzxTaA2sjK4MqtM9rttOaJcNOV3TmihNdq2mUV49+tmKh/Ra6mZYk4FB3ndEuZmNwETOu0meJIiXM/2W83Z3LkVpBmRZD8aD06P1MyYxZQ3A3KczSmavnPBOtOzYurFo1TYqTUWbFkKb81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753862131; c=relaxed/simple;
	bh=HLBgo8WoHmQBGtygxwgLoDXUsBZhkFCtmjRYBBp3Yb4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qp1oLtMvFhug/0tFGgC5kLEvNwAGi//zUAybO5wE3OaYdzT31qO6YXB3rVP6UKWQcr9dTQ7esz7WteWFltdSIhNsZ/3wJBbHduc+d1kr/RXlCpSgpwUoIfD3ZmGHxgDJDhkZNScux6sLNDEmuRqrHBlZvHiPdhhw9Llbl5S3a1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6Drn5k9; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6Drn5k9"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-53924027b19so117538e0c.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753862129; x=1754466929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cMek4dYdkiostyfp/JddFt2g0wJEkO8/61GiE//s5mk=;
        b=Y6Drn5k9cnO6yspVVkWIv6RhhJqpsY6qKHi78Dr4xHNrN1K3xMbkeJbo+J2oMPhil2
         NdruS0uXYFv5KcIlhJwQ35DoT/aODwhZr1ARWly3c6Oe+8S0dQJ6bReh1YsW/tvZkq4I
         3fZz0Zq/UD8ZtHGI6nUWWLR7xID6FaTpUaVXsfxgh23pGBKIeL2+gX03LRfh9sl59/o+
         /pTDZ4SHUGVopRmR1icQKXD62spvHuBzlDQ2EeN7KpUU7ybgdET6htnVzZ14Z05hofyo
         kVLvEYHS5dmvnXAUIZzjoQxsGx0t2zDBNVhr2KQrbyG7GDPKbDlkkGi3M6GjY/FH8IF2
         CpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753862129; x=1754466929;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMek4dYdkiostyfp/JddFt2g0wJEkO8/61GiE//s5mk=;
        b=mvyzzGP+5oHM5tpwHjH5reXfB1arJsHoe68kxJ+EmheNbqc0t4aBAE5YxZfl9/CQRv
         LquRu4n9rd0e+ZS2X6pwnElkDIqbiwlB8v86bziOdOydJK0tEmLyTXqrCj+R+QyVDmn+
         RuLfWsVnr8i+5Id+qJ4Izc4h01uSBTL+OUY55sP1Gke5SKGYvaWw+Fr00SgpxBvM49E3
         kwVeaTD/CjjhwcGqPTNdCn0V0iifQ9LhODv+QnIHuVLNiarBfpXB5XMh/8xguO/Bc3Ai
         O8FH9hoOAOrFB0CD3n5vT6hviP/BGdcMf7+p7TKJhfNZOYPM7k/U684qk0KP1ZuXp6p/
         442Q==
X-Forwarded-Encrypted: i=1; AJvYcCXA3BaeYLkCpob7gHVgyFrx81YkUOLse7nuRkFHB27RTIbxgq+QklYf0vHl24tB6p2qh3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrMvf/moA65FoyLJBE9UQW9VAwW+qapz9epCeanYykJs5cBvKu
	4y7x975tFtibkS0f48S1f5dnqbCDf/3NV7y8C0tBO4OckvYpTqck8ImkHE0CAcyv3+vpsSCtvVU
	dbuCwSVtgJXrqPg/WzSSs5NkxSIbnZVkfzcG8
X-Gm-Gg: ASbGncv6JUFK5tjA2fIU+Sm7+rdKEViPrNEnXhwrD5661Tk1BWoou2YHWkwfQ6SNNv2
	IIFdClfVKmfABixXs/jOy651mSMErad/aioV4NulgV+e1cvCa6HDrSBVKoNC+KJ3GtNzvBxgyFX
	T/8KJ509vNaEqwBA3w13YbiIEBGbVEyz7VN3Y+KHZgcLfpRDTxGQQiWxCu0xjk0fbQLv7AA4gYh
	YhhmNu2kdTA1AWhAJRoFH6taJLqnyKBJ9e7bxEGzw==
X-Google-Smtp-Source: AGHT+IFvJWMH6SWcy5TXHf6YWV+nmFG1By/Kwm5lG7wBGj2wjMsoW7KPWRWwyaOUA1lLb+T/HJ2c6V1D6jsRuiEad98=
X-Received: by 2002:a05:6122:130f:b0:531:3981:fdb9 with SMTP id
 71dfb90a1353d-5391ceefcbamr1544645e0c.4.1753862129058; Wed, 30 Jul 2025
 00:55:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Jul 2025 07:55:28 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Jul 2025 07:55:28 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqms8ot4jh.fsf@gitster.g>
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
 <20250725-pks-reflog-append-v2-4-e4e7cbe3f578@pks.im> <6414dbfd-6f34-48d1-aa3f-3fe7998f80af@app.fastmail.com>
 <xmqqo6t4up5f.fsf@gitster.g> <CAOLa=ZS6e9dv-c+tajooZa5qFZT2T+jqaJahd3BzVuE7H=5PwA@mail.gmail.com>
 <xmqqms8ot4jh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Jul 2025 07:55:28 +0000
X-Gm-Features: Ac12FXwZ4yGmy_2PwFsoDU7Il0lZ3HdiF7o_-dXHgwSokByTpAXwHs2xdSdcFVQ
Message-ID: <CAOLa=ZQfkM2PydwPFKfEqiYiCeyqmd_Wpoarr6HkbVMJnrOd6A@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] builtin/reflog: implement subcommand to write new entries
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Justin Tobler <jltobler@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="00000000000030210e063b20d9f7"

--00000000000030210e063b20d9f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>>
>>>> I tried `git reflog drop`[1] and it can deal with a branch like
>>>> `branch`.  It doesn=E2=80=99t need to be told `refs/heads/branch`.
>>>
>>> That sounds like a bug to me.
>>
>> So `git reflog drop` `git reflog delete` and `git reflog expire` use
>> `repo_dwim_log()` to resolve the provided reference.
>>
>> And `repo_dwim_log()` uses the following `ref_rev_parse_rules` to
>> resolve the reference.
>>
>>   static const char *ref_rev_parse_rules[] =3D {
>>   	"%.*s",
>>   	"refs/%.*s",
>>   	"refs/tags/%.*s",
>>   	"refs/heads/%.*s",
>>   	"refs/remotes/%.*s",
>>   	"refs/remotes/%.*s/HEAD",
>>   	NULL
>>   };
>>
>> Which means we do a best case resolution of a given reference, but the
>> function also checks for ambiguity and warns for it.
>
> True.  But as I considered "git reflog" to be a lot closer to the
> plumbing than to Porcelain, using the dwim thing smelled like a bug.
>

I agree that 'git reflog' is more of a plumbing command. I'm trying to
see what subcommands of reflog act this way, so we can take a decision
on how to move forward.

> It also is OK to update the commands that do not use dwim-log to
> also use it.  That way, the result would be consistent across
> subcommands of "git reflog".  As long as the users are aware of the
> fact that the command uses dwim-log, they can always spell their ref
> in full like "refs/heads/branch" to avoid ambiguity check getting in
> the way.
>
> Thanks.

Yeah consistency and documentation around it would be great here.

- Karthik

--00000000000030210e063b20d9f7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4bce0f72bcdb9c2c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pSnorNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWloQy85WnBuR3M1UVhIUmZBOVdzZUQ4SUFZTDRyVgpZb1JKRWIzVDFh
RjExeElscTk3d3Z2dzhjZWRIeUxMTXVSR2ZSS0ZyakVPUzVjS1BGUHZUeTcyY2Uyei82cjhDCjEx
SFpTMmdTVm1PbytBN0FBa0RTYjU1SUpDY1RXZlZHaDJ2OUhNMS9Hd2hmUTY5ZSsrdTVndmE5ZXVW
MVdoNzkKT0xTVXh6d3FMRnNHaEZHcVVPV0svVjdZZHRzN2htc1p4T0I1aVFmbVozTDU2NHBSZ0Jj
S1BSYTNOd210a1VtQwpoUnhuc1I3M0R5Um5MVEtPK2NvOXNrMmkzTFlRL0JUM2hCbG5XaUl4K3Rz
eHhheEo4VDR4OTcxVTNBaE5oY0ZLCldZSEVNUm96VnVVY284SkgxamVnamRMY2g2aXF0U2pEWVdD
ZlJHcWYzOTcwWlFSSjlwS3pFOU5NUzZVeVZNUmoKRnloMHhFUm5EcGlTRmhRamhkVGUwV2NOR3R1
VnBzRStsbXhPQ3V0blBVeXVKeUlTdGNwVHR6bThuNFRnSnM5aQppaFpkNTdwTzlrUVFnS05tTFlz
K0Era2t3OENoL2RhMjJ4WmFjZXhkYTIrUy9zdER5QXNjbHE1RnRJYzRWWXVnCm4vY0FhUyt6Ynhq
TkdNaXJEVTZTYWxaZDJUenFZR0ZjWlcrazNQVT0KPWdSczgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000030210e063b20d9f7--
