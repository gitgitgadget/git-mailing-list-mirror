Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFE1946D9
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330843; cv=none; b=moIXmoCcRJPferfElo39TqWjl15mWegG+3m6//FnlIrVlV9FM/7x2RZYh847PFrKwAIh4UsSnrLek2d67arm5kf9JAvb8LpbVqpYzz8NqkFYSPXrbSrQkTW1TyLz0E01YrL3S1t5nXecmH+HattHwDzeWsmPsBwbILvnNEw3g6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330843; c=relaxed/simple;
	bh=R6/4FOzxLTt+0hjkc+vW5nOlMlEwps2u2U92MsmHOCs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=ifHf2kZugdu5A3T5Isub9dyJ1xjIqiAT4GuVn6ijd+hJOyGA8jix0r1Gm+HevYEhwDKHIu5AoK0CQFb2qBFvECJPc6fDPnmNZRnukZvwHalUP8CihRo4BOBo7erwMQtTL7/sA3ZOcE50bMPhAWyHUwD2Ocy0oRhFa81RLa7dTsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O20SswqE; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O20SswqE"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-260fed6c380so2663161fac.1
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 02:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722330841; x=1722935641; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6/4FOzxLTt+0hjkc+vW5nOlMlEwps2u2U92MsmHOCs=;
        b=O20SswqEDsSz0twS0eIqrcnhb5FuvTg/Wcu5smdi0ToO92fL6NICu8Wan8ioa1uRSj
         1ula4UDZ3+o954mgHszo1/zzOPD/11MYxkfELoSgxyefM19HzT4pQUyTUHV1gXwQ1f8q
         3SM5KlK/dtijOSRC8tUzu5P+NTVfy2KFm0WXj9i7fzqX040GQIKPuWSKHk8AHhCbdNc8
         uDxOaBX8YBDov8EcaOz4sXb1oJziHyH0PpVGID2/E/QWweYFq9ya97PecRncKH8/0Qn2
         cv05RuCjkAKrZKK1TdcIPdId17hWwRK5n8fwcQla3pYDSAeoOCAqynozAbtMxEbrHHA7
         cChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722330841; x=1722935641;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6/4FOzxLTt+0hjkc+vW5nOlMlEwps2u2U92MsmHOCs=;
        b=GSS2stA7k1E4CHxAH378P9QiAHNOCnz/MavfL3eWyhEYn++vLbPE3DfdELON9Frr6Y
         CTm1iXx1zCcqOeJ0JpY53CmDkAWGzkIfmSpBQhhmlXnH1rfyHak7OqX0P1KmtFEnYlPF
         xxM0lOuVINqSlb1EC/11u2rrP9cwnJAfGUQXF8okAduLqnBrBvDzk3rFcAPWOe01Uo1d
         oOMKo5w4zs2ow7D47lYnsd8SNHzTtek7e/bamEkAeymZ/qKPKZKk5QAyDK2Lh2gJ/dtm
         +JpK+U8OODEEQP4ae+BoYJdWWCF0fCmL+WLJSco/rywlv5ijaVLKw6cZz4evahh40t/9
         fwPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmudSiDRIvnpfil7nyinBd3JduxYctR/GTCQLiVx6eR8XB81BxAmrUPbbQcmymNFvLmObRaltA27oFhmmWW4kG0f0v
X-Gm-Message-State: AOJu0YwA2jt7eFAPPqKFjfIzJkVxYH5ysHp2QbRPGUIYdm+gMWoZPtoY
	8RjltI7s8eNILyhdCoV3nY5anMn/zzgrqZfrABQUY+5aZhXiZg5tDGnrVaDRRRsaKxQv43uj1Tc
	+hiiaUQGilxfikpdhRe0fuFdkVKVX7A==
X-Google-Smtp-Source: AGHT+IGWt2BQqruDR8WSZ9XdTo6LQqrlrP8TbBLba3GHDuEl7tFkPzPNFn1RjY8DJmbQs8hdPsiQyw7bm32r39Wl/6g=
X-Received: by 2002:a05:6870:1595:b0:261:86d:89e4 with SMTP id
 586e51a60fabf-267d4f27716mr13449941fac.36.1722330841207; Tue, 30 Jul 2024
 02:14:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jul 2024 02:14:00 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <4daae88877f2355d6a3960883e7b3f15cf738cb5.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im> <4daae88877f2355d6a3960883e7b3f15cf738cb5.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 02:14:00 -0700
Message-ID: <CAOLa=ZQ1zGe421HFqH4wCSMwc53H5eUr18j18yM0pNgD8DxR5g@mail.gmail.com>
Subject: Re: [PATCH 02/23] builtin/log: fix leaking branch name when creating
 cover letters
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f9f549061e7365c3"

--000000000000f9f549061e7365c3
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When calling `make_cover_letter()` without a branch name, then we try to

Nit: s/then//

> derive the branch name by calling `find_branch_name()`. But while this
> function returns an allocated string, we never free the result and thus
> have a memory leak. Fix this.

[snip]

--000000000000f9f549061e7365c3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 474a893641fe096a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hb3J0WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkFUQy85R3pnQ2JUdENuUEtYbDRnQURiOFdGNit3WQphaEVRZmx1YktV
Z1ZnVWlFZEJTSGhYSTg5TWQxejdrK3V6QzBKNFoyc0dZUTBnR2pNMGp1UCtZa3REOGVBZ0tVCk5Q
ejUyYUN3RnNKdm1hbXNBMXJkN01pSHZVVVhidDJqNnRHbTNUZUVjbWo2b1FqdUg4YXlFank1bjFH
ZWxKcGkKa0R1eGRwb2hrTHpRWTVsWEhqMC9yOHNkZlpUdVRxSWU1VUswQzdHQXJqOFFJN1JBOFRG
YnBVNFA1WnFSNmRKagp0WG9DaHMraTd4YTBvMTdvbU9sYUlDTzk2RU90Z09RNEVQc2d3K0dNVjYv
S2FEckpINDlyalUvZEN2QlVreVlhCnZJbXdmVjF2UUw3bGNFQURvUW9sUEQ0bEdpUHdGUVBKSmFa
Q25teG5VY0IyZERodTB4K3lNMVdFVjA3S1puSCsKNHQ4VkdaZDBGN0xnN2RpVENmWkRVM0RoalNl
bE5MeWliOHZKVXFmbmU3ZDFIbzAzRWxUR3NHOUUzNGFIc1laWgpHblNVQS9GeVFxWVR1dzVHUmNn
QVBVVEErMVk2aktWci9PdjBYUGxHZGJqRlhZR3c2N2VlQkVvNXRaQ04yT0pGClk4VVczMVVLL1o2
STZVblVBTUpIZDZWSHFzeHlUL0VoT1p2TVhpTT0KPUR5N28KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f9f549061e7365c3--
