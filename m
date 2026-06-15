Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2136C2CCC5
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 01:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781488478; cv=none; b=cmewOf1plAISlKe7PuPfc+auYt6xgyQpDlWIJbzQQ4+YcgY1Nrz2rJpN60N/4NIkuDRB8YUjDEHhkTubJneJWeVDWzA/wIdBuWFUy1XH4+fQ/uXOzsSGh/OMwZPgK63j8qXXHlYVSOWy1wK06AvAHtT5hVrsAbz7fysD9sjllhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781488478; c=relaxed/simple;
	bh=NjxuH1zfpLCAHncZom4TLxwk51b37CMsTAe0uxQvYEE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Tgh1xXEpNYwpGpUnqKemrjJo5nqhw4HhxNiaPhhjXMEQH6jyGXphomLX5GSL2HTjy3gj1aTme+nU57RImPKTrwweD1gkFm9TORw3RJKlnypSh5rGPXWmAIox7yWQvTf4Jjh4StBdkE60YsErvXwjL3iiL4D0fc7CrxX+Eo4YUPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O981euuQ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O981euuQ"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-6cb414a5d50so2330474137.3
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 18:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781488476; x=1782093276; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeJNttwoQsp6KTNaI8Oj+ZGRXWSMT9Q1UG0STx1ozl0=;
        b=O981euuQutI2dS6Fj6vc5ubSelN6rsNWVLz3Mijszo+3gKW/yzV5EAtK1WeLvyM2IZ
         5lEUAm/Gea1g/ceuBwNF+Gk8qGQBhjocI6tmrt3HnL6qeU2uN5CrDeE525+H9hrFFE5E
         ROM6nmmaBv9uZYS6eeiD2G8q4JJXw4Cy78RnfYhJowkMQo44T1QMvVINFjq6Ug8BMbBg
         OJVM1by++Vjd5OLxjre8b6kgcqKHEaG4qg5IemxXRgATd4rudLtRJFEfkVpbM6ZhKdaE
         Q14qoV5tMI/7unttJDOscGctQJXxhSUI12rXY/9bPjGyqqlAR08GDJcXaWtf/ta1Btij
         B+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781488476; x=1782093276;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TeJNttwoQsp6KTNaI8Oj+ZGRXWSMT9Q1UG0STx1ozl0=;
        b=dlvAgkIB5TCb3C/HRCS5blsiWFsZ2Q8D/MrNDxdmD99YbJMbcs4gqHbWfzj06dixo6
         xmH5FboDEMj1b/PIDohcYkbAjEJzxKam0c22JgkCO8Yzq/VYrDtcZO+rbIIb5gzwa7Tk
         GtXgpT10suDWR+kHLn2B8F39iQdmvoGBAv+2qmsDTucoQzToOrYvXm4iK1ObJg2TaR8d
         I+H8AXUvuxAgARzGHDVyfBU2Hm15E8zZZCXhkvBxO14UcL/RDPXgnNMEWg3V7wr+3FJw
         Cd0JGmKr4oX1hy0z8SUVYN9xg0jXRtihiZ2ncaq4PdjTGaDiVAQLhYkTIoyM8PaNldrK
         z8ZA==
X-Forwarded-Encrypted: i=1; AFNElJ9djLEnB8c4BHSTOoT1JuLUBSdLER7SNWojeRoSEuJwf5uQEq0yMtNGCrRVXWuAZvVkieE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZNxG8fucdhxCQSG1c0hr4L8StFOADtI5tGLpEfi1gUPSiwqxh
	z2VRQndVJ+bkwau9x31XlvViM8hLYXSlVdoPtZO76RF0CwkCEVNgbEj+
X-Gm-Gg: Acq92OHKoELXMwpGPIOxgM34T1074Yajqjp+2GfZcAKC7inIKgKSFK4GHqtLsMlxBaU
	Z2dqSKWx3C068gwoCkAMhgtCeZanFMbGUsBwRkAS9USRqEXhgcQCnkx/vja4OWKMoEGqOEXFUp8
	oiD2AFV5CHGFvx4dlbg1ZF4z3vS6y6lab26CmvpWflloqhE3L6l0Gqkz0igu+YqTdD03XDcJg1Q
	c8i8w9GKzty78YRXo6MD48DTXW9H8o0Gkj2myBlU8QUTwGROwoh3EAccBxcULVFNc1NELCcNaG2
	yyAhdHcA16L4Mg0k+THnx7l+IZjzfvrQYUdIaMgwk04uimFyh45zIcFmArRaCA1eYctZbiiov+U
	lObLpdvWh+8LtnSQH94QifU9j0DdJrIX/6fIkr0g8DJO3NHn0V+ZxHsE6bCkkgtxoYyFlFMDuSp
	lcVivQy12RijQiWEkBMs0jiDmJsliTufVtrqgvcmjfMjqoE9MpK2/Ixv2HHrHC
X-Received: by 2002:a05:6102:5a87:b0:6da:1341:1147 with SMTP id ada2fe7eead31-71e88aba001mr7154408137.1.1781488476078;
        Sun, 14 Jun 2026 18:54:36 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:c4:89c7:b89f:3820:2765:34f6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-720847c15a5sm1771399137.3.2026.06.14.18.54.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 18:54:35 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC Patch v3 3/4] repo: add path.commondir with absolute and
 relative suffix formatting
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260612182847.562816-4-jayatheerthkulkarni2005@gmail.com>
Date: Sun, 14 Jun 2026 22:54:17 -0300
Cc: a3205153416@gmail.com,
 git@vger.kernel.org,
 gitster@pobox.com,
 jltobler@gmail.com,
 kristofferhaugsbakk@fastmail.com,
 kumarayushjha123@gmail.com,
 phillip.wood@dunelm.org.uk,
 sandals@crustytoothpaste.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <B0AAB2FE-5E7B-4C67-8A71-84C1A3ACBA44@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260612182847.562816-1-jayatheerthkulkarni2005@gmail.com>
 <20260612182847.562816-4-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> + test_expect_success "absolute: $label" '
> + (
> + cd "$absolute_root/sub" &&
> + ROOT=3D"$(test-tool path-utils real_path "..")" && export ROOT &&

Be carful with the quotes here. Actually, there's no need to use
quotes around `..`, and export can be used directly with the env
var:

	export ROOT=3D"$(test-tool path-utils real_path ..)" &&

>=20
> + test_expect_success "relative: $label" '
> + (
> + cd "$relative_root/sub" &&
> + ROOT=3D"$(test-tool path-utils real_path "..")" && export ROOT &&

Same here.

> +test_repo_info_path 'commondir with GIT_COMMON_DIR and GIT_DIR' =
'commondir' \
> + 'commondir-envs' 'custom-common' '../custom-common' \
> + 'GIT_COMMON_DIR=3D"$ROOT/custom-common" && export GIT_COMMON_DIR &&
> + GIT_DIR=3D"../.git" && export GIT_DIR &&

	export GIT_COMMON_DIR=3D"$ROOT/custom-common" &&
	export GIT_DIR=3D"../.git" &&=
