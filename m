Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EECF2F39B8
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912026; cv=none; b=RZuqPpF1lBpc8QGts9/cdUi4FDMA1XYK8/L2tMcUbNHxuyljAgh6SEso5FEfKG+6nnnUePYKuipM0Axb4QVMRxX7acGgkFDCmmy99fg6YM3ot/CCEZIjrdHnCxhMRZ4Z23VRuPu4zvIxOnvrfWe9wCy9IRoOSAtrAhc+yIxtC9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912026; c=relaxed/simple;
	bh=coGlfZ5fdS7jmEzfTjalWXXxDRsVNWUCytyHFH81ZtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgBaA9QBqHj+5CvLt6cD/USLKAZ13NZ1K9rpduI1M348jpo6YxGasAM4E/li9UODZ0YUOH+76DPB+7HZ7wzWhDyK+G1UDkxNimXiBReW5AqxuZGythUWSy+w8hV07xFQfjgc+FRpVeT16OanAAzjWjDIH73TLENn4j5Adj8hOqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KF04QeEk; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF04QeEk"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-51d14932f27so3583048137.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759912023; x=1760516823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coGlfZ5fdS7jmEzfTjalWXXxDRsVNWUCytyHFH81ZtI=;
        b=KF04QeEkDQIKewlk3RZQwuZjJJtowEhpPScSkdJvJNIzN9mLLxv46SCmi0vHLyTPpy
         JZ6B3+X+bbkfBVO4ndzNE5a/wyvy35vqYNS3/1KLFEd3aHHlcU2rsx6fu3PFmt94y/Jq
         /q6zU2aVuteGfuXnT9CX/RlfQm6Keqz7ZrPDGETQQe6NgnDRiNOqx8qFwvnqp+4xopcx
         PQOu/wE5vuKW3ugWUXlR1qU16+YJYBgWZ1rCZYXBpTGQ/P7YJP74uY8UOBXbwuNQxYCc
         1jWJEgaPdznAj+6UnlGvLT2fbaeVH2jcnTnUH6JIWCFiVlaYEglGZlNNE3d0a2MvcRMX
         KiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759912023; x=1760516823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coGlfZ5fdS7jmEzfTjalWXXxDRsVNWUCytyHFH81ZtI=;
        b=EVg8bBL3D9kgZnu8cLrHv5GsnhLoBqKhOq1J/HmU01GHE0oPuk93iUYgbKg31nv9k0
         g7f06ZR0N+wXYjvKOOyxPQYaZWhUzknUsgqGfq0S894eYBD+h/yA8wGvajolt8P8bH1v
         vLt4WxSuZHkV1bSgLFTKSaiy7FvpvCi8oIFzcIZCmEp0NAWvGBTo4jsBeErj30xSwgrG
         POt/ynzTyIvwWyqzW1bqncfyWFY7qRYoqkXUBmmjVnftqaFmMCLl/YWIpzFzaReHP0Ok
         lZ91mIBsAc3xYTqrDZ0g0lfpo6PbEOWHn98pjeJA/ZF2BtDCTKowqnkqVVMchqidYyKw
         ShaQ==
X-Gm-Message-State: AOJu0YxW6dZnnPzeQ8fhdRDxHmtqzbtNHn2Ro4EAjFH0eLq4zrT0V/NX
	9HcN2kRu4nFjAoA/TrEuyx1m7EfpRgYA+y5I+c5VynbJZtoX7qee98nsaj+YSiTGPbsF6Ocjdij
	sl+Sg4xT5ZCegPfbW6Jna5N61YKtLSi8HPy4gcy15jg==
X-Gm-Gg: ASbGncuRzQuhZ3sU0jHVzGzwg0KmVsVM1rAytXCLhJ2JbE5QaraiQ78vErn403SXkiF
	vWYkHrvcNZFo0uo7+zz/AN1llQzv+MSVEZQIeLW4BKOpAf9dTYninIL8aZGp/dB0Ri58PnQ8if5
	FH7i1CL1x3INZDkvkWyNZ1gqkKBBKzrHANCHnRPjpjBWqxliMRwiYwSrP62r/TrB/7ulh9kqUg6
	lCZn5lGX1Yjrxiq9oPXkd3/roYc5M1QmH4Yf4VuUnT48obVdwlkigVKnjzr6GY=
X-Google-Smtp-Source: AGHT+IFNRZN7knlames2lY5G9BnGnteOQovc/lGuKCC240960BZgIQ6tHN8r43mE0s0vx3ndyT8MMR4qmokegFFJpC0=
X-Received: by 2002:a05:6102:dd0:b0:5b9:ee05:dfff with SMTP id
 ada2fe7eead31-5d5e236ef22mr959223137.23.1759912023323; Wed, 08 Oct 2025
 01:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFpMFfDMmvbKMNGbmqA=d_+x48kiefT_SGQ3M9m8ST9871UE2A@mail.gmail.com>
In-Reply-To: <CAFpMFfDMmvbKMNGbmqA=d_+x48kiefT_SGQ3M9m8ST9871UE2A@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 8 Oct 2025 13:56:52 +0530
X-Gm-Features: AS18NWD0MbHVNEK9ro7QNMnxRslSUAtALvpclilX_JDK4e7WF_v9--1FhFviW9E
Message-ID: <CAPSxiM9PPHuMfje5zvM7U_rE5TRoB+=PUGCGO_k-5ZCtvQ8Q8Q@mail.gmail.com>
Subject: Re: [Outreachy] Introduction - Rosemary Ajayi
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 12:57=E2=80=AFPM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:
>
> Hello Git community,
Hello Ajayi,
>
> My name is Rosemary Ajayi, and I=E2=80=99m an Outreachy applicant for the
> December 2025 internship round.
> I=E2=80=99m interested in the project =E2=80=9CRefactor in order to reduc=
e Git=E2=80=99s
> global state,=E2=80=9D mentored by Christian Couder and Usman Akinyemi.
>
> I have experience with JavaScript and I=E2=80=99m currently learning C an=
d
> exploring Git internals.
> I=E2=80=99m looking forward to contributing to a microproject and learnin=
g
> more about the Git codebase.
Great, thanks for reaching out to us and thank you for your interest in
the Git community!
>
> Thank you for maintaining such an important project, and I=E2=80=99m exci=
ted
> to join this community.
I would strongly recommend reading through [1],[2] and [3]. They should giv=
e
you some ideas for how the Outreachy application process is designed to
work in the Git project and lays out the expectation of us mentors.

You can check [4] for more information.

Let me know in case you have any additional questions!
>
> Best regards,
> Rosemary Ajayi
>

[1]: https://git.github.io/Mentoring-Program-Guide/
[2]: https://git.github.io/General-Microproject-Information/
[3]: https://git-scm.com/docs/MyFirstContribution
[4]: https://git.github.io/Hacking-Git/
