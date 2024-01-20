Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A27910940
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705779295; cv=none; b=AOl0JIc9eI2LTr63g/t2V0hKcxtRIPux1atSXcEWBISSYLNdEg0pCW0zKtD0hXh9uZHpwM9BRTSCbC/vzbs8LziN/myixD/5ExEU9Y6TqcLScvU/JxPM/piimhP3zKqjAzZxDSccagUgfy1iFHsY5hq5ig8GOaMdW0cVfWn29+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705779295; c=relaxed/simple;
	bh=Vc0pLV9c/Ewim17WLrOZ6kyMMecx7kbT4fx+Fe5hnJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqc+JKPrKUXlfnJxvuQOMCtgZwkkORkFgoKPvGNvAZZ+ElyxbVNSrdEyC2a0tW/s19e1bcUXrGu9irKYQXW81A3CqrwABP2e+VyXsKKCIZvlrXKvCoRSuvovoikItzetkgKKfNnGCyR/CxMSKTAR8J0iwvNL7HlIbbSICBuP44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjKRTRsc; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjKRTRsc"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc22ade26d8so1385016276.1
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 11:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705779293; x=1706384093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rALoSHXa4rY0hY6bnBDVxBbm0U351Fcc+UCi07CnQC8=;
        b=WjKRTRscINrB1XW9FSiMmuGq+iLEeNIrlYfbiXQCdtK1OqWCD4Fvb9TpfrTFCtoiZl
         SGKTgYZ9z/UShAfuZZSjaw+dCvaYoUB5zYDSu3k4nkwpf8COCZcf7kkU96M9vTMypa/R
         fpwlhE/hNsyr+Rt+i+WsZCAoKHeTzO6K7K/7IshlmXKQac+y9xDT2Z4tv44szL9bbasm
         +Dxf3Pttr/Hn2BORlbnHLw4K2CLQda8Oqe9GBqWYpP5Ugu9ER8LofIEfctH/k2eUQD0n
         HdTJVfFIZpqHzb4H06jWspAarPCwE8oky+leJ7UxY48+nquVfFwC/rPrBeZgiYbQRXSf
         dXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705779293; x=1706384093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rALoSHXa4rY0hY6bnBDVxBbm0U351Fcc+UCi07CnQC8=;
        b=fstkLLdcts2bAARm+j04la1YxMXJBXRLZydNVeTLO+oyROxdRThNNjNp5UPueb4E4Y
         002GpsJNBNej5g5B85nOTD2mZfSk4NxTg3MzTc3Gi4RCapTw+398/BYoXqDXu/DlOtya
         sc2wjFexE9S7wzhMzLv4osG+2AXZcGDAZH31GnRcPNyJiuV7JsO1p6hJkZllG8oEBMkb
         NJh8FiSg2IFm5K7tY0vnjRqoq1WZITXm71V7nE+uLizM01VZhnZzRgQtxMC/f5Fsp7uR
         fBAzV41BUJj5JEISvxYaPSpUTbvUoUiY/3OTnwNM2odsQm8Bg0wrsHlf7bLeqkdvWlp9
         Qq6g==
X-Gm-Message-State: AOJu0YyjQyGDycFYaWy11B2n1FkAOepSgtPPEwd9Svxr9plTJXk1qeR7
	1hkQLPlCH+8r1MQJrGoyRPWJIUH+tO2AZtHQUPEnj/mQAM8jLeJmc0XYYBLyIZkBuGK+Pm1NL3A
	cbLYagfhWyVPqZE6aFA0H+so27Lk=
X-Google-Smtp-Source: AGHT+IFyk8dFnJBBSKscn1tOd0v0XgB7zE3wb0KPASkMKUzVhDE2VugPtcSevutYfQwWB97tyLw3MP8HrgQPvYV3ThM=
X-Received: by 2002:a25:254:0:b0:dc2:20c8:75e9 with SMTP id
 81-20020a250254000000b00dc220c875e9mr1000552ybc.33.1705779293202; Sat, 20 Jan
 2024 11:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1639.git.1705775149642.gitgitgadget@gmail.com> <xmqqr0ibetap.fsf@gitster.g>
In-Reply-To: <xmqqr0ibetap.fsf@gitster.g>
From: James Touton <bekenn@gmail.com>
Date: Sat, 20 Jan 2024 11:34:37 -0800
Message-ID: <CAA3pzWRRrwLN16RsNEJjdQg7vnSM_p_MtLqCU2ZXg5L=WPc-RA@mail.gmail.com>
Subject: Re: [PATCH] git-p4: use raw string literals for regular expressions
To: Junio C Hamano <gitster@pobox.com>
Cc: James Touton via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 10:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "James Touton via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: James Touton <bekenn@gmail.com>
> >
> > Fixes several Python diagnostics about invalid escape sequences.
>
> Thanks for noticing, but we want a bit more backstory explained here
> in the proposed commit log message, outlining:
>
> 1. With what version of Python the deprecation warning started.
>
> This will help us judge the urgency of the fix.  If I am reading the
> docs.python.org/$version/howto/regex.html right, we do not see this
>
>     In addition, special escape sequences that are valid in regular
>     expressions, but not valid as Python string literals, now result
>     in a DeprecationWarning and will eventually become a
>     SyntaxError, which means the sequences will be invalid if raw
>     string notation or escaping the backslashes isn=E2=80=99t used.
>
> in Python 3.5's document, but Python 3.6's document starts talking
> about the warning.  Python 3.6 was released at the end of 2016 so it
> is 7 years old---users have lived with the warning for this many
> years, so if the above reasoning is correct, this is not all that
> urgent to require a maintenance release.
>
> 2. How well the new construct, used by the code after applying this
>    patch, is supported by older version of Python.
>
> This will assure us that the change will not be robbing from users
> of older versions of Python to pay users of newer versions of
> Python.  Again, if I am reading the documentation right, feeding r''
> raw strings to regexp engine was supported even by Python 2.7, which
> is what git-p4.py already requires, so we should be OK.
>
> But we want the developers who propose a change to explain why it is
> a good idea, and why it is a safe change to make, in their proposed
> commit log message, instead of forcing the reviewers to do that for
> them.
>
> For other syntactic and linguistic hints on writing a proposed log
> message, please check Documentation/SubmittingPatches document.
>
> Thanks, again.

Thanks for the notes, I will update this when I have the opportunity.

Raw strings were already present in the file, just not in these
particular locations.  Given that, I wouldn't expect them to need any
particular explanation; do you still want some mention of
compatibility constraints, or is it enough to mention that they're
already in use?
