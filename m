Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01222C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 09:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbiLNJ4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 04:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238031AbiLNJ4G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 04:56:06 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A23625B
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 01:56:03 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id e13so21741385edj.7
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 01:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ehuLY2ZyfocHgKoET9e1yJJ1IVp5Otdo0Ti8jS8ZZ3g=;
        b=XrLuxzUU164mNZiwVZTJZmqvCl5hODj9+J1vfPRCw2N3LFaN1p77Ru8qSxaXkCIfHz
         4PsvJlg8vk8gXigwpRKPm6SqGAEF/XjOACtR8CHFQDdMxSN656wYpA+i3XF2OXUaL0gm
         0WxtBeLV+amkyCOJQpdee10pdOPqdXAhMJpkVNj0FtnUbGW6ODlIxIL0KV1Eg/n+eDSN
         wLYx9GF3pSX/sRoBxS37DolVjTTrtWI+hNl73W/2KfdATYupK0IogrsDBwzBmi5gxlEm
         VX5lOKTaYje2ggO4+DIppQgDtwm6ELP9yVRbS1UUt+E1SP2+9oT6PLsZaV+qg4ybTDUw
         /BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehuLY2ZyfocHgKoET9e1yJJ1IVp5Otdo0Ti8jS8ZZ3g=;
        b=aNQEyCM3NSxYzGaNYCy9v5TgPnNZyZ9+41+ebnpjGJp6LK0Arsn8q2l20KhjVxPyhI
         dfdD/fbULL6MjyIUIQtLyYC2taYFc7WAtoVRsnOqwF/y0urr30xsjS5mEGSbRTTN+Ggo
         zIVMccPpyRQy52qyxAFqJYtFHf4XMl/C5UnRRvSCn1hDYPbvdx/FCCKCKuYdtNFGcc5I
         Vj7R8FY1pQhVdJmwYckh+hkhQg7MqU4uEPBSmG9rX+TAEDVV7XTaApFTOGL7c0OZFe8k
         U3AVd2PbXnYjUpbgIbzyd4EjCbK5GrJnASwD0hgfoqvE2fnTjoffBqR3LU/N933mTMxu
         xQOA==
X-Gm-Message-State: ANoB5pmtIBdCLx9puIGIMbrrBygrnZZIxYb6nhLJu/qN6aK4wujKljfs
        upPAu4oV8kzlnlzPCheQRhisqlFeTKA=
X-Google-Smtp-Source: AA0mqf5tcF9Eis85uG921YZqx96zzoSuoSEleHO+82GgCnUcB36ceIV0cI2UyMWif2PHwRieu6qn3Q==
X-Received: by 2002:aa7:dc13:0:b0:467:559e:530c with SMTP id b19-20020aa7dc13000000b00467559e530cmr19924251edu.18.1671011761915;
        Wed, 14 Dec 2022 01:56:01 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id z16-20020a1709063ad000b007c0be4861e8sm5568600ejd.23.2022.12.14.01.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 01:56:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p5OUa-005XRJ-2m;
        Wed, 14 Dec 2022 10:56:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: don't pass strvec to apply_parse_options()
Date:   Wed, 14 Dec 2022 09:44:12 +0100
References: <baf93e4a-7f05-857c-e551-09675496c03c@web.de>
 <221213.86mt7r4ru2.gmgdl@evledraar.gmail.com>
 <2d0d77a4-f6ac-1fa7-bddb-9083579d8dd7@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <2d0d77a4-f6ac-1fa7-bddb-9083579d8dd7@web.de>
Message-ID: <221214.86ilie48cv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 13 2022, Ren=C3=A9 Scharfe wrote:

