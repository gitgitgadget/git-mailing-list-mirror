Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AD31A8F8F
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733342812; cv=none; b=Ply+vC+rTtcLUHZ9BzX1UAiuJPdSv0OD9Bl30qkPivRVBnCzLTDM1aQRqJQAj/jekLKPf0GpnEGJBUOUo8wpoin/1OftYMusNl/0EOyQnIUDAK8IUAAtu8i+fROf8+tj59wZ9sUq1P50NwLC7FiW/H1+fISqde4gCLoei8z2fg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733342812; c=relaxed/simple;
	bh=PPh5bEHOuJmXGFapRiTyBIZ62aAiutA/0225BoqwMXU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgTiZ6eM0krGT2I6NlXUZv4ENOUoV8px8lq04iviRqQroaBiWyYMwQW8jXy82O3/H4+WotTSD/Dqcb/Jiuly1uxGgIaSzbhAUqzY4WwgmVPrkozu7zzONJSKLXX9Pv7/N1RCKw/qVI/QlPZsPts/5bFZLhTiJDhZqkTYgjDkO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZnCiOtF; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZnCiOtF"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-515e0a816fbso37137e0c.3
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 12:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733342809; x=1733947609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQAlRRvAjhBzEeRLBq9g/twPbLAwwht7zju8QZ9kLU0=;
        b=SZnCiOtF5UdGOjGPCYQihnDbeEwh0WnVfAHXO4IfTxInUV48cTrJVenpvoR79wKGLz
         MM8nJ1IINTtwA2mZKwpW6di+dbtuGh8LcqORD4I8Js71rkNfz95+U5xg7ivwsLHv8KmY
         anx45MeK2Akzt+lYtYznpoJEszOEBwTHa4MTMMLBNvkktF23Rod+O0IM70RPvnCHR7nr
         CrOuarcpr9fwFWuUcWa15LmWiMMI1WvNR4C44+VVh9Dk0pJjZ+WoEA6EdbT2ykPv9ACF
         sHuXvHU3Mo92w/d2OYqdhWw7HEx6vM6sbRsICRPq69+VStZEIKMyWmSaYvzXRbKBeXff
         ID8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733342809; x=1733947609;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQAlRRvAjhBzEeRLBq9g/twPbLAwwht7zju8QZ9kLU0=;
        b=Mgq3/ff7pwqDJQRs8ta9Ni5cLPMmVdIQxcQ7NYT002VRH5S67beUxnZLF9t5qULpJH
         jKOUe2a+QmBIrUMQRyOgMj1QOzbBtehEazE7ac8n/bswdc/9gXzu6dGnMPDz8Bez6O60
         jf33lU93iJmGOmYEUMJ/7Q/2d7gnDYmOWDJwwZiJ+g7kIgBCq2/J37f73wPTS5N5WCF1
         VmtHD9srEOPWzJAwCLVkClREUDIt5fvzD5MxecEOOv5dcDSJuZJx/QsftjQQCxkBc/K1
         DZ+N6oBd696YFd14tl44aHXkvaREWpbIMHM86NmbPzLYLnhSCwxcfJ9m5QHr5eeNX3We
         X1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVysMQkpBE9N5LC5gbhFRT8lX5AZJZV0SUB4d2TKLPnhFGPxW5sa0vCYpUUUcFv4JScYUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXvQBbEX2zYe6CNXKzrilakhUZoQw+8xlaYwrtstYM4K1MV7F/
	cZJDO3ZvHizEoyhakyEq/ItuxEwBwzghvv1SvnW7RICtn4VDkpWZbkxxrpsgWzvQN2RQq3Mtxeh
	EHiLhiCwAgSMOpVIwqyeCakD9xeQ=
X-Gm-Gg: ASbGncs+M0y/RTzGPXu6jV/X5qGw3LreUxGoN2bFtlVEFzJbvZgkkig3zZmOO85l+3u
	eV6IK22HE8iN17MFndIdaT2J3ILwuWSkXdwwoI+X/SiDreZvRl/HCEG3Pnbk+/GZD
X-Google-Smtp-Source: AGHT+IHXyyTtWyfewITDVs6RAR4vGxDlW07zqwxTpARx+1vd0WhNPF0Rdaq8GFxWBubFNPUN1JW+ka9SxwIiXtMrBQc=
X-Received: by 2002:a05:6122:1d46:b0:50c:4b84:dafb with SMTP id
 71dfb90a1353d-515bf57ac1amr10127289e0c.10.1733342809333; Wed, 04 Dec 2024
 12:06:49 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Dec 2024 20:06:48 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <454b070d5bb0f64e11cab993b126ef5d37a3615b.1733181682.git.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com> <454b070d5bb0f64e11cab993b126ef5d37a3615b.1733181682.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 4 Dec 2024 20:06:48 +0000
