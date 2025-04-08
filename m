Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E261D5CCD
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125994; cv=none; b=XGSDIP1QEpiiM9vSr7aNKpirA1cKrOPSGIWYXBW4rQFum7BLDTeG2eSL1y9Nf+Fs1oaPsw+iCcFw6wB69dn5CBntKSspQYwvZNNpkO2USzLuSsbYa5jwT0AV6IcDaZyDsyyTk7sG9BOHOjDM1YSbI3Yyph1fMWTV/j8NGe3UprM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125994; c=relaxed/simple;
	bh=EHYmcPyEwYhRLdaOe7BlTDoqaJ7anfwOUQK2IFdV57A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V803McOX3CLMemjN7qqcbaTbgMfnXxczijXYeqa396SWSyXO/vNebZvUfvd99Dmut/4uOVq+Z0k8ab3WfQ3P8njtTTAFx/S4/OVTtkNVpjxStJEwE+hSonhX4jI9Z35sY1PbV1z0z1HRnwi2nVSRtdFsKtZq9pdxAUjeZhDqBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWEvDhZN; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWEvDhZN"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5262475372eso2623035e0c.2
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744125991; x=1744730791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sw4nBQ9E3qjPfWd5/9VabkiYBZVFWx4d3HvtQgfwRZ0=;
        b=HWEvDhZNLxQnHD0LNubj5NPgOenfZOz4IKqXTZYRntuhRKaus/ExIip/jN1TWLsjpj
         jzNc5ZrHG/t+g8muafbGq8mr26ga7qLOG+qjZxRaNZI9ratNfTbz91+PTGT/EvGGP7jQ
         aB5uLbcaycw98DAYCj+rHOh5GnRjvly253ti5SkhgWDXewgXJQQfBCe5jm+NGcozUF1u
         gm1NKc4y0Smfyj8S5NTQOJFJnjhw4cW3X+na3sZq/4gcCrjWdO1QPIU5yJm2pwSGuyJM
         4i6pRbzmRZg2l58zCe+oH90EZTnuP5s0J4wsalZR/aLSGdf9KOGsPoIMAZT0S0obSu8Z
         CIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744125991; x=1744730791;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sw4nBQ9E3qjPfWd5/9VabkiYBZVFWx4d3HvtQgfwRZ0=;
        b=BatCgmGAern4uROGo0J6yYtdHdgdJ+4Aqw3mkXATw+B2yQQvtebUga1nkMe37HUn2n
         /WiXSUmIgnhBgc2wGA9oFmFgnRGVDWGPra9HAOEifocDSsE2xO6tQDMO7Lcar1W0DCG/
         3jAbRH9BQqJ2qIfCz4UOQ7XEs/wcFoFrsfGyXpCLYVTZ5W2PMnoWU8rJ0oEZsOLaR/9D
         ZqJrLWaul4ZiJodico4jNxd/sCxLDyCFxkik63q73ayVdzTP60MUXkqSBYxGWDNSuSwo
         3nYHIJDe0Y3V2lHJr7EzrMVjhqM5Y6VeHFrYX61+/d3S3ISFyNjRXAkyk0eYP8XBc1aU
         2WeA==
X-Gm-Message-State: AOJu0YyLu/f9wxVdPrG0c/k7Bzh4bkcWmdG1gfblAAifUDz4hDcRwG6F
	5Y62ekM4QKQD+1HceNYqEkYNE8DIWLN2tJuZrm1pqhWnLiiryE+w65Qp+XqWLdy370q8k8jjwPw
	ontgeUhfjedSmgvSl+ISgemO829w=
X-Gm-Gg: ASbGncvWnJKWX+7jKEVShMNB3ZxpCEhRuy7or+paB9bX23rXfMy4Yckzew0hrX6euze
	/UqtYkrjClX3wqb/aQMtjYS62ClJ8/15h1QYHLYKO7ArfkUE8q/G4+75S7hXd1O4NL9PhmvtSz8
	3NUQh/wdeX0f2w9TH5PsPTopP7
