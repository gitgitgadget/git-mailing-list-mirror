Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2D2206BA
	for <git@vger.kernel.org>; Fri,  9 May 2025 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746834847; cv=none; b=ZUkKK5Km8rU2q96d/wE7h9orX19lGkoaLYDgETUvDAXHGB+FOS80Y0fW6YUNVseT6IBglWcj0As7avvlAQfTWnGstcfHHWEJxjsLFgeXFUOdzu/gm5F578yx1ushT+Rycun86ke/x2Zfto5LWORBoO9Ic+8Oy+2Rt8Ere820uns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746834847; c=relaxed/simple;
	bh=gUG30yOxvYtpIWoWtuQSR+Mgg8085pGCR3jR6eED9V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkHR9/ra9s3TrBY0iNyUCnfvy5FnE2+VJMOrV5dItwxFA5gXyiG6OZ7T8Y4CqUCpkhEXioAtt8ZaHYtLcm1giYkCTO3chcRNSOk/5QQoEQ/qP/rdIGJHq2SFQU2B9PKsMNc5d7UQGql7oQMGenuQsMpk395LLtZL1uZKUUf3qaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/PDNlxF; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/PDNlxF"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d81768268dso24903275ab.3
        for <git@vger.kernel.org>; Fri, 09 May 2025 16:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746834845; x=1747439645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvaciSzHKKJ4tcgFGox/s1E12ghgnm+EiRv3QY0SpwI=;
        b=T/PDNlxFdWjw7zGpEh2PoWYQk9H0dOFov7z2/6lUxPHWqiX0dDYI3ULRy+k+XrwpLM
         fQg7/qO3OL3aGAmgSXPB0ji83RcUXeWPB19o+blCILggsbwcygZp2nVd8bHhpEIvs8Bf
         TPCjYan0ENgicl6yoKda+khja775V5sssxTw393sXPNc6YzgXV4qcYm6ptM/xe6DOCRI
         AeYLWPMbivovuSKkvx9LgPBcELYFW5Nu9sBcJxPoF9BGC4Um/nI+qP5+Z+5d0is+JUIC
         lfn4SbuRH/xuMXNGmmF9w2Tp0X1g0UDMiBK14Q+wrSLjWfB1jgJl/i6u3wUmXd3QLN7E
         IBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746834845; x=1747439645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvaciSzHKKJ4tcgFGox/s1E12ghgnm+EiRv3QY0SpwI=;
        b=ILWAVbuInZvsvfNGJzI+Ev+/sQT2uc1e90EPunDClJkbh9ccw2efIjn/bvCeZ6TEVz
         lGd0ap2otSuTjg+xXjsJ/tydDHS2fFmm2WeOnXFU/Q1l5he+Z4O+zzbGKZ/tYIajpxyG
         4ZBfI/9zXIW9bqZn/2CkprfRxaI+NJ8tthStGQ/skqtrJPpigO8CGaqLHJwG48ckuROj
         mVvnhQA+UTHdC2yFnonY14A5DxnWdjCXPLCv5IoMwsYTIAIf1sVkOGb5S/BiYTFQCQ6r
         qxbOYwXmhbKYI31SQHrJdr+Y7ISQa7CN/QU4Y+ceat49Oh1b0ZE6JkRvGrUeDUCy50FM
         4PHg==
X-Gm-Message-State: AOJu0Yy5Rd8MIj12izZe48+6ZIE0dWHsNH8P9vib8eYdzfG3pZUPBzrN
	fFxDoyPlg+cpq+c1lMw29bOO7o2/U0CBOfPKBbOok7ie1lMf8Dx6pYwvS7ci2ip1LCiB1c7UzBb
	9OK1lFd69xHPBpufGPom5KVX9XGQ=
X-Gm-Gg: ASbGnctXiH3ypISw88dXIMnNSNlpBoPymYCPGHVe1pbKOJuc5lC8OL7siQI3+gc8+KA
	KPpLrFoJLLmrf6xMp0QJpMEn2WB0r5DcACdcNL/xbbhFsq8wLqyH7SD/mvM0HQPUp67FloQS0yZ
	fVbMGnSjVGJG7qPUeG1wlXsOvOkPxl+yVer5FTj/oyXtH7Y7HIGAoDPAtMLYqGZegx
X-Google-Smtp-Source: AGHT+IGo8uqJuMRSmo618t0BZN3y+0rY7WCOTbqy1uLMiyNTpWFJhODe52EHONVIOaJsII+pGRxNwf9UP3NGvy/g8lI=
X-Received: by 2002:a05:6e02:3cc6:b0:3da:7213:fcd1 with SMTP id
 e9e14a558f8ab-3da7e217320mr70296935ab.20.1746834845216; Fri, 09 May 2025
 16:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im> <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
In-Reply-To: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 9 May 2025 16:53:54 -0700
X-Gm-Features: ATxdqUE457ftZBs3pS6haYVAAV1P3PtHkhcQA9CDvO3KMajckADDesbpeKAkNZY
Message-ID: <CABPp-BFYuYnbHG9uUOig8gpqrLywESf6fs62e_CMi2uCtNXYYw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Spring cleanup of "contrib/"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Matthieu Moy <git@matthieu-moy.fr>, 
	Eric Sunshine <sunshine@sunshineco.com>, Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 2:20=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Hi,
>
> as I have lamented multiple times multiple times already (e.g. [1]), the
> "contrib/" directory is a bit of a mess containing many bits and pieces
> that just sit there gathering dust, without getting any maintenance and
> sometimes even in a clearly-broken state. So I decided to finally bite
> the bullet and do a spring cleanup of "contrib/", which resulted in this
> patch series here.
>
> I have used the following reasons for removal:
>
>   - The tool is clearly broken, e.g. it doesn't even compile.
>
>   - The tool hasn't received any updates for at least the last 5 years.
>
>   - The tool has a clear alternative or just isn't useful anymore.

Do we still want to use your second reason listed as a reason to
remove?  Junio brought that up on v1, and it bothers me a bit too.
Now, if you couple that with "contrib is meant as staging and projects
should graduate or be removed", then I'd be fine with it, but you said
later in this cover letter that you were going to post that
information in a follow-up series.  That makes me wonder whether the
removal of tools for this reason should be deferred to that later
series where that new direction is recorded.

That all said, I tried to do a count of which patches used which
rationale (though I split out a fourth because it makes more sense to
me that way).  I see:

  - broken tool: patches 1, 7
  - not updated: patches 4, part of 11
  - better alternative: patches 1, 3, 5, 6, 8, 9, 10, part of 11
  - already removed with just a stub left behind: patches 2, 3

(Here I excluded patches from the "not updated" category if there was
also an additional rationale given in the commit message.  For other
rationales, I put the patch under each category that was brought up as
a reason for retirement.)

So this series doesn't rely solely on the "not updated" rationale very
much.  Even in patch 4 you allude to the fact that you _suspect_ that
tool also falls under the "broken tool" category, and in patch 11, you
also argue that it should be handled differently if it's useful (which
rhymes with saying that a better alternative exists, but isn't the
same since one doesn't necessarily exist yet).



Anyway, I like the series, I'm just a little uncomfortable with this
part of the cover letter and the wording of some of the commit
messages.  "not updated in 5 years" is good supplemental information,
but I think other git contributors reading those commit messages might
get the wrong idea and apply it elsewhere.