Message-ID: <CAOLa=ZRTgJafxDTB_LWGJxGZ_YOP4fO3=s14BHNvPaHEqf4Q_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] pack-objects: create new name-hash function version
To: Jonathan Tan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, 
	me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com, 
	Derrick Stolee <stolee@gmail.com>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: multipart/mixed; boundary="0000000000006cbc32062877523e"

--0000000000006cbc32062877523e
Content-Type: text/plain; charset="UTF-8"

"Jonathan Tan via GitGitGadget" <gitgitgadget@gmail.com> writes:

[snip]

> diff --git a/pack-objects.h b/pack-objects.h
> index b9898a4e64b..15be8368d21 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -207,6 +207,34 @@ static inline uint32_t pack_name_hash(const char *name)
>  	return hash;
>  }
>
> +static inline uint32_t pack_name_hash_v2(const char *name)
> +{
> +	uint32_t hash = 0, base = 0, c;
> +
> +	if (!name)
> +		return 0;
> +
> +	while ((c = *name++)) {
> +		if (isspace(c))
> +			continue;
> +		if (c == '/') {
> +			base = (base >> 6) ^ hash;

Just two questions about the implementation for my own knowledge.
1. Why use '6' here? I couldn't understand the reasoning for the
specific value.
2. Generally in hashing algorithms the XOR is used to ensure that the
output distribution is uniform which reduces collisions. Here, as you
noted, we're more finding values for sorting rather than hashing in the
traditional sense. So why use an XOR?

> +			hash = 0;
> +		} else {
> +			/*
> +			 * 'c' is only a single byte. Reverse it and move
> +			 * it to the top of the hash, moving the rest to
> +			 * less-significant bits.
> +			 */
> +			c = (c & 0xF0) >> 4 | (c & 0x0F) << 4;
> +			c = (c & 0xCC) >> 2 | (c & 0x33) << 2;
> +			c = (c & 0xAA) >> 1 | (c & 0x55) << 1;
> +			hash = (hash >> 2) + (c << 24);
> +		}
> +	}
> +	return (base >> 6) ^ hash;
> +}
> +
>  static inline enum object_type oe_type(const struct object_entry *e)
>  {
>  	return e->type_valid ? e->type_ : OBJ_BAD;
> --
> gitgitgadget

--0000000000006cbc32062877523e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ca02277d8f521cbb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kUXRsSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMm9EQy85WGh0ZTlQUFl5eFQzMVdBNm5rWEtQNStUegp2d00rWnhxK3p6
dzVyQ2R2dTdraHIwaDNYRTdJc2hTMU5PaFQ2SEpwQlorTGlSWDUyemdYSHlMRWEzcHRYRllDCnNU
dVNFMFJyTmMyK0NLbjBjKzZJS0k3SkZoNkJnTDNrRVk5RGhMekNjaFpSVlJzRXp4ZmlrZW0yWldn
VjRIbSsKcHF2YzQrUEJKa2E3ZlI0TS91KzZBZFRIM2xCMjRPcTA5ak9rVVVMeEIramRZb29BcG9y
MVQvWWU2ZjIzdEdTUwpwZ1RiWTVROEJhS1piakUwc2pLQnBtR3oyT01Zc29ndWdqRVRnWVdWSmNi
QjFLczhVU05QTkRRUTM4T3VUdkJCCm4rQnNsWFhZd2hjRHMycWJMMVJDcHA5QWk0T0pOOEdEUzk1
bUszRzFFMVM1WkNSdXZEdGg4WS9uQjQ4SWpFQjkKM3RFUVFic2xFRS9NRW1ubDVYdEdQMWJ4ckhK
MEZEUVV2aWE0RkhVN1k3R3BJN2dDdngzc3BnWmtSNnRURklYMApjRXBkKyt2RDZ6bVdnSEFjYUNV
aXJJa0p2K3FWTmpicGswRUhNZjR6eXRKaVMrdktsQi9iREdsUVJBNkRpRFJDCnM3L0drU2hsTmdN
S2JrR0FQdkhCUE9IVlNWMjdhbFhLR2kyaUx1QT0KPU12Z2wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006cbc32062877523e--
