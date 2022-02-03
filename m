Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A290C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 10:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbiBCK0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 05:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiBCK0M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 05:26:12 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601C8C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 02:26:12 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ee12so4054061edb.8
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 02:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Kh5WAdG51XTsjRsl9lWzM9MT0Y4a3qDmdoWS6QLjILQ=;
        b=X6NPiWFq+f5Rub7zfyIsHAsGzyKzWb9wnXp5CgzS7H/zQd8tyguHuPJNqQz4wGbVTL
         ZDMl00zt0RJSSPrriqAhwHSfSRO84GLmgPPFihylynAFM24ENxDRCMPHblbk9qn2vvKZ
         U48LHvJ5R0KSqaSlvUjSJ06NetkWlBHT0hEJt3fE5DCz6jU5e0vmYrv9dlkjEZjM6Ge4
         PSMLVraFfm5EhPg4XvNo01EBLFM/zetuuCDh/drAXIC9bLUQbGhxU8HW+/N2vAbPM9Qr
         9uqRHzl5BK+TLIvfKpy+d5LKVvPKWzxXSeaZxoPYFKGnlpG5bA8y6Gm6/kKo2JlIm9D4
         /SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Kh5WAdG51XTsjRsl9lWzM9MT0Y4a3qDmdoWS6QLjILQ=;
        b=YGu4uRYAFL5wdzCVvyOfxhR4/c3vsDR5OlYQi1rzWkA5lQ5+DNcwRHn6DaELPf/kER
         fS0GGB4ZGFdpVc0h+5tzaQSo7W0fgejR6l8lQlqvNZ323FgdHh7bGz+pYa238CX2kJIG
         dIU/wLgwMKT9X2jXa7bMF28B5voSiAU4un5IVf9bEuj2ZR7lh+/BdOjxAIkg8MeCe7pn
         b0Gg85oVKZEZWMIqbsOydnVouoFMBwwofT6UeTZ3nETJ2QW6w2LI7llYiAjzANHbWZy9
         P9AkpZGbLgQ2fkgB9d4ZSwUaHlxHl0lvq2AuuHeKG2eztqzRX9k9eNrPNRmx/mUd6Ftc
         PndQ==
X-Gm-Message-State: AOAM532R5FBLuMUNtWknrGLnIJDKiMwCQSdrRkz45+ZB4AcoZIzX6YAJ
        BQ5Yp2iKB9NeyZ0MciajaiJku1PpmjP0yw==
X-Google-Smtp-Source: ABdhPJxpm11sprTfroQceSvtgjZXwLAK3HrjhjbMVNbXUd1yJ78E95ArrqWt0ATePkZ7GjXcfHxXMw==
X-Received: by 2002:a50:fc17:: with SMTP id i23mr34074820edr.346.1643883970572;
        Thu, 03 Feb 2022 02:26:10 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id rl11sm16889058ejb.15.2022.02.03.02.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 02:26:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFZJZ-004wIE-4p;
        Thu, 03 Feb 2022 11:26:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 08/15] merge-ort: allow update messages to be written
 to different file stream
Date:   Thu, 03 Feb 2022 11:01:52 +0100
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
 <04c3bdc44d2c76ffc82a95db3ca4fd07270f94cf.1643787281.git.gitgitgadget@gmail.com>
 <220203.86ee4k7lo8.gmgdl@evledraar.gmail.com>
 <CABPp-BHye_Zyw=x8B+QoSxWA1b0xyVL9==7kA4CD0q3eTrk8cQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BHye_Zyw=x8B+QoSxWA1b0xyVL9==7kA4CD0q3eTrk8cQ@mail.gmail.com>
Message-ID: <220203.86o83o5jr2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Elijah Newren wrote:

