Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05CB1C9B64
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583900; cv=none; b=LeFsBoSE32UCFy+qMfhiA78vVJfk0DnxB8jDx4/0clRMU/QOLy2Z1RSxS1VHooBdGBdj1X7soBCLdE4U8ApzX8jtK9B3D6yUgxrDXL6x0ayvTGL2T9/YjtQlJUx0loHyZl7ypPPy/si0dvPyZjvYmP12+tqUGuh7mTnrG8LiIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583900; c=relaxed/simple;
	bh=BaZAdm83lQN+XVTAGn1s/adWxJblJUO7TB9yrPtc4ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uv3Cc9z2sLw8iVgKQs06x4dCSnufJZrzi+pUAddD5dSsWqB3ZKiHaRFpMirV/bSCOSOsccRjViG824f3UZs+W1xcWUEl8e9CFxKOyL2csHkZ/69n5k9+sqMVJjJrLay+H7fZljkOyctMH321JbFUDBMR3LFpxQP8J4539sY9qrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R+Sx+Di4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+Sx+Di4"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99543ab209so168638466b.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728583897; x=1729188697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LYEuP3mGku5Fv2ahzTd2BgUqEIuhhPUfmHxb88uiSY=;
        b=R+Sx+Di4oWtKP1GvQyhVirtYRGErlJoH/hFcuu2/ufzWh71sWRSOO9mP7TOKkCicVr
         oSnsRXUOd90hgBLj40py4n/0mnF6MNRZTu13iCPeyM9sA+p2rojp7/pRs7kkmsdooxNv
         3ztRcjFqaXdvC8Vupl2AV2scwGMTG/CX/m9l/7e8JjdDchcfU4shvbbF22o4tH9EAe3X
         6fzUe0JsxgoJnSJpHkaZLGUlaJMJuXGSwsYs5vXKLxiomrmSt8IRhmlQuSQqpcAK09cY
         UGJrBQwUmet3RazOanGNaczSNmLCZgtwwgZI8HMbtSIda6BWRWgTFgp7a5u89BcxcIZw
         45Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728583897; x=1729188697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LYEuP3mGku5Fv2ahzTd2BgUqEIuhhPUfmHxb88uiSY=;
        b=Zr6RKCFGnPV5JSFscSc3DcAsr2CiUtXaODUT1C1hfwYRZdRCWX/RurjJAjXDA0IPR0
         67/F7Y3nW03SL/yV5Hl1mccmM5Em+WbZ0LffMaNp1VdkaXh5nnG8ESZkMFbZlZqf03b/
         IOu9jSK/f37XEbtzoReUAeXBOJU0RUnqLEPH1MY2e4Zm9LxFzdVV87RCXCvgnsOSoLaW
         NvDFWlZfEkMSkyIJiW6GKh7q/490VJxoV97H6V/7n5NmYQG6c0nP3xXpCOWZoxTcs/2i
         +doMb5fhgssaGeRKb/3GZexqNj3SBqE4yUtjdX6a33sW5vann7sQN426S9iMmfe5WYJx
         N3BA==
X-Gm-Message-State: AOJu0Yxvgqj0WBJJg+I4MpsvZbcR6AxycyOw1EQcGum30XbMsdPc/6fM
	KKQlooyv2H2HsWXqSul/S7Wc+Nl9woweLnJHkKHqr8ByCiVGR1MNIO4qvtRa3wPjHn42+jUzGaX
	pBo14vvzyBoeJaXEHYY1zY5nGnXClt3Ekg+qT
X-Google-Smtp-Source: AGHT+IEjggnu6OU85j1GRDhzRkvFTKSwfS+U43g+StyhUH5WatSWV/eKg3JMdflwbZtiYd+dyglM9oOMZVl75ynEgQQ=
X-Received: by 2002:a17:907:9487:b0:a99:5c0e:e3ca with SMTP id
 a640c23a62f3a-a998d201507mr506816366b.34.1728583896532; Thu, 10 Oct 2024
 11:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728582927.git.karthik.188@gmail.com> <e22ffbe0f65971579809d817984766af12898127.1728582927.git.karthik.188@gmail.com>
In-Reply-To: <e22ffbe0f65971579809d817984766af12898127.1728582927.git.karthik.188@gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 10 Oct 2024 11:11:19 -0700
Message-ID: <CAO_smVjuseH6WJgU5CRg5kyZ7J1mgqLjrvxzapR0xB6XvQ7VdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clang-format: change column limit to 96 characters
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:00=E2=80=AFAM Karthik Nayak <karthik.188@gmail.c=
om> wrote:
>
> The current value for the column limit is set to 80. While this is as
> expected, we often prefer readability over this strict limit. This means
> it is common to find code which extends over 80 characters. So let's
> change the column limit to be 96 instead. This provides some slack so we
> can ensure readability takes preference over the 80 character hard
> limit.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  .clang-format | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/.clang-format b/.clang-format
> index 41969eca4b..684ab32d28 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -12,7 +12,10 @@ UseTab: Always
>  TabWidth: 8
>  IndentWidth: 8
>  ContinuationIndentWidth: 8
> -ColumnLimit: 80
> +
> +# While we recommend keeping column limit to 80, we want to also provide
> +# some slack to maintain readability.
> +ColumnLimit: 96
>
>  # C Language specifics
>  Language: Cpp
> --
> 2.47.0
>
>

I think this means that the next automated `clang-format` invocation
will un-wrap lines that were wrapped at 80 columns (not characters)
but fit in 96 columns. Modifying this setting and running
`clang-format -i *.{c,h}` produces a lot of diffs of that kind. I
don't think there's a way of setting a soft column limit in
clang-format.

Personally, I'd be fine with a higher column limit, but we'd need to
make a conscious change to the style guidelines for that.
