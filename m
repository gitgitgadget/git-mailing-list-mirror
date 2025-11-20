Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42B211CA9
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763622088; cv=none; b=QeKhxr7Waebo1Tx6zw9OsxDRelL74ELShOJYj8sVX836E/Pc1M6WHkVPktcMAAbkBFeyFmifMJQdE+GA9XQ1/4vVBeFKfG66c3HZtX2FrpnshzCXzHKqWxS4CiJRDNwHCtez/Sy3iGehWNmE9jcmvJuiBeLW5Uh0CloPYKKSnMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763622088; c=relaxed/simple;
	bh=8Wg8qqSlK2IiF/FRnBbUqaLrI2VRgEHTfEVXmO+218c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dff48hD40W9U4mdqAGEc/2iXS/z9v2btXFY6NpO4sJChTxIlCF5ZYwgvBmDwHXnAhLMVxz7bVooJq9Babx8cO3NS3XTuXYhjV2bMZclFESBG0sADiZC3vZTliiySZMcspes9VeiBnL98yM/AAmRQJwTYE/HToKifM/69HOb1rL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkwxwHv0; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkwxwHv0"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-94900d3ef9bso22897539f.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763622086; x=1764226886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Wg8qqSlK2IiF/FRnBbUqaLrI2VRgEHTfEVXmO+218c=;
        b=XkwxwHv0pE9Vk0JIzUYIvUTBgks1Fkn0FKVttJJFgL3s2wLKxViW37yEtt44JdLRWk
         Q7MA8w9t4ckYouup/OAsMjAjb7IP/sPD6xc/lVU/3DkwhWHXtaCpauQE7HmR18/sTURr
         ogVCwVAxhHGuG3zpEfVZioV1Y4WTyUrhShhVXsxQfS5vtUu7Ssa/AYxWcesa3Gz6ja7q
         hjhwQ0QbDBcv6osAW2D0UZ5f0Lp2rLFpDved7OFAYMMhrrsS09qI6FKHf3BFIL7FLOhy
         qhq3hXVaNM4d3R+U9j4Cr6/Qz/pR8fhks3BTh2GA6LQ4FB0uajAlCo21de7IODVndbLI
         pEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763622086; x=1764226886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Wg8qqSlK2IiF/FRnBbUqaLrI2VRgEHTfEVXmO+218c=;
        b=R1kOtlv8spnU79i85+1j2RG4jjYbGgmYOZAKTwfYNQU0JoxHVkhfiGEiNXz/wW3hae
         gomZzBR+GSg3zWJwZ2M7LuYODn7GEpMnt18grCluxlqMXjvlS6XuXtFngNkVfwoAKAtK
         Ow/nQaa40WU29bu6QkpIZ8c7Op0yt9ZspVDgmk4VMFIctOnIVjUZriRgLqTEuohUP1kj
         ztxdd+s1RpmP9b0TJKzRdlj/gOYOHgMtbaXJWHxMvnuu6UmNZEatcZek1tckGsvPrtpx
         gq3VCYL6zTbWgck2tAZxwlzFt54cRcMZDr4+29B6DFB7H+/Vk8zMpzmCjZgR6oyGmgoY
         6HwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwXhoAlFsJfGA93Ovwxs5EzV9eFTZSWwcPZGZmFC8y4bJhQE8vYJWgB9+z7z2comJsm3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzfaPX5MvevvecivCjM37FTH6hOuvE4NlBKprn/XJL3/I/ETBT
	LOFppc58nCVlzOZmGlOmcWztVS6UNG7w4dGewpGthtDXVcNSyphwjoYLpXXt6+8qcKFaSmaE31R
	Dnwty75+UfRIccuR/3Q4XEkQa+QMAMMY=
X-Gm-Gg: ASbGncsBPKq9W/lOkjpzJSnGD6Gj//KtCsWqvTmotIPKIv6XNQ9BEs8U7qk/uIcT20D
	Mq5FEFdwWKSxYMLltwVggoItz46kP6T+p3Pqil9Q5ZCwx/Wi252J5dKMwWHJumoCDKSgo9zq0kD
	Tbf4gqeJcZBpBrtUeKquFovZVHAwuizvTzZcaLc6hbAnYbssD0VkJ48vEzcO/MG7eAR7gP91iyl
	t+OJSMsxWLdXyJVonExwOBLdam85zf/Zy0PvkGyTddn0aM1zGquapAgYL02pQkFnXlpWkB7atQB
	hNx6rvLI2+yZhZNvF7S6BFaDmrzb
X-Google-Smtp-Source: AGHT+IF+O8Y8vh5XDBY5JCgfO93msBvDgFmPUkHbAAiPqRzlfGKMWP3L6F6jJTihl/Y41C+icibo2ucmWMr8XQowbaI=
X-Received: by 2002:a02:c983:0:b0:5b7:33d3:6f6c with SMTP id
 8926c6da1cb9f-5b95411ff1emr1290655173.15.1763622085748; Wed, 19 Nov 2025
 23:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-2-407dd3f57ad3@pks.im> <073e9a8c-3f6f-4e5c-862a-da59043eb16f@gmail.com>
In-Reply-To: <073e9a8c-3f6f-4e5c-862a-da59043eb16f@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Nov 2025 23:01:13 -0800
X-Gm-Features: AWmQ_bmtHrmtytv2rNwuUDI4dNCXX3R3OIGcuIrjbR0h8voKiOZfYmaQ7dWuy68
Message-ID: <CABPp-BGBWaXOtt1_TvkJDAuLxVNC2UAvM+g89avPRBK9Wrb5RA@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] replay: extract logic to pick commits
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 8:27=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Patrick
>
> On 27/10/2025 11:33, Patrick Steinhardt wrote:
> > We're about to add a new git-history(1) command that will reuse some of
> > the same infrastructure as git-replay(1). To prepare for this, extract
> > the logic to pick a commit into a new "replay.c" file so that it can be
> > shared between both commands.
> >
> > Rename the function to have a "replay_" prefix to clearly indicate its
> > subsystem.
>
> I'm sorry it has taken me so long to get round to looking at this, I've
> been intending to read through this series ever since you re-rolled
> after the contributor summit.
>
> This patch looks good, the only changes to the moved code are to
> namespace the function which become public. I'm very pleased to see us
> switching to using the replay machinery.

The _two_ functions which become public; otherwise, agreed with
Phillip's review comments.
