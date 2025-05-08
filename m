Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEBC7F477
	for <git@vger.kernel.org>; Thu,  8 May 2025 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710456; cv=none; b=Euiqud/h6A1Vg4GMCFp6HP47KrgKSZPowatH4mNgapDBuDVPIxKi67cihK1ESjw47EJRAUq71gZParc+37t1bFy6JQBykwyt2F3xxmyR9Uw+tq6Jub9kTG9CQIeGsf3ilEpHtKF00P7k0ZQEFsasKU7IhVnYuSO+RvdhJeyu+Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710456; c=relaxed/simple;
	bh=XRa3VSsVvfDDfHXB2Gino+Dqwl0xGZO35z7gjaEyrC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZR42NcJiSgB3cbjoSs1SN7PYlxO5tWS4nxL78EMv7olcjUOroJc3RfazeuwnEHCNlPDoY9as9EbprCZIM3SpA+tDREToMsX+iU60vcvYqD6aJGIYzKk8KQr/0lsbs4ogxhs7X/Z/8ocanl6P5YoiPmX8WQUP9JkLY+cysmaSWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fElsJB2y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fElsJB2y"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fbfdf7d353so1248065a12.0
        for <git@vger.kernel.org>; Thu, 08 May 2025 06:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746710453; x=1747315253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ul3R+TtEg/N6+vmiL4azcCTRX4pn9runBtmsRYNWR0s=;
        b=fElsJB2yno67fI5qF6E8sZPauWSdO5vo/NsfS7ZUBwNdlX8jWagTk7J2fu9e2QJgTZ
         3n8PBjHA2xZJMyrb47EAaux5/PquQ3KzP7KdRCt+YFwfcVy8jSscCGUBtRrui+kcA4xb
         TWgKeNWMLQCU24dn7smqFYcsu9kGJSDTdNmy90drOivjstV55J4MRejHawzbjYVuuf0f
         /F9XiZIHEIGTO89rp4YbiyC9NrAH3DFCsNTW+tn37/DhDIFVPyABJFBFA9HfejYl/jLI
         seUJAxxKMc/KmpvaYAhbkRwPo2UWJrryCNdg2cvys5wfV958Lla5e68aHH36ZWwP8R2s
         AtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746710453; x=1747315253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ul3R+TtEg/N6+vmiL4azcCTRX4pn9runBtmsRYNWR0s=;
        b=SYSWLC4RWPq1QquzlwAHFs9Q30Wn5NPacZzfEFtHo69cKL0nRyAKW6WVvn+FG2+4qh
         jci3YE9TiZey6KyeiqKhWNNxZWckBfUcWzdqWN8bq7LW/3JjZkqqrvsMpm25LmqalEeG
         4bDzlBIYacsTss7gvVSefQUyVtLj35wrADnkNjbVwyyVpJkMEZl0X853PxLKMX1cMCSQ
         Mf1CeYR/FIl0HReCmdavR8SfEKalriKYU+ftRf3qinTpbaylwuU8OBc7lrg69uZ2nqPH
         q7YJfbh8YFywKuipuKiJPYYRrkoGSPPYH31lSLzWbrQBoYjESE6h4/pRyeWIhntZJESV
         3AVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfKQzbYQCmgWFq/aKs4rhKkVuTbQaVNmLy7WP+sejGXziXlu01pjybVup0yLJisZQHZ2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsM1PNd+bhuZQD1H8E9oMW9hUrg/5e9v34Qg0HkdxQzSyhdz+a
	/IhpmpyNJZhJaIaTs4wwT/K8g/CSRxgQNj+gT+VLSKQoKd/3RXxxZAp3EjV9yjGWc12ULvE11c3
	G3+KrIKqcXpyag97diEVoiZHd4/Q=
X-Gm-Gg: ASbGnctap/Vvsba7PD0A8PK1ZiGIq5v2a3+uQ8J17Fo+pA3PTMEfp2yAAGZG3JVRrOg
	7sBjFX+h2GMcFjMiQ+mLZiuwsPDftlWAz1eQZ0SknVUXWGFHlYyH+T1Jb5TPZXFd3s6HqQH4gjp
	XISwdbqqlLY0SoKt2rGIib7cScrG5KZVhULu1oOkoAuj9c++ZBNDeGuDQ=
X-Google-Smtp-Source: AGHT+IEB80hlVofaM6iMbLpSETWlWe26Lr5TOjhvfiPtG0VB/xplSb956kofP05AHdI3i65WdQ2riMmnq1lPLeBMJBA=
X-Received: by 2002:a05:6402:4302:b0:5f4:370d:96bc with SMTP id
 4fb4d7f45d1cf-5fc34e46c57mr3153818a12.2.1746710452882; Thu, 08 May 2025
 06:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com> <87ecx0ijqt.fsf@iotcl.com>
 <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com> <9a0c98d1-4a77-4f2e-9aa9-bbab11b3e44d@app.fastmail.com>
In-Reply-To: <9a0c98d1-4a77-4f2e-9aa9-bbab11b3e44d@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 8 May 2025 09:20:35 -0400
X-Gm-Features: ATxdqUF0alqATtCLm6V0txuyiZGburrZGgEnCMzuKH-d28Zvydw7xifvyAoEpdE
Message-ID: <CALnO6CBNiQ503+YTXfq0pwY-6OPRZvzAtE0BPJsw7wb=8O3YfQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Marc Branchaud <marcnarc@xiplink.com>, Toon Claes <toon@iotcl.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 4:49=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
> Use a Git user I don=E2=80=99t see the problem.  `git --list-cmds=3Dbuilt=
ins`
> lists 144 commands.  Six of them are `-tree` commands.
>
> It=E2=80=99s not been my understanding that people stumble upon niche com=
mands
> that easily.

Seconded. My experience is that the distribution of Git users is
skewed left towards "add/commit/push" with a long tail of curiosity on
the right=E2=80=A6 improving discoverability is a worthwhile goal, I think.

--=20
D. Ben Knoble
