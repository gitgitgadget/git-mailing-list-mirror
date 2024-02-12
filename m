Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CEA4F8A1
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781164; cv=none; b=LZlXqeXXj+rxsnTtyKmK87OdjT/92bjfEpJT4q2gTtVxjtLu/ks3ac91Vpwt+nldkLwvmb3pHCzL6Gsv1GkK1wNQYruddb0ishK+RowZomXj81Mr3Gfv1LIg3xEPgnMk00XCxvs3ym4X7PIOBVNGiFdhAiwmq99cBE7u673s0Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781164; c=relaxed/simple;
	bh=o6DAwN+Ncznh5NfkLVeW1tPT9Y4AfBvkdzRjg5tiryA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxAmajirSGVR90Ofe2hw/ajZzCdSO6M/ydP3xEFgDRt4/0Jvug8a1XXcofXEbr5rgIGN7Lp+uqDFX8gKC6IGlhBbyIyEYualOvzat2Uc5I/4670XOMxSS7zSqszLRz9oi+mgW1c/DzpQRjY6FXAFimN2s5+7ZdPjHG8SEP9XNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYndT/31; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYndT/31"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so47860666b.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 15:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781157; x=1708385957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffunJtqSdIm2GJjEQEEaGvJbtedvq3pXk4IxP+P7O6g=;
        b=AYndT/3176CKw1hjRFmMxSUBPZGBHPVmh9kR5Bs/ov1GLLK8qlHp6D+UTq7VS+FnPn
         6YtUKe75YDLojyXE1wk4AzQHCsD/ZwQGQblFkeT84PsGHf0lkJfry8DsFDhut9jncP4A
         HPFqCtJqPXoXcZzXoLI4ou58stPSyXUfadsslB4dRYXn2DfEf2xi8p2U6G4KZjSy5QAH
         BZdSbR6M+gosr2qWEeWtD/xZEtbF4By6M4o79emVNZbIMBrZxeT2FKINnX4hjlxvPKb6
         l11So4bx+ai3bFeAAlBZqRbkMS61rMI4SDzbJqj/gJ0bdrQ5nFggI0JVv1Yb9scutFaK
         +Tkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781157; x=1708385957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffunJtqSdIm2GJjEQEEaGvJbtedvq3pXk4IxP+P7O6g=;
        b=IVATTi6fqWw2Uzi88oeBPeWNmUwTJp4JGw1bW5Yfxo3ScpaqSrn++QlzxDsGC2gyvd
         AHk8UfIRJoYHWnuuXZEClcNCQkL6G8/epdmqAflJjbtMxgXXnTFQK5PMw7v89gHwmFHK
         3mGvm5GaW4W2ZwHmZQT3a1gJR2JzP+hltXLccZcxS8CTuhaKFMIeKGoTrBSg1NmtIOnL
         0sjNhfNTIWHziU0RdUNjRfaODJtDqxuGgsM8eZq1E44h8qHJGLccP14Hy3t1rSk4vBSq
         QFW1OvWPQrBZEM3eUCIalCveQUmsKO6IdNkrZFGZobbPdit+ne41w5NLa/cCRDBwf/l5
         NTjQ==
X-Gm-Message-State: AOJu0YxEiJ3vEHBxqFBQ2zLxHbiqBxVPCt3Nt9+9cTgmlj+Kumy2WuMm
	k9WuWTkLt0eCVzwlowCAHIBkTNzBAYIlJIibesZ4NsI2tPQWL9JSDVvE9Sftqs1rFJMSIxI9ZIG
	H2ZpGnnpWzD/QIOTmYkA+/H2UMAU=
X-Google-Smtp-Source: AGHT+IGIg+5Og+BStVkOQ2F12w6+bvTPg/XK6hP9I3jGEuGBTKOuZK9UEkC4upnP+MI3C+LwPES6Assv7VcEeeZnlwI=
X-Received: by 2002:a17:906:af10:b0:a38:32cf:1c9e with SMTP id
 lx16-20020a170906af1000b00a3832cf1c9emr5745177ejb.52.1707781156530; Mon, 12
 Feb 2024 15:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <38f4b4c4135dfebc06c2b1d5c56854af4b07fedc.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <38f4b4c4135dfebc06c2b1d5c56854af4b07fedc.1707196348.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 00:39:03 +0100
Message-ID: <CAP8UFD3ZRfrG4s5jox55dYMRF7UT3uYMkyMraEGWRJ2HqBEYZA@mail.gmail.com>
Subject: Re: [PATCH v4 21/28] trailer: spread usage of "trailer_block" language
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Linus Arver <linusa@google.com>
>
> Deprecate the "trailer_info" struct name and replace it with
> "trailer_block". The main reason is to help readability, because
> "trailer_info" on the surface sounds like it's about a single trailer
> when in reality it is a collection of contiguous lines, at least 25% of
> which are trailers.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  builtin/interpret-trailers.c | 25 +++++-----
>  trailer.c                    | 97 ++++++++++++++++++------------------
>  trailer.h                    | 18 +++----
>  3 files changed, 71 insertions(+), 69 deletions(-)
>
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 6bf8cec005a..f76841c5280 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -140,8 +140,8 @@ static void interpret_trailers(const struct process_t=
railer_options *opts,
>  {
>         LIST_HEAD(head);
>         struct strbuf sb =3D STRBUF_INIT;
> -       struct strbuf trailer_block =3D STRBUF_INIT;
> -       struct trailer_info *info;
> +       struct strbuf tb =3D STRBUF_INIT;
> +       struct trailer_block *trailer_block;

I understand that using 'trailer_block' for a 'struct trailer_block *'
makes sense and I like the idea behind this patch, but it's
unfortunate that 'struct strbuf trailer_block' becomes 'struct strbuf
tb'. Also the name change for 'struct strbuf trailer_block' could be
in a separate patch.
