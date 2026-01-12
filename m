Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4D2DAFB9
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218322; cv=none; b=H1k6xHJVuIpsILh8yMt5qQ85RaLaS4itrHiwedmynh43Cgd6Yb+mfdI24TBG4SL11vMHqaovold2cLj5TbSxeeFoJ6eTLBcVWF428nAbwzd8yub3tiy159OKFHe9A4oelnU/wWtSjGZkaqVMlYBFKCvy4XOSaLmVyBrJKDkTUKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218322; c=relaxed/simple;
	bh=pmf5mEeAAcD4eYLfoY8aXgT02xTitLbzhiUm8sTsbU4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laQ3XbzE2aTPhpwkvsD37HoKCyQUW1k0Kw+agewAqaEVJBimap1GZ1b+zLknobA+xsa6UzT9/XfzbB5foWWZDCQefQSZiZM1uCLZAUJFOyvc9HWb6SzWkehjTB9PjncRhwgZxQ6/9L1u4I0izJki9bRY63+Q3Y227h8aqtYhyu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwNvYRq2; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwNvYRq2"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5ecb1d9ac1dso3811781137.0
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 03:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768218320; x=1768823120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmf5mEeAAcD4eYLfoY8aXgT02xTitLbzhiUm8sTsbU4=;
        b=OwNvYRq2JhNEeMzi4xEoK5z1EHrSbnZaCdXryR5oV2J0iKfVnvzZZyiRzuR+unwWGX
         pxvjMzEk4unb4w64s/Y5wuYSoCfsJiAy0Z9tzWwGjtqgaMXTGrZ2bu+x6mBJJymAP8Ea
         6XhQv11EGgko3og5LtuND95F8s9hh8OxPk1X4akQX7I2EN5qdGdJymg/24GoDGqHpYbD
         m2K2IlciZDcwLNfzOEwg2zDTOlSGP+pilPHTKGytFvBaSjnlAPBmg1SiaShpySKFDsVc
         hYuCqGqf0MGtejwwqWtiGsADnZ/zj72W5/WFGqSwX0sn10hv35Tpt78SE9IFz9NsId+1
         OHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768218320; x=1768823120;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmf5mEeAAcD4eYLfoY8aXgT02xTitLbzhiUm8sTsbU4=;
        b=HXGCmrjD7EGCFxRSrdf9l6y/WMoRZueh4/lLkWzvZ8S1HJfAtZJdN8aR81kYSN6GF1
         Yj7Mg1didKL4YAwbZfLQ+iwJcVSU5I/E9eMEm+gAu3XpIZ/Udi17pHa8BlMpVBWcekz2
         B9DUJ22CZb+KCuRJ59GdNIxjkUKQ7JKECsNmzUO+79OM0gdVwnoSKaX3HVvHREyk1VqJ
         wPAAaYr2Lf5bJP1PO4Vw54ewFo6iT8kDPDmC7zT6w5aaEo9hxSt57ClzJKmJVeZRC0t+
         DA0sVjEoYp03x3bk5iV2raWvb0C4833ievO9tbc+zv6rgJ5bG1zJQ6qcXNn3MEYVaIW/
         PQCA==
X-Forwarded-Encrypted: i=1; AJvYcCU+b5P4tsUyGg3NRY/nIQdqybWF0i3wK3aa+Nw1DvnGWFqnSd0/uasdPWb28GVhk3K/Oag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPfOcvSWLtGlJ73cNzBZ+1wo5SDhcvI7Nf/QDKkPOIb2PTHPPQ
	jnRjutnbGal4rV46ucj7h71xk8vb5OUtbns861MbOQx2n8lPdJcHJ5YBt2GUleBro22YLI0UsXc
	d+wbiQXiE6Y74x/y5z8ypcdeqhvXxYYg=
X-Gm-Gg: AY/fxX57LagN6xCJ2E7NU7JfMGK/kgBEiN/S4etj9Cq0If7AHo46OupDSWU9rNkLNW7
	A0XBF3APu5Cw2O7TH27DXq2i5PojRpx/waAXDMlr9QWClmS060O1nL8Si1XlIZi/PdOwDqyXbN6
	GqqqZOUswjBBtTPwTsVw4pQOHaESNNMjP/oY0oA4U/V2mOE7HUG0XNTk+sBgXYuKEhRSD9bA4WU
	0VS13QxsImkTTirGd6KxxjOUidf+/eUo7X186jM8BBH9VqR5MbP44Up5t5aw5LrAW+axwSn8fQ2
	cEvZ4HRuFmYAQRBBqt4SxJYcMLYZfg==
