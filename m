Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F0C1D5AD2
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849722; cv=none; b=LrpuxjWqKKKXRNK0H3MGXIJWN7q363iPOzoHc3LkkOe0cZ7U1GIVydQPlXd/VEuVZ8RzJwN222dMwiDJOVZUjUo3Do7iedWcjlWgw3bEJsn+BwupnUfIP9vFOw8tfcIaQUp7ye2j1IUV0vl5t7a9vM8N7tLTfNyrBffvC8chyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849722; c=relaxed/simple;
	bh=fcgiy6CRafaCWFQ9cyooulDYT9LstnUFIYs+L1/SyCs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qctO73gAcIAeFvbd9MNxQNtjxj4EPGkciRaLk5CO16GUU9xTfKXFaypns/yghDMnEvBJ9Pj0Xj7aAkzJtS0RIKveacEuHJTS87FeDkRm9PjvkzOHs6oUBCSnWqA8S6YnnKe9erhNwLaIebFwWbTaiX+vi54E56aahgNtXESc0cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnwTN5gT; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnwTN5gT"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4a49505ba64so647186137.1
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729849719; x=1730454519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fcgiy6CRafaCWFQ9cyooulDYT9LstnUFIYs+L1/SyCs=;
        b=hnwTN5gTnvcZfj6vfsyDpnZneAgj5e99iscGjQHbvEWBRtBzlQ3YXfWmSIFsDdcG4J
         czsnz0xSwCBTvlQZdZNHo+dJ0Qb6yQUMOzoBprQLF+SutEejKk1iR0Iu11FEiEuscp0Y
         nn+cWX+/re4jSt7A+fYkRIY+cZLfuvTviPfeiNVO4vvEo7g4FOOF/31vlufe+u3xVywu
         y9GMRpB+Sr4aTU8tndkdiiQggl6dlh5OhmygqPX3jDuREmxKtldj50d1lvYpw/IW/+Bh
         3aWF9OiTAD3XH/CpbK3QBXfKrs22F7LWARC2lw5jG+8pFxun7O/xOqDD377zFbgN1m7a
         SGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729849719; x=1730454519;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcgiy6CRafaCWFQ9cyooulDYT9LstnUFIYs+L1/SyCs=;
        b=rU6eBbVmknnHerWSFWU+6JpNjQZoi60dGhy/y5jKQVanmrZGCNDdVfLPxa3n28sTFz
         Kjyx9pjvs2GQoXcUCdoSy6phLhximLQQgPi47JvEbJj8Ddlq775Z6qynhGaqjKhNUO5W
         J/I6cF3K3R9fl3Rn4hZHhtzA1L5d1vXQUbflhNhyuS+NOMKGpQlhX7rTlBJ8il+SZvay
         kq2k++0muwARxw+8UdBq1FvCy6OqWIkhte6qtHT9xfi/zIFJgX0tTvkX5Nic7J3OswXK
         ABTMpDZF5tfPiGjL5OoVWuMk8MpDmEBV/YBPU8/eBjjsWQHW8KYkDpyzSmcJXHrcUaS0
         V0Tw==
X-Gm-Message-State: AOJu0Yx/dhNPZe5zOxARxD3MOdg/k80nRUX6cqa1CcLI/jRhxC+HQWps
	LK0UXDIPHS7W+ZdnRyEzfwB1y0AjW1FMDGXt1+fTtklvOAoYIElWSTk0c/s8VL5O+JN1nAMbsF6
	SeExeR1W9Q2u0AOJS+lw1+BqHjoM=
X-Google-Smtp-Source: AGHT+IG+GyqtBJeHtGN+PjLtJWwu40LmIj1pJY7HNH9dYQva7pCuYg2sccjXQhJvr19C5NKYBwqCaoMpnds+w8Kl0yI=
X-Received: by 2002:a05:6102:41a7:b0:4a4:8165:f030 with SMTP id
 ada2fe7eead31-4a87119eaf4mr6456790137.21.1729849719068; Fri, 25 Oct 2024
 02:48:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Oct 2024 05:48:38 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xefdxe2vctdtmfm3vfanstfz5q2bgcklj7ymio5bdutioyaxmo@ujixbc5jua6m>
References: <cover.1729241030.git.karthik.188@gmail.com> <a8c8df5d95b0defec672ee139acd366219ea3302.1729241030.git.karthik.188@gmail.com>
 <xefdxe2vctdtmfm3vfanstfz5q2bgcklj7ymio5bdutioyaxmo@ujixbc5jua6m>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Oct 2024 05:48:38 -0400
Message-ID: <CAOLa=ZT0h+R83vf7tzSQLw56TU2nW16PpbMGg6tkWoTYYpbLcQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] clang-format: re-adjust line break penalties
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, spectral@google.com
Content-Type: multipart/mixed; boundary="00000000000005397206254a06c3"

--00000000000005397206254a06c3
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 24/10/18 10:46AM, Karthik Nayak wrote:
>> In 42efde4c29 (clang-format: adjust line break penalties, 2017-09-29) we
>> adjusted the line break penalties to really fine tune what we care about
>> while doing line breaks. Modify some of those to be more inline with
>> what we care about in the Git project now.
>
> From my understanding, the original motivation for these changes was to
> cut down on the noise from the clang-format CI job. These changes seem
> reasonable for that purpose, but affect the also formatter in general.
>

Yes, you're right. Which is the intended affect.

> Out of curiousity, would it be possible to just configured clang-format
> for the CI job to behave in this manner? Ultimately, I'm not sure that
> would be good idea though because having a diverged set of rules may
> just cause more noise.
>

We do that in 'ci/run-style-check.sh' already, but here I'd say there is
no need to diverge. We do want users to apply clang-format to _their_
changes, which should be similar to what the CI barfs.

--00000000000005397206254a06c3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e25141d411018cb6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jYmFYRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0I4Qy80dTEvbVRwUGhjdkFtMWExRjYzbHkyY01mSgpSWW01R2dlNEdR
aUxnYVRZWThZUUpUMVc0VGdSbzNtUVhrMnlkcVVUOVNFT0RBNXVjZ21OV1B3S0wvSWVsRHhXCkhZ
Wm5yc1dlTnJ0Zk9Oam4zbjc5WFRIVllmN3Z2aVNrclhNcm9Wc1dZT2xyY2VVZFRXem9PcXNPTENs
MjFZYU8KRXFTU1NqMlhPdndXdnYzVCszamRHWjduZ1M2U3BwTEQ4OUFqT2ltT24zMWtjRVJIQlc3
NG1xWjVTSlcxakRIVwp6L3lJWmxNRTVqOURYZXRTOHlTNzFHaXpMY1BLaHZnNVg0NmpvYkM2d1FE
cTM1M2p6NE5NVUliNkNKNDduWVZnCnBjNzAyWGlpWkdISXU2RXMrWGl6OGhERVBNQ2RRMzhROE9L
bDhJeHNQSFJKcTdPVnZVK2J4cHo5RVIwNnpncnUKakFxaktCTU1TYkF4RURyMVREbitWMlhoYmxx
dy94Smd2N29BejVXTUhsMjVwL1BJWE5ZeVNHRnZ4RUN6MkdEeAo4UXNPc29ZcGk3c01qZEVhS2VJ
ZnBJVHVKVE9NZ3RIV2EwdHJyRlpFSzN2SittNlZoMko5dTJzN2l1eCt2eGFFCngxT0NWcjVMeXRY
ZnN3UkV5eDlObGNZS2REOGNnbmkxUHNpRldvYz0KPUF6NkYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000005397206254a06c3--
