Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D128640D
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752230319; cv=none; b=ggdG2WXb/1ag4gL/ZuRg09I65AK4a0y4ahyxbVhWNGThBjly2CaydGeuW5/SsUi7waJVFzE/8kSjqomAFAz/XfIDI+wkjqvkunLJ45jz5G87u7Kpqbd3IniFZ6isYVUPVp9pxkMzHLwDbcEMQ+5jbEQbKd5AkCHUOF967qsaMbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752230319; c=relaxed/simple;
	bh=NKq5v+3Un6z0ocWGYPMqNEXAgsdhmEX9wpBdzcZKslo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=bp65zT9mUuG0mD6HYJBfzUO0T46pE7KecM/xop4beliV8DVSqSJ45ANKtyICgqKpo4I58AWMrhKfyiqVGNuDJ+Ds7S1mlq79PdcP8rmdzctWWlOcnKipfi/s0amvgJ5UAN8NVF7XtwOfClXN1mhBpBlddz9MtU66GSkMwU1cw4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUC1v7tt; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUC1v7tt"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5314b486207so815864e0c.2
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 03:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752230316; x=1752835116; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NKq5v+3Un6z0ocWGYPMqNEXAgsdhmEX9wpBdzcZKslo=;
        b=KUC1v7ttDKQ0mOkQM7N2n9Lj/bdon/Ze5WJEEnFd42XLPjHfuLEFlQVvEnnGmdsTO2
         BFT1kIa5U8s6OTyB/KojgnEXOj4ZDUXHsjjA6aEctzhJJw/VBwIW+vz6OX9aNPTgR17j
         lJJa+RxhFjrX161q1+0g+3rqjk6AgbxhYpsFDoLMYSSCy+b2NGkxPamh64kYEYkL0c5+
         toPTGhFBHBYnedRZwte9TWhv4n/6zB09JZFLeiWDMjQyTg/9vimkX++V505HhzKI64op
         KvgPhV+E18qrHhcS7Hy6PFRU8fdTZH+71PaJGdjZJ1ExmRhXooK+l+OIpx2nOfpv5kYf
         swHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752230316; x=1752835116;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKq5v+3Un6z0ocWGYPMqNEXAgsdhmEX9wpBdzcZKslo=;
        b=YalhTefXPd2B+rgFBrL06az03emEc7UYQanukL9H39whNpKG2AxUM7RELhuAM8oQ+G
         WW+wyKq2PeqLgzWgwnmLmyFQYpvr4yk3UrjzmKvzD5pZ7jdgR/Ah4tNNw0XCafrR8CFX
         YxszuA1YkZ0s5o0g1OvfDyvZ71vCzEHV7ijBLhr5TWxn04Ma7pecOnsabbSNK10n3jd/
         TuU5/z/ENSALnHwmyh+ZO+Lbl3ArxQ8kQ2QUtUu0oF+5YBBg8xcyRHh6vfh0EKb1ib3V
         qNnB2Jn6ltEGl3AvbJobe+gSqiifdgca43Q3jZF0z8TxZeatD9sZsILKPeoXRaGSWaji
         8gKA==
X-Forwarded-Encrypted: i=1; AJvYcCWl7PALKda6m06H14RSk+QXLbt3CoZ4qynfgXeR6g9JyUMA57l18smeyuWH+0lmfGu636E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39QdiNHVI8rrYbqt51WqUsIkPgz16dTFQbvD3FQZv4sG42R+f
	nMIreBZmRjUO8xQCtr9ufODlGE9XGfPLbaRXmY+Lbt8beNoNF7VX+H6FoMSGydkrJnCQUsldFd3
	APeg7ZxBvbjNaheyBsoP5Iwz9MxDovzI=