> Am 13.12.22 um 09:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Tue, Dec 13 2022, Ren=C3=A9 Scharfe wrote:
>>
>>> apply_parse_options() passes the array of argument strings to
>>> parse_options(), which removes recognized options.  The removed strings
>>> are not freed, though.
>>>
>>> Make a copy of the strvec to pass to the function to retain the pointers
>>> of its strings, so we release them all at the end.
>>>
>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>> ---
>>>  builtin/am.c | 12 +++++++++++-
>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/builtin/am.c b/builtin/am.c
>>> index 30c9b3a9cd..dddf1b9af0 100644
>>> --- a/builtin/am.c
>>> +++ b/builtin/am.c
>>> @@ -1476,6 +1476,7 @@ static int run_apply(const struct am_state *state=
, const char *index_file)
>>>  	int res, opts_left;
>>>  	int force_apply =3D 0;
>>>  	int options =3D 0;
>>> +	const char **apply_argv;
>>>
>>>  	if (init_apply_state(&apply_state, the_repository, NULL))
>>>  		BUG("init_apply_state() failed");
>>> @@ -1483,7 +1484,15 @@ static int run_apply(const struct am_state *stat=
e, const char *index_file)
>>>  	strvec_push(&apply_opts, "apply");
>>>  	strvec_pushv(&apply_opts, state->git_apply_opts.v);
>>>
>>> -	opts_left =3D apply_parse_options(apply_opts.nr, apply_opts.v,
>>> +	/*
>>> +	 * Build a copy that apply_parse_options() can rearrange.
>>> +	 * apply_opts.v keeps referencing the allocated strings for
>>> +	 * strvec_clear() to release.
>>> +	 */
>>> +	ALLOC_ARRAY(apply_argv, apply_opts.nr);
>>> +	COPY_ARRAY(apply_argv, apply_opts.v, apply_opts.nr);
>>> +
>>> +	opts_left =3D apply_parse_options(apply_opts.nr, apply_argv,
>>>  					&apply_state, &force_apply, &options,
>>>  					NULL);
>>>
>>> @@ -1513,6 +1522,7 @@ static int run_apply(const struct am_state *state=
, const char *index_file)
>>>  	strvec_clear(&apply_paths);
>>>  	strvec_clear(&apply_opts);
>>>  	clear_apply_state(&apply_state);
>>> +	free(apply_argv);
>>>
>>>  	if (res)
>>>  		return res;
>>
>> I don't mind this going in, but it really feels like a bit of a dirty
>> hack.
>>
>> We have widespread leaks all over the place due to this
>> idiom. I.e. parse_options() and a couple of other APIs expect that they
>> can munge the "argv", which is fine if it arrives via main(), but not if
>> we're editing our own strvecs.
>
> Where?  A quick "git grep 'parse_options.*nr'" turns up only this place
> as one that passes a strvec to parse_options.

Sorry about the vagueness, this was from memory and I didn't have a full
list handy.

First, that grep isn't going to give you what you want, since it only
catches cases where we're passing the "strvec" to the "parse_options()"
directly.

But if you look at e.g. how cmd_stash() invokes push_stash() or
cmd_describe() invoking cmd_name_rev() you'll see callers where we're
potentially losing the strvec due to parse_options().

"Potentially" because in both those cases we call that API, but in the
latter case we've got a missing strvec_clear(), so maybe that's all
that's needed (it doesn't always munge the argv).

>> I think less of a hack is to teach the eventual parse_options() that
>> when it munges it it should free() it. I did that for the revisions API
>> in f92dbdbc6a8 (revisions API: don't leak memory on argv elements that
>> need free()-ing, 2022-08-02).
>>
>> What do you think?
>
> Generating string lists and then parsing them is weird.  When calls have
> to cross a process boundary then we have no choice, but in-process we
> shouldn't have to lower our request to an intermediate text format.  git
> am does it anyway because it writes its options to a file and reads them
> back when it resumes with --continue, IIUC.

I agree, but making all those use a nicer API would be a much bigger
change.

> I hope that is and will be the only place that uses parse_options() with
> a strvec -- and then we don't have to change that function.
>
> If this pattern is used more widely then we could package the copying
> done by this patch somehow, e.g. by adding a strvec_parse_options()
> that wraps the real thing.

