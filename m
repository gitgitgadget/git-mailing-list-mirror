Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB0156F23
	for <git@vger.kernel.org>; Thu, 16 May 2024 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885869; cv=none; b=hn40NcFIzhoEbDW6U8NuXrv5tMMxPAlGo2NS0XdMilXi4ngHRCIUcmegfYIlp/2SzopcN3TrnvpfTp0NX++5dzTN8OhPLLGmpn8oDqeLHa3W9OjIdt7TWPaWc8NxGZ6d54ylXysU74TJANCJCE84w9i2il1hNL4IdsTnktrGF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885869; c=relaxed/simple;
	bh=f4OIJq+Bfp5sCBtzYTkGHh5D3Qc87rASw2oRoAcvEi0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=D8A505yFU/6uFKgexykhnamalJ+A7Dr2xdsp3lrt07HLa2SsujYTCVaM5whJFuZ0rklKpnq3aBfMU7femm796seH44EVjg82BTJAsjIy4VXeVGmVFtxWcjyt6wmvW/B13mlyz9IHm31rA8YqabQVt/yg3n79b48LFKXJMxt6IcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBCd+XKS; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBCd+XKS"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f1016f41e2so334352a34.1
        for <git@vger.kernel.org>; Thu, 16 May 2024 11:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715885867; x=1716490667; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4OIJq+Bfp5sCBtzYTkGHh5D3Qc87rASw2oRoAcvEi0=;
        b=LBCd+XKSmmNjgYfB4oHTe8F7jabujBhG0j8C+5D82F34y7siy4TIfNy1dkNt0GOLL0
         wNop0RJyLOKs0Geh18mT3ytuM8p5Bk+iS3cfdSO9hxcFHZ5y2Tebseh8Kmjq+dqJVAYi
         3HBx37s6wJ3iyoH4c8r7Ti7Hb9gfzUM0Hl9CboUy0bOZmTp6idt/kRvd+kmigtAcdR4S
         nbc9kyZ754ae9tBFaarPeZ8HEVhiUj+gtouHDkYN9Qddj52h1DfA6uwhC2ICyHXRU1F2
         VB9+yqEMi4cEHa5YZs/1JieDRr1twOIZQf86lc/5aEdW4BUKTvpeEVwWv7nbkgHWVpPs
         g2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715885867; x=1716490667;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4OIJq+Bfp5sCBtzYTkGHh5D3Qc87rASw2oRoAcvEi0=;
        b=OERKul/my9r/AwX+l4S217a5j1hUWXV/U8THUwpNylFj+JVmXNFxsNfv+FfUXPDsN4
         iGpy0kxkKprJnYaR+cZDjuqNpwKFx6Sl93YkyhYlioWSm3AeXCLdlYjXVCMcfJSVLseI
         OF1/5AwG9LoTHnPqhmEM0kqeoDdMxOKAcmMaYrX+VWFLNsyYe2IBeKltKyUWdSu2UyK4
         g9zgclH+GTsm11AlTVbm0TsYxggLxYcCfB6XdaczhpWC6q5IH2qMFF87fEVhAOPGP1WV
         LYyk/+a7Re3rLtrpPbMvHxhdODQ0clTFkxa0fjlAltYQm3rgGMflDlUAQcJu5eCrvdTg
         ZHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCURrUaALn9iM0Q2yRV+UiLqA8jofIey9B+OMSFwtARfFsdZ0F1MDomwTb6yg0SqdFqncb3qRszrQIAh2PbAjmxO8WJ7
X-Gm-Message-State: AOJu0YzEPJeNTgvPk/uW336RwK9LRwx4rKXgNsnhvJsQg22vxIX5v3JN
	hFaqdjlJ7NBZnzxF+8w0aNFaCyBPCPBhngP+3vGHbzfcRK1TVod31Xu5cNguSEycAx6jh6eMRhb
	6gNI14KQSaWGAx+SvSoOUL+MNOVU=
