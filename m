Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01EE15CE
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718756482; cv=none; b=HyRWzbglz0KwFpcYrCdrYYskEYH9tZf8Dfqrbse0jbh0gI0B8+UuZfIusyJNDCX0/dULa/LRrHbNmQgn6jPz/7s/2aIg8dBbLs1fouWsraJ3maGAcmHcnl9hqKP1oheJJdVbfgzTj+sOxQLRwEONhurMI25Yfg23yuCoYWlUfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718756482; c=relaxed/simple;
	bh=ZFa9iW66P6I5KHxzYVDny2kOP46/gXT2PFfyTJdngsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5FQ3rl69PpOHh+sLC2fVvvcB3GQ3wXBQnjvuCZiD3hBFhM/BKUod9J8tSJurbxhwdG1AfKZDhLILiMtk3p2ViJpu+tOjFWOoY8ZM/Zx44XLYH7XmB2K98VZTMdTRtDSkOtK8AHaZ7HvvCMsAAspGZ4jT3f+/2JXSy85i1K3cr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfa4876a5bbso5621561276.2
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 17:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718756479; x=1719361279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yo7A+H/y8Y/FBgWv6oMhkD0gQQx5OGIAg0yIc5A/Pro=;
        b=w1992wAjue5TKNjd81JLhpH4WE39GE+uIKmjOarXJk0Ky35p03Wx/dCCiqzPfX47SG
         IwTZ+sm+E3Sqnb6bkIv1QPB6yppT4bTovqAE1QrEySk0DoP1zJEi7V2zyy3jy3AljmPK
         LNnAp3UGO7xLj4IjLJD2b/cJGQ4TEn1jEWPIqPFqEZViqCkL+QtGplrkkG1Df7fwTEtB
         wfpAXWZBXfzVtCByZCfePq8LY9uGiRrKYUeNcMIaeZq+82uphuD4CBSLuKq6/4mXU3Z5
         Q24bNVzHkFbbAyGg1ikj3CQX8BEx2ongwwd9TtelDki49jtdJSs574I5ctzC2rLJH2/A
         hnAA==
X-Gm-Message-State: AOJu0YwfpJzBmw9EfdNao1hpPrj/6/1HIpvcUVKwLIGPOpgio1h3lWE6
	xeBroqpYEx56jJMQt38nxCx28IE0v7J/vIeS5aI/t3knv+SYWt8w2iFCCB253xhe6XDiZQuMwA6
	cfnhqrVEERBWh42OIkZ3OS7gXIDg=
X-Google-Smtp-Source: AGHT+IFAqWuvN1QhLH3OxPqMX166/FioPqA+jq2j4QacS0l140AT83P4LfvMOOvUbQ8a8ENEgNfIx09QwL21jTqXdPs=
X-Received: by 2002:a25:ad99:0:b0:dff:1dfd:c2e1 with SMTP id
 3f1490d57ef6-e02be0ff390mr1420240276.11.1718756478881; Tue, 18 Jun 2024
 17:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618233303.GA188880@coredump.intra.peff.net>
 <20240618234436.4107855-1-gitster@pobox.com> <20240618234436.4107855-3-gitster@pobox.com>
In-Reply-To: <20240618234436.4107855-3-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 18 Jun 2024 20:21:07 -0400
Message-ID: <CAPig+cQy2e54Pjiu=7xw7Ox=OyxmFuoW6MU31JXXuXobQ_vvXA@mail.gmail.com>
Subject: Re: [PATCH 2/4] attr: notice and report read failure of
 .gitattributes files
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 7:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> The code that reads .gitattributes files was careless in dealing in
> unusual circumstances.
>
>  - It let read errors silently ignored.

ECANTPARSE: perhaps? s/errors/& be/

>  - It tried to read ".gitattributes" that is a directory on
>    platforms that allowed open(2) to open directories.
>
> To make the latter consistent with what we do for fopen() on
> directories ("git grep" for FREAD_READS_DIRECTORIES for details),
> check if we opened a directory, silently close it and return
> success.  Catch all read errors before we close and report as
> needed.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
