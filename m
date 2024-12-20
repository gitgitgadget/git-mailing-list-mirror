Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2BC19F116
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734690646; cv=none; b=mtsZZUwkcmrSCfBRMXwI5cZiyZinOwzq559TXrqU5WpBuGSf5nZFPpZxfulPUHFDZqkgJIsHRRj/JNteHz1tzs1ftNdHNnizHxgw8z9DQZlXezNXIrtJc/HZM4D3HfJvS6Vr5NrbSRjtvLqYpAZIsX88pGKdnP3Xu3h+abMovr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734690646; c=relaxed/simple;
	bh=YA6TrBtGt1R+4IFrUSsCKO9p58cB8fJFnBOtnsu8H3I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaGOKLF5AHs+/SMlmvuKFKjsFbma9DVFXJZ7OAZr61FSxs0TJrDepp/pUmIFm7mfVRtKKcyI39L8s5XWNOJlb5lgu/mtuCNFqIS1D58m1VCocx6ENFyJ9mZxv5+WYmI3agOh+r89k1HvBaROBfpHGNBAnYR9hftmviz7V9jAGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAI9OeLu; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAI9OeLu"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-51873e55d27so960360e0c.1
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 02:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734690644; x=1735295444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OvGNdemd2QK1s9Vi/sl5UDsED86fAiM9SI2VpY9vipc=;
        b=OAI9OeLuOKqUxIIOpFPCOG3ZnBPGyi96P/iRJcgKVCGcvw9DuoJSCJYqzQkXYoGkAr
         qWhIXKLMb+oQar+qhmpzPXBXvjMNJBb/4KZpMBN0ph9oE6NPIFGlbvu9A5NjEBvVfMmN
         1zkB2MBx5Ur2S6gn5GXk97w9m/xzpo32V3ZFWJj8rTnhKMZFY3Db/hHysfOLjJY+L1Mi
         fjCY1xEdLS+D3rRB1InTGVu476Wa1aO9BP4Pt1q01B0nWoMUj0dimZUF7N3vEoTqXdAB
         GLuZpCEkxJna7BB3spgDYo/vrn7kP3gwNp1LrvuNDoh+iTvg68b/YzahG7bJX/LQM9kv
         7gVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734690644; x=1735295444;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvGNdemd2QK1s9Vi/sl5UDsED86fAiM9SI2VpY9vipc=;
        b=GTaxjEQsqKgxiDdcMf2E8A6NrnU4gSP5yMqNd93YzXFgpCbxnCe4FpZNLG55Nx7sVZ
         +ihganql65lS3h+8TU+riJt1RTsvJCfEvmvWD6vyG8F8WFYvVLVfIfqLp+KQeF2GPbI8
         0EzI1JurDY0OiRA3tcgmkWQ/w7UvE7Dtodtzkd96CFJgm+k71jTDnW+dtEhFDIx8W9WS
         dRzAKIPkGluTwG97HiUeuseYkQ2s+EAaFUJup6JcSLZ/bXsX1vItdI1uOEhf9DffnwJz
         OYg5Avtrg3Md64otNKugqfRcDT2hjW7b61Y7jtPTvdnFbsAGft6iViGKpv4pptPBwMx0
         S65g==
X-Forwarded-Encrypted: i=1; AJvYcCUISEWUdQ7MNVOo7MFS2b4axoiQQBuqrM+/GW2QcuaLcfzWY3lWxpRMlnuKnGcYcOLDjDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3w0PMe5+/SBTIo55Bzfo+V9DBcjtdokVcAF6dzUJYiaYLiHAG
	CVd2wu6NN7O8NOm14fkTeGdClBHUUkSBZv++SeI8C9wzABBJ5UagbSSEwIypxUcOXnROIhJvy/f
	AscPeE04bx0hBDvR6PkU956O+jjU=
X-Gm-Gg: ASbGncskqYJRQ69BSLmiK9jtQJDkmb955cgojvKP2IMCCBXFFauiexKNpFVa5XQSxAg
	fLkiY2U05176aKA3r3rAbanbgHkKtFwALm3v3
