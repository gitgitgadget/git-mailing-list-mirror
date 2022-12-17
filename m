Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5996EC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 12:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiLQMqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 07:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiLQMqK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 07:46:10 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57903D131
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 04:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1671281162; bh=v31GotajFc5EiJ6zI4oW0XkA2QAiCKmfRN3479IZ1V8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=s+iuKrYoxiXmV+X3tOgFak/NfdQuryVgxcFqY1BY5ph4s4jN0zo5CIc39vpE4ghHG
         pL5oimgiaB+S/1oNQoRA94d/HfqYQd/+fALtKGLsG7UWms8hPwR9XK7Mr2j5KrFIjS
         /kHi4CY53cz5W7qPjzpUigI2Ey6GkfdhndKndM7mFBHQB0FGUwvUlzsHCTWzCDLqhe
         LcnoRFRiJqODBd/jF8MzSotCP2YDjS1aeS+4wvS2BKk9S7e1wF8Um9A0I3cf1XT0Mi
         aaMhUrWlvMHm1jhiclay9UtHBD0/4DHaMq5NEnzqhKAsc5NyQzJwYnL08+TeRmGQr6
         0cPZmJlMVsY+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3m5B-1p6nYf1sPb-000nOX; Sat, 17
 Dec 2022 13:46:02 +0100
Message-ID: <e7ea30dd-91a8-9cd8-8ac4-cb9af1eb1b76@web.de>
Date:   Sat, 17 Dec 2022 13:46:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH] am: don't pass strvec to apply_parse_options()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <baf93e4a-7f05-857c-e551-09675496c03c@web.de>
 <221213.86mt7r4ru2.gmgdl@evledraar.gmail.com>
 <2d0d77a4-f6ac-1fa7-bddb-9083579d8dd7@web.de>
 <221214.86ilie48cv.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221214.86ilie48cv.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rNQmE/MzteR4HmjFYZmc1FMRBO0q3+Cz3D7i/+Z/rE3Mbe2kFjd
 K/T7+qENnq/aCCLMgKn/PMQRq8Vxbh61y9XMQueYc4bbDBBcCLVZ+PBCVx4A4PzqUidmOQF
 5vAblBxTdTRpbMFlc84/6DDFgSqt0XpBs6nv2XxZBZZdzYBMaH9P0A3grpJxA/F1hAKueNP
 N3fTQPqo94wXMP20KB0aw==
UI-OutboundReport: notjunk:1;M01:P0:6TKtKdyX4Mo=;H+iUIp3i39XmF78MbmXUyROtyN1
 Fj9QD9b6WvEi7L2R4wOXy/E1RGrwiD0ofA4U+JtYnDFvFggCifVj3PXDZTdpimGNvhuf1BUhy
 9zTvRRBcN+XB3aQjB76dqJPnEhJPEF0yg5nhMxR6QRdlFovy6+Gm7hA5jGMuiC/YJYoV1OOyR
 qEgZLFxAUYyvdeqpKPsc7upWywW22Tl3o1gr9aZQsKN8rCV6fIQFL7y18Rccj/y5lAtquGVCv
 oefUyiFfKpX1o+H5Otgy9TYAe7wR7cjdiJ28Z85J4J38pwecuT5okrtTQNUXFrKiuKpvFzRdd
 Pj11zeTIpAVgmX3FdGEkQ/0BURM0ubMLKbawPOBuIYc9EXYxSLNDpmtPiBIcckhuCAomE+T3S
 CKXsClha+IzAzqpWBRzXfg3c00F4Z9QT7QJKiDrqF0biniIs6voCnLblS4m2F45BwUls0O34W
 FUgjUnTun6Wv3ayh/v9qxllUlu7RhUf/QZWQ7XNrhlBK1erA9A20Yqact1rZufHvGrZRKyP1R
 zD8LywvIgztK5hqMcCY3Il76rerSLnQjK9OpZnIu2q0KpO/9KZJFlmdqlJcoUURysPCGVQ7Aa
 89U7OfRFCHlDZywtGZoZnwD2UdJqw+RccGNEwYqEdWiF4m4SRjGI1UdtB5nuIZry0q6U+cVMr
 TcoU5TO7iNES+3hEpjA0DA9nCGwk5ruwPdZ7S61i8kIl6H/iSn9qEITnEQqeHg2djKpVmjtcx
 Iy7S4wfvekqRhKJfHe0Hsoa4fw3EBzaIz+fStdQTXQ4gAWfXRH94aZZFLaB/jQgqz084DwDgT
 d9eEDlhto/0IV6aYn9BaLnMTAT8auj9J39KzpfDRaGnJkTPLWmHv+9hS3eF9i2StMyPT8leqV
 QJl4RwGbXY05ugnbjr/LqL/l6KA4I+olGb0DK3dlmcytz04HzWpG8AL7PSpvWDcWffqZ7LOlI
 mYa5/aa2T5Cs/mpsOFV7DMlRt28=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.12.22 um 09:44 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, Dec 13 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 13.12.22 um 09:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>