> On Wed, Feb 2, 2022 at 6:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> On Wed, Feb 02 2022, Elijah Newren via GitGitGadget wrote:
>>
>> > From: Elijah Newren <newren@gmail.com>
>> >
>> > This modifies the new display_update_messages() function to allow
>> > printing to somewhere other than stdout.  It also consolidates the
>> > location of the diff_warn_rename_limit() message with the rest of the
>> > CONFLICT and other update messages to all go to the same stream.
>> >
>> > Signed-off-by: Elijah Newren <newren@gmail.com>
>> > ---
>> >  merge-ort.c | 9 +++++----
>> >  merge-ort.h | 3 ++-
>> >  2 files changed, 7 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/merge-ort.c b/merge-ort.c
>> > index 82d2faf5bf9..d28d1721d14 100644
>> > --- a/merge-ort.c
>> > +++ b/merge-ort.c
>> > @@ -4236,7 +4236,8 @@ static int record_conflicted_index_entries(struc=
t merge_options *opt)
>> >  }
>> >
>> >  void merge_display_update_messages(struct merge_options *opt,
>> > -                                struct merge_result *result)
>> > +                                struct merge_result *result,
>> > +                                FILE *stream)
>> >  {
>> >       struct merge_options_internal *opti =3D result->priv;
>> >       struct hashmap_iter iter;
>> > @@ -4263,13 +4264,13 @@ void merge_display_update_messages(struct merg=
e_options *opt,
>> >       for (i =3D 0; i < olist.nr; ++i) {
>> >               struct strbuf *sb =3D olist.items[i].util;
>> >
>> > -             printf("%s", sb->buf);
>> > +             strbuf_write(sb, stream);
>> >       }
>> >       string_list_clear(&olist, 0);
>> >
>> >       /* Also include needed rename limit adjustment now */
>> >       diff_warn_rename_limit("merge.renamelimit",
>> > -                            opti->renames.needed_limit, 0, stderr);
>> > +                            opti->renames.needed_limit, 0, stream);
>>
>> At the tip of this series I tried to s/stream/stderr/g this, and
>> t4301-merge-tree-write-tree.sh passes, doesn't this warning_fp() special
>> behavior need a test somewhere?
>
> That's a fair point, but...this gets back to my cover letter comments
> about patches 5, 6, and 8.  They implement a code feature that seems
> useful in general...but which Dscho and Christian didn't like using in
> this particular command; they just wanted all output on stdout.
>
> So, it's hard to add a test, because there's no code anywhere that
> exercises it in this series anymore.  I originally wanted this feature
> in my remerge-diff series, but the idea of conflict headers made me
> punt it to this series.  I wanted it for this series, but Dscho and
> Christian didn't.  I could have punted again, but decided the
> underlying want kept coming up and decided to not excise it --
> especially since Dscho was helping improve it.  And Junio commented
> that he liked the idea[1].
>
> [1] https://lore.kernel.org/git/xmqqh79hx8g1.fsf@gitster.g/
>
> But yeah, it does leave it feeling slightly odd that we implemented a
> feature that nothing is currently using.  Maybe these 3 should be
> split off into their own series?  Still wouldn't have a test yet,
> though.
>
>> I assumed that warning_fp() would be using vreportf() in usage.c, but
>> it's not, it's just falling back to the equivalent of fprintf(out, ...),
>> no? I don't really see why 05/15 and parts of 06/15 & this are needed
>> over a much simpler simple helper macro like the below. applied on top
>> of this series.
>
> That macro is simple?  I thought I basically understood Dscho's code,
> but looking at what you did with diff_warn_rename_limit(), I think I'm
> lost.

I guess that's a matter of taste, yeah it's a bit of macro soup if
you're not familiar with it. FWIW (sans bug I noted below) it's the
macro soup we already use for other functions in usage.c.

>> I would get it if the point was to actually use the full usage.c
>> machinery, but we're just either calling warning(), or printing a
>> formatted string to a file FILE *. There's no need to go through usage.c
>> for that, and adding an API to it that behaves like this new
>> warning_fp() is really confusing.
>
> Because the formatted string being printed to the file won't have the
> same "warning: " prefix that is normally added to stuff in usage?

But the pre-image doesn't add that either. We're just calling
vfprintf(), not our own vreportf().

> That's a fair point; that does have a bit of a consistency problem.
> And I'd rather the messages were consistent regardless of where they
> are printed.

I think that makes sense, that's why I added die_message() recently. If
you meant to print a "warning: " prefix I think it would also be fine in
this case to just do it inline. See prior art at:

    git grep '"(fatal|error|warning):' -- '*.c'

>> I.e. an API in usage.c that allowed warning to a given FD would be
>> trying to replace the "2" in the write_in_full() call in vreportf(), I
>> would think.
>
> Hmm, makes sense.

The reason I'm barking up this particular tree is that I've got some
upcoming patches for usage.c (the C99-only macro series):
https://lore.kernel.org/git/RFC-cover-00.21-00000000000-20211115T220831Z-av=
arab@gmail.com/

It would need to deal with anything in the API. In this case there's not
much to deal with, since it's really not at all using the rest of
usage.c, it's just a "or to stderr".

>> diff --git a/diff.c b/diff.c
>> index 28368110147..4cf67e93dea 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -6377,14 +6377,21 @@ static const char rename_limit_advice[] =3D
>>  N_("you may want to set your %s variable to at least "
>>     "%d and retry the command.");
>>
>> +#define warning_fp(out, fmt, ...) do { \
>> +       if (out =3D=3D stderr) \
>> +               warning(fmt, __VA_ARGS__); \
>> +       else \
>> +               fprintf(out, fmt, __VA_ARGS__); \
>> +} while (0)
>> +
>>  void diff_warn_rename_limit(const char *varname, int needed, int degrad=
ed_cc,
>>                             FILE *out)
>>  {
>>         fflush(stdout);
>>         if (degraded_cc)
>> -               warning_fp(out, _(degrade_cc_to_c_warning));
>> +               warning_fp(out, _(degrade_cc_to_c_warning), NULL);
>>         else if (needed)
>> -               warning_fp(out, _(rename_limit_warning));
>> +               warning_fp(out, _(rename_limit_warning), NULL);
>
> Why do the only callers have a NULL parameter here?  Is this one of
> those va_list/va_args things I never bothered to properly learn?

That's wrong (I blame tiredness last night),an actual working version is
produced below. Clang accepted my broken code, but gcc rightly yells
about it:

diff --git a/diff.c b/diff.c
index 28368110147..a2bc2595533 100644
--- a/diff.c
+++ b/diff.c
@@ -6377,6 +6377,13 @@ static const char rename_limit_advice[] =3D
 N_("you may want to set your %s variable to at least "
    "%d and retry the command.");
=20
+#define warning_fp(out, ...) do { \
+	if (out =3D=3D stderr) \
+		warning(__VA_ARGS__); \
+	else \
+		fprintf(out, __VA_ARGS__); \
+} while (0)
+
 void diff_warn_rename_limit(const char *varname, int needed, int degraded_=
cc,
 			    FILE *out)
 {
diff --git a/git-compat-util.h b/git-compat-util.h
index 64ba60e5c71..d70ce142861 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -475,7 +475,6 @@ int error(const char *err, ...) __attribute__((format (=
printf, 1, 2)));
 int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)=
));
 void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning_errno(const char *err, ...) __attribute__((format (printf, 1,=
 2)));
