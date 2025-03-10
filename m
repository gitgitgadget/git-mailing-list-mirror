Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8332822A4D3
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622374; cv=none; b=HBDBJW4+B0epXfoZcNCjuqY+N2i/EULsKb6P8Djyzkd1X947O8X+K0r6g2NVincTG3zsKrnmoUnm8NCNeg8qvOTfyMplibuMuJ/QE6JiJIEpbx04g2qzAw+oYTSvNuNCq2hdbNftbfIQbRfos17RbF2oq9ff8gcWri7XRZBxlio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622374; c=relaxed/simple;
	bh=4w7z1skuFfH4wffmvkmzc/uPFNMTZRNJbKLz5HSFT5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ayet8be1EhyAGzsO5i/rrjC4elRYzdRjLkg5Ev5scRFMomZ3np9DrKWVpJw1+7yBkai6sEBRgddSifP0XkT6Ayf4eDNIwiYv+Ty0Fq45d5tNpnn1mG8SFfIJEX+PA4Li6dxE6dnaL1cPp8kOupgpebVBqRT+A7WInqgCRcaQwTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhpYU8CY; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhpYU8CY"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso6808350a12.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741622371; x=1742227171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWUmkBLhDQ8HTMkrF124Tl5nII4ki5+VAt5+8aR2BUI=;
        b=BhpYU8CY7LfX6HkF7XXcrTMua6Cm8bE67HIv3AjYg7OJCQ6NpHNo+gOxmI1o5HJ1cV
         0WJM7Oc3u4LBPly+Yx/GTFku9J/4osU+d5jXMSHDMEOaBKrmcgBY6v23DBEn9C8lSEOG
         65g/ELXIrA+Zfrp6vQh6TUnzwjs4F5Ag41MNQCMf0X6i2KZJxzcOthOZJihZ+Km6+UwE
         aEmcHculJO4Wfik3uLdBcWzaqGa/DWukneCi8q/2NEkeeGNRYoWpCbIdpBdRM5nbwx3L
         VBIxepXJuWXqVAoni1cL1xCCKBm/PnLk7SSJ9n57mMXapKMS1LnvXFmS6gx1+aVJ6DpR
         PVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622371; x=1742227171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWUmkBLhDQ8HTMkrF124Tl5nII4ki5+VAt5+8aR2BUI=;
        b=iqME20IoG4U8LyJolJ0+uUyR9mKO80xtWCW7l69Awb/ctSVqgfikNZS7DVM6QfqOVr
         mnQRuNEGvcBpaC+mqQTLyLU2TXbfTdupvEwR+hDp4CSGht2hOATDqyx+OEbSMWKE1BJj
         oHJDxv4BhGEfz8zF53F8b+eC/8W/+9MhzanQZedZIZZ5/NRDWgbk0N70MxgVGbwn7k03
         VeGvruDu2xod5vXH82GgpKBwXF88oMNlPs5rS6tFssNYRua7q99BJdqG1TSTAQEksx1L
         r/zh7HHpEyP9KDMkrWg1/8Xpo6v+ZOs+rM4d7myMY+HXmc3l8nXGLKkcqsTTfGTRMTjX
         o8CQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4jY0la/zxTgDiDzKxHh+i7dgzDndktb71urrguJg/9yasGeWyCaARgTvea3gT61ngXiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ48HMgBadEC+Tv6twEhMBvdL9g6ZpX4QW0rTV06Ummwg0wtmM
	1oGgqzPQYOy/LeScxqiJzYRqMuaZlC4zU1q6E+9vrwIT4nfvBvks5Ztxmb4v+NI58F6McW/89SO
	L9pjdA9n65d8Z4qyPjlpsZ3EBZXs=
X-Gm-Gg: ASbGncuKNzm1pXx1sgN7k+2E5onSwH2YPG1447OUbS3lh93KlvKoDDFHRcakszqFsfy
	MWzzT9FtoNL8ciWmUraO+c3O+IusYdECUxmbfhPn8n0G5AecnwgOQVC5o9veLfdwc2N5lxcOa1O
	aX8TN5c45ucqpAeoPT9R/fKtQ4P09y
X-Google-Smtp-Source: AGHT+IELulgah6ClUm/OvXAJerRMtr9JG4T7mZlvd9tnpbD73gKyU3ZW6RbXuhHsK0GGdmPsba7emSbOG0aUWpdhRWI=
X-Received: by 2002:a05:6402:1ed2:b0:5dc:7823:e7e4 with SMTP id
 4fb4d7f45d1cf-5e5e22bf5abmr17512030a12.12.1741622370601; Mon, 10 Mar 2025
 08:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210430232537.1131641-1-lukeshu@lukeshu.com> <20250224142744.279643-1-christian.couder@gmail.com>
 <xmqq1pvn6zvg.fsf@gitster.g> <CABPp-BHOvCWd6mMg0WdR4O5TfZS7TWtRCQCYPLnGpo5+jNHy5w@mail.gmail.com>
 <Z712Z0zGQD1zkdkZ@pks.im> <CABPp-BHDx4YAjCqWX_VUjHQQ-r1iDbw7UcUgLXtt1ZAJjNXD-Q@mail.gmail.com>
 <xmqqikoyklo9.fsf@gitster.g>
In-Reply-To: <xmqqikoyklo9.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 10 Mar 2025 16:59:04 +0100
X-Gm-Features: AQ5f1JowFCwQ7xHYDWT2jAks81s0ltKz9fNNP7Y2tXCavqCU8NVmvuxB5xSPamg
Message-ID: <CAP8UFD1m2Lb=e-gQgR_oT7u67-S0_XY=OebOiRq6Tnn3g9-pkQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] fast-export, fast-import: add support for signed-commits
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Luke Shumaker <lukeshu@lukeshu.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Taylor Blau <me@ttaylorr.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> This is also exactly the usecase we have been reviving this effort for
> >> :) We recently hit such a case where a customer was basically unable t=
o
> >> use git-filter-repo(1) due to commit signatures, so we wanted to help
> >> out and get this patch series landed so that the issue can ultimately =
be
> >> addressed in git-filter-repo(1).
> >
> > I'm confused; this patch series doesn't implement the option Junio and
> > I were talking about.  It only allows existing signatures to be
> > carried as-is, as opposed to resigning all the commits with the
> > current user's signature.
>
> I read the "can ultimately be" as "this series lays the groundwork
> by upstreaming what the earlier effort started and stops there. a
> future follow-up work will build on this to add more".

Yeah, this is our goal. I have added the following section to the
cover letter to clarify this:

Big picture goal
~~~~~~~~~~~~~~~~

Independent from these --signed-tags/--signed-commits options
addressed in this series, we want to have an option, that allows the
person who performed the import to attest to the result by adding
their own signature on tags and commits, whether these tags and
commits were originally signed or not.

This series lays the groundwork for that future option by upstreaming
the earlier effort started by Luke Shumaker and stops there. Future
follow-up work will build on it towards the big picture goal.
