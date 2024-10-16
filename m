Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFE13AF2
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729042717; cv=none; b=lF4+axna+W8Ezcflt6Ya2zUx0ZzEYl3XxJghG/yBljfLsGSRmKGg4/eo5Kv3q1OLwH37sf36NUHOaz7morYj6E9MHm8njIuru1pLOuAiuSimR/e33YIl5Vmbt6bwOPiHZMeQGFKqLtl61rbQ5uBLZIJc1v0k1CVaRVAourwOhuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729042717; c=relaxed/simple;
	bh=/VRYVcU1otzmsy33TngLH5hapeSKte1Y+ehVuTHlmYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZI9dyb9agLXwONJMroEIAWlKciLUX28XMCQf25ScrHP9IwCLcPw/6aQd+DkxOPiW1+mi8RfupiFJKNKyqZvzhzfsVoEoC2ZBwC4TAD/v+gM6oq0zXGBknNtBBiSpDhNbpC5sd84GFYwmPanPsMhp5Suw6yVZ7OgmbElWL6wtLBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LCpxbclT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCpxbclT"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c94dd7e1c0so6466809a12.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 18:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729042713; x=1729647513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkuZh8GH5A2NX6Fs7jO5g3oD9qnSSu1e9yWEIxCZUpU=;
        b=LCpxbclTUctuCydugpDtUVIuLr8SIIkClHpMQ9pZmOS2RjfyTXGVCSnT5YKpehdbDt
         UFsdXoMdwSGiMifrw2ibkur1g0GZa/EU2QznllD0HwL3v9qLc8GjdR8Bnb2UWundO8Tu
         ihJ1f1Q3qAFNef4QVFfIFXSN3QM1IPVLKH0alZIJGxudssR1OP2X240C+BUyX9SAePoj
         /4xQfLdKwfVP0hW+ce/gfpmXfYT8N+MWhSXI18vWWyxcmJwtdUH5YYdGKUGYmqYGZ/j+
         la4SIxmercV3t16Ui3XldflaRVRJR1aSRMjofdSquY9RO4NRLoebGKnbiBPQGxsGMfSx
         PgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729042713; x=1729647513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkuZh8GH5A2NX6Fs7jO5g3oD9qnSSu1e9yWEIxCZUpU=;
        b=wkgObqYUvJ6U/4QcGZpAWQiwNhatLcHds5EyTuo641YlToduZ1bcSc3Y6JqwpqcI94
         4q4W+4hbdwZ09VvKE/9G6SMesJSEDj/iPRER0AQloDLhPyzAuhd70IuGzMRbRoxR9L5b
         MZIa26SkzW6xxzXTDfpUU7q5GlClhDfUWJHspu3EMJpGn3wG51LiZVs595tx6MXwHp0p
         N2XaLTR2bKTsdydLQnhX3Myx0Za/7vRXU2h5ha4U2ZDclbsYAvks/e7iEsKp9L5/N27d
         EWu5kedt2tijOm/t4lVyjV5s8vmwSUrkvR8tSgycE3X3drB24VIidj3mkO+h7QqJFyCL
         Vjvw==
X-Gm-Message-State: AOJu0YwLvwXLxV9vP1tY1hXCAXDZp4S3q+Ih/45PL+JPat53nNXxdNTf
	bphDnhwfLIeuGF2EoeBFl6eia1dZHIRu1trA0j5t9KWbsXes2k51JcUFlSNWWQC7AL5gwdN7/8V
	XR9K1KiDdT8hY/cutdncVfzkwC3HkiQfDMGJ/
