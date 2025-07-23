Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBDE2594
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 06:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753250547; cv=none; b=XYEBrCCyfqqotltbNFXKyZ5BO8OT6MZjP7zH1NaBq6EEcen1FmVem7nFnSS1mc9YZJ3FJouz0LKA4E+mNBG9ZXzMpssBtL/Iv2BSs/uu8bHt3Q+CY5Oq4UTxRhVujquUYeho+YWWbBMuzCAxC9sW47q7UQKyzBNflr0xsz4/dRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753250547; c=relaxed/simple;
	bh=jbcXzsdK/7qAeF4ilaAAQDeNuWeddvF0Nj7Y6KtQRkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mq5HDN7cWrFgjLSlxdvfTWDS0PO8/ARw16zakrYey3IHA/lrnGGvLM7PT5/wPQbAIDzHsQ/y3AtpPA9mMh2BtpGh50OwbwmWWSozr7j5/Fk3wZ0svjuokh7rffBuMQpKuFBE/XFZiQfhg4IAEX4/ccu8TwLXQ3BIo3CiW7iAZVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZKNq4Qxj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZKNq4Qxj"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74b56b1d301so4169548b3a.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 23:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753250545; x=1753855345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHgv/i8wPfy80ex70TbnqD2Ya+WS9qpKDy/Lbuw1yNU=;
        b=ZKNq4QxjRk1PKyQKpPygBMJiWRJiHJROK1K7Oak4B1gFabKCavQcgOSsXKhgxoBG4y
         N+si7Ob9MT9LAX2tVPuC+mrok2IYwpXjLPlCr9BSlbESHCMZ2GU8ak0Pcnk7igLsukMC
         q+zuzulH57t35Lk3BerDkMVWO4XjYDcRUlYunaqbYT14axY+FJoU8zolPzz4xuQcBgaw
         TRSZ+Yyhflps/ZfnEjUKbtFm0DOfLmQkI+EHi20IBmzjmLXlcDMr63Uo3Cv/Qt8EHXRF
         XwnsgJ+HH8FWtHM6ZjtP94clHWrLBTEeMhQtAOLGqftpa0Iem1bmIIoJx/y0SNys+YGw
         QS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753250545; x=1753855345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHgv/i8wPfy80ex70TbnqD2Ya+WS9qpKDy/Lbuw1yNU=;
        b=Z3mtpM4O2pKH5YRBt0Px5YK0a9ij0+knKMolmXOoXWx/z6OTdEuTS/5KFVNdeP4Hm+
         gt3Pd/Bw0Cx0c1LGzYFl0umXOUaQBzkc3MXMcM+LteWHafpt3rxMtLFOcpMLN+v/j+qL
         sq9rWFILX1aNncLTzmAgcbKfJQIBzlwi4Y/5BYAMWmUpjdhxk5hCca2RcBxSVpBUVd6e
         4SjPKnTeXhzvNiuy9m2XCcbG0tJEsJC5AZAD1NAl4GXi6w3szurFAMnhDSdsVBXQmEJc
         SJ74gOxQ0mva3vwIvAu1UDrbfYeJdnVGrq34h45uHLVlikbd5C22fPqypyR7I0sqaxZS
         xkug==
X-Gm-Message-State: AOJu0YymwUHZMp2vU1H7W2NwOu77Nu6LAZ3jolN0LKLLhwpKZMH3egau
	Z8CcAEs9SPz0PWGb5/y8rGsXGMj1L7P+1wPUbx8URCYYtpNIOJJ7wNayfQ5EjjQukRoF1i+5TxN
	rCfXrqEDJTGUNEevFOpfwrj4/TXDQdYOPv3euA/hC+3fNlOhXlztCqvU=
X-Gm-Gg: ASbGncszH2QWAO6SbdZbsUagg59n6TAdvBjaOiws13M4BUaBDimyjGR67MdKWLHFh3+
	z9mR5JQ6mxbiGjnpWACDVMh4O/yqOpSg7iSdYK6JkGuUpnYR8pK50W8d8JNu2ygWwzVI8blHhZb
	m8U02KTLnCzmmB48AU5gsuKhb9fafwDoWi9lcP1e0WxJFZo5jUsJAhLxlxSpQ9Y0j7OhLcNw+xp
	qxGi+Uwsg==
X-Google-Smtp-Source: AGHT+IH6A+Um3dpeY8Dm42zgO4n8/xzxsFJM3iyo1WJpu/sfQIsQBpncc7zmhFjOBtd1qgCo/X2HoNs8hle55ox2GvM=
X-Received: by 2002:a05:6a20:c6c1:b0:220:2d0f:f8e1 with SMTP id
 adf61e73a8af0-23d48febfb2mr2381499637.3.1753250544878; Tue, 22 Jul 2025
 23:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722114220.87570-1-hanyang.tony@bytedance.com> <aH-dGhHm2xuY4yT3@pks.im>
In-Reply-To: <aH-dGhHm2xuY4yT3@pks.im>
From: Han Young <hanyang.tony@bytedance.com>
Date: Wed, 23 Jul 2025 14:02:12 +0800
X-Gm-Features: Ac12FXx-OQ0rAmnTA7e7sCAkrlOVV1FWKnsu_h-gCje4bh-Hvw--oTtkViQwg_8
Message-ID: <CAG1j3zHn_wp-R6tOJqCFi+wKro_t0oNj+aHsnbLw+O66i2YvQQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] blame: only parse detailed commit info if needed
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 10:16=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>   - What does this buy us? I guess the answer is performance, but it
>     would be sure to quantify in which scenarios and how much of a
>     speedup this buys us.
I actually ran some performance tests before submitting this patch,
On a 5000-line file with a fairly long history, running
"git blame --porcelain FILE" for 100 times, the speedup is less
than 1 second. Considering the total run time is 180 seconds, I think
the performance gain is negligible (the speed increase could even be
due to system noise).

> - Any reasoning why those two callers don't need the information.
> Reviewers can try to piece it together manually, but it would be
> nice to hold their hand and lead them through the change.
These two callers only access the author information part of the
commit_info struct, before discarding the commit_info object.
Sorry for not including this information in the patch description.

On Wed, Jul 23, 2025 at 1:08=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> If the answer to the first question is "well, not really?", then
> another thing to consider would be if we want to remove that
> short-cut as conditionally grabbing only just some pieces of
> information without getting others is not helping.
All callers of the get_commit_info function request detailed
commit information. Removing the shortcut would reduce the
complexity of the codebase. I will send another patch to remove
the "detailed" param from the get_commit_info.

Thanks
