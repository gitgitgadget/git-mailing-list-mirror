Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252BF24DCF1
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749035654; cv=none; b=GBndRYav5e6i0TBvEqd08TqavmHLQMywusEfnN/rE2y38ZKNCVFq+ydtuutzIZiO/VPnh9Q4X0sedej/VXVEIgSMOJyEwDniUdUIlacwz2U8S4rWNaotGiKdV8KzgAWdOVYbgDa6Bu17DJyRUisMrNhBSaV0glEwAWcRkbEr4f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749035654; c=relaxed/simple;
	bh=zV/EpvZ2zxb98T0ACH737FBW9NlRc03VeuX1TOaIPmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNDiZrpyiFHhaYCfOWImIx8Ooll4B/z2x9tlPq5s6xr1JxnbiDqoP17H6Jj3dFbYrgs8JDuRxGFVOYVIAW9BGVS5sLVcNGI9kZGSHq2VKPligeJzYsn+ejj/nJMUey0c0JEsMH1q3yXCJ/JyaPrx8Kwo3bkehmzNqFu9GpltlZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJuPNJ4n; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJuPNJ4n"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5534f3722caso3398453e87.0
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749035651; x=1749640451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zV/EpvZ2zxb98T0ACH737FBW9NlRc03VeuX1TOaIPmw=;
        b=VJuPNJ4naTp02TiT1h6E6LIXCY++kvxBMElOD1nbtZRI0/zfO/G8ObFBDjsvO+80on
         kDp1pd/kn4hY4O3kw/j1omRTLOoJsGmRxdTNSdtc92cJ4APK1hVdGo+OjEAo2cgyKN6z
         0S7Jr0YuM42WW8IuVa71YDWOhSl8l2QXluRbCHMYXP2Q/xgMdvaJfA5XgJnaBO7Kz9PR
         9D3joFOsyb/uIDGNW0lSSur2n55mwSg3b7164eO4wPsPnYpmcN5bIQwKExY+jsumkUB6
         hvel5R2eWeKOa/vaa5AhuXtp3BaM3/thjpzu2gUxSp96z9AC9Wavmipc27JeDCMz8aoo
         dEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749035651; x=1749640451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zV/EpvZ2zxb98T0ACH737FBW9NlRc03VeuX1TOaIPmw=;
        b=iOrVH7bB8keNlEEctY+1SzcvHLd2j4gWcxvppp8AI7HRllqfghFls2Q0FMbS+K8YkI
         1IKIBWfxkCcpevBvEWUTLPmz69aBRdXhMg5GOyZM0Uz7yO00Aj4qcdCGKBlZDbER62T2
         vFxuDnvWWNFqUqs9eOjjg2jGGgang5E1XrEq7FwAqr7vAx0z6ejQVXZaqGUhCUhZT8zf
         Q7kZKCv3nji+DMTsyb0wdzjCEyCpcMSu6YraVnmpe5wnbM1N4Kfbo9Fc+Wbdszq4AHqz
         ViYH+RzdBitIlVHBjjZqc/f/KZk+gjTibSOHYi9YI+l8rDt5ddcoRt5qHfg/b00XVWA4
         2xpA==
X-Gm-Message-State: AOJu0YzNZ5L0W2ppEKqzUc0n+EAKPsGpZbmP9Eu3Me8sbzQyhSc3IYZZ
	KgvlYaQAsw9OvL93PypD9axalhEYbnnQvzJI058Tauwqy99lNYHrSOhTg+eQPzXkd8uEbZsLfM7
	aF6LHj30+nY55zrPLLt1LILJJHi8D9lY=
X-Gm-Gg: ASbGnct2GJghAIq0xoezFzRzsKpAKJroDiODQLagiQ3fFqxSwRBmRT9v3IpAgYeCCMo
	gsmCxxUQMcQ/ifGYkVBiFou33xUOFmn/NU/4RaK1CvJBTUSfHUDw7IkLvyhbVLAyM8r9JWJmIuu
	ahbqBj2RcODHIWA/tDqjaXldosMcym8+mGA/aiqD/9v+yPc7IiKNdp4ks=
X-Google-Smtp-Source: AGHT+IGj04m6sRut78dGUW4fvBwpLwWdaosT63Kd/yWyjjXywGhpvMc0PO9+YVuiIx0MGwMBavtZtbk9gtbstYscy3Y=
X-Received: by 2002:a05:6512:39c6:b0:553:2dce:3aac with SMTP id
 2adb3069b0e04-55356bf02e4mr756157e87.16.1749035650795; Wed, 04 Jun 2025
 04:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3B3EF793-F2B0-4D77-98D7-900E5273D498@ibm.com>
In-Reply-To: <3B3EF793-F2B0-4D77-98D7-900E5273D498@ibm.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Wed, 4 Jun 2025 04:13:58 -0700
X-Gm-Features: AX0GCFtUEYD9Ni6y0GoTC2YGN_a0rzkSsA1IuPeqL-p1VWrkakOlRs9ECk6EkvY
Message-ID: <CAPx1Gvd9pUbfyq_AuQmqTqNY=mB+=agoreKR5DfphNNgc8md6A@mail.gmail.com>
Subject: Re: Clarification on GPG preference update prompts during Git test
 suite execution
To: Haritha D <Harithamma.D@ibm.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 2:39=E2=80=AFAM Haritha D <Harithamma.D@ibm.com> wro=
te:
> I noticed that the ci/run-build-and-tests.sh script in the Git repo does =
not seem to explicitly handle this scenario (e.g., no --batch, --yes, or ot=
her flags related to GPG). I=E2=80=99m curious=E2=80=94how does Git's CI/CD=
 pipeline avoid or suppress these GPG interactive prompts during test execu=
tion?

GPG does not go through Git. GPG uses the "grab hold of the user who's
watching this and ask a question" interface provided by the operating
system. CI systems disable this interface (or do their best to attempt
to do so) since there is no user watching.

Since Git is not involved here, Git has no control over this. You need
to deal with this at the GPG level (or use the same tricks that CI
systems use, but those are considerably more complex, and
OS-dependent).

Chris
