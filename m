Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3851EF38D
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646350; cv=none; b=dtpCAiuwvoBLhCPEcNrxMW1+Tr+EkmSORF9EHiBEGJVbC0E0vzeWn6M9NLfJfSSrqtfdNiSivINZWa7PKpNARJ/MveCpze+5ViKXOhOegc8Nga6AMHbVIGZ9mGnD7Gn6w0NdjxHHazykU5UeIwdlaN59CiYFhsU9P2OMertYQaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646350; c=relaxed/simple;
	bh=IHyCE/QSbRNww1/y2S3dh/naALmoZxqbPqj8mDQH4LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/dJTfDJd+VsOPg8qRrKiQCcEJcioxV2ij/svYYjxAch159wSVfk52KY2whSUe4YiLEsdZupRsZpE7vXH601/tUKvnguAzsUh0gqhCKJIj1vz5ScD1/EladyTYCBsjdIs6bDqbAL7Zv9yaDQDQf8k/B3pTU9Ti9qSLeLAQ36iAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvRRNE5E; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvRRNE5E"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso7400443a12.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741646346; x=1742251146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cftqOQwt7xjejYT/MiHpmPPwZu3rw0DbqFlf/5kQy3Y=;
        b=PvRRNE5EhlUK/E6n1n0L8siIqRiM0yzDgPqwllxmlt7Jv1R08jpYjSDeXHTik2cykp
         qw2O/Yngr+9/bVlQgdOl5jyzmplt3ZxR7IL7LC0NE2Tmmyb/fXj4IRWTuQ5H4WTY8RHm
         R+eSZbdvVZsIB6pMFZWBwDUllfh592kYMFPkFISEl+4+u3nXt/u3LFWj5xeFF+hjAIGk
         M7cO1AfLP8G+jAUKtV7guEJrPWUCoWL1SXq/6sLgmWnfM7Z920HTdVO9HZXyes1+foEM
         4EUMvrSF5pkxEo69akPrMidHnUjOdYBieEPz4ARROjbFVPZUoxLQ73P5V6kUQNOdnRNg
         NoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741646346; x=1742251146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cftqOQwt7xjejYT/MiHpmPPwZu3rw0DbqFlf/5kQy3Y=;
        b=TW8yeQz6efyRUMhPYyjGoLlZ0BoVTc78rp5mWw/f40csP4blWY4nvJxaIzq2+RRozp
         /FTG4pQL76G32NJNu7QFrak72rmLsBjuxGLgSGnYlDqxCNQDY350p+w/Qy5ZSt256LJk
         /zyDyKEcYYE/a9a1TBE6DJy25GitcFk8gkqmeLJ4Byxi1Lfg+2zdXrRan123RWoE/EZY
         J9qRS+O1OamVN6cdH8BRgzutgTxiC/LnsMdYE1o9MMT5rAmDhhjnZjDlOK8H5FYFgWqQ
         sbPNbR07HKfBv87BscZWNfDrv5rJERhyV8E1+UQKSE5e7UBeVN4BUdaFN+HHFAg7hCId
         QVrw==
X-Gm-Message-State: AOJu0YzPJiErftm44zaPAseKhsu7SHYG4qcL659u0DhV9pTKFGY4/rmQ
	1QTcXy/rN5MmtwOf9eI8aldeSR47HkKC7H6oWv7/CxVtOUW4z86FLrrPyRouOqsWuBvhEZ0oy6y
	X3jMJHF4YUeI+Bjy8bdcfQJvx4q3rHxOn
X-Gm-Gg: ASbGnculAVP45RB4Fzyt9rMOYJrJ5Cz/ZLvuDLtqcOZG0tnr4soDTYSThatbG54zdaS
	uk1SZTkvWjL3aSaDB1xJMz5LqIVmNse/PwjLH4RVtW3VmVYnJW0BCblLbadAK43ARQ6yyNM51Gg
	CKBUbGySDS7ufyVeu2HjzOdweSGluLa8QxX/HF/yNtMfCIH4YNOEnaK/8D5kC0
X-Google-Smtp-Source: AGHT+IFrl135B6rksnAdAmJfzzfNl6NVE9Gd9OVfo4/db6VbrjhDWQRykfGge4ALhUYbOlWqLpqpTPhOGira12m63pQ=
X-Received: by 2002:a05:6402:3589:b0:5e0:8c55:501 with SMTP id
 4fb4d7f45d1cf-5e5e22a9443mr15448505a12.7.1741646346293; Mon, 10 Mar 2025
 15:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310192829.661692-1-jltobler@gmail.com>
