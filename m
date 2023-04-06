Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54872C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 15:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbjDFPpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjDFPpW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 11:45:22 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF208A66
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 08:45:21 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id y7so13244751qky.1
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680795920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFsD2+GzDkJ4XHTOiptOBEv1CaiCwfmfe5UABd76rH8=;
        b=P19rU7JXHzUzmPhWhz/BlYF4wzDQ2YORVksL6gFF6XQacSJKbG+x+xYd2UPbZCG2kR
         Q3MO22MeT5kYQXRKbNRFBqqfuChlSRkwBMzbpCKErFbRDngXTfPX6qUxHnkSu7wReGxj
         6MUlOosx50IBPExa6bXsYOd6hLlVhGSbec70gqQV23Tqa3zrl9zB5dapx6I98WKPxkEJ
         IrgwCz7lumL6LXjPkHLOnMMQJBoC4qSXmAJBgKulK6szgJ5KmGjNl6JT7b8u9vGVsNf1
         UKnvlbrgv5obqZL/zFzB2HOyvtpQJ7Sx4D+wYAJATbqunx5rFvwvfsy8AxeNUe2xOInc
         FXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680795920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFsD2+GzDkJ4XHTOiptOBEv1CaiCwfmfe5UABd76rH8=;
        b=IpYYAskyYZL78kZ95kn1/QVzZ7uXODZUihEg92x0ZvcoUw5lXoNizXII6DTMWbTI4l
         h3h9+uj9Vf+KdO/TY+TeA9h6CKclAYsIbVSREETWdlZoRT9TjTkm+VnGfrgs2fOpaktB
         2fnopl7QB1F6Az+Ke+IiOt0NoGk3mEUFnBJHk4N+w9NxBRx5HVGN5v67wqoct6L61Pe1
         naCbOJC5Bg7Qtn/icq8YDWvZFN15YgDwsBWk2CLthNmyi49fudOcRAi7rh9ZXhCgFOZ0
         hbBSHxbQ1qDt0j9KgZxLEtOX+/tr0vWeBUiID6ihUsQKs9Juxp+V1dyqRiG4PFIBr7Dg
         k5Yw==
X-Gm-Message-State: AAQBX9e2M8VhyHoKKgCSn01eU9+UQVHLByqOZ6RH2MxP8jxy4bhB1bH8
        xSOAERfx98l0xkyIF4AwvTeieZCo7GElGpK2ejHy+9n7pCQ=
X-Google-Smtp-Source: AKy350Z84z2cPpW/yIWeSZZfvcjmNdEMr5kQdi9PtQ0/c+S2q2SYM1PZRitNdtPVA2x7AWMjKqze6Lb7brxBxuFNegk=
X-Received: by 2002:a05:620a:410a:b0:742:8868:bfd1 with SMTP id
 j10-20020a05620a410a00b007428868bfd1mr2737838qko.7.1680795920160; Thu, 06 Apr
 2023 08:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
 <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
 <96358c4e-7200-e5a5-869e-5da9d0de3503@cs.ucla.edu> <xmqqttxvzbo8.fsf@gitster.g>
 <6d86214a-1b80-eb88-1efb-36e61fd3203e@cs.ucla.edu>
In-Reply-To: <6d86214a-1b80-eb88-1efb-36e61fd3203e@cs.ucla.edu>
From:   demerphq <demerphq@gmail.com>
Date:   Thu, 6 Apr 2023 17:45:09 +0200
Message-ID: <CANgJU+XoyptS8NU+f6uMLrKjQakv=iN2c4DQydVaBVH3dK3s-w@mail.gmail.com>
Subject: Re: bug#60690: -P '\d' in GNU and git grep
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>, 60690@debbugs.gnu.org,
        mega lith01 <megalith01@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Tukusej=E2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        pcre-dev@exim.org, Philip.Hazel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 Apr 2023 at 20:32, Paul Eggert <eggert@cs.ucla.edu> wrote:
>
> On 2023-04-04 12:31, Junio C Hamano wrote:
>
> > My personal inclination is to let Perl folks decide
> > and follow them (even though I am skeptical about the wisdom of
> > letting '\d' match anything other than [0-9])
>
> I looked into what pcre2grep does. It has always done only 8-bit
> processing unless you use the -u or --utf option, so plain "pcre2grep
> '\d'" matches only ASCII digits.
>
> Although this causes pcre2grep to mishandle Unicode characters:
>
>    $ echo '=C3=86var' | pcre2grep '[Ss=C3=9F]'
>    =C3=86var
>
> it mimics Perl 5.36:
>
>    $ echo '=C3=86var' | perl -ne 'print $_ if /[Ss=C3=9F]/'
>    =C3=86var
>
> so this seems to be what Perl users expect, despite its infelicities.

Actually no, I think you have misunderstood what is happening at the
different layers involved here.

Your terminal is rendering =C3=9F as a glyph. But it is almost certainly
actually the octets C3 9F (which is the UTF8 canonical representation
of the codepoint U+DF). So the code you provided to perl is close to
the equivalent of

echo '=C3=86var' | perl -ne 'print $_ if /[Ss\x{C3}\x{9F}]/'

