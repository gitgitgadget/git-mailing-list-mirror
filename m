Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2CD342CB5
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214106; cv=none; b=hRPTAzoriEEUVWklgAXF7EoIalAv48WCb+3lBZF6JuIFKOLcvsZArZyRFlt+sR/uBmyCuIVerB7rJSvavrnqRdIxITf3GZ07eMKIeMd8YwOl92ChDD3P2AWpiwMSd3QYnQvVPZ2z0i0pq8p6I96Rx4M/7nRRAhWwvB3J+CZ/8vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214106; c=relaxed/simple;
	bh=Wid1KHSelQW9ykod9788GzaLyCiYThuFP9fAvldrX5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IX/fvWxL1pZKoAtCbcQYw7dEfZDqBAflHBmAEAKFNHagFWxIBEdUi38VffbIlH9W18aQQRV1O7VctQoJ14jd3maUDucN1n/N3oKca1XyapJY+S9YJ5Om88uTgC9bhGTCppibvQ4EeM1Md6ruILevnp7eNaNANn7KSPkn9t2+M7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TINro5x0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TINro5x0"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afea7e61575so94473966b.2
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756214103; x=1756818903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtwPLK1wjsQQ4PB/v5Pd/aMbWzrr55MslrpfyUB2Hvw=;
        b=TINro5x0IPdlMYkVBq40UnKvbfIvpsqOkUU5EolAkFSzUrQglFqlJVN5zGF/hZqIeG
         dZh/omKZeXk4G/XzIw2jsnoIOEVTbYIUE63Oqgf8cpZN2B2dvl4m1yq17wtrl5ruyX+s
         C8I11MQQ3Wna8pC7bB/qQWOODJ7FpEGGDw8dg6O4Ei+rV8C9/Qp8dK7cRoky/XShQkPX
         hXHEnTB1gh2+XCwzHUXOegSiqgifNujzBCfW25j2aLxyy2/2QNvNcW1FGSu1ftVLIepI
         uLBDsv+xwMMUu+w+flNQRfwJUt3rqDgENOC3CE74ef4r1PCEdC7fYzZ0XEnBVlf+4QOc
         JPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756214103; x=1756818903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtwPLK1wjsQQ4PB/v5Pd/aMbWzrr55MslrpfyUB2Hvw=;
        b=HlfbcdCyVzgZPdMZuBsaSTPXX0b8mhoeVXMpIn9x6eyPsfuy+1jiV1n8aGu39uyS9y
         kx9JihNKspKlYXmQCSmJyMJ0J1AW/FLzI1fu7LIdoYXpMydGqtd69VcEL0Z9nQV4NdaO
         rDuqYWau1ukSMYGiSsuW/MeuriK7kI0fX5wNC+gPElSpzpU3JjAO5BrWJZoOTxcPWGyg
         U0I9g/16WZLdk2mYmFM3g8YKNbrq5S4KvqK8xujt0ncGhxe/xmVktWYrIfRbVM+Ziemx
         so8Jojmepx/lf2sak2vBYiY/Nfyq7n7DJ1gVEiKajez7ei72HQ1FTMZgDAPkwiOIgeol
         2UNw==
X-Gm-Message-State: AOJu0Yy1nJtm9rnhdCEZQOgrze+nbAvIHNX+ZfDoQFv71BxnMgXMG/hy
	Zo2L4MSUzrdo+7/HnGk/ilD+XCIlBL1ddih/tKzCZGUodPqWp+spb7U32B8PDuOXIrtty30O5pG
	EEHRZlDZ5C4oLg776kxPkcsEyTafQh3E=
X-Gm-Gg: ASbGnctwcmLhdUMYP6Rz1Wzq1dw4ynHk7392b6PVkaaaHovYLmQAxsjRNf6ifkmPXqi
	wwagKd5b1YE+jaJEGYmdU5NvPx4847+kiKBsRqInglOgdCL7fQ7KDLG+bnTjQnlzg7PLO9CbRVb
	SWKna1QzG0uddaloqFENUZ1tenOXUI2eTXbL435xBukuk61H6zJTgmDxbDgsJRayYBe3ekvLI2F
	9hP7Ll550eo2VJiY77eRTVcxTGtQq0Z2bkaBjy8lnp04mrhlqQGrxURUPcuiYY=
