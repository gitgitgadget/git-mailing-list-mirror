Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7A287258
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763622275; cv=none; b=H+Mlr4KvMIGMRNJHBzqVLbQbyHCts8haRAWD/5o26ycRJEGTiySxAhg1mH49WCLKDK8DYDRZDYFyfWL8I8NwMVsPENrBEneHsKjOYGvq+AtnL0PMu+uLFZosfTYWwvHpWtqp6tVVQbMK/zz0JJ8idEyclKecE2EkuWBhRMXEmfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763622275; c=relaxed/simple;
	bh=vsg6zT7c9OafYlOdO/bqDwDHm6XzfDVsoPLyeKU/vhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOaNr4E7nbHyJkH4JLWYUDqI29UKaUBIdf76KhLlPJAIGKWbPnz9vS5pC3zRlEuCEh76vLN6DZY9uj76UCr3dX2fLHdyQrmIGrVDsuo6g3bu2rSr4J4ZcVoW4DwGKScr7kmgs1859S/CfE3yvQB3ECGs6R2N5PQ9NI0LbRpcJ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5zWvRfG; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5zWvRfG"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-94863b3620cso19925839f.3
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763622272; x=1764227072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbUMiSkQ60V7jM3FeSWbBbo36AWluXdIFFHQN2NgzCg=;
        b=V5zWvRfGy0rm+/1hbQwmQ+uj7QQCTyqgOA1x6V90LTwOhtziTiUQvZVI+hE4pXsPPt
         xC88cG4c69rDoyaEzRJ7CiJM6tDmYJw2hiuN/sINfUe9Sj9D2kdOwY7ihLesDXa9/w7+
         t12+nxhzv+ZfmqQYpUDp9hDmukFc1LsUV2HHaP7R9M9xNoLCeQWagaDSqlDdvDvxmIhu
         mAUZxMFYTl3qnJxg153GKJtVvShwvjcouaCTtlHFAJFez2QqvIEzJuQg91jfjzYeYtFw
         4zz2a2Q4Hea9v2ziAUtUaE1GHK8Iq/KdVDgaf1HMp4AGWN488HymWN6Bk39Z3BBOpPhu
         +W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763622272; x=1764227072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KbUMiSkQ60V7jM3FeSWbBbo36AWluXdIFFHQN2NgzCg=;
        b=UF/J5XSflmFBLbyRnPWYam+jRHjK5sOwhZ5OCEHOK0U3EC4chMVAUpU8inm5Raocxi
         ZFMSE5Uo/94mNXvb2QlMbU6ag2hcoM4io2hInGEW8qZtuLQL/EELbwHhz+QkRV70NQNR
         srdGyqvSqLBEVxLZy7IsoJubMF24hV3shkcudmkXaT8jY/6VZ//s4LTfNoOIOp70QyMa
         D8VXOwRRIIe9z4jHV7tBfPirkmMaBAmrK6cwQskQrgrfSFTLP/O2E17stmSGO/ZAHLLq
         gmJaK7iwxAPi9HZVkF3yiLAxt8rvli2x4FVCar7Yr3jK5YZ0d6nO5FE5SIN/xvXgtbhf
         xXlw==
X-Gm-Message-State: AOJu0YxZLeDKfNHqd2x1c3thA9VikKN0oJfMC9qfry2oHV8hgUw8RIGQ
	A5xg/Tu8jdHbJbwO9gUbnwNbvWhgFEJoM0sAAhiJ0TOnIF5VbY92K0SI5o0duW7DsUiNkDpCZ1E
	AGnIHkP0nmFhumlrMOxnkjMBkHrUX9Y0=
X-Gm-Gg: ASbGncsIAhLqQH0ntz3TJdsuLffJfsArzMCFWxaTfNaV4/EVKHlZT3QncS6FXV9KgXA
	Uw5YdQztGmBCSjXaJYhL+cp/XZnGvH4eZliUPaJAg4aQa1Kyl64T9LHOAPYMtLm65JHx+PMCo6m
	uWovpH0p2SiHLMjMFRLjvOUAjfj9b0TeJfV1wUhwTdZajCh5KM6M+XF1rtvQr7ngcovxv4TjjEp
	qGRJZ++/ZrnePJxB6lZOYhs067cnfbBrodA8b/u7zXB9ZA2KT+F3ff8MgdQ8cBOeGUwI1rIHzVM
	ynNdDo9R3rIyForz7/i4UNOlNPNG
X-Google-Smtp-Source: AGHT+IGemujZ3GxykaDYO+jbVVf7i1jwJOXLPIIM2PW2az9KusbPtXIq3iFsTNkzzok+EDRsddRSBPeX0Zq/scwC2ug=
X-Received: by 2002:a05:6638:c755:10b0:5b7:c784:53a5 with SMTP id
 8926c6da1cb9f-5b953d3f651mr1515516173.0.1763622272314; Wed, 19 Nov 2025
 23:04:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im> <20251027-b4-pks-history-builtin-v6-9-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-9-407dd3f57ad3@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Nov 2025 23:04:21 -0800
