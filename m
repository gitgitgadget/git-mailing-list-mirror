Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A91DDC3
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932782; cv=none; b=lWP9xBB4Fb57urGuPqZa1rLuStOx289PQxIyhGAQryI5gHsWvvFFrNrSD1D/CJwU1oRR1y2g6rkKiQmXqy9xqBplUaASra7KAUoBjOPIkr4KnF1bkuD6AbQBJzDpBfsGSIXqcH+97ncZy7LYmL8yqVtI4vqOfM1gtRHVJnJy7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932782; c=relaxed/simple;
	bh=Js/S6AF6aJO7KEUzs+VRLnM41gLjoSxLnfGoEcbwBW8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lorz73EbgJXs2E+09LCxUkQ4U1QIe2FaJy0d6ctf3MlPbqEBJ/r8ommA0PhZmuLNfZVzWUKfYhuo24DnORgSlBVs5c8frIKoLpU0qZPM/sD8HzR01++4EfTDZwS1cTPe1PS3T8FVyQH4v3uM7VQHwpLdld1d+VE6GWGyFRHfh08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCxL6GF9; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCxL6GF9"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ddeb015ec6so2302825a34.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 06:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932780; x=1706537580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Js/S6AF6aJO7KEUzs+VRLnM41gLjoSxLnfGoEcbwBW8=;
        b=eCxL6GF9avw1AJvOoaFdNYzZ+4NdFwff6a9CeYYaBFSX8HvkDa882+GuhJGzzeXoxc
         J2sLSYxC9I3yqVF0nCBThocyD1iHFUq8d4BaAzNR/oEcUTZ/Gm0sEIXS1mufuh05MMJw
         J/pskbztfXsFx+AhY/Y/ku2Od+896B1FsCGcEe26sN44CC7Q49pua7pfhLhcoH3GAaKR
         55KNwBhwkHwqttIuiridRquZBNz7rtPzzSAjYXX3ImSqZGiPX1Z8ln1WyN6p3PYvDxxI
         MaZLqCuzbdzR8hWa8Xj/3f0ymdmazmjzL/CckGnuvFOSdgWbNRoKzfarTd5CspMLAnjh
         9+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932780; x=1706537580;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Js/S6AF6aJO7KEUzs+VRLnM41gLjoSxLnfGoEcbwBW8=;
        b=rOaYfPxc/y2aLZWgtYoi2HcQmr52aZ5mLDRK620zPcjQsIGPczNl9cJu3nNY8sju2N
         4R7Ha2ZjMro1muSDUBgTorYbjW6Uh1Fs3qJCOuaHpOdzWduLctzxfw+YJwzPIociP1hR
         Xb0dw6R1NcQ3ym6lWWQM/4NT4hkFdfIF699wtypHjm0XcEpgSywzFONvI/2ZvuDcps8N
         7BZGIHr2I4lzKEw0L8fZzZ30lOaucayNmyb8ggfMITIv8CPrQaQLa39Y1yw85BUyYtRo
         DPAwDzdFRuIg+4jxSTYMENtGJX8mVtuphSppzZqgLKtkiDCRShlBQ9sKV92PAREEmO78
         FZNA==
X-Gm-Message-State: AOJu0Yx+Heo1yklmIwEAJKM/mV331W4L+9Dvq4KId4G9k+ENHi800nIb
	+wrwhJf/3SOXKZjo24x+PTUOJaY5W+qNFVGZFM7zwgZ8eMzLlvMjqIRYEP1bBDgwU/xHBmpXjd8
	jkAl6HLzQs5ZeerhG1UWE8g1Jqt8=
X-Google-Smtp-Source: AGHT+IH43UD6XyjLuI22kg5UBhdC8TBGdhMtvvDV2s1OzUlMfaMCOUuhuFzUdVvHbXDWc/u2D/Wt/TlnXXhbYyrs3fU=
X-Received: by 2002:a05:6871:294:b0:210:a1dd:f687 with SMTP id
 i20-20020a056871029400b00210a1ddf687mr4875842oae.69.1705932780532; Mon, 22
 Jan 2024 06:13:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jan 2024 06:12:59 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <8327b12a313b00d1ca392f446e13f9c1018f1d84.1705695540.git.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com> <8327b12a313b00d1ca392f446e13f9c1018f1d84.1705695540.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jan 2024 06:12:59 -0800
Message-ID: <CAOLa=ZQNptk28z_SG6BT0bvS_mepF+5dTGizCF1TBa4YBPHUhA@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] t1415: move reffiles specific tests to t0601
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000650c9f060f896d56"

--000000000000650c9f060f896d56
Content-Type: text/plain; charset="UTF-8"

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Move this test into t0601 with other reffiles pack-refs specific tests
> since it checks for individua loose refs and thus is specific to the

Nit: s/individua/individual

--000000000000650c9f060f896d56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 15787c12017f35fc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XdWQrb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOUd4Qy85d0p5TW0zS2NzaFJrMkhLUWNjcm4wSDFkdQpVT3Azalg5NmMy
ZHhKdzBLclpiMTdjOEV5a045dFZmRkdLREowdEI4VFAxbzRIV0FBcDBWMXRHaFBYZC9NL1VhCjdC
WGs2SjdKZ2pWbW5KY0NybjlNMzBIOU9CZUVXeXhzZnpBYS9Ha2x1NWE2WDFDSmhneWJ6M1BQc0Yw
VWxzK3MKUkExZlZ5WG1UT3NTZUlKREkvb1E3a29pSHU5SE5JaTFpVHVPQUVnVjl5cms5VWJWN0cr
enBtcC9Gb0JSLzdTVgpXVTVVb3M2Zmt1dldsU1BFUGhhMUpqRW51S1JpbE5rLytDUEhnbTI2QjNZ
R2JtMlQ1ZVQ0Z2Q3bGJJWlhOV1J2CmxlR0VzdU1OU2V1MUlWWEhRakpRWnE5NjZkQThNb2JIZFh6
UEszcG9ZRXF1dk05SVNTYUJmbUlpUWhkdWgvRjkKeWNmUmtZazNuRWJLQWlydTZQUDdZbmNaL3Bi
bDFmQjBKdUxoNkhlaXg3Y29kdUZacFNOdFB4RFZlNnZwWDhyYQpOUXg4V3BjeFVxUjJ0OGc5WWU0
VTNpZk5nclo4a1JFSEN5b1RTSGFmTkNnY0lPVllQRi9PeWdsZHBFbmJvRVBRCi9iWUJvcVAvc2pM
eG5xV2hiOHJsSFE5V3lGMUxhcm4rRWQ5UGtNOD0KPTRRM28KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000650c9f060f896d56--
