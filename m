Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC21824EF6E
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714916; cv=none; b=T6lpTunzN8SVImN6CboZ7r3NbNSBRemQFRqPwuiFUdqsoB1U2uM1BeSKCM6L9Q4AFzJjTS5WzgvyoCOQ0lakV8kzXaDyHsT6zSQl02fyEyrHl5VYZ/qw/sroOZyu1MPzBITzc6ymUvB8PxSOjjjThTGGiy3YcuAK9br5YK8lS5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714916; c=relaxed/simple;
	bh=J67u9yoGvc0xMIu0A1QwY82cOIxGIYBdCvWYbehID2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHIccof9dB4GqL5XwlFGd7andI51TQyfOO4NMql5SweQWASK3RDltzfpU1k8Hi0I1QRTnwcFlwIysUxLaxdoxxAXYSk9m2PocZWnS0GWFTOrsgxi0wPZj6SUB7BHSHpmDENCEgNu0bRqhaltO/TI48DGYT1YR1IpijueByUd9B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvX2GVa+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvX2GVa+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22359001f1aso137599775ad.3
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 10:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741714914; x=1742319714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J67u9yoGvc0xMIu0A1QwY82cOIxGIYBdCvWYbehID2A=;
        b=IvX2GVa+LKfDdJFPPimwafhKvloXLEs5c742FIbSmE/GwvUG4lX0JOllYzflNgzQy3
         T3GMMOgwy4s4CpDjbCwBMTAiutxO8i11mKcl8n0yKxShzq6nujGXt3H/NJ39Osh9eXt6
         77J7QbGViJfaue9Ygm1v3lk9tTVT3bgiyRdoOG+K3barAD4kLS+MxYOC1qABFZV1yYZz
         9lME94lRXG3Wbbus0HV+OJmq86mDWsGRxDxMVsWyrTiqQnLZqM1X3rWAzStCy2HNm2RC
         cH3i2erX/PHf0djRBS03Cb4WX5/EYI0PdJDZL44brIen8M4ikZwRGiXIXArg1tha3KOV
         5jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741714914; x=1742319714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J67u9yoGvc0xMIu0A1QwY82cOIxGIYBdCvWYbehID2A=;
        b=NiPUWArjQeHGcaZj95oZ1QH6xHtShbYm4lgLDZ3PMSqwiQTEBZ6wJ5W2pNi7BNVkXE
         2vf4EEcsM8ugtTEKPUfFz1Bz+GCHE53PMPCaKEcT9bIOO1DqM+EIvsTPwzi8vXyFW6ig
         IUpRzWwhBhiOQI2VwV5AsVlMV89Up1DKsVczko014Rd9Ig97mhCRAz0FtKdUWJkYpWuP
         lo/GDB5voS+JVD9TOyxUhvXV/sVG+/UsvNUAZOOZE/qH6PV9L5PbQnZhxYkxFNzuYN9f
         1qOe2Y354A3iWkFg+XTPZgcdh7w5nG4n6xhO2lMgdhPmRijQQTiwJCIOBXWKsCZlSrEO
         jw9A==
X-Gm-Message-State: AOJu0Yz3MN5WH+GfWlDVG9Etqvz9b4e4Kvnwa/merLwETEE6oOM7vN2/
	hNmAcTcYQ8jYZl3dIW7NvpKvyaJt1fR4Ego0XzJneCGTCObbC1cqiPnpva6tDgg8+RDEmsgRvUY
	XrdjsUZrURDl4YeONebV2yFOdf80=
X-Gm-Gg: ASbGncuMOHlzXSvlle9kbvt79nkzvvjVyzieqdg9Bcq2aX7o9sxlKr3CkVlI9Oza91W
	tEEMNIEVPOH5ZSZzOujkfOKfxFNIqFdHk/oINqhoaPbsPBqxyiMH2zSOnaS0evrXqTqGpb/Vk8B
	gj5cxbWGuLbYGQ/GTxHAt1d/ohm7U=
X-Google-Smtp-Source: AGHT+IHFq4V5Yr9mezOpZLvkeZ5Lm+G0w4jV0cIBLPS+elLST1D58yJQipdDmFHcYVMbhZ5LvVZgLtiPQfEJBVcQOWs=
X-Received: by 2002:a05:6a00:4fc6:b0:735:7bc0:dcda with SMTP id
 d2e1a72fcca58-736aa9b3cbbmr23843538b3a.5.1741714913979; Tue, 11 Mar 2025
 10:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309153321.254844-1-ayu.chandekar@gmail.com>
 <20250310151048.69825-1-ayu.chandekar@gmail.com> <20250310151048.69825-3-ayu.chandekar@gmail.com>
 <CAOLa=ZT=zGTF2DLEy9VjXhcUN3wEi7_R=8O6nV-TtBXKT=ENXg@mail.gmail.com>
In-Reply-To: <CAOLa=ZT=zGTF2DLEy9VjXhcUN3wEi7_R=8O6nV-TtBXKT=ENXg@mail.gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Tue, 11 Mar 2025 23:11:43 +0530
X-Gm-Features: AQ5f1JpO8xtVPYprFLMrHKIEjNpRA4Dg5WZbXrY4M9Mr20KlphlJjxOBT2yiDsw
Message-ID: <CAE7as+YBnOd3jTYVzmHNjei0gjhMwsV3XGk1Y7Vi45CvzJTo4A@mail.gmail.com>
Subject: Re: [GSOC PATCH v2 2/2] attr: use `repo_settings_get_attributesfile_path()`
 and update callers
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

> Can't we modify 'git_check_attr()' to also receive a 'repository'? If
> not, perhaps it would be much simpler to simply pass 'the_repository'
> everywhere and cleanup this file in another follow up series?
>

Right, that was one of the things I considered too. But since `git_check_attr()`
is used in a lot of widely used code paths that don't currently pass a
struct repository, it felt like threading repo through all of them would
create a much larger change that I intended for this patch series.

That's why I decided to stick with `the_repository` for now, and perhaps revisit
the cleanup in a follow-up series once the proposed changes are
accepted by the community.