X-Google-Smtp-Source: AGHT+IELzHcAM6LuBbJZD14chAaZUDgGpfhkIJtvRTGDAr7X6yjU+moAthAABE5ze/vELegxSpZhJQ7BIWq3igbkZRY=
X-Received: by 2002:a17:907:3da3:b0:a99:5ad9:b672 with SMTP id
 a640c23a62f3a-a99e3b20bfcmr1429843966b.10.1729042712711; Tue, 15 Oct 2024
 18:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728697428.git.karthik.188@gmail.com> <74bbd2f9db1ddfd5210be8fde2db84f67acff27d.1728697428.git.karthik.188@gmail.com>
 <CAO_smViSU5KohOqVXp2L_cM3G-jrOGQY=J=qf=-GbiGsOYd9TQ@mail.gmail.com> <CAOLa=ZT0qsG7cnnzwg7GDkBuTqZO_e+C5HwT5o9kWZ1Cto=0kg@mail.gmail.com>
In-Reply-To: <CAOLa=ZT0qsG7cnnzwg7GDkBuTqZO_e+C5HwT5o9kWZ1Cto=0kg@mail.gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Tue, 15 Oct 2024 18:38:17 -0700
Message-ID: <CAO_smVjXkpaJOKyvg_mVqxpoK5C=kVpcfGWEH5qC4vfQS=rTgg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] clang-format: re-adjust line break penalties
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, toon@iotcl.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 5:37=E2=80=AFAM karthik nayak <karthik.188@gmail.co=
m> wrote:
>
> Kyle Lippincott <spectral@google.com> writes:
>
> > On Fri, Oct 11, 2024 at 6:50=E2=80=AFPM Karthik Nayak <karthik.188@gmai=
l.com> wrote:
> >>
> >> In 42efde4c29 (clang-format: adjust line break penalties, 2017-09-29) =
we
> >> adjusted the line break penalties to really fine tune what we care abo=
ut
> >> while doing line breaks. Modify some of those to be more inline with
> >> what we care about in the Git project now.
> >>
> >> We need to understand that the values set to penalties in
> >> '.clang-format' are relative to each other and do not hold any absolut=
e
> >> value. The penalty arguments take an 'Unsigned' value, so we have some
> >> liberty over the values we can set.
> >>
> >> First, in that commit, we decided, that under no circumstances do we
> >> want to exceed 80 characters. This seems a bit too strict. We do
> >> overshoot this limit from time to time to prioritize readability.
> >
> > I think that attempting to get the weights right so as to avoid cases
> > where there was an intentional affordance for readability is going to
> > be essentially impossible. Areas where there's an intentional
> > disregard for the clang-format-generated formatting should disable the
> > formatter for that line/region, instead of trying to find a way to
> > adjust the rules to produce something that's going to end up being
> > context dependent.
> >
>
> To some extent I agree. But the issue is that clang-format is still not
> enforced within the code base. So expecting users to add:
>     // clang-format off
> will not hold, at least for _now_.
>
> So the next best thing we can do is to get the format rules as close as
> we can to the current styling, so the actual errors thrown by the CI job
> is something we can look at without containing too many false positives.
>
> > Example: In ref-filter.c, there's 13 lines when initializing the
> > `valid_atom` array that are >80 characters, and 20 lines that are >80
> > columns (when using 8-space tabs). Line breaking in that block of code
> > may be undesirable, so just disable clang-format there. I don't think
> > there's a consistent set of penalties you could establish that would
> > handle that well without mishandling some other section of code.
>
> While true, we can quantify if it is better or not:
>
>       =E2=9D=AF ci/run-style-check.sh @~50 | wc -l
>       4718 (master)
>
>       =E2=9D=AF ci/run-style-check.sh @~53 | wc -l
>       4475 (with these patches)
>
> And looking through the other changes, those look like violations which
> should have been fixed.
>
> > It's also not clear what the reason for the overshoot is in many cases.
> > - difference between "80 characters" and "80 columns"?
> >     - (1394 >80char lines in *.{h,c}, 4849 >80col lines in the same fil=
es)
> > - intentional for readability?
> > - refactorings pushed originally compliant lines out of compliance?
> > - no one caught it and it was just added without any intentional decisi=
on?
> >
>
> I agree with your inference here, but I'm not sure there is a smooth way
> to have this information. Either we go full in and say we enable the
> formatting and every patch must conform to it, or we simply keep the
> clang-format as a warning system. Currently we do neither. I'd say we
> should be in a state to reach the latter and then we can gradually think
> of how to move to the former.
>
> >> So
> >> let's reduce the value for 'PenaltyExcessCharacter' to 10. This means =
we
> >> that we add a penalty of 10 for each character that exceeds the column
> >> limit. By itself this is enough to restrict to column limit. Tuning
> >> other penalties in relation to this is what is important.
> >>
> >> The penalty `PenaltyBreakAssignment` talks about the penalty for
> >> breaking an assignment operator on to the next line. In our project, w=
e
> >> are okay with this, so giving a value of 5, which is below the value f=
or
> >> 'PenaltyExcessCharacter' ensures that in the end, even 1 character ove=
r
> >> the column limit is not worth keeping an assignment on the same line.
> >>
> >> Similarly set the penalty for breaking before the first call parameter
> >> 'PenaltyBreakBeforeFirstCallParameter' and the penalty for breaking
> >> comments 'PenaltyBreakComment' and the penalty for breaking string
> >> literals 'PenaltyBreakString' also to 5.
> >>
> >> Finally, we really care about not breaking the return type into its ow=
n
> >> line and we really care about not breaking before an open parenthesis.
> >> This avoids weird formatting like:
> >>
> >>    static const struct strbuf *
> >>           a_really_really_large_function_name(struct strbuf resolved,
> >>           const char *path, int flags)
> >
> > Is this how it'd be indented without the penalties, or would it do
> > this, with the function name indented the same amount as the return
> > type (which is, in C, probably going to be the 0th column most times):
> >
> > static const struct strbuf *
> > a_really_really_large_function_name(struct strbuf resolved,
> >         const char *path, int flags)
> >
>
> It will be indented, so not the 0th column.

