Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B722538F
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065139; cv=none; b=EOXM5Nu0DeWMZn0mUa0u4jP7sOM/x8NARWhcRHoAZbn3c6QRELDpEss8BLw+z2fQCT/KFSrqVsGVHWGkextYk1yXeJhaULODPkBxIsWVe3JIUySZ2ueV8MPRa97mvYTm4sxESTw0BJE4rpDVml/Fy4uTCRB7e+1fb1Ie7IZ3Vxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065139; c=relaxed/simple;
	bh=Av/23UcLh1N1iPB1nnTI7izYbrD4B1BKTZ4Q8SitMFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tTIaR3LhDxcLuTwixQ6n8Ou5vlUY3L5wHVfsDdBiR9IbCzE2ALjk+Sei8j8Y4mMoRHmCBUcAjrk4MH/HtD50y0HaPteCGOKwaGv5kMdCKdx7h4nUN7QL4mZI8FnT/iynNMznY3HFFoGL5ishKK+U9u2Laurr7i+EahSDxZXbllg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdooY6cV; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdooY6cV"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-40a6692b75cso3914256b6e.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 05:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752065137; x=1752669937; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Av/23UcLh1N1iPB1nnTI7izYbrD4B1BKTZ4Q8SitMFU=;
        b=kdooY6cVnNJnEyTytfeodWFaBafFM+Y56FdEfo+TMHmkBCuyjyBhAbKS87H0W+bmCX
         y+kjhQJUi3ghnTsDns980PZINgPR/RFs+at6pnx3pM3n9noO86/ufvT8Jdq2aCwioeYV
         TsbedLzdpyTaG5PBubwGMm5yYLm8FJFiCb/jjAWv9qkOzFzG4fiI4TjSU4My3J4aGNd7
         0hO5oD5yP7Lru3Pqurt3U23JtwI/oCgwJNI10v80Pqb202l0GrWNPLLRwYPZ8AJ8jQUo
         x/6XUqFTIhh/s1ytI+VqKX/PUvTEqPH3g3b2wVeCREAbC5CfGBSOt07JGdW0ARkfjF2b
         q0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752065137; x=1752669937;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Av/23UcLh1N1iPB1nnTI7izYbrD4B1BKTZ4Q8SitMFU=;
        b=IxiuxvqADVlmj0n7PdxLcpKsIOydHPSKwN+a798xouYi62r1tHldy0x+7QZzqrb/Kt
         zpYv5VWjiBotL1V2qsUegVlWOWxJPGfNtJzrO79jZHrMsTaAlGWe2L6VlExKK1Ps77EQ
         awrauR7zUGgapGlxVU1G68tzJ/uPE8BCRyRDajByVA1G09I6FCL61f3r8yqaPETpVoNA
         gGKQKKTF1ezbpwSf2I2wPTQrWvvvKY3tY/awTosFriDk6PG1UYxE8KIjAB6VNoUtpXU4
         sXPqro+WOtFETPS6e8xvZIj1cviCEGYUXCQ5jkg+t2Nex2gnL28cvyZKAzrHbFt5Nsaq
         jEBg==
X-Gm-Message-State: AOJu0YyZjFtVQvPKqC4joQFqCJb8ITk90WAxFj72Q0wMdq7e04nzoNFl
	TkQk0Z6KL9BMziTTC5a4Xx2A949RUTOGNZtrcT2wbgC6VN8NhNNtLKDdXdwb4Z2shA7TnbMFv8r
	bqGvgb/GgZaur4Ny6k1plmf1NvfTY+92tUPbP
X-Gm-Gg: ASbGncsA7a/71gjd1kXX7ucuMhZTXqh3zWbNk2Hg0SG6FUrqZGcWzGdOQ+jbdQRBBoL
	SIByM92UWJLx3yZPalLDDPBclNFky5YoVI2n1HG/o/1GkCbDmL34hJNG3HbbrqqvcEcGpP6Krgt
	bIeI+EiM+CdWqyxZ5BSaX7g1Wn1SQlSEKIpQ9KYvDoWAQ=
X-Google-Smtp-Source: AGHT+IGwe1/j85HvZiFfprzqhXfxKfkDANX/2JK55LBt+1pb+PyrcODMKxU5y0zd86HPbiGXqn9qpeBpYXaiQ63kDhA=
X-Received: by 2002:a05:6808:4a4c:10b0:40a:a971:3918 with SMTP id
 5614622812f47-412bd499a85mr1096141b6e.38.1752065136702; Wed, 09 Jul 2025
 05:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKMuBmSeFh63212_GhBHfOTbW5VaqvQjo7jz4aowm8bntCXkVw@mail.gmail.com>
 <20250706032512.GB3041790@coredump.intra.peff.net> <xmqqv7o2vc64.fsf@gitster.g>
 <20250708225007.GA1180568@coredump.intra.peff.net>
In-Reply-To: <20250708225007.GA1180568@coredump.intra.peff.net>
From: =?UTF-8?Q?Jos=C3=A9_Miguel_Armijo_Fidalgo?= <jm.armijo.f@gmail.com>
Date: Wed, 9 Jul 2025 22:45:10 +1000
X-Gm-Features: Ac12FXw4tHtX6T3krIUICy14ZuYAR757RNwYODMiMy7XOE-YP9pNL64UfR8EUDA
Message-ID: <CAKMuBmS+jFO61iFP5H7-B0UKsiguZ4ufkqsUg7YpZGoJVMHYaw@mail.gmail.com>
Subject: Re: Bug: "git stash create" ignores "message" argument
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Thank you for taking the time to look at this issue.

I don=E2=80=99t have a specific use case for these commands yet. I was simp=
ly
trying to learn more about Git and naturally turned to the
documentation. However, it didn=E2=80=99t provide many answers for these
commands. I understood that a use case is to create a commit object
and then store it in the stash reference. And as I kept experimenting,
I noticed I could pass a message to the create command, but it wasn=E2=80=
=99t
clear what the command does with it.

From the perspective of someone trying to become more proficient with
Git, the documentation didn=E2=80=99t help in this case. I wasn=E2=80=99t s=
ure if this
was a bug in the code, a documentation issue, or both. After reading
your answers, this seems to be mostly a documentation issue: if the
command and options are there, they should provide enough clarity to
understand their basic purpose and functionality, right? It also makes
me wonder if these commands aren=E2=80=99t commonly used because their use
case and concrete usage steps are unclear (chicken-egg problem?)

For example, my understanding was that commit objects created with git
stash create could only be used to add them to the stash. But your
comments have let me see that this is incorrect, and that these commit
objects can actually be used to create new branches, perform a
cherry-pick, and so on. tbh, I find it odd that a command of the
"stash" family can create a commit object that can be used for other
things. I can understand that this is legacy and can live with that,
but it=E2=80=99d still be great to have it documented so people can learn
about these commands.

Looking forward to hearing more from your insights.

Cheers,
Jos=C3=A9 Miguel