>>> On Tue, Dec 13 2022, Ren=C3=A9 Scharfe wrote:
>>>
>>>> apply_parse_options() passes the array of argument strings to
>>>> parse_options(), which removes recognized options.  The removed strin=
gs
>>>> are not freed, though.
>>>>
>>>> Make a copy of the strvec to pass to the function to retain the point=
ers
>>>> of its strings, so we release them all at the end.
>>>>
>>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>>> ---
>>>>  builtin/am.c | 12 +++++++++++-
>>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/builtin/am.c b/builtin/am.c
>>>> index 30c9b3a9cd..dddf1b9af0 100644
>>>> --- a/builtin/am.c
>>>> +++ b/builtin/am.c
>>>> @@ -1476,6 +1476,7 @@ static int run_apply(const struct am_state *sta=
te, const char *index_file)
>>>>  	int res, opts_left;
>>>>  	int force_apply =3D 0;
>>>>  	int options =3D 0;
>>>> +	const char **apply_argv;
>>>>
>>>>  	if (init_apply_state(&apply_state, the_repository, NULL))
>>>>  		BUG("init_apply_state() failed");
>>>> @@ -1483,7 +1484,15 @@ static int run_apply(const struct am_state *st=
ate, const char *index_file)
>>>>  	strvec_push(&apply_opts, "apply");
>>>>  	strvec_pushv(&apply_opts, state->git_apply_opts.v);
>>>>
>>>> -	opts_left =3D apply_parse_options(apply_opts.nr, apply_opts.v,
>>>> +	/*
>>>> +	 * Build a copy that apply_parse_options() can rearrange.
>>>> +	 * apply_opts.v keeps referencing the allocated strings for
>>>> +	 * strvec_clear() to release.
>>>> +	 */
>>>> +	ALLOC_ARRAY(apply_argv, apply_opts.nr);
>>>> +	COPY_ARRAY(apply_argv, apply_opts.v, apply_opts.nr);
>>>> +
>>>> +	opts_left =3D apply_parse_options(apply_opts.nr, apply_argv,
>>>>  					&apply_state, &force_apply, &options,
>>>>  					NULL);
>>>>
>>>> @@ -1513,6 +1522,7 @@ static int run_apply(const struct am_state *sta=
te, const char *index_file)
>>>>  	strvec_clear(&apply_paths);
>>>>  	strvec_clear(&apply_opts);
>>>>  	clear_apply_state(&apply_state);
>>>> +	free(apply_argv);
>>>>
>>>>  	if (res)
>>>>  		return res;
>>>
>>> I don't mind this going in, but it really feels like a bit of a dirty
>>> hack.

What's so dirty about it, by the way?

>>>
>>> We have widespread leaks all over the place due to this
>>> idiom. I.e. parse_options() and a couple of other APIs expect that the=
y
>>> can munge the "argv", which is fine if it arrives via main(), but not =
if
>>> we're editing our own strvecs.
>>
>> Where?  A quick "git grep 'parse_options.*nr'" turns up only this place
>> as one that passes a strvec to parse_options.
>
> Sorry about the vagueness, this was from memory and I didn't have a full
> list handy.
>
> First, that grep isn't going to give you what you want, since it only
> catches cases where we're passing the "strvec" to the "parse_options()"
> directly.
>
> But if you look at e.g. how cmd_stash() invokes push_stash() or
> cmd_describe() invoking cmd_name_rev() you'll see callers where we're
> potentially losing the strvec due to parse_options().
>
> "Potentially" because in both those cases we call that API, but in the
> latter case we've got a missing strvec_clear(), so maybe that's all
> that's needed (it doesn't always munge the argv).