I'm not getting that behavior when I try it. Is this only indented
with your updated penalties?

Currently on ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f, git status is
clean, added this line (no line breaks, just in case my email client
makes a mess of this) to top of path.h (chosen arbitrarily):

static const struct strbuf *a_really_really_large_function_name(struct
strbuf resolved, const char *path, int flags);

and ran `clang-format path.h | head -n20` and got this (where `int
flags` is indented to align with the opening `(`, but tabs cause
problems yet again):

static const struct strbuf *
a_really_really_large_function_name(struct strbuf resolved, const char *pat=
h,
    int flags);

`clang-format --version` shows it's a google-internal build, but it
still respects the .clang-format file, so this shouldn't matter? I'm
assuming it's a relatively recent (within the past 1 month) commit
that it's based off of.

>
> >>
> >> or
> >>
> >>    static const struct strbuf *a_really_really_large_function_name(
> >>             struct strbuf resolved, const char *path, int flags)
> >
> > Personal opinion: I prefer this over the version that has a single
> > argument on the first line. My preference for reading functions is:
> >
> > return_type func_name(arg1, arg2,
> >                       arg3, arg4,
> >                       arg5, arg6, ...);
> >
> > Or
> >
> > return_type func_name(
> >         arg1, arg2, arg3, arg4,
> >         arg5, arg6, ...);
> >
>
> I'm mostly basing my changes on the current state of the 'clang-format'
> and our code base. I'm happy to change it if everyone agrees on this :)

I'm wondering if tabs have caused some confusion here... [thought
continued below]

