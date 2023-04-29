Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C48C77B60
	for <git@archiver.kernel.org>; Sat, 29 Apr 2023 19:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjD2TUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Apr 2023 15:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjD2TUX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2023 15:20:23 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4A32134
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 12:20:21 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-546de76c23eso664077eaf.0
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682796020; x=1685388020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycSYC1JIGc4ZzMhL3b72eolTp8kQxcoo5KbCTvcWpOI=;
        b=SuPI/qzmO3qvCK4b1/YancmoAxOMIJU4sasRvlqXwRvbqiRv5ALAVIlZw7MeWMqg/N
         1IUvPteQfz7F5QT82kW9/meLd0xsu4arAn6Ot8ItW10t6gfcQqbzvzrQmzNEhY4ACzwf
         S8OtQqSyrVEGiSOQlkWs9NHQyRiJvfeZwwwZ+7yBD8Npv1+0FEa6ZtfNmu5idkRq7J8k
         odkbsDEGwkKixryNt7DYka5rfdXZd9iBpNnyY+LjAgmVku0ZCsTAYAOiXuOm9Bq9XP5V
         ZjsewqwGcSKa8q/DNh9yTmc4dj51jgk7YeVkXf8FpyZZH4IE5QXJ602M4HsM+HQwsn03
         oe7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682796020; x=1685388020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycSYC1JIGc4ZzMhL3b72eolTp8kQxcoo5KbCTvcWpOI=;
        b=RWbpSJ3m7O4/E1tgjctNj5ZzMw9qCS8ratDnF0k6ZMu34QNWuJqRbqJ4G35AZuQhnr
         A8hqDTWN1Q4sHdP4LDZY4cMdvuTa3BMFuixl/OhML42yYdohZ3Xb0f4UBCMsobywkcLb
         kv0IDUrV00bS4YR9NiBG26tyRHPT8uo1va6oyrQSRP0WsJUVwD+x4/xDzVbHDVk6EI5x
         T2/X2TuK3nBxDsEZc54DQnk2N69o/9uowpCm1EajzJnHWThiHBl4VhrkEotPoRRWDHOD
         vR+v8WSf7XGRKmD4xFaMIYThg8kN+engtpcJaScSROQ4Q1x+/yvzPB4PWnUWEs+nuuDJ
         qg1w==
X-Gm-Message-State: AC+VfDxdaMZ1fkx1yvlEsxUHc2U7ZNW4dgH3J1K8/2JNVWOK2RMjC2ei
        +dg4T3g6dufJgBPFptXdydQLYz1h1goy/Dm3R+s=
X-Google-Smtp-Source: ACHHUZ53bpval3P6kB83bjYNTyxOi21a6CpvwBoh/hRMDBOyCmTwzKzV5Vui5VtRj5mEWEtzikdRcuEcFPn2McTDeYo=
X-Received: by 2002:a54:4783:0:b0:38e:7bb:5a0d with SMTP id
 o3-20020a544783000000b0038e07bb5a0dmr4617772oic.27.1682796019920; Sat, 29 Apr
 2023 12:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230421055641.550199-1-alexhenrie24@gmail.com>
 <20230428042221.871095-1-alexhenrie24@gmail.com> <xmqqsfcjevbz.fsf@gitster.g>
In-Reply-To: <xmqqsfcjevbz.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sat, 29 Apr 2023 13:19:00 -0600
Message-ID: <CAMMLpeQB1zdTEWd+=d0kaKwpzax093iLTuytZtvn0nTSJ2xT4A@mail.gmail.com>
Subject: Re: [PATCH v2] docs: rewrite the documentation of the text and eol attributes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com, tboegi@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2023 at 12:05=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:

> Thanks.  I wonder helped-by tboegi@ might be in order, but hopefully
> it may come during the review of this round.

Sure, I'll add a Helped-by line in the next revision.

> 1. Overall, the new text is clearly written, and I think it made the
>    updated description of "Set" and "Set to string 'auto'" easier to
>    understand.

I'm glad you like it!

> 2. "on checkin and possibly also checkout" may be redundant, as the
>    section in which the `text` attribute is described is all about
>    various conversions upon checking in (i.e. moving contents to the
>    index) and checking out (i.e. moving contents out of the index).

For the `text` attribute's behavior to make sense, the first thing a
newbie has to understand is that `text` definitely enables
normalization on checkin and might or might not enable normalization
on checkout. The original text made it sound like `text` only controls
checkin and `eol` controls checkout, a false impression that is
especially misleading because on Linux and OS X, `text` without `eol`
(or core.autocrlf or core.eol) does only enable normalization on
checkin. The new text may be slightly redundant, but it makes the
important part crystal clear.

> 3. It is unclear why we would want to mention "even if it has CRLF
>    line endings in the working directory".  "Regardless of the line
>    endings in the working tree files" may slightly be better [*1*],
>    but I think the text reads better without it as storing contents
>    with possibly different end-of-line convention is the point of
>    "end-of-line normalization" in the first place.

