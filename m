Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442C22612
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710744183; cv=none; b=GxvlPOGiStpBThL8TZuaBCvhSrUwczPsbZhiFXTK7BPdIX4y+Zpx7Vz6NEVO8GJ6YzFoLbCTAFeSEGN2J5dXbKSa5cVMBvsEpCPjGeTmYx1EHa7oLTxXB4BPBR8iwCjQcjhdJUQrYcNqesi3rZo3nXerNxvqkxOCGSvtK81z6/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710744183; c=relaxed/simple;
	bh=VbUxOE6Yx///I+RJIPfho92SO4JZB6C2psO3iITKPa4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TVNFYHmS0El/SSd1QZSVhXUgh9TnlRY0kvY7oq2R0t6r4VcxcglJsgtbzTC3OBvoi7pr8Ul03NfELoLLZM1EAuePWGEkSrBjRZswhh7NRLXX9UBhGhTmEHJgJiItYlWw9uSrlYPi4+y66TTSGC1sgVSkontCOFNxKDys1sSfzIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2+El2lp3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2+El2lp3"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a08eb0956so64261107b3.3
        for <git@vger.kernel.org>; Sun, 17 Mar 2024 23:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710744181; x=1711348981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YbZJpE6jpo0ZZs1nxb1sqgdNV/V7N+l6Rs/iOe+NhmU=;
        b=2+El2lp3+TNiQCX+27bJ5MPdGhd0vpqXXsdykavJURpXQmIGDcFWXmqqPf9hE+3zYl
         xxsLsUT1Z7F1p431yUDhk+PE6LDuL66G/xMqM/gbgfkbvFPXSVkE9/7izQ15Q15O3fnS
         /biA/MrsHpt7NiYTQEoSRxYwPMpRdh3BXHptm2XIkzk+PaQel/kiHQ6jwo3+8q81cy1i
         BQefeya1Fqx+iURdkJPnvnBFdH9fuRX7AxlljdfAl1TYaTG9ptlwQmM80crLeeetpG/B
         YEpZsBX/SpXax7eP7C1sq0iB+dlUO7UhEsB4mw0c2i0YiLaBIDQMeR9WGLRSwXUb3Gsf
         oFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710744181; x=1711348981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbZJpE6jpo0ZZs1nxb1sqgdNV/V7N+l6Rs/iOe+NhmU=;
        b=h3lrzynrurXUjXqRoUBhgct6V71SApuFddUFDatGWyHMtUkNwAfmZtFWKsd9Q+Ns/V
         tcmDM4MUQodj2kIw26f19CCEjMFwLJiovHBZYWDzQ1quGsYWOWdNmbzdSeqS81MC5uoI
         K9drq9cHCViwojOLAtbaDBJqw0PrgHBSXz3anZ3BUe6nLgtkmgPp7aiK2PnbBCzvq6Yv
         cLgenntvmNHO8g6wBvJBHm9CsEC5+sOZOtW96WWth4HRXg/SO1nnTbgH6aIb1r6qW64W
         69f/InSW4UN82FmnZq1dYz0nRizqpp/5T9oQvQajaC3bzEHl29UE+LOMBwhtnx7Fg+Zv
         lAOw==
X-Forwarded-Encrypted: i=1; AJvYcCVVTVgojOzmsGeYjmlX5BBcKMhhSwzIitmPNjPe28qTcCmZ8KLz+NGB+QmO1ESfkNgVmDZEHNaYAeigjIXc7vcIRhZq
X-Gm-Message-State: AOJu0YzxbUSNmyVsDh6CfiztumWA596i4scm9j/X/o0bzm5RWw2Aqnwv
	HcH4XdeK5oq+9nj/G2auSfLS1a0WOTm9wwqCANRZ1Wi3180Z/cgrDcg0Ldc91J1k1EPK8R9bJJA
	xLg==
X-Google-Smtp-Source: AGHT+IHMXPyCvizg87U7E4IQ7DuED2Wbu4nmyBjiEmNe818hy4BipvDzKiRNEbNWrCEduBY2CdwovWzC6Fc=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a0d:d64e:0:b0:609:f0f0:20c4 with SMTP id
 y75-20020a0dd64e000000b00609f0f020c4mr2139007ywd.4.1710744180891; Sun, 17 Mar
 2024 23:43:00 -0700 (PDT)
Date: Sun, 17 Mar 2024 23:42:59 -0700
In-Reply-To: <20240318053848.185201-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240316035612.752910-1-brianmlyles@gmail.com> <20240318053848.185201-2-brianmlyles@gmail.com>
Message-ID: <owlyr0g82g7g.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 2/2] docs: adjust trailer `separator` and
 `key_value_separator` language
From: Linus Arver <linusa@google.com>
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Brian Lyles <brianmlyles@gmail.com> writes:

This v2 LGTM. Thanks!

> The language describing the trailer separator and key-value separator
> default value is overly complicated.
>
> Indicate the default with simpler "Defaults to ..." language.
>
> Suggested-by: Linus Arver <linusa@google.com>
> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> ---
> This commit is new in v2 per Linus' suggestion[1].
>
> [1]: https://lore.kernel.org/git/owly1q8a4qhh.fsf@fine.c.googlers.com/
>
>  Documentation/pretty-formats.txt | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index e1788cb07a..8ee940b6a4 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -316,9 +316,8 @@ multiple times, the last occurrence wins.
>     `Reviewed-by`.
>  ** 'only[=<bool>]': select whether non-trailer lines from the trailer
>     block should be included.
> -** 'separator=<sep>': specify a separator inserted between trailer
> -   lines. When this option is not given each trailer line is
> -   terminated with a line feed character. The string <sep> may contain
> +** 'separator=<sep>': specify the separator inserted between trailer
> +   lines. Defaults to a line feed character. The string <sep> may contain
>     the literal formatting codes described above. To use comma as
>     separator one must use `%x2C` as it would otherwise be parsed as
>     next option. E.g., `%(trailers:key=Ticket,separator=%x2C )`
> @@ -329,10 +328,9 @@ multiple times, the last occurrence wins.
>     `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
>  ** 'keyonly[=<bool>]': only show the key part of the trailer.
>  ** 'valueonly[=<bool>]': only show the value part of the trailer.
> -** 'key_value_separator=<sep>': specify a separator inserted between
> -   the key and value of each trailer. When this option is not given each trailer
> -   key-value pair is separated by ": ". Otherwise it shares the same semantics
> -   as 'separator=<sep>' above.
> +** 'key_value_separator=<sep>': specify the separator inserted between
> +   the key and value of each trailer. Defaults to ": ". Otherwise it
> +   shares the same semantics as 'separator=<sep>' above.
>
>  NOTE: Some placeholders may depend on other options given to the
>  revision traversal engine. For example, the `%g*` reflog options will
> -- 
> 2.43.2