And if you check, you will see that U+C6 "=C3=86" in utf8 is represented as
the octets C3 86.

So what you have done is the equivalent of:

perl -le'print "\x{C3}\x{86}"' | perl -ne'print $_ if /[Ss\x{C3}\x{9F}]/'

which of course matches. \x{C3} matches \x{C3} always and everywhere.

What you should have done is something like this:

$ echo '=C3=86var' | perl -ne 'utf8::decode($_); print $_ if /[Ss\x{DF}]/u'
$ echo 'ba=C3=9F' | perl -MEncode -ne 'utf8::decode($_); print
encode_utf8($_) if /[Ss\x{DF}]/u'
ba=C3=9F
$ echo '=C3=86var' | perl -MEncode -ne 'utf8::decode($_); print
encode_utf8($_) if /[Ss\x{C6}]/u'
=C3=86var
$ echo '=C3=86var' | perl -MEncode -ne 'utf8::decode($_); print
encode_utf8($_) if /[Ss\x{e6}]/ui'
=C3=86var

The "utf8::decode($_)" tells perl to decode the input string as though
it contained utf8 (which in this case it does). THe /u suffix tells
the regex engine that you want Unicode semantics.

I believe that the same thing is true of your pcre2grep example. You
simply aren't checking what you think you are checking. You terminal
renders UTF8 as glyphs, but the programs you are feeding those glyphs
to aren't seeing glyphs, they are seeing UTF8 sequences as distinct
octets, and are not decoding their input back as codepoints.

You could have checked your assumptions by using the -Mre=3Ddebug option to=
 perl:

$ echo '=C3=86var' | perl -Mre=3Ddebug -ne 'print $_ if /[Ss=C3=9F]/'
Compiling REx "[Ss%x{c3}%x{9f}]"
Final program:
   1: ANYOF[Ss\x9F\xC3] (11)
  11: END (0)
stclass ANYOF[Ss\x9F\xC3] minlen 1
Matching REx "[Ss%x{c3}%x{9f}]" against "%x{c3}%x{86}var%n"
Matching stclass ANYOF[Ss\x9F\xC3] against "%x{c3}%x{86}var%n" (6 bytes)
   0 <> <%x{c3}>             |   0| 1:ANYOF[Ss\x9F\xC3](11)
   1 <%x{c3}> <%x{86}var>    |   0| 11:END(0)
Match successful!
=C3=86var
Freeing REx: "[Ss%x{c3}%x{9f}]"

The line: Matching REx "[Ss%x{c3}%x{9f}]" against "%x{c3}%x{86}var%n"

basically says it all. Perl has not decoded the UTF8 into U+C6, and it
has not decoded the UTF8 for U+DF either. Instead you have asked it if
the UTF8 sequence that represents U+C6 contains any of the same octets
as the UTF8 representation of U+53, U+73 and U+DF would. Which gives
the common octet of \x{c3}.

> For better Unicode handling one can use pcre2grep's -u or --utf option,
> which causes pcre2grep to behave more like GNU grep -P and git grep -P:
> "echo '=C3=86var' | pcre2grep -u '[Ss=C3=9F]'" outputs nothing, which I t=
hink is
> what most people would expect (unless they're Perl users :-).

It is what Perl users would expect also, assuming you actually wrote
the character class [Ss\x{DF}] and asked for unicode semantics. \x{DF}
is the Latin1 codepoint range, so perl will assume that you meant
ASCII semantics unless you tell it otherwise.

Basically these tests you have quoted here are just examples of
garbage in garbage out.

Perl has been working together with the Unicode consortium for over 20
years. Afaik we were and are the reference implementation for the spec
on regular expression matching in Unicode and we have a long history
of working together with the Unicode consortium to refine and
implement the spec. You should assume that if Perl seems to have made
a gross error in how it does Unicode matching that you are simply
using it wrong, we take a great deal of pride in having the best
Unicode support there is.

https://unicode.org/reports/tr18/

FWIW, i think this email nicely illustrates the issues with git and
regular expressions. To do regular expressions properly you need to
know a) what semantics do you expect, b) how to decode the text you
are matching against. If you want unicode semantics you need to have a
way to ask for it. If you want to match against Unicode data then you
need a way to determine which of the 6 possible encodings[1] of
Unicode data you are using. If you get either wrong you will not get
the results you expect.  You may even want to deal with cases where
you want Unicode semantics, but to match against non-unicode data. For
instance Latin-1. In Latin-1 the codepoint U+DF is the *octet* 0xDF.
Maybe you want that octet to match "ss" case-insensitively, as a
German speaker would expect and as Unicode specifies is correct.  Or
vice versa, maybe you are like some of the posters to this thread who
seem to expect that \d should not match U+16B51 (as a Hmong speaker
might expect). Perl resolves these problems at the pattern level by
supporting the suffixes /a and /u (for ascii and unicode), and at the
string level it supports two type of string, unicode strings, and
binary/ASCII strings. By default input is the latter but there are a
variety of ways of saying that a file handle should decode to Unicode
instead.

cheers,
Yves
[1] UTF-EBCDIC, UTF-8, UTF-16LE, UTF-16BE, UTF-32LE, UTF-32BE.




--
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
