Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7587716D4E4
	for <git@vger.kernel.org>; Tue, 28 May 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899372; cv=none; b=JK1rngkDlqjqEsa9rXE40D1I5mJHLSv/RUxeE7DzgonuE4KsBVwY1LeWf4SKlt06nmvK62a9/fDEgGKtqsbzn2+dGpwiiWPQ77ZTdQfcrMNdFUIRFi98Rnu5B8cozbqeF3USfe/ZX3Sp/SOh9uoxE+snlvOVGnbusGIvqSp1BkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899372; c=relaxed/simple;
	bh=mCb83SlLs84nl0ROiC3wBIIpcZCl/q5XB3GKnvsjC1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1jfse8XJDkpJ3Xt2oUf0O2GYvv7TXpc8dV8Btqo80AOqH3PBqA2vv8xXV5WWnGfKUDEUpbds0FkjrxxDnF1wi/++LGRX68QxtZb4OKKcGMe55Ebz5jYPIaNosg8ybV4udrKq/ccy3Z/0IvvKCXZwJ2jB6edletPcqoaoeUyHQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWjXFaqe; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWjXFaqe"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6303e13ffeso90540966b.3
        for <git@vger.kernel.org>; Tue, 28 May 2024 05:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716899369; x=1717504169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCb83SlLs84nl0ROiC3wBIIpcZCl/q5XB3GKnvsjC1E=;
        b=NWjXFaqei/hS8u5d5RjePs+8+UCZT14YcrXM8pATWQSpD4b4MZHBHs2XJrK/Pbp5Qh
         r12qV/oBLumMESsNAHdHH7tn5VCF2xJK837GRdAjWpez//d/dI+50qOz2lfxuXg0qghM
         Iy0AbkLWYI7Cp2iYjM13F/sjQPoFPTA8kytuJDsXeNZ3j+pB//fdi1pLH03EwlfkBplR
         yT9q31RFpsJvoxVQUScfsDq+DbOhPO82Yof0KC3gZVDFQd6oQrHnTuESWkYQUqehK46x
         FHOTlzFt5lJU/u3apeq0mN6VW2VbsNTGpJMCxdZhI0/afJLQWUdM+qSUO4973NVaN98n
         kKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716899369; x=1717504169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCb83SlLs84nl0ROiC3wBIIpcZCl/q5XB3GKnvsjC1E=;
        b=Xu54Sp1PVca83kaEG4BGBOo07jKV4zgvTa6HvfFokYsXT+6gX7QdRn8IK/bsOcp4Cn
         QEYBLZwqDokNL56ot2hDr601tvitP/yL6dpVPlGM0wX73rzcJ8Hj8AmRuySDmJXNrMwD
         mlYKMlVJFVaGh0YIq/JqDkmSaNUCjcgXKpIoaVd74l70U0l8/Y50zmOplKyq5Dd4O/98
         93dDxzR2veLQLIuWv66IldCVKK8EQdcV6bnRw3DD6KMyxT7r5kTM9sDLsnfmR0Q9LaHi
         gxeG1naYI587kyd45qCV4gwf9CQKDzJpytypZCsZtOEoFoWjIoo8xb2t/z0x1hZyxGHG
         3WmA==
X-Gm-Message-State: AOJu0Yyac3zobrhKNFGZIXeg2IWm4f5b1+EmQomezmCiInaixYmwlfe/
	MJX0k2Bb2TQQH9aYKu7Pv2yM+hgzdMZdD7MD7nsupSnYNUrVtjwsBuA3Y8njMe3ry9e7f4Glo8r
	k4wmI8w0ddrgsss1t7VzhFX6UZ9k=
X-Google-Smtp-Source: AGHT+IFkIlsMsLh1EDeEdue7Ki9rQxAZRHhFSng5lKbxQC9H+elQLWUN6bHkN7KScSQ+x34C404Zi6Da5w2IPJP6qys=
X-Received: by 2002:a17:907:1b0a:b0:a62:b97b:b3bb with SMTP id
 a640c23a62f3a-a62b97bb496mr647047266b.74.1716899368553; Tue, 28 May 2024
 05:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528113856.8348-1-chandrapratap3519@gmail.com>
In-Reply-To: <20240528113856.8348-1-chandrapratap3519@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 28 May 2024 14:29:16 +0200
Message-ID: <CAP8UFD02+bDsCxZACSfuSuHWhEeKBH4boxu+ic6xnDo8hMZJqA@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t: port reftable/basics_test.c to the unit testing
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 1:46=E2=80=AFPM Chandra Pratap
<chandrapratap3519@gmail.com> wrote:
>
> In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
> testing framework written entirely in C was introduced to the Git project
> aimed at simplifying testing and reducing test run times.
>
> Currently, tests for the raftable refs-backend are performed by a custom

s/raftable/reftable/

> testing framework defined by reftable/test_framework.{c, h}. Port
> reftable/basics_test.c to the unit testing framework and improve upon
> the ported test.
