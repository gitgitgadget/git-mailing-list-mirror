Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09DB17BA1
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873933; cv=none; b=EJUamwUS0k8CweZX6qpejhpPzsPgeNoKYqGfuCbaoGoj7RFWTqQzlk8eiBdDSFGyguWdSjZAaZ1BDkSL4uAzHLpwvTyE9uj/XqBDEu/ELoyuAjYpLCCKrzBnL0JICCd5MaLWUFh6pe6pbZkKAbdBmCCJ+fiKj6aOou4ezAJqFrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873933; c=relaxed/simple;
	bh=SbTvFJICom8LHzholLnCJY3WRqeGnJx4z4wXwFslTrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PH4XZuD5aavjXP/+z0gnDsBBT/DlYKaL2B3yKWgJ81Vac2sA0B1owpqHaAAKxJnxDW425YoQtOo7x//zIrRphCsDFASx4LibXj8ZGPAnbX65zbAGFpnB3DWOeOZ2rVBDbD482gLJAb7UNljK1k+4dPDTYuVnkOYBHfT4q2iv8OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b50aeb2424so16065356d6.0
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 15:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719873931; x=1720478731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iag3c/mZZkSbOPr2U8OnNRlb6dOUcJz4a/i5mjIasKI=;
        b=OSOztmIkQt74B8row34vdO+txCQDTCl37UIOgsljZ64QRhqIO89ThZl7WVgugf+Znr
         cszFQwdbRrLQByodWD3B1dZK/OlhxvnRztFNiSbTD38s+C3HVJg7a5nLCzrOlbo+orhC
         YJwFYM31NSKJj5yDkaPfJxVedw25sNdc3cjg5LLoVoj/UwbPzUu+OHluIezEd4FMhSK6
         bHh3VvIPxRJgECLWyB2L/2MN8bzKaDXQxQz+RxmzZCo0DatPhVKlWxZc21J2OmPtmDjT
         sgezyc4BiASM/AJNHc6CW9TFUEG7Yd78ESAXyCyOuMk7MX8wmRKczTRSUfawMy+Fdz68
         BrVA==
X-Gm-Message-State: AOJu0YxjuqypJilIF13cZ6vc9FFJWBZxz/DW67Wd/BsKjsUd14wZ3wW/
	0K9AXtdFeOXL9nJm5oilIDijymtto/najH1lrINWWtAvF6Tj9MOesPzp7XCccnmKtca2hAYH/21
	GBXs/LzfvCfO0pMDXxNLTxmDdRoofnA==
X-Google-Smtp-Source: AGHT+IHFGGV0wXOny5YmUq/ojdPHiyhLJCTRUXI1kqB8I/0EH75V/e0WHrAl3HK3AZr/EtCukYxOl5VJwiKuEYpT0UU=
X-Received: by 2002:ad4:5aae:0:b0:6b4:fc6f:17ba with SMTP id
 6a1803df08f44-6b5b70c725cmr81804496d6.33.1719873930743; Mon, 01 Jul 2024
 15:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net> <20240701220840.GA20631@coredump.intra.peff.net>
In-Reply-To: <20240701220840.GA20631@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 1 Jul 2024 18:45:19 -0400
Message-ID: <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 6:08=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> [...]
> This commit adds another option: feeding the snippet via the function's
> stdin. This doesn't conflict with anything the snippet would want to do,
> because we always redirect its stdin from /dev/null anyway (which we'll
> continue to do).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/README b/t/README
> @@ -906,6 +906,14 @@ see test-lib-functions.sh for the full list and thei=
r options.
> +   If <script> is `-` (a single dash), then the script to run is read
> +   from stdin. This lets you more easily use single quotes within the
> +   script by using a here-doc. For example:
> +
> +       test_expect_success 'output contains expected string' - <<\EOT
> +               grep "this string has 'quotes' in it" output
> +       EOT

We lose `chainlint` functionality for test bodies specified in this manner.

Restoring such functionality will require some (possibly)
not-so-subtle changes. There are at least a couple issues which need
to be addressed:

(1) chainlint.pl:ScriptParser::parse_cmd() only currently recognizes
`test_expect_* [prereq] 'title' 'body'` but will now also need to
recognize `test_expect_success [prereq] 'title' - <body-as-here-doc>`.

(2) Until now, chainlint.pl has never had to concern itself with the
body of a here-doc; it just throws them away. With this new calling
convention, here-doc bodies become relevant and must be returned by
the lexer. This may involve some not-so-minor surgery.
