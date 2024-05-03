Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2F101F2
	for <git@vger.kernel.org>; Fri,  3 May 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746958; cv=none; b=mCOFUcBdjBqqH+X7Hrn8H0CCakaripkBwqcQULc0zuOKQrKu1RiH375LoF+UWM41ZgpZXhbSEL1XETZzzZifmYECJL1x6u+T2EoAQR2kc86Y0Xq+qONnzHwqTmBMPkbD/9DXyw+YGdE+KYigek6HkUth0i5EXS8+N8CcHd+Tt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746958; c=relaxed/simple;
	bh=fxD4C38Epz6evvrTjlsNNMDBYwfzoNd/xwV4ffmvwsM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=og10Ze9hYwtV+bPhdEJatuBGHE3R39PeTAUN9noMICCSXRfVQj9nP+/gY0V8LCMx1BS2xKRfafg5uzRiUwV1UovupkRkxa7f474b9GLGB26UrtFfKlvfcVL+JeVE/cghglp6EJADPCJavVUoV/XJc38Za1IpzYJglD0GCI4OSLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKTINtni; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKTINtni"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-23dd52c6176so1279622fac.1
        for <git@vger.kernel.org>; Fri, 03 May 2024 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714746956; x=1715351756; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQShPyJeMovNxyMtQuPFfOG2yZLET4QV3Le6qp5s6TM=;
        b=XKTINtnitG1HzqgUNAw4q7WRPoFNr5aIATfsF6DWCMgO3GcZSkoV0mML868HWhDVFn
         Dg96Ic3EAXC66rNgocqznzGFK1k8eBZCRQximBBgH9bkdIOIuIoYSVihvSWidXoj4tvr
         OMcGhl7Smjw6NEoRz4fG5NKaXm9CfFviMX4xry90lqhDQoiFJIFkSijls/ZEnW4GXA3X
         rUOK34Ucipno2tig9RAoKMMJEctLSlzTZAVYtXmqn6TCUk4/DLkLqyyChZTHfQG+z6ly
         OAbYBhLQ8fdx4LGAvouE4gWyuhIied0OuRgvnQ16uXBTuwXHB+V6J64a6nL613/fksD6
         xs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714746956; x=1715351756;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQShPyJeMovNxyMtQuPFfOG2yZLET4QV3Le6qp5s6TM=;
        b=a8XsIY1eD8tcnMgK1ugqgSdqLUfGGiZ/0VS3UclJiCqPp3fUSmHv1wPS9C/rFEvZZT
         twFYdwRWqRFfyj3uClFXz0Nc8ryQ7e+DqdYbW4Spd85PfJ8XFdiIJpAGXbekyYlX4DAl
         CmsuQEukl+1I1JNYksI4yg1j2JAE0bevJJQXyTMvk6U7vSkSZnqFKJuMZsrz0AsXh2gh
         he43DCb1k50f7//In0jIuRKNnHjmqMwvWXxYL37ct5Yv6yRbHrl1u4wLpKmNNe2KoGSL
         9SAiCKxILTSewj04IlMcXgfojDYW26LyLz0o2Zib4KtqdI8Rw0Fln0qi33j1MG2WQ2d/
         XHDA==
X-Forwarded-Encrypted: i=1; AJvYcCUn+h7wFDX15HxDq8FksErTexrBYI93vyp4HZUVtIOqoVgLuE+0m+ksww0SyYHY9Z16R/7wEgwAM4NoqfzEvk0LDx2I
X-Gm-Message-State: AOJu0YxlPr9jXoI38jRLWJuu9y86rxCbm8YtQZ3b/aRv3lu0sZQKIYgS
	xB+ovAMZE2sBTfhfia1pF17JjnHdoMDCkYEOniJrXHPeowMRjQY/276fdPt98NZbsX0wPKBYxyE
	SKVF+dVROt/CmqVhikNSWSt1oIQs=
