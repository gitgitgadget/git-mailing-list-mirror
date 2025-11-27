Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C823C8A0
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764279954; cv=none; b=Nrwyg1Yg1y1yCwImiGFQFLpy4FbuSWLYRZ4rje1JgcLI66bMjEbqNxWtJiYpJRe2nPn+p3zQGgcwma5y4gep7J2yfeA2nQW7iern9SmvInSkp8fH+PguCURbjQ60dGnQiQaa2zdqLsse9lxFg7zPdfwbxqS6nLKqOqpVnKNWCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764279954; c=relaxed/simple;
	bh=Jt4tC4vuysmDnbN/p+8tjoHmmCyVkU5TRPj0LzODBQI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgt/Ln5/Di2j6p+CcemvYS1KhDuYmIaePCOYm0cTQWBUroZq7SgNJUQymacjkaDpw5bBSe3PrOg+s6tHiUxi+cm59imMY8jpkweQNINIptdiB2dXvz0+PhW7dGgZYm0TspYkOmkBiAtXcuSreIErjjuW4+un9eayyac6Rp2FyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFl/nzD6; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFl/nzD6"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-93539c5e2b5so713400241.0
        for <git@vger.kernel.org>; Thu, 27 Nov 2025 13:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764279952; x=1764884752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jt4tC4vuysmDnbN/p+8tjoHmmCyVkU5TRPj0LzODBQI=;
        b=MFl/nzD6YguVuhIMVNcf+PM9KutYLO/x1AkV8hruhOBclGxzHPeXcsIpzZfkvQGxcP
         5O+x5e97jHApyvkAPl9hyY+aa7WuLQbLFaTRlRkxtawp4PRuqLLFpxBkY93zhnhYTwJA
         uMMazPJILCp5rO0zMyZd1n/Nr4g/4DT7k2nTY/WyNz0fPJ3RFULtQvcIYBuSg1oPMZVM
         bzqruMJMKkkpBlPJhLqjTbavxlfc0CY3EZuFm9WnY95vYnM7bTEQt/5fopoXJqVlJsQp
         ITQswlX5kMJAdW0nJ9V4hKDdSED5D53ye/FqIiCrG8pWNBbmWWw12w5xQpPBE+zFMoud
         77UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764279952; x=1764884752;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jt4tC4vuysmDnbN/p+8tjoHmmCyVkU5TRPj0LzODBQI=;
        b=jXHW4YB5/GPVsh3lfvVoBzqyeOIQROVRikIKIfK+kWVv5xVdY1fonsNsWwSWf0NxJS
         SaKpxJy52CWnUz0+LIwmSCinlZcFEjMW8kPjVY4Q16j515vkLoq+KWtiS5G7VXEFK4u7
         49qOtNBmB0E0mo2VgUJsZj8K49XTKItXFVdz2P0wCZBJaFcDuBzoVm7XbV8w4rKjT5Gw
         pOZYJJSww+NF86uZwCPWSWlWZ8Hzp3XpfK2XOAp4HUNhqRM2idKtYbMUQuuAETBq6cYv
         uiIc00B/Q9U2f4Gsyvldpn5AxAPu5ZuqBMn2hQ2rIaDJ3WMqQ7ByoNzN7ynlbsz93+K0
         E7Dg==
X-Gm-Message-State: AOJu0YyPoepugF16pmiysV/vx7bMAOezhWUlAPduScuTgUyvHZ0aQPim
	upd5/X/0s6Ixk0+S37PbtP18LbTHyxMK2aQXPTxnIIGGSMS69YQYpx6Y9/W6na1kU21YgQ/8sj6
	dfRAJASJ7yakDNeHS7rgsGUmxbjlCFGY=
X-Gm-Gg: ASbGnctjM5su2PCucBaixeuWEpDmvDpFE7ngOpX2o1RprzGQLQ4+2ZPBTYIrLDeyYwy
	8+nNmUXENmPnBMG4uHm0igndywK4BxIPRA5tWEtCkHu54Kc1OxlaF4op3gKzRroHfnIbgaAIlqq
	tcvI5Ducw3Dr7oq7FqhNFbrDsLFYylAQPMV27l3BV60fbCshk8uGaYbjUV1etRDCxOZybbrp/CT
	AxIpfGraCiFkEAVHyyGP2fL/O3TfzOONAxaf2gy2cTTHfNdfXrqHF69pJSVnJVjoOqmPYT/7PPp
	MK8sYnQfuqk3cU0RYj0u5U5XYlAfww==