In-Reply-To: <20250310192829.661692-1-jltobler@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 10 Mar 2025 18:38:54 -0400
X-Gm-Features: AQ5f1JpPA235YNiK4luDSrWMDtBrZLPV0gP_k68Up3TpBBkN_FEc6ZuH7hpdpmU
Message-ID: <CALnO6CBh_pYiU0p6pSndJ8rdDiykqBkRgosyrO1QhaQ55BKrkQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 3:32=E2=80=AFPM Justin Tobler <jltobler@gmail.com> =
wrote:
>
> When walking objects, git-rev-list(1) prints each object entry on a
> separate line in the form:
>
>         <oid> LF
>
> Some options, such as `--objects`, may print additional information
> about the object on the same line:
>
>         <oid> SP [<path>] LF
>
> In this mode, if the object path contains a newline it is truncated at
> the newline.
>
> When the `--missing=3D{print,print-info}` option is provided, information
> about any missing objects encountered during the object walk are also
> printed in the form:
>
>         ?<oid> [SP <token>=3D<value>]... LF
>
> where values containing LF or SP are printed in a token specific fashion
> so that the resulting encoded value does not contain either of these two
> problematic bytes. For example, missing object paths are quoted in the C
> style so they contain LF or SP.
>
> To make machine parsing easier, this series introduces a NUL-delimited
> output mode for git-rev-list(1) via a `-z` option following a suggestion
> from Junio in a previous thread[1]. In this mode, instead of LF, each
> object is delimited with two NUL bytes and any object metadata is
> separated with a single NUL byte. Examples:
>
>         <oid> NUL NUL
>         <oid> [NUL <path>] NUL NUL
>         ?<oid> [NUL <token>=3D<value>]... NUL NUL
>
> In this mode, path and value info are printed as-is without any special
> encoding or truncation.
>
> For now this series only adds support for use with the `--objects` and
> `--missing` options. Usage of `-z` with other options is rejected, so it
> can potentially be added in the future.
>
> One idea I had, but did not implement in this version, was to also use
> the `<token>=3D<value>` format for regular non-missing object info while
> in the NUL-delimited mode. I could see this being a bit more flexible
> instead of relying strictly on order. Interested if anyone has thoughts
> on this. :)

Without taking a deeper look, I think token=3Dvalue has the benefit of
being self-describing at the cost of more output bytes (which might
matter over the wire, for example). Generally I like the idea;
sometimes I find it troublesome having to parse prose manuals for the
specifics of output formats like field order, especially when I end up
coding a parser for the format. If the field order doesn=E2=80=99t matter t=
o
the consumer, then perhaps using ordered fields AWK-style is
inappropriately terse?

OTOH, the -z format is for machines, and they don=E2=80=99t need human labe=
ls
;) [I think token labels would be a great parser-writing and debugging
aid]

Best,
Ben

>
> This series is structured as follows:
>
>         - Patches 1 and 2 do some minor preparatory refactors.
>
>         - Patch 3 adds the `-z` option to git-rev-list(1) to print
>           objects in a NUL-delimited fashion. Printed object paths with
>           the `--objects` option are also handled.
>
>         - Patch 4 teaches the `--missing` option how to print info in a
>           NUL-delimited fashion.
>
> Thanks for taking a look,
> -Justin
>
> [1]: <xmqq5xlor0la.fsf@gitster.g>
>
> Justin Tobler (4):
>   rev-list: inline `show_object_with_name()` in `show_object()`
>   rev-list: refactor early option parsing
>   rev-list: support delimiting objects with NUL bytes
>   rev-list: support NUL-delimited --missing option
>
>  Documentation/rev-list-options.adoc | 26 +++++++++
>  builtin/rev-list.c                  | 86 ++++++++++++++++++++++-------
>  revision.c                          |  8 ---
>  revision.h                          |  2 -
>  t/t6000-rev-list-misc.sh            | 34 ++++++++++++
>  t/t6022-rev-list-missing.sh         | 30 ++++++++++
>  6 files changed, 155 insertions(+), 31 deletions(-)
>
>
> base-commit: 87a0bdbf0f72b7561f3cd50636eee33dcb7dbcc3
> --
> 2.49.0.rc2
>
>


--=20
D. Ben Knoble
