Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AE6303A1A
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302240; cv=none; b=W03C1/RFONr8R7GaR5B/SHmx4FqVhdreiZazXGuhOjMMH0Gm6U7HVuMCFFMDt+/qxjjEwYF5CznEurxoKJN/zAqeJogqoGufchFySpdD2Z/fSLgc8J4fUXvUz9H05eFa39NoBavwBc5BUxkQbZDp1vz1XnkxYojdbgosB0yey38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302240; c=relaxed/simple;
	bh=3z6lZeggHa67z4XGw7XsFhr/P1FI4rI7kEJ0Ce8u0Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fe/rOe6Hsy0r7Ze23lDTBrAz0YftYs18PDSiir/LC7wKFcOVF3yxlJprnM5KoQtAt5KlMmKu6JIS9QplywcTcVsqH1/arSpHa4+K0SVNb9TADuDNrnNRA6s70gdBBOGGwPmogw76RWfe9UIpFX+QfQbUQCBiutNbA3uv48fVOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lX2bNgmG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX2bNgmG"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso3148565a12.1
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761302235; x=1761907035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVVWpyBqSk94i8rW8+d+qmD3/0B8UsgyViMSGVK/bj8=;
        b=lX2bNgmGrQoyjZ7+7D1Fn2haLTlCTzp9MV9BK0jJnsHhTi5QZexWQ0+VaZV+oYCj26
         RwaEgrJFjyGvU7rBo/4jqcsE86fiCEwvtsrG/YciOcO65fa1QCPFCWxlENKsLi1ECi7U
         wq0RfAYSnrj3Yjh/V7onhmAkT7w5iPfLVZfi8I0R1reOA0m3zkj5AH9zVJyO2LacWdZK
         clHweB6+7ziGO+w6VkUjzrIhKmS3I/JZfocHKJklb9gWt4eXbQQbWfIU4cvYtEYOP2Z7
         +W+rXdCNzRQ5HnERgweTkPWaXOa/tjTd1e5jbj1yOwM+TEyOg9dlEx//OxH0llQZFmO/
         gMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302235; x=1761907035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVVWpyBqSk94i8rW8+d+qmD3/0B8UsgyViMSGVK/bj8=;
        b=tl1jcWzzvE1f2V6XAMIsDeT3rp3G68+jkJMy0gGkQKpizMSQaL8E2Fo5M8WOSKC5uU
         jWK2gLGkBKHeXuJlJkQ8xiNjJefZWg62mNjnqtsvnQJHXmeu1YmJRCsFq4IWDF9EYfRd
         c9Vj7fUhlC8kMyIeFT6DD7C6LNf0Xgkh7exYp+liAp44HjamtPmnPtFxI3l1r3PT4Faf
         f1opIr4Xl69L8B5aFcyqORY94aHRVazc2WzQZ/umBvtZgmTNHMxZf5pm9y880Vz3+LjT
         J1b19hPcRlfgzzslzDHPf/uL1YiOyrDKFnRC0JdM5sUsJ6RdGP/JZHsF/wqrB3yJeFa6
         SGeQ==
X-Gm-Message-State: AOJu0YwJz1wYWJ+YbGHgr3M0+vByw5pLnlKQMuC4MLkRuOroGmA5yQEr
	6NX0mli94KkcVmpxGriSHfsJLaxc6jIXpJqWNVEVCx2rPDcOyziv18NYUAORHJel5NyJRtioNw9
	3hMNzL0flDXeNXeap3ZYeUu93yv9gprQ=
X-Gm-Gg: ASbGncsVLWvi2HIQEEjbL6KHNEcYBiD2KDBAxBupCTDqB9++OuflXrc6mRcQvOVUaOd
	1IjU15oeVcZqSsnxrOR4vv9Wmh9wWAUB8J8dNBV2B2oFF+sY2yUdhcZUzSGXiFT64SE/n5FkIuq
	2YH9wtDnSiecnhdjvX7a8fKcg0uQZ53sLmTxzDxO1Hu85oZlO0TEhWXlFo8ZABjs6go6iRR/5Nw
	fmEqWonKqsVEf10Nnm/rO9RfF+eyF8lo2OtqBqWBPvd+98qj2ypCbpFzicnpiksW2pXOW0=
X-Google-Smtp-Source: AGHT+IEJg+1ZJmqEqSYBn+lWCzzzewZNjP1luiU82kJ59ipRNKltxZt+CYjOzZKSjzfkrYQAoUfuyBFaNx5lcpKxkKU=
X-Received: by 2002:a05:6402:5244:b0:639:f648:1093 with SMTP id
 4fb4d7f45d1cf-63e5eafc214mr2063537a12.4.1761302235203; Fri, 24 Oct 2025
 03:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-1-siddharthasthana31@gmail.com> <20251022185045.29256-3-siddharthasthana31@gmail.com>
