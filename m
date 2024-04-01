Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B41CA80
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711967908; cv=none; b=aSt+X3T2uJq4jRF0SKsLrIjV9DdIscB5r/cEGGJc4hWiVujLUjQ9Afmmosbb5YEmvzNUb+7ineHNv0I5Xp+1JHn8sbcFPkSE9XU91d94ohbBUu0ZxofBTOQaUCWVHYwYiEi2UqVBQEX12cHNoOQsEti7PBgI/jGEpjqKqfIzZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711967908; c=relaxed/simple;
	bh=n8zni/9fTonXtyLGzBLiUq9nyAjde4Io2Ck8A4+nxOg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJrCxqDe/XfAWuovRHFEck9bgweiW+L/TyGIDGiBXHzrIOXos11qOrW9Ymg2BDjTpUtogABPo3lvvrrmvR2Med/r4fWHQdsIPtgEmp8OI+G4ib4aCLGIYZl2S59X7Yi6MWiAW2/Njf/MaSJmagYUhn0pHB4GPFzolfbyICCXcaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ancB3vAa; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ancB3vAa"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a4a14c52fcso2092743eaf.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711967906; x=1712572706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AV7ai/oTq1SOt97XCYcqSxsIXV2m0qDHpMnaUvIRRIc=;
        b=ancB3vAaqI4nuLiQJR+ort2aGcAhlbwOqvMnYcdn03xaI+2jsH1Vyj5N1BY7vj3/Tw
         cf0Ya3ixytcseKITZ9g6BKmC09gtcGs1vrJleiZO0NUkH+FrcPSKdKKV41I+uycJenA7
         z13ekRg2YTZCyIqcRYFKB5snw6vLj+VHHxZPcc7dyHEjViEwbSFICuGoLjdp2e5x8p2B
         vwv7kqAdCmWAEnv+WnQMCsNFzqZbAirAOw9p/qKsO0MYP7POQkL1B5c9uT0JHmxzwKX0
         +BcBmC73qJ4o9ehFqG3i1ZdfSJUignyZ9xaO1AHRDdGJyNsNa8+I18kz9zyddgojSHP1
         XsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711967906; x=1712572706;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AV7ai/oTq1SOt97XCYcqSxsIXV2m0qDHpMnaUvIRRIc=;
        b=MKDXJBysR6r4e42zEVLFHsHjatfTM6BnL9YriFVSWAlRk/30zJiNVJre/rWsGQ8bHB
         +GFiMyUz0mKWpDbKrFyQazzpNRZ0tznTnER/EZoRd3OIuIQUNOU9DJl6DAFGsRobfSDa
         ZJJUTxOdQ1yOi1crSPapcDq7NuTpEXiPBDKj+7zBE0/U1nWG3MYNnIs+g6mHB1nEEszK
         I01I4/YUAvyyrOrRWTpxpolNsr6yP0eeD3/1oy1GVfAQz8T8gxY7qhrwfygMXjCGBtca
         4TGYTf3tfOFokLt3r43ZdUGefUygkzN4SeDZgi2cBLkxeXyJAoW+o9oXFBShMC1iID+6
         yqsQ==
X-Gm-Message-State: AOJu0YzozgiO3IWS2GqY2LzPGJkss7QDz0cFSTsg6RNnBwmcnTa60+mt
	oY3ne0CSKZYynv7pfmoBLw9HHJyJYj5himbu6D6/uteqwv/TwZ/qYsfd6d1u1amWNKBnZdpkKFz
	Y0FqTIe+iwdUSI6Q5ijKzgTiamtM=