OK.

>>> I think less of a hack is to teach the eventual parse_options() that
>>> when it munges it it should free() it. I did that for the revisions AP=
I
>>> in f92dbdbc6a8 (revisions API: don't leak memory on argv elements that
>>> need free()-ing, 2022-08-02).
>>>
>>> What do you think?
>>
>> Generating string lists and then parsing them is weird.  When calls hav=
e
>> to cross a process boundary then we have no choice, but in-process we
>> shouldn't have to lower our request to an intermediate text format.  gi=
t
>> am does it anyway because it writes its options to a file and reads the=
m
>> back when it resumes with --continue, IIUC.
>
> I agree, but making all those use a nicer API would be a much bigger
> change.

Indeed.

>> I hope that is and will be the only place that uses parse_options() wit=
h
>> a strvec -- and then we don't have to change that function.
>>
>> If this pattern is used more widely then we could package the copying
>> done by this patch somehow, e.g. by adding a strvec_parse_options()
>> that wraps the real thing.
>
> The reason I'm encouraging you to look at some of the other strvec leaks
> is to see if you can think of a pattern that fits these various leaky
> callers.
>
> So e.g. a strvec_parse_options() won't work for the ones noted above
> where we've lost track of it being a "struct strvec" in the first place.

Right.  It would work if we used a strvec in place of *every* argc/argv
pair, but that seems a but heavy a change.

> I have a local version somewhere where I did (pseudocode):
>
> 	struct strvec vec =3D STRVEC_INIT;
> 	struct string_list to_free =3D STRING_LIST_INIT_DUP;
>
>         // populate vec...
>         for (size_t i =3D 0; i < vec.nr; i++)
> 		string_list_append_nodup(&to_free, v[i]):
> 	// call parse_options(), or otherwise munge "vec"...
> 	free(strvec_detach(&vec));
>         string_list_clear(&to_free, 0);
>
> I.e. you snapshot the members of the "vec" before it's munged, and
> free() those via a "struct string_list".
>
> Then you don't strvec_clear(), but instead free() the container, its
> members being free'd by the string_list.

So the same as my patch, just with a string_list instead of a string
array and ownership juggling.

> Here's a (not yet in-tree) patch that uses that:
> https://lore.kernel.org/git/patch-10.10-81f138e460c-20221017T115544Z-ava=
rab@gmail.com/
>
> I think that's more reliable & general than the pattern you're adding
> here.

How so?

> In your version the only reason we're not segfaulting is because the
> parse_options() consumes all the arguments, but that's not something you
> can generally rely on with parse_options().

Could you please elaborate?  What do you mean with "consume"?  Or could
you give an example of a segfault do to partial consumption?

I see one caveat: We should keep a NULL sentinel at the end when we
hand the copy to arbitrary functions, as some of them don't even look
at argc.  Is that what you meant?