X-Google-Smtp-Source: AGHT+IGzQx4sBs2uCNkx8d4T+dxS6D1C4j+cM092OrS4yoxt+Xzbnono/R4lc1YN6rCEqmFpVRh477c6ARbCS+Etk98=
X-Received: by 2002:a05:6102:4b0c:b0:5db:c9a7:bdef with SMTP id
 ada2fe7eead31-5ecb1eaeefemr7946516137.14.1768218320288; Mon, 12 Jan 2026
 03:45:20 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 06:45:19 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 06:45:19 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-13-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im> <20260112-pks-refs-verify-fixes-v2-13-2e9e453bd6c3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Jan 2026 06:45:19 -0500
X-Gm-Features: AZwV_Qiu09C5JBPp35k_v8I-fb648kaPTyi34GW4cAMyuAGdseySIqdHhy5N7Xw
Message-ID: <CAOLa=ZTDTqpWgKW7=X70ofFJEK66mfOEOgQy-PpMHo_n6kyS=Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] refs/reftable: fix consistency checks with worktrees
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000ddda6106482f6811"

--000000000000ddda6106482f6811
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The ref consistency checks are driven via `cmd_refs_verify()`. That
> function loops through all worktrees (including the main worktree) and
> then checks the ref store for each of them individually. It follows that
> the backend is expected to only verify refs that belong to the specified
> worktree.
>
> While the "files" backend handles this correctly, the "reftable" backend
> doesn't. In fact, it completely ignores the passed worktree and instead
> verifies refs of _all_ worktrees. The consequence is that we'll end up
> every ref store N times, where N is the number of worktrees.
>
> Or rather, that would be the case if we actually iterated through the
> worktree reftable stacks correctly. But we use `strmap_for_each_entry()`
> to iterate through the stacks, but the map is in fact not even properly
> populated. So instead of checking stacks N^2 times, we actually only end
> up checking the reftable stack of the main worktree.
>
> Fix this bug by only verifying the stack of the passed-in worktree and
> constructing the backends via `backend_for_worktree()`.
>

Ah, I was the author of this, I didn't know that the fsck function gets
called per worktree, so thanks for fixing it!

[snip]

--000000000000ddda6106482f6811
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2596e54393fb2dff_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sazNzMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXRSQy85dFdqM3VQWHVkdmVTb29xb0FvbFMvdVg0awpqTCtEa2tjczQ2
d3haOU1HcCswdlNOdmFzYmpIU3FLV3EyVmh1bDlrV1k5bUtOMzkySzgydDF2SkdIUi9xdis5CkFh
MmJHVlFzVWpvamZ4WHlvemNVNWZDWmZKU3o1TVZvbmVYcFF1Uk02ZmdzK0kyRFJSRUdQNkZnT25w
eFJENUgKK0RLTXEvZjYvYVpzVndSeTRKOUhmNjB6M2xkSzZzL01ZbGxrNUMzTXBVb01paXZUVzBP
ZndpQ3pDa2ROLzlZeApNVkFuM1F3WVo4cG9wNU9TYU9HMStRWEtaNmxQN2tvMVJCT05PdmFsS0Ez
RHhydzdVQmFJaVhURk1tTmlhNktRCjVvQkhUbmVWSitJZWlVMEhyUHJGNXB4Z2MyY1cyTlJMTXE5
WlNXUVoxSk5pOUErZU1TSlVDdUtWdHhQcFZac0MKVE5RMm5ISzcxU1VKQ0xHNE5ib09pYUh1djdB
Z3ZwZC9ZV1FBdEZyV0hwVXl3WDZTN3EzTU9yQjNZQm5PYk5QOAp3UERKR3N4djRSUzJiTmtKdlJ5
N3BIT3p5Zk9oSlBpZ0R4UGFlaHRLbmRHRzVSUHdRN1hwbDcvOUNvZyt4dVlQCnB2cVJuNE9RWEtI
MkZpbFpiQVhhRURLcUlqWFlIcG9vVUxTMlFPcz0KPXhjVFkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ddda6106482f6811--
