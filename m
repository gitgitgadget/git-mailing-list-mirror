Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5245C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 08:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiGEIuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 04:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGEIuS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 04:50:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53E4644B
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 01:50:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y4so1016824edc.4
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 01:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KpwVvudCKfctCZtq2W6B567FNhFnacpX+RvpyeRMnv4=;
        b=ffWT2X9kzfKMjYOh/dT2L/O28XHxH7xZgrxGCP4VODA/QvEw2VXfnrJckQB3uiLmYE
         WlplWzSGoxXnhZNozem9KOfT2W4ZMb1eVlBpwT8f3wgoX92CFh2Cg8dUwLA09lcG/vw+
         uDhiB3454Kx3Waf3TyZchTF0DDmTpAR5s6/UzW5fgZySpONlbrAiebS0x7tOBJ4XltO8
         Wndn8j0i+lXDeQ+LsiuTdMHz3zahnDxfYItBhQP4AyCpad+1Q4JOUf1XXi39ivNgykQq
         /ldXurueW4B2PDzwD2YIYMoS83dGc17ySFU/IGwZkHkI1p1NdgTd5/ojFy9Eyietg+QD
         G86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KpwVvudCKfctCZtq2W6B567FNhFnacpX+RvpyeRMnv4=;
        b=kmX6SOEP61SBzQZPtYGBLUHX5v8u4b9ZGmYm5hlNX8e4KYkkZ9Y+/3agosNuer7yIS
         Y7r0qb7Ie2NNtGvs8EvR1RUaVJFDuOzTAXiJ0vERwfOXqzTABgLFZ70/K4kfQX5clRyd
         /aJaQjAFRAiqwc7IGEOK28oTOsxcsp1zTNhwLMDzogf0sP5+l6u05127Jj2jcgdtwHIk
         yw4Qxd7EU/FhsjVkHC7IHTCe5XvnNSC9ZghL0wUjJ/Fvh9QKvYg3pia7TC529vVyFzbm
         ZZKVtEWKa5P3HevuABzxEZG/bIiyExnd4/FwKINtV/gKo3S0Ak6Itot+JjYa96wYHeIl
         0t8Q==
X-Gm-Message-State: AJIora8mBrsPhrVJQrz6xmcG7Tvqnyv1Wd/Y8YdyBg07uExEmjqMGrtc
        57Xfh9O/a2Xw3PsM58NyoLyvSBRqsLY=
X-Google-Smtp-Source: AGRyM1vTbHL+Mw0WJkIZRyYYCqmqv47LYZghkaLgc3T1BGWTQtXuITHD0aFonPBD9SwCQG+YHs74vA==
X-Received: by 2002:a05:6402:380a:b0:437:d11f:b8b0 with SMTP id es10-20020a056402380a00b00437d11fb8b0mr44823300edb.425.1657011011895;
        Tue, 05 Jul 2022 01:50:11 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j12-20020a1709062a0c00b00722e1bca239sm15306549eje.204.2022.07.05.01.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 01:50:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o8eG1-003pCi-Nh;
        Tue, 05 Jul 2022 10:50:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v5] ls-files: introduce "--format" option
Date:   Tue, 05 Jul 2022 10:39:18 +0200
References: <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com>
 <pull.1262.v5.git.1657002760815.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1262.v5.git.1657002760815.gitgitgadget@gmail.com>
Message-ID: <220705.86sfng9c5a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 05 2022, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Add a new option --format that output index enties
> informations with custom format, taking inspiration
> from the option with the same name in the `git ls-tree`
> command.
>
> --format cannot used with -s, -o, -k, -t, --resolve-undo,
> --deduplicate and --eol.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     ls-files: introduce "--format" options
>=20=20=20=20=20
>     v4->v5:
>=20=20=20=20=20
>      1. Let --format incompatible with -t.
>      2. Fix %(eolinfo) and %(eolattr) docs suggested by Junio.
>=20=20=20=20=20
>     Looking forward to =C3=86var's reviewing.

Thanks again, I took a look at this and it looks good to me as-is.

If you do want to further twiddle with it at this point I applied these
changes to it locally while poking around, changes:

 * Some trivial whitespace between variable decl.

 * Removed a "return;" at the end of a function

 * I found the new write_*() helpers to be uneccesary, what I did spot
   after seeing if they could be factored out is the existing
   write_eolinfo() function.

   I see you just copied some of the code from there, but
   e.g. initializing to "" and doing an unconditional strbuf_addstr()
   looks odd IMO compared to just doing it inline as below.

   I think if helpers are to be introduced here I'd think it would make
   more sense to split out the small bits of behavior from
   write_eolinfo() so you can call it picemeal and share the code, but
   since it's calling trivial external functions I think just calling
   those directly probably makes more sense...

 * Likewise for the test I wondered if you were adding a bug by not
   reporting when lstat() failed, but then found that this is the same
   thing we do on --eol.

   So for the tests I think it's better just to demonstrate that we can
   emit the exact same thing that --eol does with --format.

 * We've gone back & forth a bit on whether this would combine with
   --debug, while it's an internal-only feature it would be nice to have a
   test for it combined with --format, noting that the behavior might
   change...

 * There is one subtle behavior change here in that I deleted the "ce
   &&" part from write_index_eolinfo_to_buf() when moving the code
   over. I'm 99% sure this is the right thing to do, as other code in
   expand_show_index() unconditionally dereferences it.

   So perhaps we don't need that guard in write_eolinfo() either? In any
   case copy/pasting it over when we're already assuming a non-NULL "ce"
   in the same "if/elseif/else" chain looks a bit odd.

   Ah, I see it's because in show_dir_entry() we explicitly pass it as
   NULL, but that doesn't apply to our new codepath, so as long as we're
   not sharing that helper with write_eolinfo() it makes sense to not do
   that check.

   Even then the helper should probably assume "ce", and write_eolinfo()
   itself should do the "is ce NULL?" check which is specific to its
   use-case.

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 79ecdce2c9c..cc3cece3830 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -77,30 +77,6 @@ static void write_eolinfo(struct index_state *istate,
 	}
 }
