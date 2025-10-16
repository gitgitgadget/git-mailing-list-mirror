Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF3D1DFD96
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648137; cv=none; b=pEiHYJ8UGVL0SdD4mOXTyX0c/R6oDBsw3QLYfFosH5btUFMGHn5QFY+ds1F9i5Zk5BcULHstE6mz2gLihRQG7riZ6RoR/EdQTtU/cj2gTrU/tXQ69mr1EyVnmbO925Ww/da8SdlZUQqIe/ianb2/yjIqxEiZ0wsJ/JNrOC4iYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648137; c=relaxed/simple;
	bh=gSfPojtbTUjwrIy+aZDArzxRszaK7qgD3SXlUiGtrb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fQSwGfbKCO1njbcPFIJrl5b4Q7Gto8yixh7XuHbsF/S2abf/byuwS4ltFOsGOkjMwG9iyjOAWoyJqZlob27xwSbcyKgWhWqD9fVwg3sA8LC5WF1T4eYU9qTb0rudIezXEiWr2NiiuExjsujSe/OzYENZQfidhmKco6/hWCfAPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqD4prjv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqD4prjv"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290cd62acc3so4319215ad.2
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 13:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648135; x=1761252935; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSfPojtbTUjwrIy+aZDArzxRszaK7qgD3SXlUiGtrb4=;
        b=HqD4prjvhw6uZAUt0n7rFMRC4h2ZxtroZl04qPfHwgTlf7e6YOjvVr9vI5VrMO30AR
         jEoBLj0qdgpfUdySKgHVjAjLosDuyPw32aKVyUIF2lAhDd18X0U/a8RYsO3e8+JsaB30
         6wGZ3lgVvug+B0LDOb1AcYNkYErBENXBlH/NjTfokgnbgs3nS2J3qJ97+sFOebBu/j1Y
         ybGtKjGpKCXKbKBt4NSFbo5XGqd/8LNzQXkp2c3zJqlYHsoR7bZti5OA6vUG8x0eD+W4
         bhuEhl816BsfuoOtlq6f+2zWO4nqqdgCI7vc6Lm5mMccUwvK7kM8iEUSaTZD7XBhcX70
         3Iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648135; x=1761252935;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSfPojtbTUjwrIy+aZDArzxRszaK7qgD3SXlUiGtrb4=;
        b=hsAOEwCzc5IYDoWBUJqxdBWlGnaqI4yHZspWovLKtJpDCw7AcmwoL54tZERZfJnRe4
         C4Cz5lCyFusWGBQJtYMXzsGBHoqVl9IcceI+eqIeqr3V1LyIRdRZx2o1i/KLmXysvxN2
         1KjJxh+v8/XRGy78YNiWVAFTyAYkzYLlSFP/fF9LHN7NL0rdWXiVfWxQLel9sZs8W1ZD
         XaeRYbuo9LgOEKaPc+abXmCzcaR3EtmIrTrCxd2xe6x89YAPNYIMykOP6hAbBUMAK5vB
         yN4wmk1Yi78jgutd0/D/jBUnW0+rNK5lf9mxRVqhkbi14G7aG+u5jzXgge4kNcjRDlgu
         czsA==
X-Gm-Message-State: AOJu0Yw/27WZ4qmQEsJJsrjgFwTliYmQpxJug3cZa7pqhiR/1wPH5fbG
	dS4K7vEfLNUOY3EibP6jThFuJGo06ncRnzpyfBfYaNLokpd0wuymttMajuI/eZNQ
X-Gm-Gg: ASbGnctIGmiwpp3U1P+6qgFRjjG8uHadEgOYu98tRKLcWSCC7PCgSDFbswLyUB3uWlu
	V55roDHmjlX/w/YRn9hFG38q1E9FA8eAdj2nsPi19L1rPYsyWHUiudDxoFj8ezGrjW2TFV4fSxb
	0pba8wDqsB6L7Pjz2glfIns3ew/ZP1t+0KOpO7bGNV53v5OkPDA2VHqtuZWVvWm35+11KVPxKjE
	kSSfPdPRa2xPx90N/T4GNR9XQWG76NnaTARjhHY4jy0AAmvh9mxGwNHdJ7bF/CcHk8zn9gJ6LIV
	s+K07VCreX+kEI+nsV/gTAJfTUhk8+bBuYtgQSzv0eVq1XXMyaRnmZe6IIjvc84BnXGIGTuwOZK
	5bRvaUIbwfLiORIewOyrdwOrX02HcZQs5kGNyOFiIDzwTf48yGsKnhDqo1eQDGUHDxkVTRDCTyZ
	fE9Wo=
X-Google-Smtp-Source: AGHT+IFEeZVFDh9Jo5adzDin+5Pr72AK/OZS24pHeQyRPkhl7XH5a8uFVrdLYlh6TiTQqdAP4nhVBQ==
X-Received: by 2002:a17:903:19f0:b0:28e:9a74:7b58 with SMTP id d9443c01a7336-290cb94784dmr15183645ad.31.1760648135059;
        Thu, 16 Oct 2025 13:55:35 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::43bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930fb79sm40297325ad.13.2025.10.16.13.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:55:34 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git <git@vger.kernel.org>
Subject: Re: Signed-off-by & the law
In-Reply-To: <CALnO6CDNRw3UcU9UM7rpkAoQsSmfdkxMKVihmoUmUOCv_fpbJw@mail.gmail.com>
References: <CALnO6CDNRw3UcU9UM7rpkAoQsSmfdkxMKVihmoUmUOCv_fpbJw@mail.gmail.com>
Date: Thu, 16 Oct 2025 13:55:33 -0700
Message-ID: <871pn2ftx6.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> Any contributors/users with an interest in law feel like taking a stab
> at answering "Is Git's signed-off-by legally useful" ?
> https://law.stackexchange.com/q/111158/26698
>
> Having a solid reference answer is usually a good thing, if one exists.

Not sure if it has ever been a topic in court, but it would allow you to
argue that committers signed off to the DCO acknowledging that they have
the ability to contribute the work under an open source license [1]. In
other words, the they have confirmed the work is not owned by their
employers, as is often the case with Software Developers in the US [2].

What I worry about is whether people actually read it and fully consider
whether they own the copyright to their work. My assumption is that a
non-small percentage of people just add a "Signed-off-by" tag as a
prerequisite to getting their patch approved.

That is why I prefer copyright assignments. I have done many various GNU
projects that I commit to. I feel, at least in GNU's case, that they
force you to consider whether an employer may own your work [3]. If so,
the FSF will request your employer sign your copyright assignment.

Obviously, the assignment process is time consuming and a barrier to
entry for new contributors. For that reason some GNU projects, such as
glibc and binutils, allow you to send patches with "Signed-off-by" to
the DCO if you do not have a copyright assignment nowadays [4].

Obligitory statement that I am not a lawyer here.

Collin

[1] https://developercertificate.org/
[2] https://en.wikipedia.org/wiki/Work_for_hire#
[3] https://github.com/coreutils/gnulib/blob/master/doc/Copyright/request-assign.future
[4] https://sourceware.org/glibc/wiki/Contribution%20checklist#Developer_Certificate_of_Origin