The reason I'm encouraging you to look at some of the other strvec leaks
is to see if you can think of a pattern that fits these various leaky
callers.

So e.g. a strvec_parse_options() won't work for the ones noted above
where we've lost track of it being a "struct strvec" in the first place.

I have a local version somewhere where I did (pseudocode):

	struct strvec vec =3D STRVEC_INIT;
	struct string_list to_free =3D STRING_LIST_INIT_DUP;

        // populate vec...
        for (size_t i =3D 0; i < vec.nr; i++)
		string_list_append_nodup(&to_free, v[i]):
	// call parse_options(), or otherwise munge "vec"...
	free(strvec_detach(&vec));
        string_list_clear(&to_free, 0);

I.e. you snapshot the members of the "vec" before it's munged, and
free() those via a "struct string_list".

Then you don't strvec_clear(), but instead free() the container, its
members being free'd by the string_list.

Here's a (not yet in-tree) patch that uses that:
https://lore.kernel.org/git/patch-10.10-81f138e460c-20221017T115544Z-avarab=
@gmail.com/

I think that's more reliable & general than the pattern you're adding
here.

In your version the only reason we're not segfaulting is because the
parse_options() consumes all the arguments, but that's not something you
can generally rely on with parse_options().

Also, and maybe I'm missing something, but wouldn't this be functionally
the same as your implementation:
=09
	diff --git a/builtin/am.c b/builtin/am.c
	index 30c9b3a9cd7..e65262cbb21 100644
	--- a/builtin/am.c
	+++ b/builtin/am.c
	@@ -1476,11 +1476,13 @@ static int run_apply(const struct am_state *state,=
 const char *index_file)
	 	int res, opts_left;
	 	int force_apply =3D 0;
	 	int options =3D 0;
	+	char *to_free;
=09=20
	 	if (init_apply_state(&apply_state, the_repository, NULL))
	 		BUG("init_apply_state() failed");
=09=20
	 	strvec_push(&apply_opts, "apply");
	+	to_free =3D (char *)apply_opts.v[0];
	 	strvec_pushv(&apply_opts, state->git_apply_opts.v);