=20
-static void write_index_eolinfo_to_buf(struct strbuf *sb, struct index_sta=
te *istate,
-				       const struct cache_entry *ce)
-{
-	const char *i_txt =3D "";
-	if (ce && S_ISREG(ce->ce_mode))
-		i_txt =3D get_cached_convert_stats_ascii(istate, ce->name);
-	strbuf_addstr(sb, i_txt);
-}
-
-static void write_worktree_eolinfo_to_buf(struct strbuf *sb, const char *p=
ath)
-{
-	struct stat st;
-	const char *w_txt =3D "";
-	if (!lstat(path, &st) && S_ISREG(st.st_mode))
-		w_txt =3D get_wt_convert_stats_ascii(path);
-	strbuf_addstr(sb, w_txt);
-}
-
-static void write_eolattr_to_buf(struct strbuf *sb, struct index_state *is=
tate,
-				 const char *path)
-{
-	strbuf_addstr(sb, get_convert_attr_ascii(istate, path));
-}
-
 static void write_name(const char *name)
 {
 	/*
@@ -114,6 +90,7 @@ static void write_name(const char *name)
 static void write_name_to_buf(struct strbuf *sb, const char *name)
 {
 	const char *rel =3D relative_path(name, prefix_len ? prefix : NULL, sb);
+
 	if (line_terminator)
 		quote_c_style(rel, sb, NULL, 0);
 	else
@@ -270,6 +247,8 @@ static size_t expand_show_index(struct strbuf *sb, cons=
t char *start,
 	const char *end;
 	const char *p;
 	size_t len =3D strbuf_expand_literal_cb(sb, start, NULL);
+	struct stat st;
+
 	if (len)
 		return len;
 	if (*start !=3D '(')
@@ -288,12 +267,16 @@ static size_t expand_show_index(struct strbuf *sb, co=
nst char *start,
 		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
 	else if (skip_prefix(start, "(stage)", &p))
 		strbuf_addf(sb, "%d", ce_stage(data->ce));
-	else if (skip_prefix(start, "(eolinfo:index)", &p))
-		write_index_eolinfo_to_buf(sb, data->istate, data->ce);
-	else if (skip_prefix(start, "(eolinfo:worktree)", &p))
-		write_worktree_eolinfo_to_buf(sb, data->pathname);
+	else if (skip_prefix(start, "(eolinfo:index)", &p) &&
+		 S_ISREG(data->ce->ce_mode))
+		strbuf_addstr(sb, get_cached_convert_stats_ascii(data->istate,
+								 data->ce->name));
+	else if (skip_prefix(start, "(eolinfo:worktree)", &p) &&
+		 !lstat(data->pathname, &st) && S_ISREG(st.st_mode))
+		strbuf_addstr(sb, get_wt_convert_stats_ascii(data->pathname));
 	else if (skip_prefix(start, "(eolattr)", &p))
-		write_eolattr_to_buf(sb, data->istate, data->pathname);
+		strbuf_addstr(sb, get_convert_attr_ascii(data->istate,
+							 data->pathname));
 	else if (skip_prefix(start, "(path)", &p))
 		write_name_to_buf(sb, data->pathname);
 	else
@@ -310,13 +293,12 @@ static void show_ce_fmt(struct repository *repo, cons=
t struct cache_entry *ce,
 		.istate =3D repo->index,
 		.ce =3D ce,
 	};
-
 	struct strbuf sb =3D STRBUF_INIT;
+
 	strbuf_expand(&sb, format, expand_show_index, &data);
 	strbuf_addch(&sb, line_terminator);
 	fwrite(sb.buf, sb.len, 1, stdout);
 	strbuf_release(&sb);
-	return;
 }
=20
 static void show_ce(struct repository *repo, struct dir_struct *dir,
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
index 60c415aafd6..baf03f9096e 100755
--- a/t/t3013-ls-files-format.sh
+++ b/t/t3013-ls-files-format.sh
@@ -40,27 +40,13 @@ test_expect_success 'git ls-files --format objectname' '
 	test_cmp expect actual
 '
=20
-test_expect_success 'git ls-files --format eolinfo:index' '
-	cat >expect <<-\EOF &&
-	lf
-	lf
-	EOF
-	git ls-files --format=3D"%(eolinfo:index)" >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'git ls-files --format eolinfo:worktree' '
-	cat >expect <<-\EOF &&
-	lf
-	lf
-	EOF
-	git ls-files --format=3D"%(eolinfo:worktree)" >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'git ls-files --format eolattr' '
-	printf "\n\n" >expect &&
-	git ls-files --format=3D"%(eolattr)" >actual &&
+HT=3D'	'
+WS=3D'    '
+test_expect_success 'git ls-files --format v.s. --eol' '
+	git ls-files --eol >expect 2>err &&
+	test_must_be_empty err &&
+	git ls-files --format=3D"i/%(eolinfo:index)${WS}w/%(eolinfo:worktree)${WS=
}attr/${WS}${WS}${WS}${WS} ${HT}%(path)" >actual 2>err &&
+	test_must_be_empty err &&
 	test_cmp expect actual
 '
=20
