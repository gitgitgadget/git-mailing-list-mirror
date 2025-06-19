Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E249213E6A
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750365019; cv=none; b=BU9qMeZ8u+pIMowGfdL+/1I3xKlV8O4Fgfx9v9fvvfGumgz0NH6bM9cSGeH7VDCQSC+2KsE2hH04NgzR09NgVBq8erw3H5BSi3QvH6R8LwTGbeAgW+zMgOfTWm0xmnYjlnuSXw9Ch1CocOxAsKYuVCbQMx5bSouoLPIc8bbwSI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750365019; c=relaxed/simple;
	bh=0dw9/b3Pf1OIp8gpD393Nn2QKZVkpB3VILJOh47h+wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQFddkBDmNmWsIEV7b/7KCCmcbAEYtOxRPBcgrxL3LkLbgyMJAxz7kYVLBGhoTVr8q+w1o1RZPFt8Hsc+tx5fkY4cIN0na61EdwAaRZahV87Ez2YMMQes7m07wTxuMhni4ZvPGC4ufBCpka55yTdqaepvVI0U0i4ebcz0ZTbq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI7EnjXG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI7EnjXG"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so1902740a12.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 13:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750365014; x=1750969814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P3cI7S6EpL0NR4FH040EePBnoQjFpJPp+mXaFxp0BU=;
        b=SI7EnjXG8tdr2eBMVboSLRzxEe3u9+xyRSAwNZOuOHuMyuZ/y8kMBfzZzNbb3tE6mY
         by1eGCxjx8tpRd9UwbGWqnHnR8GlgY8f6ZZLtn/Jm+7rRjdq/hiFiGhachaiIrpIokOO
         tJR2irhlhozMxREYqSmvyz5fjmaEl0HDtBY/IGMUwQoyvf6edmxoqwv/YiLQVOVqEJKI
         K1VydqOrGzpelhxDdY6lEQlU0cCr0oN0n3AQh+9cOOyFwsue1pGCnROYgvNP9c75pLM4
         kE0XfKhuX2FG8Jln7+sZu5/0GpXXgWQyJRyo4B9smM62/tMT3n9PfhlTBlylCAPFQ1+T
         z4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750365014; x=1750969814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P3cI7S6EpL0NR4FH040EePBnoQjFpJPp+mXaFxp0BU=;
        b=o69qFBnamLVfdqeb4PJqOz9T9oWtIHlpJOLgwVYxtgd8iH7kLMpvWoTx2L9CxBD46R
         XR/gcsECqWj6MsuUD8apTMbgAfl8VLkreCf2qC2eGjC3CIQ7c8RyA95ph05s3afCL6mf
         0oO2wCHDaKeqeGuLLzXvPssC6sUbYXA2jWINrEucCLXprqU484z3oKPPgjjgAQOqq4rK
         4JWNFd3lwVinGGb3GS1r2NWzio/zVT/4eG0P9DBWb0OYkcuYom4Bz+rNk2DPd8XZ05yf
         qt0mmIDMaPKnDDEKNZKf+3M2BNV+ldH+SFUVNwriC1XIOBnTUfa9VyKEYnUCKIAHZzio
         jqWQ==
X-Gm-Message-State: AOJu0Yx603zKijsh6palqCVERuOlkQpZ7gLAfh11Swlc2A7DR3S1Ikv/
	9y++L/S55GpL0OClRGWhOUXTlCFnddAz/XL6Ih/TKvo6uoIRTzZTvbGl6aYEGfV1tgal52GRNkl
	Tb3L3hoeB8moHFgX6u3LvSZFjDGRyMJ0=
X-Gm-Gg: ASbGncviAvUlcJoYRL9hJPFUVuOn/3NxlO3QP5vpo+3KLEO31D4D4Ya9O+idCwueGi0
	jfsOojX4twmxymzr5060xajcPjvC4B+h9zgcHKwbGXuHqN6f/UzLKjGcEiKoLcOMIx27QBItFXx
	Og4drNPet5ol3g373S9NEYzzraHcLO0Xit2vIqTFrf7a+DEw==