X-Gm-Gg: ASbGncuHuTfhLRxvxc13/w4FE6KpxilE8cS7qcAFrTH9Sp8MBaSYpx2AdcuVTmZG5Pt
	EmTJMkbba9+ZlS1RXjp6PPZW2TQmYVPUvOrfZb5MMS1P98s7yICMb6eFdLBEoUiWCxDBUwDOLBq
	Iabnm8d83JRy5oXvOsI700vLpIr6bzS5qYflHjVpNWqqKeIMOIvQQmY6o8MDHhptEXltCTm0bci
	eReq+JYG2aLjuqP47V+QAU/ZyLcTwO7o8Ll4+P/
X-Google-Smtp-Source: AGHT+IHFyk9m8gIGD6h+jsSxRjJWmMvUeaUsUlJ2hmp1Rd+CVczdQhzx1F5twSPAJ1owqN/+QaBZ1pD5pjq+mdRnoOg=
X-Received: by 2002:a05:6122:8b04:b0:520:60c2:3fd with SMTP id
 71dfb90a1353d-535f4704334mr1439946e0c.3.1752230316153; Fri, 11 Jul 2025
 03:38:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Jul 2025 05:38:35 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Jul 2025 05:38:35 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-15-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-15-62627b55707f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Jul 2025 05:38:35 -0500
X-Gm-Features: Ac12FXwrG7BVAJNPdZYOMKLyEvXRAKacR4fHPQQfCp8zWWwSCbqGh17xQ8VAA-Y
Message-ID: <CAOLa=ZQ2msNYfURDXe1eNBtbFxDjmc4dJ-u1s0Fo-mqyjnnQHA@mail.gmail.com>
Subject: Re: [PATCH 15/19] object-file: get rid of `the_repository` in `force_object_loose()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008f37730639a4e95b"

--0000000000008f37730639a4e95b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `force_object_loose()` forces an object to become a loose
> object in case it only exists in its packed form. To do so it implicitly
> relies on `the_repository`.
>
> Refactor the function by passing a `struct odb_source` as parameter.
> While the check whether any such loose object exists already acts on the
> whole object database, writing the loose object happens in one specific
> source.
>

Q: Since it exists in the packed form, won't the check always return
true?

[snip]

--0000000000008f37730639a4e95b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e39685a6cd8ed2d0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1odzZha1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkI2Qy93SXlYM2tRV0VRTWhxWmxZNEhLM29CbXp6UgpwRFltZmtSelg5
dVgrcEJzbjRMYzRwanNsVmh5b1ZBcGtCL0pUcjNxTjdkMHo1eFVPRkJDTFBkS2tFejRQbk53CnNW
QWFLdGc1VnE2RHJLblNZYUtCWllGVzhrRjk2clZnL1laSkJ5bjVrMENuakQxeTc5MDhVUzlScm1r
M2xpYTMKRUdZNEFncFFlQ2NjVG1IZytkRXlnVEFUSVV6bkVZcW8rL2ZSdHZmNXZOcGNQY3NMRkgr
bm1YUHNpY2UzaStTdAorV3BRZlVhajYyejNCQTE0OWREaFlrT004MUNPUmtjcm5YMTBpTmtDNlVO
V0JKV1NSaVlGL0k4Y0pLMzNpazBGClRPM1JpOWZMbHdFSS9aTW1TNHVMZENQN2lEdlJZbUM5bTlO
VmJ4OWwzZkpUYnRzRzJrL05YelFnOUFxaDdjVnIKSE1jeEJHOWZFdzhFcGY0cXRQVXYwWGEyWGxZ
b0NaM2ZLVjdacGNnamh6RDJPREppbFd1Zk1qeGkwS3hXeGo2QgpOb3gzTXF1bzJSVUNDQmc4YnFv
ZWd1QUlCNUV2eVJWMkRoMFFBdTJyNkNjV3ZtWUlMOXU0T2ZqR1JnbVZOR1FzCk1VSmZlQ3p6WmRH
eUZabm9ub3JNbFJ6R1g4RnF5eTVLelJZcXFnTT0KPXhjVGkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008f37730639a4e95b--
