Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03D29AAEA
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867160; cv=none; b=j2ARf1RKTpfA7lq5gkeWIrGjc/Gop8FwJd61nfdil+o4gCL5fuPhC8th4blWeLEjgCSUXYUbOmOSydY52DVDvBxG0DpW06Xl9kzOtni5n4LDuXxEX8tJyFVsbhCUOE+++8oH9H8UlbIUCmy7NO/KSkRnE54uXeuL/nd173hyxJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867160; c=relaxed/simple;
	bh=ZD9IhVng/2YUclkrwCwPu5lRVjuySOY/u4JtKRf0NQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h35W08QTUncXXSUF0XYyfjxhHm7ueJPI7Cd3Q4w0xcC//41kCkqUkTkKX+U6EDFWp2YBsQ91lk4441mGJ9fxx3D0xn+CN5vICJpS05t4BknnwwzxqxP2g2pZ7FJLHNzNDK2x/i9y98AmMvvbZjGdiK1wIlCHXC8KN33TqdreY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlQSoi2J; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlQSoi2J"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b31c6c9959cso4560a12.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867158; x=1751471958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyVbND9CNnn2/tufXdMB4dNXkUwd4tzWv2r408GVxVA=;
        b=IlQSoi2JSXOfgLM2ofXennMaExKV8sALQzUBYgKjimbs3HMh1CVnQGzJlLMpnRtt9f
         euQbBJKQEVCf3ZvEbDgszBo22Io4SbT0f1T/k8N19AWP4QlPnPKCq+v69dTaTxvPpvPb
         Rq2pu7Kdo5JAJ01mJLHSbsX1nPBbgPQWpB05ymlRhI8ubY93pcjg3NwlLJ1LLrpFnQ+m
         dn6/rA+aeT/F33lKnwCLHon4RmiaBIPhaY8xR17Egrm14Oa8NcPau98coZdmWkXUZXWK
         wwxeyQVqYLPdQFFhlnRmzRf5OQEYa/P4cdC4YWUsfQXc5Sbs8q4l7wRjdbqJJSZ3DoOX
         It2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867158; x=1751471958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyVbND9CNnn2/tufXdMB4dNXkUwd4tzWv2r408GVxVA=;
        b=LcKQFtKXq+8QRbT+FGfvAbmUHD3aWg7c6RzLVBIp+zgUpvzKGXS1z781FSc+DeXTA5
         fXyDsRVi8mF8NJfJJrJy0N9szqe9NTHKmST1s3JRtaCMvWxMUUhJBqMPM7EnzCc+x8jT
         DKoX5FNCWEowhmTdvDN4eIavqjFxS7aZ3mnvJ6qsbebraWu3IvXdmb+q/iUn/dPLaTbY
         jUeUg3iTHNWBAHWnagGIIrVQK93eACy+pClbjgXSXWYknDJRCMIchZq5H7b3G/8Cyuz6
         2ZaQC4crWFRZxwZru1sl217q/HGZFABtwF6Q17pvxOtf3r0lKSt3yulSrD31EXtvZLzC
         TSDQ==
X-Gm-Message-State: AOJu0YyFM/K3uAsbMxv8c94H6FpEuPVGdUu4J0V+8nAY1Uad5rFd0wlL
	md6BJ8Y+AULvt+n9vwEUy44x+L6IkrlDz9I4KNippYGcSdCxkGz4UeMQIg/+OI9YDPWT0H+ulr/
	2+v4C7PxUIW5Kn8hmPCjPK2Wi06jwcpVzwHxT1Qk=
X-Gm-Gg: ASbGncvIE8J+O9R/Tj5Gkdx73vv5x5nV5grDhZ9Dd1R2TaOfNfkgmTgvpBkEtoIc+A7
	xlJt2XjDnfxee7ax++lWcE0muSyWf2RmF4WTrG75DEiNjnuslI8tqmYUXiw9raxX0DG9IjzRjsQ
	W7J02DScE5Pu9QN5Qvyuk/tuS6PprSH1SefWg+jw79QOq8LsvOsZLkTBVrDkEyMaJik7q5I6pME
	kpzVg==
X-Google-Smtp-Source: AGHT+IGTNmNVbu1sUFvYfdj6aGFuiea7tXkR/fSpTNAU4F30jdB6z1CBav/E6TDafYhTm5gMakxXbc8Oz1NUZKFqzVA=
X-Received: by 2002:a17:90b:37c5:b0:313:62ee:45a with SMTP id
 98e67ed59e1d1-315f2623cc4mr5794946a91.13.1750867158086; Wed, 25 Jun 2025
 08:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749343601.git.ayu.chandekar@gmail.com>
In-Reply-To: <cover.1749343601.git.ayu.chandekar@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Wed, 25 Jun 2025 21:29:06 +0530
X-Gm-Features: AX0GCFuCcaYY655L1sob53blbmYTmODz4eHhp7HrY8N6ALs4xZhaCqawcSdLJII
Message-ID: <CAE7as+aJS7qaqoRTZsiL87m_L8KMYe=EE=-uB40jh6yGXDKO_Q@mail.gmail.com>
Subject: Re: [GSOC PATCH 0/2] builtin/prune: remove dependency on global
 variables and 'the_repository'
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, shyamthakkar001@gmail.com, peff@peff.net, 
	karthik nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 6:37=E2=80=AFAM Ayush Chandekar <ayu.chandekar@gmail=
.com> wrote:
>
> The aim of this patch series is to remove the definition '#define USE_THE=
_REPOSITORY_VARIABLE'
> from "builtin/prune.c" by removing global variables and the global 'the_r=
epository'.
>
> This patch series contains two patches:
>
> 1 - Move the global variable 'repository_format_precious_objects' into 's=
truct repository'
> and update all affected code paths accordingly.
>
> 2 - Remove the dependency of 'the_repository' in "builtin/prunce.c", allo=
wing the removal of
> the definition.
>
> Ayush Chandekar (2):
>   repository: move 'repository_format_precious_objects' to repo scope
>   builtin/prune: stop depending on 'the_repository'
>
>  builtin/gc.c     |  2 +-
>  builtin/prune.c  | 25 ++++++++++++-------------
>  builtin/repack.c |  2 +-
>  environment.c    |  1 -
>  environment.h    |  2 --
>  repository.c     |  1 +
>  repository.h     |  1 +
>  setup.c          |  5 ++++-
>  8 files changed, 20 insertions(+), 19 deletions(-)
>
> --
> 2.49.0
>

This patch appears to have gone unnoticed as it hasn't seen any
reviews yet. Resurfacing it in case it got overlooked.
