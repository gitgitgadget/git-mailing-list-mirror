Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814B1D6193
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171981; cv=none; b=m9MRoyvhsAuPxHjK3sPskTPFxHD88akGIqftBGC/W8KNv/BNYz40APOwiSD2Z3p+xt/+Cnaw/idqTxhTRMJUJh7vjS9lT8r4mWeNpld6Yxug/fR/JXrY8hWhyi5mYstV2/0int/MQffSqS2PmmSCxsPSJ6UVKAueUH+rZjPYyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171981; c=relaxed/simple;
	bh=I6VGqnc3Fwmt1maydGDIE/pHarstR4ROJm2jrqSRIls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMFafpf8z4EbAnOPeTvLdeNbX4nUyfgWACHPY0BCcTYSlcIdOS7M7/G8EJ2r3wBunPIlhYEoedAEl7O/jsVBtivQUYmluY2g2vAlWau+avrjk98dEIjE56LoDRWaPTCV/0ZC1zoCaFPr1CLnqWzd8tLCtkh56hf2v4ty0DANCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6zu2Vzi; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6zu2Vzi"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5522bd69e14so1010676e0c.1
        for <git@vger.kernel.org>; Sat, 11 Oct 2025 01:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760171975; x=1760776775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6VGqnc3Fwmt1maydGDIE/pHarstR4ROJm2jrqSRIls=;
        b=E6zu2VzinibXHuCpToiAF6Ym9Yphy6D8QIpOfWghmAUCFSODymEqC9p0u+lN1CNwpq
         6PZhvSFznBb9RYeY/mHQcfVF+yCFeODoTIUHFT9cEJRNxGqg+q9qjRqzQbhFr30LfomY
         kcD6BhiP9FFRGg/5ky4lsmPAyX4WST8j58cPbscPWPsIllsUAdYVwSnoDXnySwO0Uwjg
         MwPolc3Oa5jAUdYayPiaP+uODG/nLKjvn2qsV2+ZPwiHxC57RQ3LR8Wz0QjKdOH3bUCy
         CfA/2J316eWeMRTbWvVbGP8yTHc/QGS37bJq2qiP5StMCPF/YJm43VjvYPUApZdwHug9
         Y4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171975; x=1760776775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6VGqnc3Fwmt1maydGDIE/pHarstR4ROJm2jrqSRIls=;
        b=pwhdXGThkt4sJXumznU8bu9X7zBeY8Hj7ARYxxnKSPfoR/S2YWxz/fpna2vfEMX7lh
         HmuZgN6imwYYjCE2uY6LplnESPQ0SkrZcT1bJc+xOxOgk0y+VD5aTs2NmFQ07NxgMw+b
         PPLjSm53e28is7qelDow65gO+N7xk9g4B+zAWdR6s6LHbuG0VeohgipUXn5192XEcKJE
         898AQ/aAQKkCDUtnGxslGdE3reccPkL4JG4gB2Fl4vf5c9BAcEoenaplAH/qBA26hV8b
         enN2PZzjFNzaPFzXHX7Rcb6CkqRV1Ao4QPgz/YwOH3YJd8khLj02KCNJFC1ZL/Zn9KoL
         /e+A==
X-Gm-Message-State: AOJu0YxVk6dlPgjZyUnHRuXGssvOH1TTwI+f2vufsoPmPyG4FgKqAOMH
	NHg9Q5Lm/Xci/bMFRPOBCAC5xzYd5H+5RaP1pX3Woj1NNzxhFGCMOD5pi53zMqlcWdmQ6V4lhqo
	FJIDx4uZ/28594DF8wnBQD8Li6SPDjKwYf8SCwGZl/Q==
X-Gm-Gg: ASbGncvkgDZNyU2jU0fIpYkFjQxKJEuSOIKFMtPx0iokY7FoFDnsd7el5v9N0u85FG0
	nLij6BTU6x2CrLZHvtgXVfpc2/y5yu0rSwnK/b0XPuh3PG5ApcRKEJq5eYkzdWK9ClgEM2LJJP7
	UudsnbcUyn9TxI3JWqEPq/LBUEEaV6L3dnCVJNORuDTXwsJrTfB/0Qrqp5RXFEA0phqJWgBbmlN
	E6pr+kVNtmOTtC/g+S5UkLgDwwXTURnRACOZFXWfkjJSD+bLACLtS/XLX0jdFEHelkopASiF2y1
	3fs=
X-Google-Smtp-Source: AGHT+IG9VYWjRFyKrZDIXNaOdlDb116mFReYmYJFF/lTPJeeMQxALxYZ0fuxM6GVfp9PpzkgDAAFo39YkwEr7/0mUMM=
X-Received: by 2002:a05:6122:3c44:b0:543:8c04:43f4 with SMTP id
 71dfb90a1353d-554b8bf17a0mr6606182e0c.14.1760171974693; Sat, 11 Oct 2025
 01:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJrT3AvkiXFBsfoGypHiXAOY6pDqxbYc5jap2Vn_ONCUh85a+g@mail.gmail.com>
In-Reply-To: <CAJrT3AvkiXFBsfoGypHiXAOY6pDqxbYc5jap2Vn_ONCUh85a+g@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 11 Oct 2025 14:09:22 +0530
X-Gm-Features: AS18NWCMxvgfJHIbGUysgTlyb9uLKusc2AX1thS94UB0J1xrFdW_63UN7n834pg
Message-ID: <CAPSxiM-u_LjkdXZLcKC6FysrWFCOxPsHB4Rk-_HPHrRaOkqr-g@mail.gmail.com>
Subject: Re: [Outreachy] Introduction from Applicant (Archana Kumari)
To: areychana <areychana@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 11:11=E2=80=AFAM areychana <areychana@gmail.com> wr=
ote:
>
> Hello Git community and Outreachy Mentors,
Hello Archana,
>
> My name is Archana Kumari and I am reaching out as an applicant for
> the current Outreachy internship round. I have successfully subscribed
> to the mailing list and am excited to begin contributing.
> I've been using Git for 5 years and am eager to contribute to the core
> project. My primary coding experience is in C and Python. I am also
> familiar with Shell, and I am comfortable setting up the Git source
> code and building/testing it locally.
Glad you are interested in contributing to the Git project and that you are
comfortable setting up the Git project.
> I am particularly interested in the microproject idea related to
> 'Refactor in order to reduce Git's global state'.
> I look forward to interacting with the community, receiving feedback,
> and submitting my first patch.
> Thank you for the opportunity!
> Best regards,

I would strongly recommend reading through [1],[2] and [3] if you have
not done so.
They should give you some ideas for how the Outreachy application
process is designed to work in the Git project and lays out the
expectation of us mentors.

You can check [4] for more information.

Let me know in case you have any additional questions!

Best of luck in your contribution period.

>
> Archana Kumari
> areychana@gmail.com
> IST/India
>
[1]: https://git.github.io/Mentoring-Program-Guide/
[2]: https://git.github.io/General-Microproject-Information/
[3]: https://git-scm.com/docs/MyFirstContribution
[4]: https://git.github.io/Hacking-Git/

Usman