X-Google-Smtp-Source: AGHT+IEgMo5a+XL5FQN4Lhb37oYXWZHVkGukAehH9JPDA7kffW4V/Ohh7cROF0qdXmF20J3UnCnn+HLVGK/bBgaMYk4=
X-Received: by 2002:a05:6122:2105:b0:516:1e32:f8c7 with SMTP id
 71dfb90a1353d-51b6496ebd5mr7166087e0c.0.1734690644078; Fri, 20 Dec 2024
 02:30:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 02:30:43 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <87a5crh3oy.fsf@iotcl.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
 <20241216-320-git-refs-migrate-reflogs-v4-4-d7cd3f197453@gmail.com> <87a5crh3oy.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Dec 2024 02:30:43 -0800
Message-ID: <CAOLa=ZRnwqsChx9SiMv_95Leyijh_E7zEhkeHQOea=gjfGZ-Qg@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] refs: extract out refname verification in transactions
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: ps@pks.im, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000a2e1df0629b123df"

--000000000000a2e1df0629b123df
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>> +static int transaction_refname_valid(const char *refname,
>> +				     const struct object_id *new_oid,
>> +				     unsigned int flags, struct strbuf *err)
>> +{
>> +	if (flags & REF_SKIP_REFNAME_VERIFICATION)
>> +		return 1;
>> +
>> +	if (is_pseudo_ref(refname)) {
>> +		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
>> +			    refname);
>> +		return 0;
>
> With this early return you don't need the `else` below? Why did you add
> it?
>

You mean we could simply have

  if { ... check for pseudoref ... }

  if { ... check for bad refname ... }

  return -1;

then, you're right, that would work too. No specific reason that I added
an else.

>> +	} else if ((new_oid && !is_null_oid(new_oid)) ?
>> +		 check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
>> +		 !refname_is_safe(refname)) {
>> +		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
>> +			    refname);
>> +		return 0;
>> +	}
>
> I see you've swapped order of checking whether it's a pseudoref with
> checking whether the format is okay. I think this shouldn't make a big
> difference, but it will give a different error message when attempting
> to update an illformatted pseudoref. For me it makes more sense how
> you've done it now. But because you mention both checks as bullet points
> in the commit message, do you think it would make sense to say something
> about them being swapped?
>

I actually didn't notice that I did swap them. It doesn't change the
logic. However, for creation of a pseudoref, in the old flow, we'd check
if the refname is safe and then go to the section where we check for
pseudorefs. Now we simply skip to the pseudoref check. I'll add more
details in the commit message locally for now and will include it if I
do re-roll!

> --
> Toon

--000000000000a2e1df0629b123df
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 76944201a060387c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kbFIwOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDlOQy93T0E1ZitDbUJ6V1J1SkFWelNoSHhWV0JRTQo1S0JQeUdNME9q
d082QTBIWGtvV2JIa25pVFphYkFTUU9tUEhkWjQ4Y2ZHR0luaDcxcnZpTElqbmNyOFhIZDRNCis3
SFQ5L0Foc0RlWloxN0wzcWlKQW9FZjIvUzB1RWdnalB3UDU2NUhwcE9hTExYcEI3M1ErUTM1Sm0r
d2JCazYKU1lYbDJuckszeVdnTWVzQm8vcjU2SnRwUnRPVm5TL0gwcnZBOFZXcHh3TUJBTFJ2ajRy
US96Uzc0R1dZdkR1UwpIT3RjWHdoUGlDbXloVnJyVDA4TkQ5STBBOHZWdjlTdjFaZkNCOVVyelpX
SFYrOHJNSEsvbk1YNkl3aXc4ZFpPCkViVTRmTFlJQ1JGSWN6SU00aXR0bXFxWDZrSVEySzEvM291
Z0Mrbm9BZ3JtaFN3K3RwNnRLVTVFdVJhaGdKbVMKMk55dmZTM2tGazltQytnWTMwNi81a25Lc3Y1
ekdBYmhUS3J6Z0dyZUFwZmlIZExsNkhQbHpKWkVselMzbkNmMApoTnJrKzVnRFZRMnFralV1S3Ev
RTBkYnM3TWRCR2pFK2laZjdnVDEwV0dkUmk0N0J4QW5UT0hhQ3J3dkN6MEpXCklBRlFMUHY5Zy9R
R3hFcnlQNS94OVNqVm9wQURBdk0rbWl5aDFybz0KPTNmbzMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a2e1df0629b123df--
