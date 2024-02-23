Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A9125A2
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708669407; cv=none; b=qWjPj9Q8eaIxWhE0kTfpLITFuNJ7uBdlkxCeIEa8q1DhwYyIa60w+jnC7YqdoQ+FenL3NpjrakrileasR55xPdcCcXUKGpXeQVgHKUslTU42XTzZJa///P24Pl3wcvEmNdqkdtmVSf8MirCIK4kWMMa7XlhYKCMcwMuGUf6HCtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708669407; c=relaxed/simple;
	bh=ywcjfIAIaSX2PrbtvfpZVnN0C1QTsTBL8WT9aMFnISo=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=Gcsgb1GqfWAHCWHTfjkTGzdRB5P8/IKd5Mxed4dkcpgBeR7EIv6Dd9edA2tegWz1UeMAD0cSX0evKniPNEmajc+yoowCfqhCY6Pxrt3+NHKFX6pvJ5iQrGSx8UInyXsrRBHEdF8ozgASih3N/1p3qcZmTlvCKSWCl/uSgSkimB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2B+W5eC; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2B+W5eC"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78725b62cf2so1245685a.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 22:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708669403; x=1709274203; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ywcjfIAIaSX2PrbtvfpZVnN0C1QTsTBL8WT9aMFnISo=;
        b=H2B+W5eCPSGqNO9xmtL9j3y0YNMTcpdWMF7yZtJXTNcG2w/G4mClzIM2ENJi1bW9/a
         kPG276sssm1/YS5HPusRpDegrKaNZ/CrRMqK7T1sImiSc8nZL/WwvIx4UVGONf5k7w0N
         wT46r7DcBLc2RrC3GLMAhTG4Vg6BwalRDX0mht+/jUPc2NYbZqEmw0EjlHFa2yrFw8RY
         kQ9ZRh3qVF5o8JAPFbaJQ0gg2WXal4dGr9Evjuerq/vWv654RONkw0IPL+TpSORFkRoU
         VnSLA9Qhm6eE7foo2TDcEHHwVbBbtKZr+PUEBNCPY5MqiS5d0Gytfe8i+dpIaauxfcJq
         pNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708669403; x=1709274203;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywcjfIAIaSX2PrbtvfpZVnN0C1QTsTBL8WT9aMFnISo=;
        b=wuuQCgsaq7OxUrCgYywbM34hNsOLYJvNbCSs3Cu49dHx6Nz8jBx8/jUgt3GSNnrJCd
         r7dMwaHa3xe0XA4t/AU3B/tIx/hIsW+yYODGbNObnAuINP9otqcXjPm7LYWItlF8sWni
         B7LqlBGcJAAhVn4e0Thn2qGrTM+vKI4cNr9DutoXw/CX4Asfjok4/sNEyK4uj2omISCr
         Kj2yaOxx80YacdTfkNky47s4M7wo72vyAxoYVV4fcZ/+EGxJj8XZXLUop03FuIAqjU02
         VkHkD09/7CQDIGwkrkZZVquCsQh+KCkhThtvkTgiU8ODxriIsXl9WEr3rwB/b+IErbsZ
         LQaw==
X-Gm-Message-State: AOJu0YzgzRG7zpn8S9CUMBlQHqDNCscRxqDe7cY/S9p/96w776EBv5FJ
	D1WrI87U8LuFRVdBeifR0affbV7sfZ1jw+cccPJBsmyLtboUazmLPDo9mdKs
X-Google-Smtp-Source: AGHT+IHoXFNFvrdP3jCFEj0CopsHuzCXcaFyVm+iRubmrwfcPDqLAhbavlbMM5pe7EktvSexvDFgWw==
X-Received: by 2002:a05:620a:1925:b0:787:80bb:c2e7 with SMTP id bj37-20020a05620a192500b0078780bbc2e7mr1103870qkb.51.1708669403257;
        Thu, 22 Feb 2024 22:23:23 -0800 (PST)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id o18-20020ae9f512000000b007879a1d261esm1450325qkg.67.2024.02.22.22.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 22:23:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: <phillip.wood@dunelm.org.uk>
In-Reply-To: <8c2eec1b-9a59-4739-a903-b2e8955f3ff5@gmail.com>
Cc: <git@vger.kernel.org>, <newren@gmail.com>, 
	<me@ttaylorr.com>, <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] cherry-pick: enforce `--keep-redundant-commits` incompatibility
Message-ID: <17b669c4bfe6602f.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Fri, 23 Feb 2024 06:23:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 10:35=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:

> Well spotted, do we really need a new test file just for this though? I=20
> wonder if the new test would be better off living in=20
> t3505-cherry-pick-empty.sh or t3507-cherry-pick-conflict.sh

I was modelling this off of 't3422-rebase-incompatible-options.sh'.
Additionally, I do feel like these tests are only tangentially related
to the tests that actually exercise the features themselves. Notably,
the setup requirements are drastically different (simpler) since the
test should fail long before any setup actually matters. For that
reason, I think a separate file where other future tests for
incompatible options can also live does make sense.

Is there any particular downside to the new file that I am unaware of?

--=20
Thank you,
Brian Lyles
