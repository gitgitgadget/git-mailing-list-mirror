Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC4417BB6
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780044; cv=none; b=JPcv2aWlefgWp31jkYyntD2fZlWWtrRlytwOAn3Nly+tt32M5grJJOdVTakmAUiHtbivGljxj+ApvyDR+lqJ6g88Vqx+BVTrau6bblb8UqZImTxLcpDGya6LOTjB48ay2gT7Wf5tVZYYmvnflz6kvBgfFSsrWkfdEU+YaIfPvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780044; c=relaxed/simple;
	bh=BYC44yx6j7KqO/VpWUuaN0b/32aTvihuzV0vmF4pObM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVrL5Srv9CD2AYIfjWHx0hPGyjEae/o8rLmPj7DcL83HOT955cm2HpT2//btNig25zjQKBt/3iv5eUb2fx9OtejISDK1mjB4RrimdQWlZlS8uUu7zg0bAwLQBvKn1+ynwu4LuOpPv1PCWyRYdpQxvWAVtnRfotuD+0NUA+32fAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYFp+NPn; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYFp+NPn"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so8151583a12.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 04:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741780041; x=1742384841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6GMrL7M9s2jBKnKdnIlm+LqSqgA07Q16df6VvEq098=;
        b=PYFp+NPnyjOjWhbrQpufh6rdid47YgG825rENRoM2A9UZIKpYPUXcKg+tjlWHPBSpZ
         qMfNINxBM/jKN23yByRwIqare6HVjb00dteBlws7O6Bz2f7Lj7nO83nX8N6DmhzzjurD
         RWW9TqXmEa3yuwf9isOFzmONPbc8V29jfHFsS4pbCN6GrrQmrNygQDCClQiBkBmnT3RG
         LvDVkPAwnYgdCfJLoLIv4SNeFO2WQ3bXDu7GXu2mSgOFdLKYQuwfaBS602OpDCQio65v
         aNrhyXDX2t2Lmi3XiIIiXQU3BSGmFB/meqxgg7Lk+mi90gasqmBmld7TYNQrusWr/gpx
         loDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780041; x=1742384841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6GMrL7M9s2jBKnKdnIlm+LqSqgA07Q16df6VvEq098=;
        b=qKzNvVPoKDYzGIjeE5/H9OARRspOxuVhjMvGK3VlK0gS8Ukb1dUEaQktCznhvX409S
         LINrJN/1zRxTCZ/9M9ar0SfnKe2U5gh2dHU17J3B9KBDqbkTM5ZxUNQtvzaXRbae3J2D
         whHIJgA7z2N6kW5u05vWB3PeXa7/9K6V44yO0N9w9FIHwsBxV4OitFm15ai0ZNXGzRnH
         S0m4r9qpW6HQr29F+Oo5nz+0r2KhNCNFO1HHebIGDLxaRKfmjjYQqMMti2loGCpHvfz/
         X6XvprBWxGp4U1TxJeR86VDnE2Dfm2VaheDMIF+Y9DYbVDZAu9GMQ2xh4WqnkZnV/LkA
         PUVQ==
X-Gm-Message-State: AOJu0YzfFsC7fc9+C+0/roGQG5neUN/utKSyKr0+Foe70EMJCcG8XWxA
	u3gWpE2rvmzz6V/vGn3AkYBE+xcSMd2sMg5k9aY5MBFj4WR5dXs2Bb36IjJjRjqUrbWRP+tkZMP
	hLa2y52jQdiEtjIuPzYci55XvXQ8=
X-Gm-Gg: ASbGncvHISYXoH/ts1zsDto8Y2Mto2UGsuuuyhaWn1bJ3aUZZSUEBjNO4tf+G5Kzuqp
	VzOAxXnAxHroIFqABcoz3UkzPca6w96evVy9G4GEOAvDUV4vxH3f80NI1RRi7cvqFJ9H3ZDPJz0
	aMcxCrBi8eYlvFfbZucemU7Q6dQDgT
X-Google-Smtp-Source: AGHT+IG2iMMMGJL88546MLJZ6oXxWePq93jHCNmLg+K+iPQSFrscTJyjEVK+hqK5qZytEt11B+sBhnOof/uqGny2tSw=
X-Received: by 2002:a17:907:874b:b0:abf:5fa3:cf96 with SMTP id
 a640c23a62f3a-ac2b9de398amr984984966b.14.1741780040563; Wed, 12 Mar 2025
 04:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310074053.1886097-1-christian.couder@gmail.com>
 <20250311152413.1059343-1-christian.couder@gmail.com> <xmqqmsdr2szx.fsf@gitster.g>
In-Reply-To: <xmqqmsdr2szx.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 12 Mar 2025 12:47:07 +0100
X-Gm-Features: AQ5f1JpOC5OerASXLIYI9ACYZriJYyoppsBZltmMll0dlSmeUv2SxdC-WYDvjQc
Message-ID: <CAP8UFD0b1fH+oJTR+2ZrC30_Ga=JOkv9kxVM8VLvBMNJPhCvDw@mail.gmail.com>
Subject: Re: [PATCH v2] promisor-remote: fix segfault when remote URL is missing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	"Randall S . Becker" <rsbecker@nexbridge.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 9:48=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > +     GIT_NO_LAZY_FETCH=3D0 test_must_fail git clone -c remote.lop.prom=
isor=3Dtrue \
>
> This one triggers test-lint violation.
>
> diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-rem=
ote-capability.sh
> index 23203814d6..4c5c3c7656 100755
> --- a/t/t5710-promisor-remote-capability.sh
> +++ b/t/t5710-promisor-remote-capability.sh
> @@ -257,7 +257,7 @@ test_expect_success "clone with 'KnownUrl' and url no=
t advertised" '
>         # It should fail because the client will reject the LOP
>         # as URLs are different, and the server cannot lazy fetch as
>         # the LOP URL is missing.
> -       GIT_NO_LAZY_FETCH=3D0 test_must_fail git clone -c remote.lop.prom=
isor=3Dtrue \
> +       test_must_fail env GIT_NO_LAZY_FETCH=3D0 git clone -c remote.lop.=
promisor=3Dtrue \
>                 -c remote.lop.fetch=3D"+refs/heads/*:refs/remotes/lop/*" =
\
>                 -c remote.lop.url=3D"file://$(pwd)/lop" \
>                 -c promisor.acceptfromserver=3DKnownUrl \

Sorry for forgetting to check that and thanks for the fix. I use it in
the next version.