X-Google-Smtp-Source: AGHT+IEKO2AWeCXVfL3BYq7fKyW9wNJpqMGHT23fp9uh5mvGkERt0iaSMnpl2N8Pj1MlkYxMhdVNcDHurBK08es2hvg=
X-Received: by 2002:a17:907:3f1a:b0:ad2:3f9a:649f with SMTP id
 a640c23a62f3a-ae057f65c4cmr22490166b.42.1750365013449; Thu, 19 Jun 2025
 13:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqmsa3adpw.fsf@gitster.g>
In-Reply-To: <xmqqmsa3adpw.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 19 Jun 2025 22:30:01 +0200
X-Gm-Features: Ac12FXzYuWVrKSYTwkh5htVVOfe84Ur1e3GQxDR3LtVFX53rDqxlliSBZtJCUDA
Message-ID: <CAP8UFD0YEgh4Oy8MDpT0DfZJgo++NHf3mF6VsYxAG1CjhrKGLQ@mail.gmail.com>
Subject: Re: .clang-format: how useful, how often used, and how well maintained?
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 6:39=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Cc-list chosen from "git shortlog --since=3D12.months --no-merges .clang-=
format".
>
> I am wondering how often our developers use "make style" aka
>
>     git clang-format --style file --diff --extensions c,h
>
> and also wondering if the suggested style fixes are really
> "improvements".

Karthik and I discussed this today in the context of the "check-style"
GitLab CI job which often fails even if it doesn't make the whole CI
job fail. We agreed that it might be a good idea to either improve or
just disable some dubious style checks.

> For example, taking randomly the latest patch I
> just injested into my tree, i.e.
>
>     $ git am a-single-patch-file.txt
>     $ git reset --soft HEAD^
>     $ make style
>
> I got the output attached at the end of the message.  The result is
> a mixed bag (I commented on the "patch" as if it were a patch
> submission).
>
> I have this suspicion that nobody complained these sub-par
> suggestions the tool makes based on what we have in .clang-format
> because not many folks run "make style", and "make style" is not
> very easy to use after you record your changes into a commit.  IOW,
> there is nothing packaged to help "I have four commits on top of the
> upstream, I want to run style checks before running format-patch",
> i.e.
>
>     git clang-format --diff HEAD~4

Maybe a format-patch option (perhaps called '--format-check') could be
added to run such a command before format-patch actually outputs the
patches?

> Even the output from the tool is of mixed quality, there are good
> pieces that can be used to improve your patches.  So we may prefer
> to see the tool used more often, but not in a way to suggest its
> output is always better than what the human developer has written.
>
> For that, there are a few things we'd probably need to do:
>
>  - Improve our tooling so that the develper can check a range of
>    commits they made before running format-patch, and other
>    situations.
>
>  - Improve .clang-format rules to reduce false positives.

I agree that both of these would be nice.

> > git clang-format --style file --diff --extensions c,h diff --git
> > a/builtin/fast-export.c b/builtin/fast-export.c index
> > 332c036ee4..d89e5ba6d5 100644 --- a/builtin/fast-export.c +++
> > b/builtin/fast-export.c @@ -658,17 +658,16 @@ static void
> > print_signature(const char *signature, const char *object_hash) if
> > (!signature) return;
> >
> > -     printf("gpgsig %s %s\ndata %u\n%s",
> > -            object_hash,
> > -            get_signature_format(signature),
> > -            (unsigned)strlen(signature),
> > +     printf("gpgsig %s %s\ndata %u\n%s", object_hash,
> > +            get_signature_format(signature), (unsigned)strlen(signatur=
e),
> >              signature);
> >  }
>
> I do not mind the original but the updated one is not worse.  IOW, I
> would reject if a human sent this patch to fix the original that is
> already in-tree with "once the code is written in an acceptable way,
> it is not worth the patch noise to replace it with the updated one
> that is not significantly better".
>
> I'll call this kind "once the code is written" in the rest of the
> message.

Yeah, I think those should be considered false positives. They are not
worth failing the "check-style" CI job or even having a human look at
them.

> >  static void warn_on_extra_sig(const char **pos, struct commit *commit,=
 int is_sha1)
