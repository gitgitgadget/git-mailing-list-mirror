Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC431F418A
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285580; cv=none; b=Fw+Bupzp/P3nwNtFA3QpQTtbH0vakpwkPwXMiPUfoKaZ03v2V5RyCUjlB35gOFy4l14SSOB+0Ofeti6fmRJgVYrlgK2sZL9SKrdfWfLBW2cxIe7sovtm1qVUUQcnmaOb1fc9xG3ZlS3qPx3NE0U7WVgnQcEYP+pt9TMhWY/gh0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285580; c=relaxed/simple;
	bh=GJosBuVgkNI3a7otFq3Zs09kduDboJXedpFMm/Bk98g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=L3n/+cCf86pLZpcpNuVA6L9Snt+ywQZExCoz32f6XI0qczdVGvUozS5dnJ1qTQGVeur6gajLMIPBQxHcdmoxDCxHEjYxAGsKcjeP3CmHd97P15Ycut2xr/FmXQR1ic5faF3Se/T5r9b4jvB+QSYq9RIMNBVd5tfiRpUe5+dh9fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBcdhLxh; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBcdhLxh"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso4437499a91.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742285578; x=1742890378; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GJosBuVgkNI3a7otFq3Zs09kduDboJXedpFMm/Bk98g=;
        b=CBcdhLxhTP2/QnmllVk3RU65Zjo0hWDypysVrpDUWvsH/krs6F9GjOQt9pqkC51a1M
         sAxDeipnQv8RBSkHAf6FJ4cyLAYAfCeRWXdkW2SR6DmLlv1z7SGSDncJGa5HKS/YufYa
         w74vtjvz0B7z0QX45CNMgmVn6xF0Ye01gTIqfaacKgY50OTwF4BvTUVIZWtM4hRaCJj1
         JD9LQ0ryZlZHVyRSe1UX23MSR+8j75iLmTeHSkhuDlGnwegSXo4rct6FV2wiACFWhZqK
         T3+5jijDEfVjK40uGMJtZyN1AiFGuiVucbbsokvX5r6Kh4Zcby0UxXWNXfQXhsmQ9trd
         FVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742285578; x=1742890378;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJosBuVgkNI3a7otFq3Zs09kduDboJXedpFMm/Bk98g=;
        b=A4jXAsLSi5G1SRd2JwcxW2sv+99GOW0a1uw83P2RKsE5pd7oxkDMRjK+UOvoc2cbwy
         ng0uXeZpRzwGgQ+H7HdUYi432bMlagDlvU6pmGDvJkUILOhN73idyBfKxIZYROpRqgpy
         NkJp8tijTWrSqI0UZh2JQ+eyKKdnDEvQVxEEnVUB1jcL+TtVedAYRfUgHXtdN1U+2ZBn
         u2+5js/s7yORBewZATrwfnoUP4H7491J+qQnqRZLc72PIx6F5c/BkqNu8EeCUg/BEngL
         qEdU/0M+rU5QHQhhDTr0pC7dkZhicTmzIprD3rQV7+lP6vIxZEhHbgbzo2bXJA0l95le
         PWbg==
X-Gm-Message-State: AOJu0YzWqOpjKApvQ7TyBDDyIhgyaBjzSHorgkrhm4udufEvwiSN3CVL
	47OOlPNenQr7DYuMbviUNA0fqvsOi3JETq+Z4DaJKLjs6qm3QJR3hs3KVQpdJs7FUnqFKs+Oju+
	eDVKGuWbIn21OBBVCCytV58mAn8U7TaFYo+4=
X-Gm-Gg: ASbGnct3O0g6IkonH7jenFbY8EUpdjHKC4sVCweC3Hfln9PJc5ObEuRWBRp5L3q3MPz
	fK+YiDueFiNRP5jk5MH7pzIvWZIgkojBq/TM+6ZhJXuc34EcuA7R5BVv74wNjIGpwJU8XpfW7Jj
	UO7kGV9siXeMVShRWx+1mEszGldSJt
X-Google-Smtp-Source: AGHT+IH3vPFiToWNefJsX0taeWYGH1K9GSncelz0JBuVHEapv2Fu7OFAEjhtYIUlEvPk+mzq//fft50GOib3nwUnUbc=
X-Received: by 2002:a17:90b:3508:b0:2ff:5e4e:861 with SMTP id
 98e67ed59e1d1-301a5b80f3emr1994464a91.24.1742285578135; Tue, 18 Mar 2025
 01:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sampriyo Guin <sampriyoguin@gmail.com>
Date: Tue, 18 Mar 2025 13:42:46 +0530
X-Gm-Features: AQ5f1JomMoaCkeveRj3-zHK23ZboKI4fJqdOiCzpm4fbYoz8yY1srUNJcYbgcPo
Message-ID: <CALz2WHCCn_AoWHg0oW5jQxdzRJ-uOp+QPjofXG-PK-1pNxfziA@mail.gmail.com>
Subject: =?UTF-8?Q?=5BGSoC=5D=5BPatch=5D_Modernize_Test_Path_Checking_in_Git=E2=80=99?=
	=?UTF-8?Q?s_Test_Suite?=
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone,
I've submitted a patch using GitGitGadget. This is my first patch.
The pull request: https://github.com/git/git/pull/1918
I'll continue to work on similar patches. I will also explore any other patches.

Any feedback is appreciated.

Thanks,
Sampriyo Guin
(He/Him)

PS: You can call me Sam too!