> Also, and maybe I'm missing something, but wouldn't this be functionally
> the same as your implementation:
>
> 	diff --git a/builtin/am.c b/builtin/am.c
> 	index 30c9b3a9cd7..e65262cbb21 100644
> 	--- a/builtin/am.c
> 	+++ b/builtin/am.c
> 	@@ -1476,11 +1476,13 @@ static int run_apply(const struct am_state *sta=
te, const char *index_file)
> 	 	int res, opts_left;
> 	 	int force_apply =3D 0;
> 	 	int options =3D 0;
> 	+	char *to_free;
>
> 	 	if (init_apply_state(&apply_state, the_repository, NULL))
> 	 		BUG("init_apply_state() failed");
>
> 	 	strvec_push(&apply_opts, "apply");
> 	+	to_free =3D (char *)apply_opts.v[0];
> 	 	strvec_pushv(&apply_opts, state->git_apply_opts.v);
>
> 	 	opts_left =3D apply_parse_options(apply_opts.nr, apply_opts.v,
> 	@@ -1489,6 +1491,7 @@ static int run_apply(const struct am_state *state=
, const char *index_file)
>
> 	 	if (opts_left !=3D 0)
> 	 		die("unknown option passed through to git apply");
> 	+	free(to_free);
>
> 	 	if (index_file) {
> 	 		apply_state.index_file =3D index_file;
>
> I.e. we leak the strvec_push() of the "apply" literal, but for the rest
> we append the "state->git_apply_opts.v", which we already free()
> elsewhere.

state->git_apply_opts is released elsewhere, but the copies of its element=
s
in apply_opts are leaked here.

> So actually, aren't we really just fumbling our way towards the "nodup"
> interface that the "struct string_list" has, and we should add the same
> to the "struct strvec".
>
> This seems to also fix all the leaks you fixed, but without any of the
> copying:
>
> 	diff --git a/builtin/am.c b/builtin/am.c
> 	index 30c9b3a9cd7..691ec1d152d 100644
> 	--- a/builtin/am.c
> 	+++ b/builtin/am.c
> 	@@ -1471,7 +1471,7 @@ static int parse_mail_rebase(struct am_state *sta=
te, const char *mail)
> 	 static int run_apply(const struct am_state *state, const char *index_f=
ile)
> 	 {
> 	 	struct strvec apply_paths =3D STRVEC_INIT;
> 	-	struct strvec apply_opts =3D STRVEC_INIT;
> 	+	struct strvec apply_opts =3D STRVEC_INIT_NODUP;
> 	 	struct apply_state apply_state;
> 	 	int res, opts_left;
> 	 	int force_apply =3D 0;
> 	diff --git a/strvec.c b/strvec.c
> 	index 61a76ce6cb9..efdc47a5854 100644
> 	--- a/strvec.c
> 	+++ b/strvec.c
> 	@@ -22,7 +22,9 @@ static void strvec_push_nodup(struct strvec *array, c=
onst char *value)
>
> 	 const char *strvec_push(struct strvec *array, const char *value)
> 	 {
> 	-	strvec_push_nodup(array, xstrdup(value));
> 	+	const char *to_push =3D array->nodup_strings ? value : xstrdup(value)=
;
> 	+
> 	+	strvec_push_nodup(array, to_push);
> 	 	return array->v[array->nr - 1];
> 	 }
>
> 	@@ -31,6 +33,9 @@ const char *strvec_pushf(struct strvec *array, const =
char *fmt, ...)
> 	 	va_list ap;
> 	 	struct strbuf v =3D STRBUF_INIT;
>
> 	+	if (array->nodup_strings)
> 	+		BUG("cannot strvec_pushf() on a 'nodup' strvec");
> 	+
> 	 	va_start(ap, fmt);
> 	 	strbuf_vaddf(&v, fmt, ap);
> 	 	va_end(ap);
> 	@@ -67,6 +72,9 @@ void strvec_pop(struct strvec *array)
>
> 	 void strvec_split(struct strvec *array, const char *to_split)
> 	 {
> 	+	if (array->nodup_strings)
> 	+		BUG("cannot strvec_split() on a 'nodup' strvec");
> 	+
> 	 	while (isspace(*to_split))
> 	 		to_split++;
> 	 	for (;;) {
> 	@@ -90,7 +98,7 @@ void strvec_clear(struct strvec *array)
> 	 	if (array->v !=3D empty_strvec) {
> 	 		int i;
> 	 		for (i =3D 0; i < array->nr; i++)
> 	-			free((char *)array->v[i]);
> 	+			free(array->nodup_strings ? NULL : (char *)array->v[i]);
> 	 		free(array->v);
> 	 	}
> 	 	strvec_init(array);
> 	diff --git a/strvec.h b/strvec.h
> 	index 9f55c8766ba..ac6e2c04cea 100644
> 	--- a/strvec.h
> 	+++ b/strvec.h
> 	@@ -31,12 +31,18 @@ struct strvec {
> 	 	const char **v;
> 	 	size_t nr;
> 	 	size_t alloc;
> 	+	unsigned int nodup_strings:1;
> 	 };
>
> 	 #define STRVEC_INIT { \
> 	 	.v =3D empty_strvec, \
> 	 }
>
> 	+#define STRVEC_INIT_NODUP { \
> 	+	.v =3D empty_strvec, \
> 	+	.nodup_strings =3D 1, \
> 	+}
> 	+
> 	 /**
> 	  * Initialize an array. This is no different than assigning from
> 	  * `STRVEC_INIT`.

We can do it, but it's quite complicated overall.  strvec is with its
"duplicate everything" stance is easy to understand and reason about.
Adding a nodup variant will remove that feature.

> In any case, for this change (and leak fixes in general), could you
> please also mark the now-passing leak-free tests. This fails after your
> patch, but passes before.
>
> The failure is a "good" one, as they're now leak-free, but should be
> marked as such:
>
> 	GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck GIT_TEST_SANITIZE_LEAK_LOG=3Dtru=
e \
> 	make SANITIZE=3Dleak test T=3D"t4256-am-format-flowed.sh t0023-crlf-am.=
sh t4254-am-corrupt.sh t4257-am-interactive.sh t5403-post-checkout-hook.sh=
 t4152-am-subjects.sh"
>

Well, it might be my laziness talking, but can we avoid that?  There are
lots of leaks present in tests and plugging the last one for a particular
test script holds no particular significance.  Wouldn't it be better to
update the annotations at the end of the release cycle, similar to
translations?  Or automate it via some kind of CI job?

In any case: Requiring to run the test suite with LeakSanitizer for leak
fixes would be a hurdle that I'd jump only reluctantly.  (LeakSanitizer
is not supported on my development system, an M1 Mac.)

>> If we have to change parse_options() at all then I'd prefer it to not
>> free() anything (to keep it usable with main()'s parameters),...
>
> I'm suggesting passing a flag to it to have it free() things it
> NULL's.
>
> Maybe that's a bad idea, but I don't see the incompatibility with
> main(), for those we just wouldn't pass the flag.
>
> It does have the inherent limitation that you couldn't mix strvec and
> non-strvec parameters, i.e. if some of your elements are dup'd but
> others aren't you'd need to arrange to have them all dup'd.
>
> But I don't think that's an issue in practice, either we pass the fully
> dup'd version, or main() parameters.

Yes, but your examples at the top show that sometimes the parse_options()
call is hidden by several layers of other functions.  We better have a
more general solution.

>> but to
>> reorder in a non-destructive way.  That would mean keeping the NULL
>> sentinel where it is, and making sure all callers use only the returned
>> argc to determine which arguments parse_options() didn't recognize.
>
> I think this would work if parse_options() wasn't clobbering those
> elements in some cases, and replacing them with new ones, but doesn't it
> do that e.g. in parse_options_step()?

You mean the "fake a short option thing", right?  That would have to be
addressed somehow.

> It also seems like a much more fragile change to try to ensure that
> nothing uses the "argv" again, but only looks at the updated
> "argc".
>
> Both that & adding a "const" to it would be a huge change across the
> codebase, so I'd like to avoid them, but at least the "const" method
> would be helped along by the compiler.

Agreed.

Ren=C3=A9