> >  {
> >       const char *header =3D is_sha1 ? "gpgsig" : "gpgsig-sha256";
> > -     const char *extra_sig =3D find_commit_multiline_header(*pos + 1, =
header, pos);
> > +     const char *extra_sig =3D
> > +             find_commit_multiline_header(*pos + 1, header, pos);
>
> OK.

I don't think those are OK. If the existing code already has longer
lines, like perhaps here the `static void warn_on_extra_sig(...)` line
above, then it's not worth suggesting wrapping lines like this. It
could result in a code with both long lines and wrapped short ones
which could be puzzling and harder to read than if the code had only
long lines.

Ideally our tools should be able to:

  - provide full patch (including the commit message) which correctly
wraps all the long lines in a file, so that such a patch can easily be
created and added as a preparatory patch to a patch series,

  - suggest wrapping lines only when they are longer than
"max(existing lines around the hunk, our maximum line length
default)".

> > @@ -735,19 +734,20 @@ static void handle_commit(struct commit *commit, =
struct rev_info *rev,
> >                * The searches must start from the same position.
> >                */
> >               sig_sha1 =3D find_commit_multiline_header(sig_cursor + 1,
> > -                                                     "gpgsig",
> > -                                                     &after_sha1);
> > +                                                     "gpgsig", &after_=
sha1);
> >               sig_sha256 =3D find_commit_multiline_header(sig_cursor + =
1,
> >                                                         "gpgsig-sha256"=
,
> >                                                         &after_sha256);
>
> This is a suggestion that is clearly worse than the original.  These
> two statements should look similar as they are doing similar things.

I agree.

> Line wrapping the former only because it uses tokens slightly
> shorter than the ones used by the latter inevitably makes them look
> more different.
>
> This is why I am dubious of any automated tools that have to make
> their decision mechanically.

When such a tool suggests wrapping too long lines, it's more likely to
be useful than when it suggests unwrapping short lines. So I think
that if we could configure the tool so that it stops suggesting
unwrapping lines, we could likely reduce the number of false positives
without much drawback.

> Is there a way to express:
>
>     We want lines that are longer than the 80-column limit to be
>     wrapped at 80-column, but do not coalesce shorter lines only
>     to make them into a smaller number of longer lines.
>
> If we can say "wrap overly long lines, whose definition is longer
> than 100-column, at 80-column" in the earlier half of the sentence,
> it would be even better.

Yeah, if it could look at lines around the current hunk that could be
even better.

> > -             /* Warn on any additional signatures, as they will be ign=
ored. */
> > +             /* Warn on any additional signatures, as they will be ign=
ored.
> > +              */
>
> Looks significantly worse.

I agree.

> Is there a way to express:
>
>     Our multi-line comments begin and end with slash-asterisk and
>     asterisk-slash on their own line without anything else.

If there is no way to express this, then it might be better to disable
wrapping any comment if the tool has a knob for that.

[...]

> >       char *space =3D strchr(args, ' ');
> >
> >       if (!space)
> >               die("Expected gpgsig format: 'gpgsig <hash-algo> <signatu=
re-format>', "
> > -                 "got 'gpgsig %s'", args);
> > +                 "got 'gpgsig %s'",
> > +                 args);
>
> What was the tool thinking when it made this suggestion?  IOW, is
> there a stupid rule in .clang-format kicking in?

Yeah, this is kind of strange because it looks like the opposite of
what the tool suggested in some cases above.

> > @@ -2744,8 +2746,7 @@ static void parse_one_signature(struct signature_=
data *sig, const char *v)
> >               *space =3D '\0';
> >
> >       /* Validate hash algorithm */
> > -     if (strcmp(sig->hash_algo, "sha1") &&
> > -         strcmp(sig->hash_algo, "sha256"))
> > +     if (strcmp(sig->hash_algo, "sha1") && strcmp(sig->hash_algo, "sha=
256"))
> >               die("Unknown git hash algorithm in gpgsig: '%s'", sig->ha=
sh_algo);
>
> This is probably slightly worse from extensibility's pov, which a
> mechanical tool cannot make a good judgement, but the author of the
> original did ;-)

Thanks ;-)

That makes me wonder if we could use an AI tool with a fixed prompt
(that we could improve over time) and provide it our CodingGuideline
for these kinds of things rather than a mechanical tool.

[...]
