Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A42566F4
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694840; cv=none; b=KmwCMq4l26OCMGxY+83o5S35lv3NpM+gLvLK9q0CDNd83tbDx+JWuvq56geAG4NGkYqWUkSVyAvmDpOyxyFfBsI6MaM6NUouP/Olnc7ie/sVYhBZ0rDd+SW5RBppz/TMigFKSdBO5zTQ76LV0bjKwCxXoxDlQnVuUHAqYkk7ZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694840; c=relaxed/simple;
	bh=H9MUq/a8Wdyv4ZulwPS/pvxWkppmjqV3CvWExsLd8wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sp8EYVNupJtjAt4oz4tIxOHM30MiCnlNQlK6VyUj2xmG5q8QRq+QddVB8s3ntL2R+RQgxdRq770T691Olxyu/c5oZY4an1ju4Azznok/vSSyrjJrEP3K/vagS+Cnnl9+3I2puhdZ9RsC4X82pZXsbiKJE2C9RYfWjZN1cho5TC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijEJHzSF; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijEJHzSF"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso4305582276.1
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 05:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741694837; x=1742299637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9MUq/a8Wdyv4ZulwPS/pvxWkppmjqV3CvWExsLd8wk=;
        b=ijEJHzSFosIwQ1NBa+0yIuL25/88l8FcEfkr7bij8Ur/w6SEdIVxjRZV1yyq3zHjXJ
         mt1JBduA+SjTafg+nQLB+CXO3nP6woNRX2G1EQvmLpN1nu+XE0lphZxb/DGv0jI8s+S0
         L7fRleJNwNTYm6VCDNRBnAZiWkL+WBYfbV2/F8fXizFv6f8wAuRt7qI+64xTSL8Dhi3i
         vjDYKjlfbsYSwsJkNNwBA3zfDeGxuw5KlPcCk63dkiBsm9M/+31afBQ4e2ityhfwuweY
         A/XJerWhaEUErYzjsAxukob6jk4C2bTqpMp8/Iitxk/WwyeU1BXRcXwYrNm7+0v4yOMw
         MOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694837; x=1742299637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9MUq/a8Wdyv4ZulwPS/pvxWkppmjqV3CvWExsLd8wk=;
        b=I3FTMoWHmLZw9Yyl1ceUglw3ekVNtFoQtvhTEDLxhEy86gJekU3Rzh24UWhyBZyctp
         D9Z3SXr7W/bgKCE2JZpFqTNUnxBnBw6QIHuoxkqMzWb9r0w6SLURaIYV62HWdfVSNsHq
         IsxwVR4qGg45Wy6/UFVuqjz86Fn15qeTjl21UBaAUF5Y7D74e6PyopR36+LLp5yB6hs1
         7lP8KDbZydEgQVCQalHtTglpIWdHFhtnkAgA5xgmZ2xykVKxGZ/wwnnJlMa4sgeBn5Am
         GW/Alaw09Zjm0mzQGK2LW7gy/smEMnSfUvvykVarS1GFXqlizbImiN2raIls+piq81xs
         /eyg==
X-Gm-Message-State: AOJu0Yy8QP2sSLICkDIK5DLoUpMVps/XBERyjJTJz8LoB7iy98LaYpBA
	43MeOwGJmHaxu8rFoMa2ocwN0bdSdg6+E2oRxavgvMxAVX31rHqcUMlSJAYKUImu3TonBY8POrK
	XRphiDPhZdphKZoWk832HeHv6lvEodM5qLsdlIw==
X-Gm-Gg: ASbGncvxHyE/dgrBfb0a1qgdOuf5DNFmv04/xqVxqq16FQI+t5x9e1ZfybvaNIj2ulj
	8FIVvN7K8sXMjMU1ORaOk5dqmg2j6VT2Cafi1DlMxec48ymJX2zj9whaZKe+5Syybx+qyNyc4Vy
	QfTsaKiPz/UA0bxrKdRQ3AbvNn
X-Google-Smtp-Source: AGHT+IGxtdqWeDXdaSBnXkLp60A+Ltme5X0SvIngjrzdEg11ZPvXRJjfE1mVJRVTvlY7hChLBLTH8pypm2WStN8eU5g=
X-Received: by 2002:a05:6902:2a8b:b0:e5b:32f5:e38b with SMTP id
 3f1490d57ef6-e635c174865mr19235975276.23.1741694837066; Tue, 11 Mar 2025
 05:07:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGedMtcSSkmQ2u9yYvKMiWnprWR2VZrbuoT9EX+U6nuxOWiEHw@mail.gmail.com>
 <CAGedMtd0-m54075w97Z4pQ0wqAjgPRA8+HX5iar0POyuC6-GCA@mail.gmail.com>
 <CAGedMteK9=wYwCoPMGZ5t+FN_ZHOcSGxDenq8fkVM64oGpc4sQ@mail.gmail.com> <CAGedMtfiAttLUgPNyU9nNrvOjNrJ0NsCayjyTevCoAurwMDwzg@mail.gmail.com>
In-Reply-To: <CAGedMtfiAttLUgPNyU9nNrvOjNrJ0NsCayjyTevCoAurwMDwzg@mail.gmail.com>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Tue, 11 Mar 2025 13:07:04 +0100
X-Gm-Features: AQ5f1JpO7_zEqN0OLUl7ULHC3gxhu6E6BAdwiImxMvo_LOwWTOlFsIewQiBs6Sg
Message-ID: <CAGedMtcLRjr0GVNYmUU_tacrA0aRvOCYFGyOy0FACTBL=X3cwA@mail.gmail.com>
Subject: Re: [Outreachy] Blog: Completion of My Outreachy Internship
To: git@vger.kernel.org, Christian Couder <christian@gitlab.com>, 
	Karthik Nayak <knayak@gitlab.com>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Git Community,

I am writing to notify the Git community that my Outreachy internship
ended on Friday, March 7, 2025. It has been an incredibly rewarding
experience, and I am deeply grateful for the opportunity to contribute
to the project while learning from such a talented and supportive
community.

I want to extend a special thank you to Patrick Steinhardt, Phillip
Wood, Junio Hamano, Christian Couder, Karthik Nayak, and everyone else
who has helped me grow during my internship. Your guidance, feedback,
and patience have been invaluable in shaping my understanding of Git
and software development overall.

Although my internship has ended, I fully intend to remain involved in
the Git project and continue contributing and maybe even become a
mentor in the future :). I look forward to what the future holds, and
to further collaborating with the Git community.

Additionally, as I transition from my internship, I am actively
seeking job opportunities in software engineering or DevOps;
internships, or full-time positions. If anyone has suggestions,
referrals, or advice on potential opportunities, I would greatly
appreciate it.

Thank you once again for all the support, mentorship, and
encouragement throughout my internship. I=E2=80=99m excited to continue bei=
ng
part of the Git community!

Below is a link to the latest update on test conversions;
https://seyi-kuforiji-902b48.gitlab.io/posts/a-retrospect-on-new-test-conve=
rsions

Thanks
Seyi
