Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAEE1A5B84
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821826; cv=none; b=RIBEeF+zrfi55aHea3eVlyOybmcGy9HZw+DWcm8r3+6MWRZKANYRKgWHbGntDzqZUsr4HIdmHNCDwbtagfhcswYJ2GluOm0glR1Sw856ENSG+aOuL+Woyxohzh4fw7IipnEjNtDHNmJSshyVU/p7jr97jtLU5QWlR3XIPapvEGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821826; c=relaxed/simple;
	bh=tIvpj5rO7gQuHjshw05n3a8mrpVC9esiYVwcVpa4TW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5EmjODVYnmCApEnNostHja0kK9Q1lP+kFD96SV8W6qiMHVeBn8LcfCO87V9ay1KijfeyLIiU8aL9vquJUb/eGx4kieYZXIjQf1/APGCMZ9yTh1tcFDozqbbIANvG1fwPTaxRrBm9Jp/yIk/jE7RtlrLXa70gth3frSrkhfzanA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G71JsGlz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G71JsGlz"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4767b3f8899so54004821cf.0
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 06:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742821823; x=1743426623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw1mrEgmA89y2WL+VXF6enAh1pu9yzCqgaEdUEIOS8s=;
        b=G71JsGlzkznUEYKQVcckZxJUuIKrAEXbhrFF4XO0pcqLJEda546hgn87iFEMhORBd/
         lFl6kLbICb1pbkHSMVCD2HM5C9L/8tNNNPl30L8T8qqfe+hWHX9Y4RbTnrsNZdDnlZep
         YMgojph/L8roxThp//NX4y+FOur25G1v3irC6DUsWll5COxZs98Wwn//oPJMszPyLMb5
         Enoal9nS0YpCixOyfU7703AgcD5DbD9TuayIBnPzrxMq0+0y+O7FNlSHFsKjsbijehSQ
         I2QDtU8Q3D6iaBmJGGDXrFb3AhFmUYAFcl+HGKokj6Zgp7UG7Bqhjnxi2fapuyepQ+3Y
         xLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742821823; x=1743426623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dw1mrEgmA89y2WL+VXF6enAh1pu9yzCqgaEdUEIOS8s=;
        b=OBwRzqNpzJyGGOSXD1pkm4jHyfpExrWwU2OG04Ak36NiLdXpAJuHaPAbs7iH7Po3Sl
         bQdEZw7h36osbMr1sq+12UHPGJv+j0+QDDweLE6J0U2F+9v5avweuTtasVDagVqmMcMg
         BesFh01IskOoyDtTBT/RdiBf7suRuc4+4YY5Q9/BVVQhHh/yQYgVoX+Y2qmSYulZnOIL
         LjKARca5gWXPxXdCqDX88VGEMTG5teemsD2l43KbyLEMYCrDFzz+ZcUp2loIO2SeqhkX
         +DuFDa198ohxks8QzpJfyCwiGA0HamC8/K35IFQe/NL2vZlmFvyH05PDF/ub/hR3pxCo
         wQlw==
X-Gm-Message-State: AOJu0Yxumnozcd5OmnVsNyVQ3cZAIrveo8E0kmpZoffM5Y44JKogg4Nf
	iPgzUFFfweJ3OXwzgRVheaJfJ2R2LQqO0jXGcLSTX+2/fWnO0tLSK8vC/qdO5XstYssnXTYrlH6
	MStjlI+2427TKYgCHm7UVqiRKMY4=
X-Gm-Gg: ASbGnctLPYEgkcE4vt3qucH7ybHsMVVFScdOWLg64eHTtPyDGa33stRNgMRItKrRHhG
	vOT5FovmDoCEoXSF32Opny5bDnmoSTIqNSXg86qNp6dlSVPMXVnu2VndWLT4g81jeNUc1W02FSD
	lTgkd+uaOo/zDZ9lPplAjk6XEea0G+V2qhU+7OACuYpNG/ajEDIXyzR+7ID/c=
X-Google-Smtp-Source: AGHT+IF14ifwspax3jZAu19ukSpD1CL0Qn3rpEOyIZfmmqh+5R7obXP8KQQX70sCVPeXspKNgXAJSqtOvdfcF4g25C8=
X-Received: by 2002:a05:622a:244c:b0:462:b7c9:10e with SMTP id
 d75a77b69052e-47710c41352mr278761281cf.13.1742821823272; Mon, 24 Mar 2025
 06:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqa59evffd.fsf@gitster.g> <20250321143022.5406-1-jayatheerthkulkarni2005@gmail.com>
 <20250321143022.5406-3-jayatheerthkulkarni2005@gmail.com> <xmqqiknzqu2h.fsf@gitster.g>
 <CA+rGoLfALoTvQuAzQPx7rqd-Zy+wMiyEbF5Y8_-2Yi-yE-2qpA@mail.gmail.com> <xmqq34f3qbna.fsf@gitster.g>
In-Reply-To: <xmqq34f3qbna.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 24 Mar 2025 18:40:12 +0530
X-Gm-Features: AQ5f1Jr5lgFt0H8MBdoAtPAQUaz1hsaR7_gtx8w_UwzpIGAamqRwp15LUS7u0hQ
Message-ID: <CA+rGoLf7R5BmpN1E+AXYhEKz=Th2TcpfDr0NxNma54GR_X_K-Q@mail.gmail.com>
Subject: Re: [[GSOC][PATCH v3] 3/3] docs: replace git_config with repo_config
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 10:16=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
>
> >> > +#include "builtin.h"
> >> > +#include "gettext.h"
> >> > +#include "config.h"
> >> > +#include "repository.h"  // Required for repo_config_get_string_tmp=
()
> >>
> >> I do not think we updated Coding Guidelines to allow // comments.
> >>
> > Since this was a tutorial I thought this was helpful, anyways I will
> > remove the comments, because I get that this would be bad practice for
> > newbies.
>
> I meant that I think our guidelines frowns upon
>
>         #include "foo.h" // for bar()
>
> I didn't mean a comment is necessarily bad.  IOW,
>
>         #include "foo.h" /* for bar() */
>
> may be OK.
>
> But real programs will evolve and API elements that are used from a
> header file will change over time, so it may not be a good idea to
> single out a function like that in the comment.  It would be much
> better to explain _why_ each change is made in the text that
> precedes the sample code.  E.g.
>
>     Add `#include "config.h"` because you want to use X and Y,
>     and `#include "repository.h"` because you want to use Z.
>
>     Then, add the following bits to the function body:
>
>      ----
>     #include "builtin.h"
>     #include "gettext.h"
>     #include "config.h"
>     #include "repository.h"
>     ...
>     int cmd_psuh(int argc, const char **argv, const char *prefix, struct =
repository *repo)
>     {
>         const char *cfg_name;
>
>         printf(Q_("Your args (there is %d):\n",
>
>
>

In the latest patch version I've removed the comments, since we
already added a line above saying the user has to include
`repository.h` I don't think we need to go in depth into that, do let
me know if that is not the case, looking forward to any more feedback.