X-Google-Smtp-Source: AGHT+IGzZzQMICD9C41cELdxMAJ51GnfT4+x0ojDALCuBIYT713KEGDijdbj9kUP67DVWSbmQ4d2vJo30oXe8z/bLGY=
X-Received: by 2002:a05:6870:a918:b0:220:c604:8df with SMTP id
 586e51a60fabf-24172e02947mr24599888fac.37.1715885866881; Thu, 16 May 2024
 11:57:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 May 2024 18:57:46 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 May 2024 18:57:46 +0000
Message-ID: <CAOLa=ZThWW0ToK3x-GBynSPZ0E_ssKRd_bLH8ayy0QD4gkOGpw@mail.gmail.com>
Subject: Re: [PATCH 00/16] refs: drop all references to `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000922caf061896cf8b"

--000000000000922caf061896cf8b
Content-Type: text/plain; charset="UTF-8"

Hello,

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> in "ps/refs-without-the-repository", we have removed all functions in
> the refs API that could be trivially converted to accept a proper ref
> store as input. This was a mechanical change, and because the resulting
> patches were quite large by themselves already, I decided to push out
> further dependencies on `the_repository` in refs-related code to a
> follow up.
>
> This patch series here is that follow-up and removes all references to
> `the_repository` in "refs.c" and "refs/". This includes both explicit
> use of `the_repository`, but also implicit use via `the_hash_algo`.
>
> The series is based on 19fe900cfc (The fourth batch, 2024-05-15) and
> pulls in "ps/refs-without-the-repository" at c8f815c208 (refs: remove
> functions without ref store, 2024-05-07) as dependency. It applies
> cleanly to both next and seen at the current point in time.
>
> Patrick

The commits here were easy to follow. Apart from some small nits, I
don't have any changes to suggest here.

I did confirm we no longer have 'the_repository' anywhere in the refs
code. Which is super. BTW, should we also remove the migration code
added in refs.h, since 2.45 is now released?

Thanks

--000000000000922caf061896cf8b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c7b090bb96c2fd6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aR1Z5Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNS93Qy85c09IeHh6bStReTkwZm5xZVNoQzc3SG13YwpkRVZ6cWRxZnJt
bGcrWW41S2lieFJha3JLT3lJSHNNaEpSS3dISi90ZXJJY3JVSEF2bkh3eDVNb2V2Q2FSeDM5Ckh1
c0lVUmE4cDk5WnE3blZTdGpNS3lRcmsrMWhYeU9BSDNRNVpxY0tmUm1oQXNxTFprcXpTSzhQTkt3
WWx1RG8KVjBaMld2d3BDQkxabGt5M1gxQ0hSd2pGelAwd2xQSWF3V1lVTjdzWS83d1JHZ1VnOGVI
RFhQbkpENEUwQmxCQgpEWmlJQzZJN2Z0RXNWb0tLZ2tMeFNKaDFQOFdBNjJFRERRUVBLK3F6eXZj
UDJ0dFdLaysxNjc0NGIyekltTDN0Cm5iVHNqYzdsY2hWMVVmM29MbFROU1ZFZkpxYTFIalQ0eHdm
RFhHamVQeVZPdGJMZXowOEFMTCtzTkxnZ0R5T2EKSDVzSWdUZE9EbldFYXV6OS9iSXFqWmVKdjNH
cnR6UmRTRjJYejk3THV0NmNwbjRuTFZCSGFweHpTb0dTTnViLwpRT2RkczNSWTJTUEp5RGE3QzFn
eUJ4THdrYnVkNmJWOE5oQUpsS1VKc2g4Q0JIM3F1SmsrOUY2U0wzejFIZWgrCkxEdVM0dk1yakF1
YjFJaU9nenJ0TWxSQkt3Mzl5SHJVQ3FMSGQxbz0KPU8rNXoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000922caf061896cf8b--