X-Google-Smtp-Source: AGHT+IH7NDR7KZvl9IFjAIlcPmWQFvR8/2mQGKQzeKJV4jSQXaMFVNDXl0tR61ggx8NkNnqRbfz1NOoCA+nVXCi6drQ=
X-Received: by 2002:a05:6870:a349:b0:232:f9e0:e4da with SMTP id
 y9-20020a056870a34900b00232f9e0e4damr1153532oak.1.1714746956479; Fri, 03 May
 2024 07:35:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 May 2024 07:35:55 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240503071706.78109-1-james@jamesliu.io>
References: <20240430014724.83813-1-james@jamesliu.io> <20240503071706.78109-1-james@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 3 May 2024 07:35:55 -0700
Message-ID: <CAOLa=ZSHPVbd2pweNz+MtkdWgsZepsExODyd7UNx1774TzWV0A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all hints
To: James Liu <james@jamesliu.io>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000038a21206178da3eb"

--00000000000038a21206178da3eb
Content-Type: text/plain; charset="UTF-8"

Hello James,

James Liu <james@jamesliu.io> writes:

> Hi,
>
> Thank you all for the comprehensive feedback. This is v4 of the patch
> series to introduce a --no-advice option for silencing advice hints.
>
> The main changes are:
>
> - Two preliminary commits to reorder/clean up the options documentation
>   and usage string.
> - Caching the value of GIT_ADVICE.
> - Adding tests which explicitly set GIT_ADVICE to false and true.
>
> Cheers,
> James
>

This version looks good to me.

Thanks
Karthik

> James Liu (3):
>   doc: clean up usage documentation for --no-* opts
>   doc: add spacing around paginate options
>   advice: add --no-advice global option
>
>  Documentation/git.txt | 18 +++++++-----
>  advice.c              |  7 +++++
>  environment.h         |  7 +++++
>  git.c                 | 11 +++++--
>  t/t0018-advice.sh     | 68 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 101 insertions(+), 10 deletions(-)
>
> Range-diff against v3:
> 1:  55d5559586 < -:  ---------- advice: add --no-advice global option
> -:  ---------- > 1:  ae3f45dadc doc: clean up usage documentation for --no-* opts
> -:  ---------- > 2:  1b0019026a doc: add spacing around paginate options
> -:  ---------- > 3:  31e73e6c0e advice: add --no-advice global option
> --
> 2.44.0

--00000000000038a21206178da3eb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9d44271273777c45_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZMDlrb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL21sQy9vQ1VKN0J4cHFYNFZaZlRlb29aNUQ5ME8ybApjbEtQbUl3ZVVa
VGVwRGk0dHNnVGFQOGtIMDBFbzV0UDBJUm5DNVMvRmFwR1FiOUZqNy9VM1RZRUpvQUxiK3hhCkJX
c2tFMHBVQVMrT0JjejQ2akthYlFhTXhESkFPYmZpMXFMRW43UldaajRvMDhhWDZFSEhrVjd5M25U
SU8rUm0Kamx5U000eSs3OWVkSmVGcGpIVGZQUDJZeUhWV0NCUUJSczEweWxXLzFOZllkeWpDWDU0
TmlLeGhGYnNHYlRHTQpqSWcvQytrejczTHN3dm9QbkF5cEt4UnA0aDA2TndlYS9tVXlDWGNyeHRQ
Z2E1bi9zRDJoeHZUcXF0aDI5S3FVCmF2NCt2KzFlcnFRSkxxQVJRQVJoRVRNNFFWRUJqZzNWazRR
dTBZRlQwRmRqRmplMVhhQUE4OE5Xd2ZXcURWRGkKZHRHUmMxa0Z1NmcyVS85MHFnNGxoRFZrekVt
ajg0WmhTMnlKV2d0aHVaczE2b3ZiMFZTT2Y5VDJ3SEtVYmhFdApEeTNzdER1dHZ3Qmp2d1FMK3Fm
MURqTk5UOVFaOVNWODhCcFhSYXY1RFpzVGpoL3VMNEJwR2UzRzFIRzAxTlBlCjVUdVB6eldYbmN3
cFJQa21ETkpEei9hT0hXOEkrT0xLNmhPSzU0ST0KPVp1ZUMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000038a21206178da3eb--
