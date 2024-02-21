Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AA03CF6D
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505952; cv=none; b=colbivj7ibPNgv+iAD3zD76k2V560kmOZNjcr4R1uXeMCTZzGzLg1SPLfASTJnVJECu7D6Wat2OuLr6IJ/5nmuvgy2/49L720+e2767YtVEp4uoVOsHFa9R/wWvVVkWMMOc2Xq1wMAPV/KT+7JRD5NY6qWgTNaLeJEjbnrfBhp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505952; c=relaxed/simple;
	bh=ahVJWva6ofjCub8mPGlBPDgyWk6cpNNE+KDxb2S5ze8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdPBqqhpKrXesHcJqi6UkhuxDtDWVSvveaOvwOqYKaVtJPWzicGWssm3YLX1UwDVsFIOma6sHW2VD7IHRz038bt5UxkiSMeDFFUd/8J4+zU3yr+Pe+bDxQQyOnT9M6Q30FKpsnbOwbGA9ZuO55lWshY0//WIfYuwDRk81BGCZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfGLqhhg; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfGLqhhg"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e28bd74883so3578939a34.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 00:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708505950; x=1709110750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ahVJWva6ofjCub8mPGlBPDgyWk6cpNNE+KDxb2S5ze8=;
        b=dfGLqhhgepwjOJX/PzwiUp3Ioxkhv92upkkR+ZZkx3wPpT29T5yEW5ZeRxi3TFTnqq
         PvB0mn1I8MC0bWQr6tZ7d9Paw0xDa5lIKNT+4/s9sgfnIvAnMKIMebb3yPHloSlX2bKh
         2wUijwEoWRLOKZqNyr6IkKUKKxEo9KFnYROPn2reQ0ZFbiWzdio/56g2d0Zydcs9bgE1
         fVZxjjUydlmy6n0i5ct+BIq6k2TY7/BJw617ueX+ed6WAVU/AstwHdjZPEfP2n75jm+V
         hA/XmGqJnKnHvdNxO75o8OBdDtb1lvrXTNlh5qoojfOFcoS+3EKM0pZZFYJyd7m1M4MO
         4Sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708505950; x=1709110750;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahVJWva6ofjCub8mPGlBPDgyWk6cpNNE+KDxb2S5ze8=;
        b=sc0xQLWQn383gGACHRPlNIdfJps57pzOBRT31YRShGnz9chDTYQJjkn+xZ0szmjB8c
         F9GqE59F+TxoSbIGRWtKMr/scZvg/dmdXON1zXSw30cdAS3UtbfJSFToTNKQsDJI3ABa
         iP2jo4d9TblWdQz73b9YHVTa0DROYTJCJMWprBkZ6H+KBLRelP5XpHLEA/irduzUWKon
         6YxtMPlOV3W2J/npL//rIBSS3jWlM/WMvlWBnu3TnnxP0rDamfIFdt271g83KfvBC9M5
         0rpz+7wFQ9QIcYmWwN4fHUc1ee/jSYg6uHjGk9cUDMr8sWmz7QE6H9RMuSaFaOoBIvo+
         TVfA==
X-Forwarded-Encrypted: i=1; AJvYcCVReo1cAXi7Ohx8D/CdnhjwVXAUj4e0ef9q6lmGgHqmRfrD3LJhHbRjDEqdlHh3Yi60aqXnrTT74ehcyXm2kXbBsAJq
X-Gm-Message-State: AOJu0Yz83pTl0QV0787Fdp9GEqV3nx363+M0ZBHUQi8fyi6zAuGHNNkw
	RfoR3TXv+4zvj8ul9yWzgHPlUHp8crLPcMjtr9fbMyyItU+trQrBvpb5LZoFmjAnvPoZyuCGAd5
	RLXkKmU1UjoYEFra36Ohc6jrVXMA=
X-Google-Smtp-Source: AGHT+IG/tlOBXqgXoPHFf3S+l0SIz1RKjAKdGD5Uadjk8jrmzYKfVafNfF/jU3jpJOrUQhNX4DiyuPaiwHmzUYNahgY=
X-Received: by 2002:a05:6870:219c:b0:21e:7cb8:84ec with SMTP id
 l28-20020a056870219c00b0021e7cb884ecmr6074283oae.28.1708505950260; Wed, 21
 Feb 2024 00:59:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Feb 2024 09:59:09 +0100
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com>
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki> <ZbpGzAd6FGEeTdrh@tanuki> <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
 <Zbtmoo8qTmj-yt99@tanuki> <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <CAP8UFD3GBT7s1jGOc=fe6XdYGF1c--tMBDiy_sDg1Afsa=drDw@mail.gmail.com>
 <26cf6320-7ead-4ca0-b4b8-ca7008cae401@gmail.com> <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 21 Feb 2024 09:59:09 +0100
Message-ID: <CAOLa=ZQkhj1JDGQdZL9gZ4oLFQRdENRnAyJ-OfmGTb+7biaRDg@mail.gmail.com>
Subject: Re: Git in GSoC 2024
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Content-Type: multipart/mixed; boundary="000000000000432c920611e08aa4"

--000000000000432c920611e08aa4
Content-Type: text/plain; charset="UTF-8"

Hello,

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Hello Christian, Patrick, Karthik and all,
> Karthik, I was able to get your Gmail address and have sent an invite to
> you. Could you accept the same after reading through the program rules
> and member agreement?
>

I confirm the same, and have signed up.

Thanks for handling everything here.

- Karthik

--000000000000432c920611e08aa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 50afc4bb89cd749d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YVnUxc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXZ6Qy85N2EyT0l0OUYzaXZCdW10eU93WkhieEhyTwo5UjhJRU0yV3Ro
YUMvOCtKWmxhS0FIQ0sxa29YWEJ4dmxUOG1HOHZOM1NRTHovOVl1bml4ZzJxVXhQVmV3SnlSClNV
L0xQUWZFR3czRzJWdDZ5SnptSTFqY1BGeEpyY3RKQ2JaeUZ6SzY2Rkx2STRvOFRyNzRiaTJ0SlZD
WndkUjkKVmVIS1RuYm5NeEJ2cTFhWEVFbnhLUjBqdzhxNXBVR2JzWkcrUFdlb2dHTzl5ckdJcDFl
bEprUVRFVWp1MDFKUQo1dDRpNDQ5ZWVrbm9tY2dIdmNKRUZsYTcwQ0x3RThKZjNobWJ4UEtVOTMw
RmhJRlZEeDNsUkNnTXREUkdoc3Y0Ck5nZzV0c01kVDd5alFJOHpCN1ZLZVd0UzlVWm9TUUF3MU9l
K3d3cGkyV2xyc1lkOHJVYlVoMlo3RkRHa1hEeVoKd0lidk5CaHMvY0JZZ0ZRdGlBN09ESmdFQWsr
U1RxWllGMVJPWlBXSHo5RXpXaG42eDZqUThMN2VJdUYrZHF1NQpQS0ZyMUVDRVhEaENJWWRhUllm
cWtuQnhBUUs2Tk15SnJtdmZWUWxFNnBtYzRkTjI5SnhZNGFWWWVpcmdkbFN5CjNEdUYva2NMZXJ4
dXgzMmRKbmwwMlZCV3o4S20zWEFNdGlCWUQ4WT0KPWpzNGoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000432c920611e08aa4--
