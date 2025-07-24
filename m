Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195423ABB2
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 23:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753398668; cv=none; b=RC4NUBtfGr8o6z0Ph/bLHaWhOuPPc+PILemwVwualekenKEpalL0+WUhRYt00TpIkk99XaDVal9KFbiZn5tDki4ASO8vF2c8Ys071nJIHQ3jfYxPYVENrgCVbWv1AyU/AM7rlTcBu9Li/+rPKbs1HZba5s+QuYOk4OTlEV5jQ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753398668; c=relaxed/simple;
	bh=OmUyU9bJHx47u8MGw+l4WI5CUaOn2O3inXuonK2vYlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDeS1KLZSNRhKK/9HOCVoWRGpod4gZXjMQLhAyw8saoJOViz6mjOkIv22coepUKzChYGZ10TgHcCnRhwTOnIVIOfUFd5l4ITIDvsGg6fkBzOfQnj8YuwX626PYiVKZ35C/saOFcObnXYQ1cCiKT1OjO69Bnffsjh+jJzeHBVqqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnwUoYzu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnwUoYzu"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so1289913a91.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 16:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753398666; x=1754003466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJG33AuYmAqFFD9QA6rMG3hdpghrjQtptLouYGaR0fA=;
        b=PnwUoYzucBL7ibYm8ZtR6xihLVvAiVEtuSOz2nr7DSDlvwiL7fJdDTCR1D8XQGRtPZ
         O8y63MCH7yoQ1TaiLYUEjg5IfjHr5j2v0EGtpsEN+GwKgY7oQ+Pvvxv6zXmnM3MZUr1g
         tfpfP2/Q4A35jOYPFIBVgBrE8hTTrIo+s8ZG6Npcj8OakCiBhy75bEU+piLTy1eV5Qw+
         JwUlf4uv273fye1Adw1R+XvbAJ2xw85tf1Bh+ddj+JBqO6126r+C4J+mh0E2JzSHuT9i
         U3Tg9zDVNwjra0R/f2sDh3JWZvLev1t0op0QNXw5JrN4g5yWe6feAUHenmffRXKb9lBi
         jCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753398666; x=1754003466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJG33AuYmAqFFD9QA6rMG3hdpghrjQtptLouYGaR0fA=;
        b=C5pfIpJv7CPLorHbVRGPbhOCsx/osZ2vxm2c7MkIRFjz44eYVmw7BKGQbj2FPDZsPJ
         pDn7MDRoLrI/+y8HjraA5uMlGFlju15f55SlQv4tggaIT1fDr7Bzy+hzTv4W/Vtp7uu0
         2x9A8VoCvQQ2iLsZ+c7wYmwrjQU7IH3EBC7N3Q5upZLID7COYxFbC9pE51+kYednF9aF
         LTeJoQUSXKmbHk8M07yYxxCgcn45Wr2kw2yGqLa+n5CRpOQZtkAeRO7UMxIN4ux66h12
         AwKRTzvQg9Ecls7jRLNZWlyi+M1MfrrRqeMRDQpS2y6yiwIVA3/AtpyjnWe9D1lZ1YsW
         f6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVczvObI5Rz4/s2chs2ERoc/OhKF2ht2504JrtqtrHyWpI6AiTe7t0/SgU5PIQ/PShwBmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ/FBhRPVXHT2DjKLRX+gN/BPpt+VvJUpGrRa51+xmP05h56nk
	FpaYQlo6iZBnuM0XfwpGdYJRZzSUmLmNSF7s8F1lH2vG0ve481Y70TtCLUFoRB/99yhXv6JYyyf
	kXivVYvCcB+YK8P3oellnT9LcCYqg/PQ=
X-Gm-Gg: ASbGncs6rNReolY6GubOH6CvR7kd5qZRxM+BKU4dY0yNDr/85CdRPAZRfEF3Fqgx7zQ
	Q43AI5tVNCOPZy2KnXBMejoXbLYoPEo6qPdtl83xhdWGT3+npL7xlX4QwBzQjTGB1lmD+0IrT+B
	Ed1/H2zh6IaSjwWz7f48tj9kaT1awZgIKNlNJKpc42qwhJ/6r3PZjIy1aXi7DGrY4KRM1we+tCo
	lEfIHI=
X-Google-Smtp-Source: AGHT+IGiN4aX3aF3d6YqvpZXeS92ByBNUwUMkK8aCAiTRQDNifcB7GaWmK5TRjT6fffPZNBjDKDQfMtzi604urfOnqo=
X-Received: by 2002:a17:90b:388b:b0:312:ec:412f with SMTP id
 98e67ed59e1d1-31e506ef9afmr13293607a91.14.1753398666158; Thu, 24 Jul 2025
 16:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFA9we_yDs9SPL2pJU_WiUz8CqvQ8ZPHwXBfTzHHbt-QGV34qA@mail.gmail.com>
 <CABPp-BH-bVrX+w7ZtQie_kJ4vaD9subtqsAG5+WHYCmG408xNw@mail.gmail.com>
In-Reply-To: <CABPp-BH-bVrX+w7ZtQie_kJ4vaD9subtqsAG5+WHYCmG408xNw@mail.gmail.com>
From: Martin von Zweigbergk <martinvonz@gmail.com>
Date: Thu, 24 Jul 2025 16:10:55 -0700
X-Gm-Features: Ac12FXw0fIFCUoe7BRca4hZ2SmUqTei3Yb-xKeiy2GlxjhI1iFC17jd5004veeQ
Message-ID: <CANiSa6gDgEQN31J6TGgYHHxi+-0O4U4YC4wyWeY0=GvTJw2swQ@mail.gmail.com>
Subject: Re: Precious files and the .jj directory
To: Elijah Newren <newren@gmail.com>
Cc: Jade Lovelace <lists@jade.fyi>, git@vger.kernel.org, sebastian.thiel@icloud.com, 
	josh@joshtriplett.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 8:22=E2=80=AFAM Elijah Newren <newren@gmail.com> wr=
ote:
> Or am I missing some case where this comes up?  Is one of the edge
> cases for the handling of untracked files biting you?

If I understood the discussion correctly, it typically happens in what
we call "colocated repos" [1], where `.git/` and `.jj/` are siblings.
I just sent https://github.com/jj-vcs/jj/pull/7071 to at least warn
against running `git clean -fdx` when creating such setups.

[1] https://jj-vcs.github.io/jj/latest/git-compatibility/#co-located-jujuts=
ugit-repos