X-Gm-Features: AWmQ_blYgIf6rTmNiNGzib2_gKJrsZy3amGuCj77osmUz5rqFEjcQQhjtDSN-4w
Message-ID: <CABPp-BGRnx7+qvFcDeWCZEZm1aRn=kRezZ2KZA0E=8hji9Vjiw@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] add-patch: add support for in-memory index patching
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:34=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> +int run_add_p_index(struct repository *r,
> +                   struct index_state *index,
> +                   const char *index_file,
> +                   struct interactive_options *opts,
> +                   const char *revision,
> +                   const struct pathspec *ps)
> +{
> +       struct patch_mode mode =3D {
> +               .apply_args =3D { "--cached", NULL },
> +               .apply_check_args =3D { "--cached", NULL },
> +               .prompt_mode =3D {
> +                       N_("Stage mode change [y,n,q,a,d%s,?]? "),
> +                       N_("Stage deletion [y,n,q,a,d%s,?]? "),
> +                       N_("Stage addition [y,n,q,a,d%s,?]? "),
> +                       N_("Stage this hunk [y,n,q,a,d%s,?]? ")
> +               },
> +               .edit_hunk_hint =3D N_("If the patch applies cleanly, the=
 edited hunk "
> +                                    "will immediately be marked for stag=
ing."),
> +               .help_patch_text =3D
> +                       N_("y - stage this hunk\n"
> +                          "n - do not stage this hunk\n"
> +                          "q - quit; do not stage this hunk or any of th=
e remaining "
> +                               "ones\n"
> +                          "a - stage this hunk and all later hunks in th=
e file\n"
> +                          "d - do not stage this hunk or any of the late=
r hunks in "
> +                               "the file\n"),
> +               .index_only =3D 1,
> +       };
> +       struct add_p_state s =3D {
> +               .r =3D r,
> +               .index =3D index,
> +               .index_file =3D index_file,
> +               .answer =3D STRBUF_INIT,
> +               .buf =3D STRBUF_INIT,
> +               .plain =3D STRBUF_INIT,
> +               .colored =3D STRBUF_INIT,
> +               .mode =3D &mode,
> +               .revision =3D revision,
> +       };
> +       struct strbuf parent_revision =3D STRBUF_INIT;
> +       char parent_tree_oid[GIT_MAX_HEXSZ + 1];
> +       size_t binary_count =3D 0;
> +       struct commit *commit;
> +       int ret;
> +
> +       commit =3D lookup_commit_reference_by_name(revision);
> +       if (!commit) {
> +               err(&s, _("Revision does not refer to a commit"));
> +               ret =3D -1;
> +               goto out;
> +       }
> +
> +       if (commit->parents)
> +               oid_to_hex_r(parent_tree_oid, get_commit_tree_oid(commit-=
>parents->item));
> +       else
> +               oid_to_hex_r(parent_tree_oid, r->hash_algo->empty_tree);
> +
> +       strbuf_addf(&parent_revision, "%s~", revision);
> +       mode.diff_cmd[0] =3D "diff-tree";
> +       mode.diff_cmd[1] =3D "-r";
> +       mode.diff_cmd[2] =3D parent_tree_oid;
> +
> +       interactive_config_init(&s.cfg, r, opts);
> +
> +       if (parse_diff(&s, ps) < 0) {
> +               ret =3D -1;
> +               goto out;
> +       }
> +
> +       for (size_t i =3D 0; i < s.file_diff_nr; i++) {
> +               if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
> +                       binary_count++;
> +               else if (patch_update_file(&s, s.file_diff + i))
> +                       break;
> +       }
> +
> +       if (s.file_diff_nr =3D=3D 0) {
> +               err(&s, _("No changes."));
> +               ret =3D -1;
> +               goto out;
> +       }
> +
> +       if (binary_count =3D=3D s.file_diff_nr) {
> +               err(&s, _("Only binary files changed."));
> +               ret =3D -1;
> +               goto out;
> +       }
> +
> +       ret =3D 0;
> +
> +out:
> +       strbuf_release(&parent_revision);
> +       add_p_state_clear(&s);
> +       return ret;
> +}

I'm totally unfamiliar with add-patch.[ch] beyond what I've been
reviewing in this series, so this may be a dumb/naive question, but
why add a sibling run_add_p_index() to run_add_p() via
copy+paste+modify?  (Or is it not copy+paste+modify in some
interesting way?)  I'm worried the two will drift, and I'm curious
whether run_add_p() should just be calling run_add_p_index() and just
passing r->index for the index field.  Is there a reason that doesn't
work?