-void warning_fp(FILE *out, const char *warn, ...) __attribute__((format (p=
rintf, 2, 3)));
=20
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
diff --git a/usage.c b/usage.c
index 0bfd2c603c0..c7d233b0de9 100644
--- a/usage.c
+++ b/usage.c
@@ -253,20 +253,6 @@ void warning(const char *warn, ...)
 	va_end(params);
 }
=20
-void warning_fp(FILE *out, const char *warn, ...)
-{
-	va_list params;
-
-	va_start(params, warn);
-	if (out =3D=3D stderr)
-		warn_routine(warn, params);
-	else {
-		vfprintf(out, warn, params);
-		fputc('\n', out);
-	}
-	va_end(params);
-}
-
 /* Only set this, ever, from t/helper/, when verifying that bugs are caugh=
t. */
 int BUG_exit_code;
=20
I do think you'd probably prefer the non-macro version, which is pretty
much just going back to this:
https://lore.kernel.org/git/6fb4f4580a581b2e43bc4b8deaa3d2d2bf4a8756.164347=
9633.git.gitgitgadget@gmail.com/

diff --git a/diff.c b/diff.c
index 28368110147..21c9561f546 100644
--- a/diff.c
+++ b/diff.c
@@ -6380,17 +6380,28 @@ N_("you may want to set your %s variable to at leas=
t "
 void diff_warn_rename_limit(const char *varname, int needed, int degraded_=
cc,
 			    FILE *out)
 {
+	const char *msg;
+
 	fflush(stdout);
 	if (degraded_cc)
-		warning_fp(out, _(degrade_cc_to_c_warning));
+		msg =3D _(degrade_cc_to_c_warning);
 	else if (needed)
-		warning_fp(out, _(rename_limit_warning));
+		msg =3D _(rename_limit_warning);
 	else
 		return;
=20
+	if (out =3D=3D stderr)
+		warning("%s", msg);
+	else
+		fprintf(stderr, "%s", msg);
=20
-	if (0 < needed)
-		warning_fp(out, _(rename_limit_advice), varname, needed);
+	if (0 >=3D needed)
+		return;
+
+	if (out =3D=3D stderr)
+		warning(_(rename_limit_advice), varname, needed);
+	else
+		fprintf(stderr, _(rename_limit_advice), varname, needed);
 }
=20
 static void create_filepairs_for_header_only_notifications(struct diff_opt=
ions *o)
diff --git a/git-compat-util.h b/git-compat-util.h
index 64ba60e5c71..d70ce142861 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -475,7 +475,6 @@ int error(const char *err, ...) __attribute__((format (=
printf, 1, 2)));
 int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)=
));
 void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning_errno(const char *err, ...) __attribute__((format (printf, 1,=
 2)));
-void warning_fp(FILE *out, const char *warn, ...) __attribute__((format (p=
rintf, 2, 3)));
=20
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
diff --git a/usage.c b/usage.c
index 0bfd2c603c0..c7d233b0de9 100644
--- a/usage.c
+++ b/usage.c
@@ -253,20 +253,6 @@ void warning(const char *warn, ...)
 	va_end(params);
 }
=20
-void warning_fp(FILE *out, const char *warn, ...)
-{
-	va_list params;
-
-	va_start(params, warn);
-	if (out =3D=3D stderr)
-		warn_routine(warn, params);
-	else {
-		vfprintf(out, warn, params);
-		fputc('\n', out);
-	}
-	va_end(params);
-}
-
 /* Only set this, ever, from t/helper/, when verifying that bugs are caugh=
t. */
 int BUG_exit_code;
=20
Note that both your pre-image, my macro version and Johannes's
linked-to-above are technically buggy in that they treat a
non-formatting format as a formatting format. I.e. we should use
warning("%s", msg) in that case, not warning(msg).

See 927dc330705 (advice.h: add missing __attribute__((format)) & fix
usage, 2021-07-13) for a similar bug/fix.
