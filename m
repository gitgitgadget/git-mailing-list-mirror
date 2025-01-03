Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE22F1B87FA
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735905563; cv=none; b=IH7xRPYcExmLLZ0c+Fghk+RCaTQ8uFjPJZb6VxhNeyviO/3t+cRiJj9o1L/7hW9z9lbFhMeWJvoylx0aEcHanuUXzLPtNF3kB+jpP09msLNP4ocUqIjzQtUDBRK/LxKPOkcKcAlcsDbGAPOyUSYpHqbjZxStwZYb4DAF7LSzFZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735905563; c=relaxed/simple;
	bh=7FC51RXd6Z/apNhGRShDpg6xEGIAhHzqvtn7OIQ+Nq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0i4A+gPHw8M3Tsn8Jd25u5GFFwwVIcC6g0aQ7A5Cy8SO4TVLLZ4P/tYMFu1qq0hOsG5fxQpZuM16k2TJi8KD05cKv+o0qCfO68HZ1HiC0iQE5WHBF3RWobpNbUjKUM16yxWctpYl6qJUaCC7sUS1lH80Nut+5fD5xRJCm3bA/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxUQ1aWt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxUQ1aWt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso87467545e9.1
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 03:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735905560; x=1736510360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpLnVuXDdn2LhdNObRY+RZxw6s1GhVCoLhlhNErXr6M=;
        b=HxUQ1aWt7ZJdjvOGISOl1o6hk+x6RtRS1pUtP2VfClj5RIIpeSqsFFQhCLENYs8GCO
         RtHY61pdQM6ctNfuC0wKEVFm2VjhxQAKF6GmJroVXK3sU+cZbKFpRan6Kaa1pnpYdLlO
         dRe+vFlP12X2iIIOBw78WRr/D0UTP0i6KzgOfJbL9v2X5NH9ZK6wEBoqqD2KcxsrRAFu
         7LMSFl7QOr+Wv95xN2B+wFoJ8aTITUwm493HQH2LK6lmYLhvNeCU5v8sWfsv5+CTGpya
         0hAkarVdx+1WtS5TKFj6U2VCeth6PHR7I1OT1wtaHXcMT8uZ5cj8jO8esshE+pjCl++J
         /gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735905560; x=1736510360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpLnVuXDdn2LhdNObRY+RZxw6s1GhVCoLhlhNErXr6M=;
        b=qZ/tpmN9IPHkSVx48lh5UHtiUi9O6xAecs6DeJXU5R1oS4EtjYCxWM7J4bdfwDQAT5
         qUVxD90e4Boqyj7m5eIQ74how3ILEWAqZol59ZwJtUEyP8uBshJgQHjVZgWflzSH7Mk/
         SYvjruWCv1f3MzSOwrjY7fBnX3Du9V0xWfA67e8eB7agkz9Uy/zcIIOrAYUvjgGu/VDW
         tBoVD5uSuj/xBlX87WAv7gSh7cWNZQA6///fYNYSAsjRHbU/itZDewEApCq8uEORCipP
         jJMhHocjrJUU9pFEH3M0u4fzA+qoeiHb0+XWI02k3SAzu+nG9RDV5o7y+vEz2TbI7oqT
         ozfA==
X-Gm-Message-State: AOJu0Yx1XdeNctgxIjYpUswyBuH2zeBC/bulqycLvb6f1WOS6uHBHC4u
	fxEZzMeaqgJoYsXFQe2088PP79I+mvFcloZ20n7HKqSE4xvSxN4g1KlaPSshQ17eyUPqe8RJDrD
	oScPWkOAiUiWvVNGZ73HSCfKtb5tmAuRH
X-Gm-Gg: ASbGncugtsPHWXF5n0FJR4fQ2Iz8Ip3PSM/8IbWcBN5iJrtTJx5IljVwSVbCOGdJrC/
	w7QKd5ndds1b1YuaFCDCPlOb2TgWmeJLN5Pfy
X-Google-Smtp-Source: AGHT+IGb94GCx2LfW89BiRl6lglqs5SrtvtVAXF3i92ehIxDJg4qkQhgeHy9DQgfyJZTegCOE7dGCVlkNgmO/dQCq3A=
X-Received: by 2002:a05:600c:1396:b0:42f:7e87:3438 with SMTP id
 5b1f17b1804b1-4366790cd9bmr462254815e9.0.1735905559883; Fri, 03 Jan 2025
 03:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1735903029.git.martin.agren@gmail.com> <CAPig+cQoFC_2M-S0d7SLBPFvusXQC93pbk3QP2+qhsa7BJGnuQ@mail.gmail.com>
In-Reply-To: <CAPig+cQoFC_2M-S0d7SLBPFvusXQC93pbk3QP2+qhsa7BJGnuQ@mail.gmail.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Fri, 3 Jan 2025 12:59:08 +0100
Message-ID: <CAN0heSqKsAoeQdhUhP1fK8V3H2Xi=UeoHGM1GH-=QdysC99qwA@mail.gmail.com>
Subject: Re: [PATCH 0/2] documentation fixes for 2.48.0
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Alejandro Barreto <alejandro.barreto@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Jan 2025 at 12:39, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Jan 3, 2025 at 6:34=E2=80=AFAM Martin =C3=85gren <martin.agren@gm=
ail.com> wrote:
> > These two patches fix some misrenderings of the built documentation,
> > introduced during the 2.48 cycle. As usual, the exact current behaviors
> > (symptoms) differ a bit between AsciiDoc and Asciidoctor.
>
> Both patches make sense. Out of curiosity, how are you discovering
> these problems? Are you, for instance, running doc-diff and manually
> scanning the output?

Yes, exactly. Something like

  ./doc-diff v2.47.0 v2.48.0-rc1

is a nice way of finding out what's new. Occasionally, some oddity like
these stick out.

(The diff can easily look huge, but often several pages contain the same
content, so the 2nd/3rd/4th/... instance of a particular diff can be
skipped. Inclusion of diff-options.txt would be the typical example.)

Martin