X-Google-Smtp-Source: AGHT+IHoCFSpOnYOIZHjAfKxCMbL58vyT6snVeYxe67ikY62ysDSFWP9eQnyalV4+CGKGP8H4bADRUQIbjtlokxt7MA=
X-Received: by 2002:a05:6870:42:b0:22a:8443:45bb with SMTP id
 2-20020a056870004200b0022a844345bbmr6201495oaz.47.1711967906264; Mon, 01 Apr
 2024 03:38:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Apr 2024 03:38:25 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAPx1GvdXdH3OdY1nC2ijVSdpWfg8jn5=j0KB+Wgv70wWeCNH5g@mail.gmail.com>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240330224623.579457-8-knayak@gitlab.com>
 <xmqqy19yf40l.fsf@gitster.g> <CAPx1GvdXdH3OdY1nC2ijVSdpWfg8jn5=j0KB+Wgv70wWeCNH5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 1 Apr 2024 03:38:25 -0700
Message-ID: <CAOLa=ZRiTVGs9k5O0+RcNSnu=yyVVS8F2TF+VZOtPGg6EaDDLQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
To: Chris Torek <chris.torek@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000eb98230615069623"

--000000000000eb98230615069623
Content-Type: text/plain; charset="UTF-8"

Chris Torek <chris.torek@gmail.com> writes:

> Meanwhile, for testing purposes I was curious as to what happens
> if you ask `git update-ref` to delete an existing symref, so after
> creating a test repository:
>
> $ git branch
> * main
>   symref -> main
> $ git update-ref --stdin
> delete refs/heads/symref
> $ git branch
>
> Whoops, this doesn't look good...
>

This is expected though. Remember that `git-update-ref(1)` by default
does dereferencing of symlinks. So in your case, 'refs/heads/symref' is
dereferenced to 'refs/heads/main' and when a delete command is issued,
'main' is deleted.

Try the same with the `git update-ref --no-deref --stdin` instead.

> Restoring the branch name (I had saved the hash ID Just In Case):
>
> $ echo d88ee82e6a5c29c95f712030f5efc9d43116ae79 > .git/refs/heads/main
>
> brings things back, after which this works properly:
>
> $ git branch -d symref
> Deleted branch symref (was refs/heads/main).
> $ git branch
> * main
>

Here you switch to using 'git-branch(1)' and that doesn't dereference by
default. So there is a difference in the two attempts.

--000000000000eb98230615069623
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d4643200362750a4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZS2pwWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3JTQy85ckRrSVpiamNieVYyb3JBUStsWEFXVlpLdAo3U3grYXBBRHM5
c1FreWZzS0N3MC9KczFjcTVQdUhycnl2RWhFWGhOYW5Fa0RIWE5VRGVMcFhSM0xJM1pvQjNjCnho
UmJDMnV1WXJlL2ZTOXRVTm42R09KYWI2ZHRSYW9EV29SSUdPSFNvSlBaMzhRcUR0d3V6NlhINjdj
R0g5dW8KNjFiOS9NbXliNVZVd1hMSURFTU1WVHE4S2ZHeTRTSDdJUjM3MGhWM3g0WDdiVUxyUCtZ
Yjg4N2pHRzBwOHpyTQpkWVdZaXZLVHpsOXdEMjdMa1p2c1VGSXErSlNLeENRNGRZanB1ZHZrcnFz
SUtUZ2lIY01xZ2NITDBlNmtjeis5CittbDR6V1pYR29YcGZvaWQ3TlVKNUxDanJWdFJHY2FnVDRv
cGhOQk56VldzTUZJVWdGczNVaEN2bDRwTWlTVGUKYjU4L0k2d0RWazh4VDdtTXIweGNLbXp0d0hi
UUdSQWlIS0oycllsVHF1ZFJ5OFhiZ2RlT2VWRDBHYk5sMGJYdwp3R0U0VWdzTFhxQ0hXaUFuYndv
ZDgxSXVJV1FMZER3Y2JhUG9WSTFhdUJoYlJWeFFhMk52b29kamliNW5ZTWFvClhYb2p3TVdNR3dB
NmlBdGE5RGlNYWVqV1AxOW1ocGhlTHR6ME9Udz0KPTdxOFAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000eb98230615069623--