X-Google-Smtp-Source: AGHT+IHwAKewY3x7fv1MSoydkFuzZODWr4eRpC7GuIl4mHIYrQcHbaa5Xjij15g8Bs6btEng8+5YExLav8VTUJHvmRo=
X-Received: by 2002:a05:6102:f93:b0:5db:d36c:89d4 with SMTP id
 ada2fe7eead31-5e1dcc950a9mr10427519137.3.1764279952109; Thu, 27 Nov 2025
 13:45:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 13:45:51 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 13:45:51 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqy0nrjlc0.fsf@gitster.g>
References: <20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com>
 <20251126-kn-alternate-ref-dir-v2-2-8b9f6f18f635@gmail.com>
 <xmqq7bvcpy35.fsf@gitster.g> <CAOLa=ZRPYUJu4hVuZrXdJ1vq89=Pkiyw0-As=0B6pL1-cymR8w@mail.gmail.com>
 <xmqqy0nrjlc0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Nov 2025 13:45:51 -0800
X-Gm-Features: AWmQ_bnlfOSV3sWix4VEp6KfeDd6aeVZVHB6TwjPRwK0L8WuvtXw_-azzBAmU_o
Message-ID: <CAOLa=ZQnR9s33tsUbKUevsp7W0+EUcM4x55CLOQn_A2znVo6Fg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com, 
	sunshine@sunshineco.com, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: multipart/mixed; boundary="000000000000d4895d06449a6fab"

--000000000000d4895d06449a6fab
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> (2) My understanding of `string_list_split()` was that the `delim`
>> argument are a set of characters to split the string on.
>
> Ah, silly me.
>
>> But the mechanism isn't for 'git refs migrate', but rather we want to
>> add/update references via 'git update-ref' into the dry-run folder
>> created by the 'git refs migrate'. In the broader sense, we want to
>> manipulate references within this dry-run folder as if it is the
>> reference folder for the underlying repository.
>
> OK, I took the cover letter description too literally, it seems.
>

I did change the cover letter for this version with the plan of how this
would be used. Let me know if you think I could clarify further.

> If we want everybody in a single session to have a temporarily
> distorted view of the world, it has been a tried and proven way to
> use environment variables that override the default repository
> layout, e.g., GIT_DIR, GIT_WORK_TREE, and this "no reference
> interactions go there, not the usual place the repository
> configuration says" environment variable fits very well in the
> context.
>
> Thanks.

Yes! Exactly. Good to see we're on the same page :)

Karthik

--000000000000d4895d06449a6fab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f7f4003ce1a004ff_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rb3hvMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0doQy85WHRUSk91d1lJbHE3aXFURGlWSlQrUnJvUQpkUEF1eW1QYXNj
emlGZ0FlZzJzelNPNktkV1BlUWxIV2Fyd3dGVzdYL1BtT2V5ZlJjS1ZkbVRENVJ4ZDcydFBJCmhE
WWR6c2ZFRlZ2SVBReE1zeXp4RFZRZ0g0a1Y4NGVDbS9wZTZaN0NsbzZ3bmdlSldGY0RFVlVtb1NQ
WGh3eTQKY3pheXl5M2tBZ2wxTkM0TWVUTDAxM2tKUWd1QlZieFhuMDZNV0tTWXY5SkROK294ZXpQ
MW9POVN4NDVheExqNgpTNlNBNlFWeC9qQTY4VFlmNWllTmtTQ05Gc2VNNld2UmZSd0YrNGV5elNL
MW91Q1d4cnhwdytpcWJUMHpFeFJICjlHbEdDNGJ6ZmtvNGpORzJRRU56WDBxaDRMUXpMS0dFM0I5
SFdpam00M3hwMTE1d0VUcHVBeUZXYmlQT2JMaG0KZlAyRW5nNEVUTUpxSFNOaGVPT0IyY3RGUDI4
YXROUk5BNHRuaTVKVWFJUkF3dTJQUWVJVHlWY1hqNDZncDI1bwp2M1Y2VHR1VnJuWEgvU0lCRGE5
TFhkNjMwc1c1RGJOb1VVTFlOR1F4ampFUjhKMHdMdHp5TDQwcENNKzFjQks5Clg3c2lZZytxSzFE
QjZDV1lKeFJnUHA3Uzk2SjNmS2lPZG5nTjAzVT0KPUE1a2UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d4895d06449a6fab--