> *1* The intent is not about special-casing CRLF but any other; if
>     Git were to be extended to support ancient MacOS, we would
>     convert even if it uses CR line endings.

I called out CRLF precisely because I was thinking about platforms
that use CR instead of LF or CRLF. I wanted to make it clear that if
you add a file that was written on or for an ancient Mac or Commodore,
the line endings are not normalized. Git can be used (and probably is
being used by someone) to version-control files for those platforms
without actually running on those platforms.

Then again, maybe the fact that the `text` attribute does not
normalize CR line endings is a bug in Git, and we shouldn't advertise
it in the documentation as if it were intended behavior. What do you
think?

>    "the file is stored in the index with LF line endings" may better
>    be rephrased to "the contents is stored, after converting to use
>    LF line endings if necessary, in the index", so that we can use
>    the verb "convert" to stress the point of setting this attribute.

The phrase "if necessary" would be a bit confusing. What makes
conversion on checkin "necessary"? The reader would wonder if it
depends on the Git config and the platform like conversion on checkout
does.

Would you be OK with your proposed wording minus "if necessary"?

> 4. This problem is shared with the original text, but "This
>    attribute marks the path as a text file" might be a bit
>    misleading.  If it is left unspecified (i.e. unmentioned, or any
>    earlier settings by explicitly overriding them with "!text") or
>    worse yet, explicitly unset (i.e. "-text"), it marks the path as
>    a non text.
>
>       This attribute is used to mark the path as a text file, which
>       needs certain end-of-line normalization upon check-in and
>       check-out, or a non-text file, which do not.
>
>   I dunno if the extra verbosity is too much, though.

Hmm, I would find your proposed wording misleading because it seems to
imply that the default is `text=3Dauto` and that `-text` (or a config
variable) is necessary to turn end-of-line normalization off. In my
opinion it's already clear enough that the attribute is unset by
default and that `-text` unsets a previous `text`.

> >  Set::
> >
> >       Setting the `text` attribute on a path enables end-of-line
> > -     normalization and marks the path as a text file.  End-of-line
> > -     conversion takes place without guessing the content type.
> > +     normalization on checkin and checkout as described above.  Line
> > +     endings are normalized in the index the next time the file is
> > +     checked in, even if the file was previously added to Git with CRL=
F
> > +     line endings.
>
> "the next time" -> "every time", but that is probably moot, because
> I would question the need for the whole sentence.
>
> The last sentence, starting with "Line endigns are normalized", may
> be redundant and we probably are better off without it.  It would
> risk becoming maintenance burden because we have to make sure it
> stays in sync with what you wrote in the introductory text.  "as
> described above" before that sentence is clear enough.

I added that sentence to make the difference between `text` and
`text=3Dauto` more clear. If all we have is the introductory paragraph,
it sounds like Git only converts CRLF to LF on checkin if it had
converted LF to CRLF on checkout. However, if you feel strongly that
the sentence is unhelpful here, I'll remove it.

> We may want to use the phrase "checking out" somewhere in
> conjunction with "in the working directory" to be consistent with
> how the section is titled.  Something like
>
>     This attribute marks a path to use a specific line-ending style
>     in the working tree when it is checked out.

That's fine.

> >  Set to string value "lf"::
> >
> > -     This setting forces Git to normalize line endings to LF on
> > -     checkin and prevents conversion to CRLF when the file is
> > -     checked out.
> > +     This setting uses the same line endings in the working directory =
as
> > +     in the index, whether they are LF or CRLF.  However, unless
> > +     `text=3Dauto`, adding the file to the index again will normalize =
its
> > +     line endings to LF in the index.
>
> First of all, "uses the same, except if ... then LF is used" is much
> harder to understand than "use LF, except if ..." as an explanation
> for "lf".
>
> The description may be correct but is 'eol=3Dlf' what controls how the
> normalization is done upon checking in?
>
> As you said in the explanation for the `eol` attribute as a whole,
> `eol` is effective only when `text` says the path is a text file,
> and that (i.e. the fact that `text` controls the end-of-line) makes
> the path to use LF line endings, isn't it?  The last sentence
> starting with "However, unless" that talks about conversion going
> into the index feels out of place.

That's a good point, it would be more clear here to explicitly say
that the setting affects checkout, and not mention what happens on
checkin (which was described previously in the `text` documentation).
Also, if we delete the sentence here then the seemingly redundant
sentence that starts with "Line endings are normalized" wouldn't be as
redundant.

> There are some exception handling in the code for odd cases like the
> contents with mixed line endings, a path set to use LF but the file
> actually has CRLF, etc.  While they are worth describing, I wonder
> if they should be done in a separate paragraph.

Probably best done in a separate patch after this rewrite is done.

Wow, that was a LOT of feedback on a relatively short piece of text.
Are you sure you don't want to rewrite the documentation yourself? ;-)

-Alex
