Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30571E882
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110355; cv=none; b=GXPNaYniD27S56BPYd+oUwQS+rCj8g4EbZ0TNhAw3boQQSVxZE+OCycRKfD8CJIZGm9ONz9q7XhHBmpVL74WdlHEN7W7KbpLmppJPDkY+dMHAQ5yP7+4xrnqN/6Kw0QdXtyNloOsU15Ya2riVQyahFUna0Lym9k76pYWyyAd3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110355; c=relaxed/simple;
	bh=W8ZfFUmInXETnMX/iD4itHmgO1sYkhywFfftkU1gtT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxQ96a3cmal89uHC2Ik3HjR9ndxcGs8otpy0gMaii/iyNkgXLbbc9NFMVsC37YEs43Zkta4cnNKnlH2sXLzU5pSjnQy3R6KWKo5ASbWQfaPJPuu28FxAPBrrRfkWllI1Z9hpPMtfr5MH92ta/ZBgUC1J6o7aTKIVrBXUEL034Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyJUO6Lw; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyJUO6Lw"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607a84acf6aso9719757b3.2
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 11:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708110352; x=1708715152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syz6L7cyMzNmcIsTx7wu6HEUR7nxMWeEYOFu6Hr53o8=;
        b=iyJUO6LwUsjl27NwU+QpsiKlw8vVzr8+CcMdRHYGDcCFHsHhcaMxzaTr5XxbGtk5u8
         Xm9ue6xUMdeEWZHPu/NAy48tamqwPuv4llpFmHeKD5sp8Z0HUIzczm97YmSQjhatld6p
         2F34gsF3ZoUeXboWM4OngkUNJuJ5hSicQOiEi5bQ4hPka4fcm3AGj6Ft2oV/dxwTd/y4
         uJmGJmSphKmtnGx+XIh6VDpPgE0e6vO3ehuRsoYZDgKsdKiQiMZxSSg1aAjqSLzVK28n
         htW0ByFhen7dvlHHvA2Si+8W6bkQrh5nBYiqlqosLt4yfi7bt4AQlLf9JwQnOlXztlhP
         243Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708110352; x=1708715152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syz6L7cyMzNmcIsTx7wu6HEUR7nxMWeEYOFu6Hr53o8=;
        b=ZDuCC0XNhCQUnHTrUXcHZhbQ9i/x8E1UqTYx+cNvbad7hvQfKdr5+uH88GitZj+dtg
         8Jzd55LysXoGUHYLlIwzZa7YvEUS5eaAMpTQxiqYSASNF5FsOwgAlKfaGrwoflsbG+ZJ
         hjh3u960dFrInBVDfd643qrFiJqtk2AOmMygyfVuGsu5GIBK/byM0r4ZwVV4hbfvXnHs
         qcEy/hfXDJEIREXbWiakti6FXlZy4npukO7joHfclwN8sJ2omzvIqpxoxg6WlTe5RbLZ
         IBK0+Sjpd6QZGm/QPnK5nXp/veVzh4WvwBLPI9awNSHDr4Pd3AJzHN1J73O3Nty9La1G
         D/kg==
X-Gm-Message-State: AOJu0YyeabQq/234JjDVlg0qS9088/Lw5ZuZJ1P53uTY7/Lii39Kd5Ba
	b5dtQcJ/toUPDrnWa8qbCCmDXG3ZP5PPv624g4zc+ug1VNM3p+CXDPMfdm1ntS28oFyQgnUT8Dc
	3PuIHQiwrClvZDJlFDAD0OcifkyQ=
X-Google-Smtp-Source: AGHT+IGYAFCCDIrCYjDxehdUtFezQ3CJL04byaAp4Tmx1bm4M5bevNAUJVdwf5qR7T0uc1yft4GYOG0fzSDe1yOb0JE=
X-Received: by 2002:a81:4804:0:b0:604:4073:2164 with SMTP id
 v4-20020a814804000000b0060440732164mr5526379ywa.41.1708110352454; Fri, 16 Feb
 2024 11:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216101647.28837-1-ash@kambanaria.org> <20240216101647.28837-2-ash@kambanaria.org>
In-Reply-To: <20240216101647.28837-2-ash@kambanaria.org>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Fri, 16 Feb 2024 12:05:16 -0700
Message-ID: <CAMMLpeS-Q7drd0rHnpMEkuomUGOr0iJi3FGFWihA=oFbdZ=Duw@mail.gmail.com>
Subject: Re: [Improvements on messages 1/5] rebase: trivial fix of error message
To: Alexander Shopov <ash@kambanaria.org>
Cc: git@vger.kernel.org, gitster@pobox.com, worldhello.net@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 3:16=E2=80=AFAM Alexander Shopov <ash@kambanaria.or=
g> wrote:
>
> Mark --rebase-merges as option rather than variable name
>
> Signed-off-by: Alexander Shopov <ash@kambanaria.org>
> ---
>  builtin/rebase.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 4084a6abb8..9c6d971515 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -746,7 +746,7 @@ static void parse_rebase_merges_value(struct rebase_o=
ptions *options, const char
>         else if (!strcmp("rebase-cousins", value))
>                 options->rebase_cousins =3D 1;
>         else
> -               die(_("Unknown rebase-merges mode: %s"), value);
> +               die(_("Unknown --rebase-merges mode: %s"), value);

Hi Alexander! The other patches in this series look good to me, but I
don't think this one is right. This error message could be about
either the --rebase-merges command line option or the
rebase.rebaseMerges config option. The word "rebase-merges" is
intentionally ambiguous enough to cover both situations and was not
intended to be left in English in translations.

-Alex
