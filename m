Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF4C1FC7F7
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107716; cv=none; b=mrKN4/+qPJpNo0P/Rmcn3BhdFBPuwMcMysuhFmMR+BrXl5pwlLFZJAbUBjjeglHKDmnaYey+kWbTK7lKjQAbvNir6VnObIhdkyenRX7WFE2qiRDMYOtYGEBZUfeqFJRisUbmEA3mZsRTfuw9aRnjs2L1fUNC0lzCH9dTRRn+3/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107716; c=relaxed/simple;
	bh=7v4NGlGY7HuWUxKHIcywDGIHkra/1+7xipsytznzfO4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwaB/IkfoNv5tWPmkGmTUHYE4cwMOjxmtMKW5tZs6eWQ2bQV/bxEQj1eJfOg6qTDEH5tdCyKWxj28OrJZazIKVrFrABF5mDHkrbzsVylSOOdbvnLo/aj/PkGCct3Av7b6UVJUsZhh/7ZoILim7Fzn5XfYkb7t8EyE3QyXyrtLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8a/GtiJ; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8a/GtiJ"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85b95896cefso325634241.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 01:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737107714; x=1737712514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7v4NGlGY7HuWUxKHIcywDGIHkra/1+7xipsytznzfO4=;
        b=M8a/GtiJnWC3fxzaWbVmxPV9S1hNLRrLQBA0pQXASgj8JCuAYqHM+PaoF/Bal4s1kb
         jxk6OdLWxm9QXQdLSvgrAuD1oZNU1DApZ8LppS4c3jb7dRHs3BVy7Z6WnB7UxlQDifRP
         SnybIEDAEX4u0mL6YIP0DKEh6cravFBqsMSqEuE0Q/wLvzWWcGVQGBUOiO0kTFP3YwMd
         26ClZaGKirtRmvRSEmTwc3WeA0mzMm2StgIYRvlDcvul4v7wRcERLzmnKXbGfitc2x3W
         wI/TZiVkDNowv/wI72/7tCVDZhC4j7n+kGDEmM5nTEGrcOaVKbN6d/fSdsZE+TV/8O3G
         1IQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737107714; x=1737712514;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7v4NGlGY7HuWUxKHIcywDGIHkra/1+7xipsytznzfO4=;
        b=B8vq8XXcuVNH2k5MiAxqrh+d5oAmawADQrDfPdp/2Z+MK0q4zJ/XaazCbpq8fTD+Qa
         fCJLfTYWOD67IIt/RBPrNeD6XIUN5B2EsQQFtlb6P8FVIGlLUcCpGojE0rJ87yZEc7Jv
         rOJzFAVB/+yZAP6QJnwO3WX4QQE9ujvryoti+xOF1dK1mD/M6DO35AX+GELsXJ5YNx7w
         u18k7dNpIHnY5FQ3+unllF8COMCu/PbQrgAkbzhCUei0pIb2vdXDEZAo2Ys+stO0palc
         d5iQBmlys9VTfOyPS76KIUIaaP/o16606//W+VjcXSvg5HMLgswKoGqcTxH52XoW6lWp
         xYVQ==
X-Gm-Message-State: AOJu0YzWjFmWbOqOJ04FOkfYvzEuEOkVjF+seJ7m5qX2MG5vMJB8AT02
	OW1dw4t3t9GgjhWsWTc1OB3cF8Ie8+Z4MSbpPBmuBgd62aZtbOnY+tDhgUtW0VMZ65aT7l9iym0
	YS5ZQN2GCbzEXaXcBfYkrIgLS+yHymNTP
X-Gm-Gg: ASbGnctjO0pEy3te67AjqSplTWY0hNY2KiQFEMsKBTozrDkfCB8tjVPkrKeg1DSOzJq
	GbDae8abyRDQ35IL+y6rMblg8fiORbhJa3d0y5iU=
X-Google-Smtp-Source: AGHT+IHMgaUXMwydUp3DUWW519Gm7gCFnHEJBjikATXqW3iJAmKhBzLZEEtU7Qpnv8XOx18YxsstGOokx+fWEDDyqWE=
X-Received: by 2002:a05:6102:304b:b0:4af:98c6:bc97 with SMTP id
 ada2fe7eead31-4b690cde005mr900386137.19.1737107714253; Fri, 17 Jan 2025
 01:55:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jan 2025 09:55:13 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z4onCYz5zD0L1_Q-@pks.im>
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
 <20250117-kn-the-repo-cleanup-v2-5-a7fdc19688f5@gmail.com> <Z4onCYz5zD0L1_Q-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 Jan 2025 09:55:13 +0000
X-Gm-Features: AbW1kvYstceIO0xpob9FKiJ1cnL_MsNAJoRN_XAa274m1G9ignEQivw8q3wgvkI
Message-ID: <CAOLa=ZRaJUHCANv9ot6FbtgYnEDVV3itWnF--0g3NikLZkohmA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] pack-write: pass hash_algo to internal functions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000003ed8e5062be3e8fa"

--0000000000003ed8e5062be3e8fa
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jan 17, 2025 at 10:20:52AM +0100, Karthik Nayak wrote:
>> The internal functions `write_rev_trailer()`, `write_rev_trailer()`,
>> `write_mtimes_header()` and write_mtimes_trailer()` use the global
>> `the_hash_algo` variable to access the repository's hash function. Pass
>> the hash from down as we've added made them available in the previous
>
> This doesn't read quite right -- from where do we want to pass it down?
> Other than that the series looks good to me, thanks!
>

I should have s/from//, but let me rephrase it to make it clearer.

Thanks for the review.

> Patrick

--0000000000003ed8e5062be3e8fa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 50fd28ba85241bd0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lS0tQNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEhkQy8wVFJqR05zWnVZQzJqY0xGS3JPVkVLSndzZwp0TCtWR1E1QnhC
ejRUNzlldUxxVHZTeGJTcnpZSmhBOGZBVDNxdTlCUVIyZlRVdEFVNmhWNGxHZUxpS1hUNmlzCmZt
MGoyQ3hjNjFYazAxR2FBVjhzaSt4MVlxcXQydVVLaGpOcllsUGJYcThLdnZnM3pPbGZSK3M1RU1W
bGw2dmMKdXM2TzMxeXRLenFpVGlKS0RjdXpxTlNFOStvVnhjMDdac2xyKzZpOUJZR2Vja0RGM0ZC
cEtDN1E2am5wUWlucQo1MDNhR25KbUFWUHFpV0o4ZmtlZG9NVjBIQVNPWEhJWUthaW1Tc3p2cXBy
Skt0RGYwV3pMM1kvTEJzMHVybjRFCnJEWExGdUFhZDVLNmkraklhaGdLS3hNbHU2T29aMmZMSFJF
R2ZJTnMvODcyOTh1TzVmaWRMN2N2cWIzeitFYzIKeDY1ejZIZ0VPRVpqaG9BTHRaVTRockpZcXNK
Zkt3cE1xN290MnJubTNTWjdXaWVVUlJHOGJzLzhJTzc3UFVFNgpkTTFRTFdsL3I0QkdEOU1BUmdM
d04wb0doSThwSEVPV2FueHV6eGxOcGhTTndQQmZUWDdmQys4VHpOazZ2M2tQCjVlVFJIYVhKSW5y
QUdXbkJGOC93WlprRm1yVG9TZXl4cTVZTDlFMD0KPWZrUUYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003ed8e5062be3e8fa--