>
> > or, in some cases, putting every argument on their own line (typically
> > when the majority of the arguments are already on their own line, not
> > having one "hiding" somewhere is preferable, but at this point if
> > that's not what my formatter does, I don't fight it).
> >
> > For functions that accept an obvious first parameter, such as
> > `strbuf_add`, maybe having the first parameter on the first line is
> > acceptable/desirable, since it's "obvious" what it is/does. But for
> > many functions that's not the case, and needing to read the end of the
> > first line, potentially beyond the 80th column, feels weird.
> >
> >>
> >> to instead have something more readable like:
> >>
> >>    static const struct strbuf *a_really_really_large_function_name(str=
uct strbuf resolved,
> >>           const char *path, int flags)

Does this have `const char *path` aligned with the opening `(`? if so,
then that matches my first example and I'm fine with it. If this is
truly "first argument immediately after (, other arguments indented
one indentation level", then my original comment stands: I don't find
this readable at all, and I don't see evidence of this being an
acceptable format according to our CodingGuidelines document.

I also don't understand how the penalties would produce t


> >>
> >> This is done by bumping the values of 'PenaltyReturnTypeOnItsOwnLine'
> >> and 'PenaltyBreakOpenParenthesis' to 300. This is so that we can allow=
 a
> >> few characters above the 80 column limit to make code more readable.
> >
> > A few examples, such as by formatting the code using the current rules
> > (since much of the codebase does not currently comply), and then
> > changing the penalties and seeing what changes, might be nice?
> >
>
> You mean apart from the example above?

The example above is hypothetical, but I think I was thinking about
this incorrectly. Our existing codebase isn't formatted with
clang-format, and formatting it first and then adjusting the penalties
doesn't really provide much useful information.

Setting the penalties as you have them in this patch, and running it
on a copy of the line you have there, produces this for me:

static const struct strbuf *
a_really_really_large_function_name(struct strbuf resolved, const char *pat=
h,
                                    int flags);

The 80 column limit is still _strictly_ adhered to, it won't even go
over by 1 character:

static const struct strbuf *
a_really_really_large_function_named_Ed(struct strbuf resolved,
                                        const char *path, int flags);

(note: switched tabs to spaces because tabs are difficult to use
during discussions like this)

Specifically:
- 80 column hard limit applied
- return type on its own line
- continuation arguments are aligned on the next line (which is
expected since we have AlignAfterOpenBracket set).

>
> >
> >>
> >> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> >> ---
> >>  .clang-format | 13 +++++++------
> >>  1 file changed, 7 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/.clang-format b/.clang-format
> >> index 41969eca4b..66a2360ae5 100644
> >> --- a/.clang-format
> >> +++ b/.clang-format
> >> @@ -209,13 +209,14 @@ KeepEmptyLinesAtTheStartOfBlocks: false
> >>
> >>  # Penalties
> >>  # This decides what order things should be done if a line is too long
> >> -PenaltyBreakAssignment: 10
> >> -PenaltyBreakBeforeFirstCallParameter: 30
> >> -PenaltyBreakComment: 10
> >> +PenaltyBreakAssignment: 5
> >> +PenaltyBreakBeforeFirstCallParameter: 5
> >> +PenaltyBreakComment: 5
> >>  PenaltyBreakFirstLessLess: 0
> >> -PenaltyBreakString: 10
> >> -PenaltyExcessCharacter: 100
> >> -PenaltyReturnTypeOnItsOwnLine: 60
> >> +PenaltyBreakOpenParenthesis: 300
> >
> > How does this interact with PenaltyBreakBeforeFirstCallParameter? Does
> > one override the other?
> >
>
> From my understanding PenaltyBreakOpenParenthesis seems to apply more
> generally and is the more preferred value.
>
> [1]: https://github.com/llvm/llvm-project/blob/a4367d2d136420f562f64e7731=
b9393fb609f3fc/clang/lib/Format/TokenAnnotator.cpp#L4322
>
> >> +PenaltyBreakString: 5
> >> +PenaltyExcessCharacter: 10
> >> +PenaltyReturnTypeOnItsOwnLine: 300
> >>
> >>  # Don't sort #include's
> >>  SortIncludes: false
> >> --
> >> 2.47.0
> >>