X-Google-Smtp-Source: AGHT+IFI2wpiKK9BtvWWUhJnIgdLJ9odDttvvHS0h7YvcMIfWHudDNVmOE5S0p6cEkHYZfiIlIS3xGUyLy3l95d021I=
X-Received: by 2002:a17:907:7f9f:b0:ade:79c5:21dc with SMTP id
 a640c23a62f3a-afe2901b543mr1536444366b.25.1756214103168; Tue, 26 Aug 2025
 06:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im> <20250824-b4-pks-history-builtin-v2-15-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-15-964ac12f65bd@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 26 Aug 2025 09:14:49 -0400
X-Gm-Features: Ac12FXyfu8FCbc-oicdTqBBhslpIIs6CTNwKqZvJBfvgw9XOthBrXK262tPhjcU
Message-ID: <CALnO6CBRv-Jvm1FsUAkDSyaNNRXtMukReKzefvCw5-vj=-pnCA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 15/16] builtin/history: implement "split" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 1:44=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> diff --git a/builtin/history.c b/builtin/history.c
> index 16b516856e..6d3f44152c 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -517,6 +527,285 @@ static int cmd_history_reorder(int argc,
>         return ret;
>  }
>
> +static void change_data_free(void *util, const char *str UNUSED)
> +{
> +       struct wt_status_change_data *d =3D util;
> +       free(d->rename_source);
> +       free(d);
> +}
> +
> +static int fill_commit_message(struct repository *repo,
> +                              const struct object_id *old_tree,
> +                              const struct object_id *new_tree,
> +                              const char *default_message,
> +                              const char *provided_message,
> +                              const char *action,
> +                              struct strbuf *out)
> +{
> +       if (!provided_message) {
> +               struct wt_status s;
> +               const char *path =3D git_path_commit_editmsg();
> +               const char *hint =3D
> +                       _("Please enter the commit message for the %s cha=
nges. Lines starting\n"
> +                         "with '%s' will be kept; you may remove them yo=
urself if you want to.\n");
> +
> +               strbuf_addstr(out, default_message);
> +               strbuf_addch(out, '\n');
> +               strbuf_commented_addf(out, comment_line_str, hint, action=
, comment_line_str);
> +               write_file_buf(path, out->buf, out->len);
> +
> +               wt_status_prepare(repo, &s);
> +               FREE_AND_NULL(s.branch);
> +               s.ahead_behind_flags =3D AHEAD_BEHIND_QUICK;
> +               s.commit_template =3D 1;
> +               s.colopts =3D 0;
> +               s.display_comment_prefix =3D 1;
> +               s.hints =3D 0;
> +               s.use_color =3D 0;
> +               s.whence =3D FROM_COMMIT;
> +               s.committable =3D 1;
> +
> +               s.fp =3D fopen(git_path_commit_editmsg(), "a");
> +               if (!s.fp)
> +                       return error_errno(_("could not open '%s'"), git_=
path_commit_editmsg());
> +
> +               wt_status_collect_changes_trees(&s, old_tree, new_tree);
> +               wt_status_print(&s);
> +               wt_status_collect_free_buffers(&s);
> +               string_list_clear_func(&s.change, change_data_free);

I think I'm supposed to see the changes between the old and new trees,
right? Does this only happen if I use the interactive machinery to
edit a hunk? When I try accepting some changes and leaving others for
the next commit I get no diff in the template.

I did try to add new diff lines to a hunk, and nothing showed up=E2=80=A6
maybe I'm holding it wrong? I'm pretty sure I compiled this version.

It doesn't look like it's triggered only on commit.verbose config, either.

> +
> +               strbuf_reset(out);
> +               if (launch_editor(path, out, NULL)) {
> +                       fprintf(stderr, _("Please supply the message usin=
g either -m or -F option.\n"));

According to the usage, git history split only supports -m, not -F ;)

> +                       return -1;
> +               }
> +               strbuf_stripspace(out, comment_line_str);
> +
> +       } else {
> +               strbuf_addstr(out, provided_message);
> +       }
> +
> +       cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, 0);
> +
> +       if (!out->len) {
> +               fprintf(stderr, _("Aborting commit due to empty commit me=
ssage.\n"));

It _would_ be nice if this and similar errors left me able to "try
again" without losing staged changes=E2=80=94I think I mentioned this befor=
e,
though. And with the in-memory indices vs. actual working state,
presenting a UI here could be very difficult. So it's an
understandable choice.

--=20
D. Ben Knoble
