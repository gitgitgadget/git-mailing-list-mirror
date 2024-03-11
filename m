Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C090E58217
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196214; cv=none; b=r/4TzKe3qejcd3tJqtjPOfSK1CMVK3DICLYsFoDsc1oeX6Qy7xq2Sm+P0yol/wrXiH12qESPtp7+87B4QtFJusAUvaj3kuGj07V6lPL4lj9fBi9UMap1c+njDARNgU2DFtaxfdA7XjQP4Me1+uMZY6rfc84q97Ge1xwttJzqNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196214; c=relaxed/simple;
	bh=2FB7gqGUwOAZZXdTFF27wSI8JGhbs0mUR/Vfy9+uSZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wmt6vqSrQ+rxz1F9PiAAen3TWwG6+69ygYurrBnG4nQzSx7q62sm2KmeVsmPHKHpx2Yoe4HFNRF3cxOpGQsSwgKuw5tCJR+hRfFfHPMlCPt1kcMFfmlu9r83Cpc5ikapNPL58aq3z/SSFOupCKJp8cSdcTQm9TnGMVZyrYLmVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNJhoH5t; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNJhoH5t"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d23114b19dso66410031fa.3
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 15:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710196211; x=1710801011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pF5JVqV0DUNMUh7lcuotZt/vSsEdgAShbCPsAe2xXUk=;
        b=PNJhoH5t6AoFnaz48BYCqTDkrFJUOWw+11nL3dDnzpTzW1dAMPgOb1DExHOxlwSWaC
         ZNjBc/qVQonCgUxWJA7Wv1ikPoO9eUHoSSggB5OHNUoMlC6iTaRNywwATvWajFN714xQ
         VqYcVTF0yfVnHkxCRlxeL5vE0gciocr0y1DLcqkAGN/AZjFDjvkj2o0rkAiwvUE7LzcY
         YDQ+M1U28XPMxdGDKSeHVHgEvqUHXkmDR0t6HpoSqBMA/JvPwSe1YR8j8cul1PGxNif6
         t1/js4eTl7MPvFxk890GUu0LxySBqZY1EzRqFxYcK9bJeaQMc3iCvT8/OESji+qBmO/X
         tWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710196211; x=1710801011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pF5JVqV0DUNMUh7lcuotZt/vSsEdgAShbCPsAe2xXUk=;
        b=P1jg64VILm0dF2mSCcCfkWE1WRrrhcj6YOD3eh3h5e++4FiNcndiDlXrBtVl5towwd
         KyimEnnG/6KtUZIAPSw6DdfZ+e9706IjupiidUn7RfcFnpJO1S/ls4y05jCVN8gaxWRQ
         cK4RciVoZDfhUABVEcSqvqb/6kSKpT2K8rG5WOVduPQ0X84o7Qpks8p2T+3e+ytyjzEk
         GD6U/cxupjHTFntRIHf46hwG3FYQTgYSb0McmCvghiU9RhsPivjFMBaPO/AkjvWHtP4P
         q3zsIabqkJry5W8S2/B6czpLMjPuhyEojqXQl48XKhCvrNEAPYhwJrvqyT1jqPXi/xNo
         S5ig==
X-Forwarded-Encrypted: i=1; AJvYcCWy5mzHRyZTkojx2lz0zzUhk2GSW8qT0wsvlqZG6oinJbfC1Zgk7RbMePvaE9kwPypAtdWwVVUxqTS35ZmwWvD9CdV5
X-Gm-Message-State: AOJu0Yym1aHECAr20S03hX60v0N1XAe0Lvwy0zikwOhvl4XglOLz0WF5
	wpEaeb50YRX6Z2DGWnyFiz7qfXb5X1yaESSnOVakc8tx0MsuyJana80r3mEOLFaKtvfoPbq56Lu
	row9LKlBz0WLwJNHYxtXowA16DR8=
X-Google-Smtp-Source: AGHT+IF2JWG+1R7a9Lq1K9CeZTQx2iKM2xtUwcVu17Rvbds4/FDK03wUx5RslHg5W7Mw13sPku1MfYbkxVAqgOPXLFw=
X-Received: by 2002:a2e:9ed9:0:b0:2d3:3305:c37d with SMTP id
 h25-20020a2e9ed9000000b002d33305c37dmr1198854ljk.2.1710196210307; Mon, 11 Mar
 2024 15:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310162614.62691-1-garyan447@gmail.com> <xmqqedcgvjik.fsf@gitster.g>
In-Reply-To: <xmqqedcgvjik.fsf@gitster.g>
From: Aryan Gupta <garyan447@gmail.com>
Date: Mon, 11 Mar 2024 23:29:59 +0100
Message-ID: <CAMbn=B5m7oeSy0tmChLRs=HKqAp7043s244jEKVFNayAxmcdUQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 0/1] add zero count optimization in ewah_bitmap.c
To: Junio C Hamano <gitster@pobox.com>
Cc: Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 5:08=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Aryan Gupta <garyan447@gmail.com> writes:
>
> > Hey everyone
> >
> > I hope you are doing great. I came across a "todo" in the code base
> > which was based on zero count optimization. I tried to fix do it but
> > I am not sure if this was the required this or not.
>
> Do you mean that you are not sure if the improvement you made is
> what Vicent Marti meant by "zero count optimization" when e1273106
> (ewah: compressed bitmap implementation, 2013-11-14) was written?
>
Yes.
> Unfortunatelly, "what is "zero count optimization" in computer
> programming?" does not produce great hits, and you are probably
> better off to ask who wrote that comment (Cc'ed).
>
Sure.
> A few general pieces of advice:
>
>  * We usually don't do a cover letter for a single patch (instead we
>    write extra explanation after the three-dash line).
>
>  * An optimization patch usually is expected to come with
>    performance measurement, just like a bugfix patch is expected to
>    come with tests that show existing breakages that change the
>    behaviour for the better with the fix.
>
>  * Pay attention to coding style, as deviating from existing style
>    distracts reviewers and causes them to miss obvious bugs.
>
> Thanks.

Okay will take care of this. Thanks a lot.