In-Reply-To: <20251022185045.29256-3-siddharthasthana31@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 24 Oct 2025 12:37:02 +0200
X-Gm-Features: AWmQ_bnzoblV_TA6Ae3tBUMY5xI0aPuD3Pze43sPLQH2ZXaSHDAVNfx5U3cuYfA
Message-ID: <CAP8UFD00rE7gF+baidmoi7nYwVKa3UDQgj+TB4wJLtjJF7u9gA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] replay: make atomic ref updates the default behavior
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, 
	newren@gmail.com, gitster@pobox.com, ps@pks.im, karthik.188@gmail.com, 
	code@khaugsbakk.name, rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com, 
	johncai86@gmail.com, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:51=E2=80=AFPM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:

[...]

> However, it should be noted that all three of these are somewhat
> special cases; users, whether on the client or server side, would
> almost certainly find it more ergonomical to simply have the updating

Nit: maybe: s/ergonomical/ergonomic/

> of refs be the default.

[...]

> Change the default behavior to update refs directly, and atomically (at
> least to the extent supported by the refs backend in use). This
> eliminates the process coordination overhead for the common case.
>
> For users needing the traditional pipeline workflow, add a new
> --ref-action=3D<mode> option that preserves the original behavior:
>
>   git replay --ref-action=3Dprint --onto main topic1..topic2 | git update=
-ref --stdin
>
> The mode can be:
>   * update (default): Update refs directly using an atomic transaction
>   * print: Output update-ref commands for pipeline use

Nit: maybe it should be mentioned that the command is still
experimental, so it's OK to change the default like this.

> +--ref-action[=3D<mode>]::
> +       Control how references are updated. The mode can be:
> ++
> +--
> +       * `update` (default): Update refs directly using an atomic transa=
ction.
> +         All refs are updated or none are (all-or-nothing behavior).
> +       * `print`: Output update-ref commands for pipeline use. This is t=
he
> +         traditional behavior where output can be piped to `git update-r=
ef --stdin`.
> +--
> ++
> +The default mode can be configured via `replay.refAction` configuration =
option.

Nit: s/via `replay.refAction` configuration option/via the
`replay.refAction` configuration variable/

(It seems that "configuration variable" is used around 6 times more
than "configuration option", so we may want to standardize this
wording.)

> @@ -54,8 +68,11 @@ include::rev-list-options.adoc[]
>  OUTPUT
>  ------
>
> -When there are no conflicts, the output of this command is usable as
> -input to `git update-ref --stdin`.  It is of the form:
> +By default (with `--ref-action=3Dupdate`), this command produces no outp=
ut on

Nit: s/By default (with `--ref-action=3Dupdate`)/By default, or with
`--ref-action=3Dupdate`,/

I think it's better to be very explicit here, especially as we mention
`--ref-action=3Dprint` below.

[...]

> -       const char * const replay_usage[] =3D {
> +       const char *const replay_usage[] =3D {

Nit: Not sure this change is worth it, but I understand that it might
help pass some automated/CI tests, so not a big issue.

[...]

> +       /* Default to update mode if not specified */
> +       if (!ref_action_str)
> +               ref_action_str =3D "update";
> +
> +       /* Parse ref action mode */
> +       if (!strcmp(ref_action_str, "update"))
> +               ref_action =3D REF_ACTION_UPDATE;

Nit: maybe:

       if (!ref_action_str || !strcmp(ref_action_str, "update"))
               ref_action =3D REF_ACTION_UPDATE;

> +       else if (!strcmp(ref_action_str, "print"))
> +               ref_action =3D REF_ACTION_PRINT;
> +       else
> +               die(_("unknown --ref-action mode '%s'"), ref_action_str);
> +

[...]

>  test_expect_success 'using replay on bare repo to rebase multiple diverg=
ent branches, including contained ones' '
> -       git -C bare replay --contained --onto main ^main topic2 topic3 to=
pic4 >result &&
> +       git -C bare replay --ref-action=3Dprint --contained --onto main ^=
main topic2 topic3 topic4 >result &&
>
>         test_line_count =3D 4 result &&
>         cut -f 3 -d " " result >new-branch-tips &&

Are there tests with the new default behavior added? It looks like all
the changes in the test script are about adding "--ref-action=3Dprint"
to an existing test.
