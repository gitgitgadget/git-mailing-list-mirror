Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B401BC41
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309780; cv=none; b=QgTPT/MO74MKpgTJ8V35HXKofbFCOyzSAkt+voO5HEeeEnw0WQ34/WCV+3dYlePO0pQyf4vY3cnZLn0ZKCXlIEwA1veuwFBgbVu/nyAePBvj0vcIFMeUKiKMO5NTv9744xL9csa+kXTkVTlb8S5AZcnLjf9hO7SoFKm1t9H5Xe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309780; c=relaxed/simple;
	bh=poJzinFVL/3ZpMVZ0zXVkw4E7LCDTIZ8hxEnwKddfTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyaEbsMpQ6mfOoBetaV6EA/4C/ymCN9hC+FIc4JQBniwtPRxQmWM+d/XBYnq7FqA8PtGKNvzMqiTXwHyR7v34y5aH0UfMFRcuF8YZYgM5FnBANEI8V3NMQePqsFPqaOp4sZr7XboiQOWiXNuMinhazCdTWw2aQP4VsI/dkOfQNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn9rdHsk; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn9rdHsk"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-622b4b14a75so3993000a12.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 22:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757309777; x=1757914577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poJzinFVL/3ZpMVZ0zXVkw4E7LCDTIZ8hxEnwKddfTk=;
        b=Yn9rdHsk4EJqg00qIbcymmNESWX59x7e4DOljdFUG9H1tYYA1MtXg5YcWfNxL7D6kk
         tk2/hADp1gdiyGgKSFSeORpZ3D4sKdA6b2YBvwrPSJ4uZL3i3jGT5FY74BJQ6o74DK2N
         uOs5Tn2v3uUEfKCLncG9Dj2I0kXIuJGms3bcvTHiAufuRI6gGopf1e4vNqlrh9XhiQqd
         9uuBxslFYr7SvKJAUNXrYkPOrODF+ZCkiwu2YTz/xd/qIfWrnAs+sATzDmvUVR8TbBv+
         ZC7pWhciKN0qkYw/dTNiUBwa7HR0XTOFFeHD57ERrCOrNkg6A+2+3lkFYaI0TLibtBnG
         0OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309777; x=1757914577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poJzinFVL/3ZpMVZ0zXVkw4E7LCDTIZ8hxEnwKddfTk=;
        b=sse1Y+uECMAsZzgHcX6647aLIlfI1kLB2Q04wm1QT5aB7toz6Gu+OOkUl7+SRBjKBw
         IuENCyt11H545xlRHP3vo1MFyuFMq1K588HMVzNddKu2nl5afgsctq7C66YI1GJvWuwr
         I24Z2lLvSD3YecuL4uCjnbL1WD3xfjvwklsIWAIavDnHwEJdDJJjZqz0Fqzp2kOCNrTs
         D2k9H21EK4qjH2C90gKNwjg3RpW4T5kRrBf4kOt9+bwR5PRO+6CZwqzhhVR4vX460euR
         JmyawCpD/s+O7eiUkABAtkxUBCTsPzpLwgnkVxInlEmvTBTd42UrsZpijzMEP4cFeEjt
         9sGA==
X-Gm-Message-State: AOJu0YytT2A9wR+TFMoA7fLmTrZN7thsheTYaH/a/WMUiqTRi248uI5y
	pIRkg+o7OU5+GzRKFbYh57mygtJHJKdU7624Ll1ybX4G6g2kyU4A33GrWlA3PwevaZW+diP1uH6
	5UKBYBu6y1PjJVTpsA4Vn6x2MY4Q3/JiFiQ==
X-Gm-Gg: ASbGncuUPx3C1mNJ3YbTQqsGitKcqi6RciTeAeaMIkI+6Qm6YQAe5Zi+9r+OMYk4OAo
	JaQAzukn+OcPbe+VKNnCl7SFw90Qs0g8O7gE2JqW2HKra/nOu1Z+XuV5f8JniNLQ20io2SrBcdg
	vV24oRS6dB099klJE3o5HJaNJuR6j5/0sDuNfWsWKFOtqCx/bGNhJRWkGdjejfoMzhakFCSezi+
	oZTnPmOjhrNVaLxDcGoaako3+QfXHk=
X-Google-Smtp-Source: AGHT+IE8G53pcYrn2mF2p+WJe3YjAz2Wr08SpaKq3c6EmbAS9eOgcSVMj0qGJnKwEwTuwyP+evty4ELbw0diV5ffmGE=
X-Received: by 2002:a05:6402:524a:b0:61c:526e:e8bf with SMTP id
 4fb4d7f45d1cf-6237ebc6e89mr6033038a12.22.1757309776879; Sun, 07 Sep 2025
 22:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721141056.2283349-1-christian.couder@gmail.com>
 <20250731072401.3817074-1-christian.couder@gmail.com> <xmqqqzwvqay9.fsf@gitster.g>
In-Reply-To: <xmqqqzwvqay9.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 8 Sep 2025 07:36:04 +0200
X-Gm-Features: AS18NWC9ySerr_amvYTH0kA3Ry73oZ8z7IwlL-8Mdz1tW4YZlR3RJeQD_znGo54
Message-ID: <CAP8UFD0RHf9W3YCHYEtv5t1cnPe=CmfT52zh_898sCErEtiaKg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Make the "promisor-remote" capability support more fields
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Jean-Noel Avila <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 1:32=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:

> As I do not want to keep an inactive topic in 'seen' for more than a
> month, I was doing my usual "sweep" of the topics, and found this
> one.
>
> I think I gave a review on one step that pointed out a few problems
> with an outline for a possible solution, but I did not see anybody
> else reviewing, and nothing happened since the end of last month.
>
> Since the summer is a slow season, I do not mind keeping it for a
> few more weeks in 'seen', but I can simply discard the one I have,
> and requeue a new version in 'seen' when it materializes.

Sorry for the late reply on this series. I had a long vacation in
August indeed. In such cases feel free to discard my topics without
asking.

Now I have just sent a v8, and I hope I will be more (re)active on this.