X-Google-Smtp-Source: AGHT+IFfu5J+H9+B4WkMcvzkDelImBEGjm08Z0cvmFp3PM2GTaDdDHwc3ySbK8fN0rhvYUrFx7Xob8jl/zK3vLXotxI=
X-Received: by 2002:a05:6122:3d12:b0:520:5185:1c31 with SMTP id
 71dfb90a1353d-52765d75bc2mr12863071e0c.9.1744125991100; Tue, 08 Apr 2025
 08:26:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 15:26:28 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 15:26:28 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqfriiy9vh.fsf@gitster.g>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250408085120.614893-1-karthik.188@gmail.com> <20250408085120.614893-9-karthik.188@gmail.com>
 <xmqqfriiy9vh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Apr 2025 15:26:28 +0000
X-Gm-Features: ATxdqUEZr5OF5kMy5UAKPxh2T3kNcODkm2lSykUH-lEGJKMgwlBg3fF-l764OdE
Message-ID: <CAOLa=ZT4fOz1sd31EhyLGeyQzS6GO0aSYN0L4fdPALRixkD6xQ@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] update-ref: add --batch-updates flag for stdin mode
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im, jn.avila@free.fr
Content-Type: multipart/mixed; boundary="00000000000024bae6063245fa1b"

--00000000000024bae6063245fa1b
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Content-Type: text/plain; charset=y
>
> Please don't ;-).
>
> More practically, is there something we can do to avoid this
> happening in send-email?  It may be a not-so-uncommon end user
> mistake that we would rather help our users avoid.
>

This seems like this was in response to the following question:
     Which 8bit encoding should I declare [UTF-8]?

Which I should have just clicked 'Enter' on, but typed 'y' as 'yes
please pick UTF-8'. Which again confirms the encoding, which I
presumably didn't read. So I guess the problem Exists Between Keyboard
and Chair.

>> When updating multiple references through stdin, Git's update-ref
>> ...
>
> Will replace and queue.  Let me mark the topic for 'next'.

Thanks!

--00000000000024bae6063245fa1b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ebb945436b2018be_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mMVFDSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMEYzREFDUnYyZzJqMkZoL3J0TDREVnk3S1FIMmh2dApENldSbXlFV2pl
NmV1YTJ4UWtNOG9XVGNzd0E0RnhIdmF2aWNvdDY2VDJyUlQ4SnYzVjVMNGlLZ3Y5V2hXSVBxClQx
akczUHJMTzE4VEtjOVlEenlTM0dmYVkyTm5pRUEyN3FOSWdyaStXdkFqeU5vVkl2QTNnUHRRNDlV
THYwM2kKUjZuc1czWVFVRDlMVS81YzdhT3R2MDRZakU4WTJGYWUyY3pQSVFRaGhPZlhkSEQzK2Qv
ZXdCWCtFWWgzZ2dlTApFZjZnWjBDNHZia1QvVGdheERzaXJ0VktTc0VsUlZSUU1HZGM0MTVkdkc2
Sk5uRkxmUmgvb0xkWDVtNS9wL0I2ClBRT3k4citSb0pKMlBhUzAyM3dUWVAzMzloVUtpOGYxS09H
YjYxclNOMDRiSml6R21tYWs1dVhEam1LYXVNcFkKUVJmeEhZVWFSWGt6UmhJL1FudndhcUhiY1dR
RFgwa3pqdEc2RFJ5WjNhYVJCdUdmcWRiTnBndG50alRHdFVvdgpXU0ZYZmJDZC9kSlpxZTlFUytS
UVhMUkx2bHdYQmplWHFBMVZpSnd2a1pXQlpWTmIxVkhMWDJ6RGNKb00wMkZ0CkR3YXZSVHVrUjB2
S0F2c0JvTjR5cE9IRjNtVzBwSk52SDAvZGM5Zz0KPWlkaHkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000024bae6063245fa1b--