=09=20
	 	opts_left =3D apply_parse_options(apply_opts.nr, apply_opts.v,
	@@ -1489,6 +1491,7 @@ static int run_apply(const struct am_state *state, c=
onst char *index_file)
=09=20
	 	if (opts_left !=3D 0)
	 		die("unknown option passed through to git apply");
	+	free(to_free);
=09=20
	 	if (index_file) {
	 		apply_state.index_file =3D index_file;

I.e. we leak the strvec_push() of the "apply" literal, but for the rest
we append the "state->git_apply_opts.v", which we already free()
elsewhere.

So actually, aren't we really just fumbling our way towards the "nodup"
interface that the "struct string_list" has, and we should add the same
to the "struct strvec".

This seems to also fix all the leaks you fixed, but without any of the
copying:

	diff --git a/builtin/am.c b/builtin/am.c
	index 30c9b3a9cd7..691ec1d152d 100644
	--- a/builtin/am.c
	+++ b/builtin/am.c
	@@ -1471,7 +1471,7 @@ static int parse_mail_rebase(struct am_state *state,=
 const char *mail)
	 static int run_apply(const struct am_state *state, const char *index_file)
	 {
	 	struct strvec apply_paths =3D STRVEC_INIT;
	-	struct strvec apply_opts =3D STRVEC_INIT;
	+	struct strvec apply_opts =3D STRVEC_INIT_NODUP;
	 	struct apply_state apply_state;
	 	int res, opts_left;
	 	int force_apply =3D 0;
	diff --git a/strvec.c b/strvec.c
	index 61a76ce6cb9..efdc47a5854 100644
	--- a/strvec.c
	+++ b/strvec.c
	@@ -22,7 +22,9 @@ static void strvec_push_nodup(struct strvec *array, cons=
t char *value)
=09=20
	 const char *strvec_push(struct strvec *array, const char *value)
	 {
	-	strvec_push_nodup(array, xstrdup(value));
	+	const char *to_push =3D array->nodup_strings ? value : xstrdup(value);
	+
	+	strvec_push_nodup(array, to_push);
	 	return array->v[array->nr - 1];
	 }
=09=20
	@@ -31,6 +33,9 @@ const char *strvec_pushf(struct strvec *array, const cha=
r *fmt, ...)
	 	va_list ap;
	 	struct strbuf v =3D STRBUF_INIT;
=09=20
	+	if (array->nodup_strings)
	+		BUG("cannot strvec_pushf() on a 'nodup' strvec");
	+
	 	va_start(ap, fmt);
	 	strbuf_vaddf(&v, fmt, ap);
	 	va_end(ap);
	@@ -67,6 +72,9 @@ void strvec_pop(struct strvec *array)
=09=20
	 void strvec_split(struct strvec *array, const char *to_split)
	 {
	+	if (array->nodup_strings)
	+		BUG("cannot strvec_split() on a 'nodup' strvec");
	+
	 	while (isspace(*to_split))
	 		to_split++;
	 	for (;;) {
	@@ -90,7 +98,7 @@ void strvec_clear(struct strvec *array)
	 	if (array->v !=3D empty_strvec) {
	 		int i;
	 		for (i =3D 0; i < array->nr; i++)
	-			free((char *)array->v[i]);
	+			free(array->nodup_strings ? NULL : (char *)array->v[i]);
	 		free(array->v);
	 	}
	 	strvec_init(array);
	diff --git a/strvec.h b/strvec.h
	index 9f55c8766ba..ac6e2c04cea 100644
	--- a/strvec.h
	+++ b/strvec.h
	@@ -31,12 +31,18 @@ struct strvec {
	 	const char **v;
	 	size_t nr;
	 	size_t alloc;
	+	unsigned int nodup_strings:1;
	 };
=09=20
	 #define STRVEC_INIT { \
	 	.v =3D empty_strvec, \
	 }
=09=20
	+#define STRVEC_INIT_NODUP { \
	+	.v =3D empty_strvec, \
	+	.nodup_strings =3D 1, \
	+}
	+
	 /**
	  * Initialize an array. This is no different than assigning from
	  * `STRVEC_INIT`.

In any case, for this change (and leak fixes in general), could you
please also mark the now-passing leak-free tests. This fails after your
patch, but passes before.

The failure is a "good" one, as they're now leak-free, but should be
marked as such:

	GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue \
	make SANITIZE=3Dleak test T=3D"t4256-am-format-flowed.sh t0023-crlf-am.sh =
t4254-am-corrupt.sh t4257-am-interactive.sh t5403-post-checkout-hook.sh t41=
52-am-subjects.sh"

> If we have to change parse_options() at all then I'd prefer it to not
> free() anything (to keep it usable with main()'s parameters),...

I'm suggesting passing a flag to it to have it free() things it
NULL's.

Maybe that's a bad idea, but I don't see the incompatibility with
main(), for those we just wouldn't pass the flag.

It does have the inherent limitation that you couldn't mix strvec and
non-strvec parameters, i.e. if some of your elements are dup'd but
others aren't you'd need to arrange to have them all dup'd.

But I don't think that's an issue in practice, either we pass the fully
dup'd version, or main() parameters.

> but to
> reorder in a non-destructive way.  That would mean keeping the NULL
> sentinel where it is, and making sure all callers use only the returned
> argc to determine which arguments parse_options() didn't recognize.

I think this would work if parse_options() wasn't clobbering those
elements in some cases, and replacing them with new ones, but doesn't it
do that e.g. in parse_options_step()?

It also seems like a much more fragile change to try to ensure that
nothing uses the "argv" again, but only looks at the updated
"argc".

Both that & adding a "const" to it would be a huge change across the
codebase, so I'd like to avoid them, but at least the "const" method
would be helped along by the compiler.
