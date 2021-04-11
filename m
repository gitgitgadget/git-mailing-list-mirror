Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70478C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 15:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4188F611AD
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 15:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhDKPIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 11:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhDKPIK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 11:08:10 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0678C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 08:07:53 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso5668133otv.6
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPQbD94iqI+TLNf+BkoGAgH+I2ioFgyN4zMqyBH68+o=;
        b=ckpiwO4XcL7fVxVL4kNuatM6h9zTPSkdYkjTUitGq+bEgyC8BPk+8QpwKkVN0j90Qr
         /1OOCSheV5UVKUzoDxdqzhQFLGgb+YaPknBebQkfpL3V0nu+ama/6RuA2AXXENHrmYpR
         wJxem3vc+5oi7yssOj04alwaPh15GvCzh1dl1NZY/mYWw+EdvaBoqB7sGOPURvzPKHnl
         wGnHgk+3mCur2MogYJqDaFaRqzJvBSisXtDf5i6gl61JIWCQMEweymX1LedvWilfp7eh
         yK+tafn/90lKbxUtZVy5NwN44FbsVwTVFXXG9yCDSafxZ3aagtqqypYMmRGZlnw3wDHc
         PwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPQbD94iqI+TLNf+BkoGAgH+I2ioFgyN4zMqyBH68+o=;
        b=eDMjoaafsdaY/FXq+VvEaxNlA4FsplX3iBYiYaJ+/ZHmLTkVhoqNqKNRozniAP6DQH
         SmJLkHDyS8PyTJTT1ZPsQ044rUaNBN2H2zNuob/FJwyGpqsHSpnH/7QgtzCUO8pCqVJf
         dLPCn8mn7+ZpLal/rMs6TA/4elgbKju9VPHn++mfn9ZYVzlRb0Lz+L2FhdYqyeMmVkvw
         yTzFCHwn4ZQH9yC+ikV6SdfjKPskNtx0t4xQ83/t+aD8v0FmD4AKkafJ5zHx2Vi1g/Kn
         44bq0Y0yIAFzMNmR3u6eBeV3GJ7dQLmBowGjVc7A+5Y8IlqYOOE6+iZxXEd0EujDPBJp
         vXqg==
X-Gm-Message-State: AOAM530rW6R8peZ39fkMLdLAYR26ggLJ5Yn372vQWDEbBXOAzXV0UHjT
        SZdaSt9D4jXyfGDCZpP7RnEkqw7MhqJljuauzaaZBP8mMG3QHQ==
X-Google-Smtp-Source: ABdhPJxo+agRtfwBzAls3UwCo3O2aM+lO+p2n11N+56YQJM5QZ13iTW8Z4+lkiAR2m4zJPN6NvhfkU9USpXekJQ3Mmg=
X-Received: by 2002:a9d:740c:: with SMTP id n12mr19878054otk.21.1618153672917;
 Sun, 11 Apr 2021 08:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210326024411.28615-1-stdedos+git@gmail.com> <20210403122604.19203-1-133706+stdedos@users.noreply.github.com>
 <xmqqr1jq7bzc.fsf@gitster.g>
In-Reply-To: <xmqqr1jq7bzc.fsf@gitster.g>
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Sun, 11 Apr 2021 18:07:16 +0300
Message-ID: <CAHMHMxUVy4MUarT-q5EHwf_6cPNn+TSmNDuQbuxXvYPpnQTmpg@mail.gmail.com>
Subject: Re: [PATCH v3] pathspec: advice: long and short forms are incompatible
To:     git <git@vger.kernel.org>
Cc:     =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos+git@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000dde88005bfb3c243"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000dde88005bfb3c243
Content-Type: text/plain; charset="UTF-8"

Hello there,

Implemented the last fixes

> > Signed-off-by: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
>
> The sign-off name and address must match the name and address of the
> patch author (i.e. "Stavros Ntentos <stdedos@gmail.com>").

The author *is* Stavros Ntentos <133706+stdedos@users.noreply.github.com>;
I don't know why it is messed up. Maybe if I send the patch as an
attachment instead.

With regards,
Ntentos Stavros

On Sun, 4 Apr 2021 at 10:19, Junio C Hamano <gitster@pobox.com> wrote:
>
> Stavros Ntentos <stdedos@gmail.com> writes:
>
> > It can be a "reasonable" mistake to mix short and long forms,
> > e.g. `:!(glob)`, instead of the (correct) `:(exclude,glob)`.
>
> The word "form" may be sufficient for today's us because we have
> been so focused on this particular pathspec magic issue.
>
> But reviewers are not, and those who read the "git log" output later
> are not, either.  Let's be friendly and helpful to them by saying
> "form of pathspec magic" or somesuch.
>
> The same comment applies to the patch title.
>
> It also might be more friendly to readers what the mistaken form
> would do, too.
>
> Here is my attempt, taking all of the above into account.
>
>     It is a hard-to-notice mistake to try mixing short and long
>     forms of pathspec magic, e.g. instead of ':(exclude,glob)', it
>     may be tempting to write ':!(glob)', which stops at ":!",
>     i.e. the end of the short-form pathspec magic, and the "(glob)"
>     is taken as the beginning part of the pathspec, wanting to match
>     a file or a directory whose name begins with that literal string.
>
> > Teach git to issue an advice when such a pathspec is given.
> >         i.e.: While in short form parsing:
> >         * if the string contains an open parenthesis [`(`], and
> >         * without having explicitly terminated magic parsing (`:`)
> >         issue an advice hinting to that fact.
>
> OK.
>
> > Based on "Junio C Hamano <gitster@pobox.com>"'s code suggestions:
> > * https://lore.kernel.org/git/xmqqa6qoqw9n.fsf@gitster.g/
> > * https://lore.kernel.org/git/xmqqo8f0cr9z.fsf@gitster.g/
>
> It is sufficient to just write a single line
>
>         Helped-by: Junio C Hamano <gitster@pobox.com>
>
> immediately before your sign-off, I would think.
>
> > Signed-off-by: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
>
> The sign-off name and address must match the name and address of the
> patch author (i.e. "Stavros Ntentos <stdedos@gmail.com>").
>
> > +     mixedPathspecMagic::
> > +             Advice shown if a user tries to mix short- and
> > +             longform pathspec magic.
>
> Good.  Here the phrase "pathspec magic" is used.
>
> > +/*
> > + * Give hint for a common mistake of mixing short and long
> > + * form of pathspec magic, as well as possible corrections
> > + */
> > +static void warn_mixed_magic(unsigned magic, const char *elem, const char *pos)
> > +{
> > +     struct strbuf longform = STRBUF_INIT;
> > +     int i;
> > +
> > +     if (!advice_enabled(ADVICE_MIXED_PATHSPEC_MAGIC))
> > +             return;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
> > +             if (pathspec_magic[i].bit & magic) {
> > +                     if (longform.len)
> > +                             strbuf_addch(&longform, ',');
> > +                     strbuf_addstr(&longform, pathspec_magic[i].name);
> > +             }
> > +     }
>
> OK, so we are collecting the ones given by the short form so far.
> For e.g. ":!(glob)", we write "exclude" in the longform buffer.  If
> we had more than one, then before adding the second one, we add a
> comma, so we may see "top,exclude" for ":/!(glob)".  Good.
>
> > +     advise_if_enabled(ADVICE_MIXED_PATHSPEC_MAGIC,
> > +                       _("'%.*s(...': cannot mix short- and longform pathspec magic!\n"
>
> Do we need to "shout!"?  I think a normal full-stop would be sufficient.
>
> 'elem' is pointing at ':', 'pos' is where we read '(' from, so
> the above gives us "':/!(...': cannot..." for "':/!(glob)".  OK.
>
> > +                         "Either spell the shortform magic '%.*s' as ':(%s,...'\n"
>
> Here, the shortform %.*s excludes the ':' that introduced the magic,
> so we would see "shortform magic '/!' as ':(top,exclude,...'".  Good.
>
> > +                         "or end magic pathspec matching with '%.*s:'."),
>
> This one I am not sure about.  Something like
>
>     $ git add -- ":!(0) preface.txt" \*.txt
>
> may be plausible, albeit rare, and it may be a good advice to
> explicitly terminate the shortform pathspec magic before the '(' in
> such a case.
>
> But presumably it is much rarer for '(' to be a part of a pathspec
> element than an attempt to introduce a longform magic, it might be
> worth spending an extra line to explain in what narrow cases the
> latter choice may make sense.  Here is my attempt.
>
>     or if '(...' is indeed the beginning of a pathname, end the shortform
>     magic sequence explicitly with another ':' before it, e.g. '%.*s:(...'
>
>
> > +                       (int)(pos - elem), elem,
> > +                       (int)(pos - (elem + 1)), elem + 1,
> > +                       longform.buf,
> > +                       (int)(pos - elem), elem);
> > +}
> >  /*
> >   * Parse the pathspec element looking for short magic
> >   *
> > @@ -356,6 +386,9 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
> >                       continue;
> >               }
> >
> > +             if (ch == '(')
> > +                     warn_mixed_magic(*magic, elem, pos);
> > +
> >               if (!is_pathspec_magic(ch))
> >                       break;
> >
> > diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
> > index 30328b87f0..8b9d543e1e 100755
> > --- a/t/t6132-pathspec-exclude.sh
> > +++ b/t/t6132-pathspec-exclude.sh
> > @@ -244,4 +244,42 @@ test_expect_success 'grep --untracked PATTERN :(exclude)*FILE' '
> >       test_cmp expect-grep actual-grep
> >  '
> >
> > +cat > expected_warn <<"EOF"
> > +hint: ':!(...': cannot mix short- and longform pathspec magic!
> > +hint: Either spell the shortform magic '!' as ':(exclude,...'
> > +hint: or end magic pathspec matching with ':!:'.
> > +hint: Disable this message with "git config advice.mixedPathspecMagic false"
> > +EOF
> > +test_expect_success 'warn pathspec not matching longform magic in :!(...)' '
> > +     git log --oneline --format=%s -- '"'"':!(glob)**/file'"'"' >actual 2>warn &&
> > +     cat <<EOF >expect &&
> > +sub2/file
> > +sub/sub/sub/file
> > +sub/file2
> > +sub/sub/file
> > +sub/file
> > +file
> > +EOF
> > +     cat actual &&
> > +     cat warn &&
>
> Are these leftover debugging aid?
>
> > +     test_cmp expect actual &&
> > +     test_cmp expected_warn warn
> > +'
> > +
> > +test_expect_success 'do not warn pathspec not matching longform magic in :!:(...) (i.e. if magic parsing is explicitly stopped)' '
> > +     git log --oneline --format=%s -- '"'"':!:(glob)**/file'"'"' >actual 2>warn &&
> > +     cat <<EOF >expect &&
> > +sub2/file
> > +sub/sub/sub/file
> > +sub/file2
> > +sub/sub/file
> > +sub/file
> > +file
> > +EOF
> > +     cat actual &&
> > +     cat warn &&
>
> Are these leftover debugging aid?
>
> > +     test_cmp expect actual &&
> > +     ! test_cmp expected_warn warn
> > +'
> > +
> >  test_done
>
>
> Thanks.

--000000000000dde88005bfb3c243
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v4-0001-pathspec-advice-long-and-short-form-of-pathspec-m.patch"
Content-Disposition: attachment; 
	filename="v4-0001-pathspec-advice-long-and-short-form-of-pathspec-m.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kndavwnm0>
X-Attachment-Id: f_kndavwnm0

RnJvbSBlZGI0YWYwMDk3OTEyNGM4Y2MxNjc0YTVhZDc2Zjk2MzRmNzRkNDJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGF2cm9zIE50ZW50b3MgPDEzMzcwNitzdGRlZG9zQHVzZXJz
Lm5vcmVwbHkuZ2l0aHViLmNvbT4KRGF0ZTogU3VuLCAyOCBNYXIgMjAyMSAxNTo1Mzo1MCArMDMw
MApTdWJqZWN0OiBbUEFUQ0ggdjRdIHBhdGhzcGVjOiBhZHZpY2U6IGxvbmcgYW5kIHNob3J0IGZv
cm0gb2YgcGF0aHNwZWMgbWFnaWMKIGFyZSBpbmNvbXBhdGlibGUKCkl0IGlzIGEgaGFyZC10by1u
b3RpY2UgbWlzdGFrZSB0byB0cnkgbWl4aW5nIHNob3J0IGFuZCBsb25nCmZvcm1zIG9mIHBhdGhz
cGVjIG1hZ2ljLCBlLmcuIGluc3RlYWQgb2YgJzooZXhjbHVkZSxnbG9iKScsIGl0Cm1heSBiZSB0
ZW1wdGluZyB0byB3cml0ZSAnOiEoZ2xvYiknLgpUaGUgZW5kIG9mIHRoZSBzaG9ydC1mb3JtIHBh
dGhzcGVjIG1hZ2ljIChgOiFgKSwgYW5kIHRoZSBgKGdsb2IpYAppcyB0YWtlbiBhcyB0aGUgYmVn
aW5uaW5nIHBhcnQgb2YgdGhlIHBhdGhzcGVjLCB3YW50aW5nIHRvIG1hdGNoCmEgZmlsZSBvciBh
IGRpcmVjdG9yeSB3aG9zZSBuYW1lIGJlZ2lucyB3aXRoIHRoYXQgbGl0ZXJhbCBzdHJpbmcuCgpU
ZWFjaCBnaXQgdG8gaXNzdWUgYW4gYWR2aWNlIHdoZW4gc3VjaCBhIHBhdGhzcGVjIGlzIGdpdmVu
LgogICAgICAgIGkuZS46IFdoaWxlIGluIHNob3J0IGZvcm0gcGFyc2luZzoKICAgICAgICAqIGlm
IHRoZSBwYXJzaW5nIGlzIG5vdCBleHBsaWNpdGx5IHRlcm1pbmF0ZWQgd2l0aCBgOmAsIGFuZAog
ICAgICAgICogaWYgdGhlIHN0cmluZyBjb250YWlucyBhbiBvcGVuIHBhcmVudGhlc2lzIFtgKGBd
CiAgICAgICAgaXNzdWUgYW4gYWR2aWNlIGhpbnRpbmcgdG8gdGhhdCBmYWN0LgoKSGVscGVkLWJ5
OiBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0YXZy
b3MgTnRlbnRvcyA8MTMzNzA2K3N0ZGVkb3NAdXNlcnMubm9yZXBseS5naXRodWIuY29tPgotLS0K
IERvY3VtZW50YXRpb24vY29uZmlnL2FkdmljZS50eHQgfCAgMyArKysKIGFkdmljZS5jICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMyArKysKIGFkdmljZS5oICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMiArKwogcGF0aHNwZWMuYyAgICAgICAgICAgICAgICAgICAgICB8IDM0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrCiB0L3Q2MTMyLXBhdGhzcGVjLWV4Y2x1ZGUuc2ggICAg
IHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiA1IGZpbGVzIGNoYW5nZWQs
IDc3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2NvbmZpZy9hZHZp
Y2UudHh0IGIvRG9jdW1lbnRhdGlvbi9jb25maWcvYWR2aWNlLnR4dAppbmRleCBhY2JkMGMwOWFh
Li4wNWEzY2JjMTY0IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2NvbmZpZy9hZHZpY2UudHh0
CisrKyBiL0RvY3VtZW50YXRpb24vY29uZmlnL2FkdmljZS50eHQKQEAgLTExOSw0ICsxMTksNyBA
QCBhZHZpY2UuKjo6CiAJYWRkRW1wdHlQYXRoc3BlYzo6CiAJCUFkdmljZSBzaG93biBpZiBhIHVz
ZXIgcnVucyB0aGUgYWRkIGNvbW1hbmQgd2l0aG91dCBwcm92aWRpbmcKIAkJdGhlIHBhdGhzcGVj
IHBhcmFtZXRlci4KKwltaXhlZFBhdGhzcGVjTWFnaWM6OgorCQlBZHZpY2Ugc2hvd24gaWYgYSB1
c2VyIHRyaWVzIHRvIG1peCBzaG9ydC0gYW5kCisJCWxvbmdmb3JtIHBhdGhzcGVjIG1hZ2ljLgog
LS0KZGlmZiAtLWdpdCBhL2FkdmljZS5jIGIvYWR2aWNlLmMKaW5kZXggMTY0NzQyMzA1Zi4uYjE5
NTU5NjZkNSAxMDA2NDQKLS0tIGEvYWR2aWNlLmMKKysrIGIvYWR2aWNlLmMKQEAgLTMzLDYgKzMz
LDcgQEAgaW50IGFkdmljZV9jaGVja291dF9hbWJpZ3VvdXNfcmVtb3RlX2JyYW5jaF9uYW1lID0g
MTsKIGludCBhZHZpY2Vfc3VibW9kdWxlX2FsdGVybmF0ZV9lcnJvcl9zdHJhdGVneV9kaWUgPSAx
OwogaW50IGFkdmljZV9hZGRfaWdub3JlZF9maWxlID0gMTsKIGludCBhZHZpY2VfYWRkX2VtcHR5
X3BhdGhzcGVjID0gMTsKK2ludCBhZHZpY2VfbWl4ZWRfcGF0aHNwZWNfbWFnaWMgPSAxOwogCiBz
dGF0aWMgaW50IGFkdmljZV91c2VfY29sb3IgPSAtMTsKIHN0YXRpYyBjaGFyIGFkdmljZV9jb2xv
cnNbXVtDT0xPUl9NQVhMRU5dID0gewpAQCAtOTUsNiArOTYsNyBAQCBzdGF0aWMgc3RydWN0IHsK
IAl7ICJzdWJtb2R1bGVBbHRlcm5hdGVFcnJvclN0cmF0ZWd5RGllIiwgJmFkdmljZV9zdWJtb2R1
bGVfYWx0ZXJuYXRlX2Vycm9yX3N0cmF0ZWd5X2RpZSB9LAogCXsgImFkZElnbm9yZWRGaWxlIiwg
JmFkdmljZV9hZGRfaWdub3JlZF9maWxlIH0sCiAJeyAiYWRkRW1wdHlQYXRoc3BlYyIsICZhZHZp
Y2VfYWRkX2VtcHR5X3BhdGhzcGVjIH0sCisJeyAibWl4ZWRQYXRoc3BlY01hZ2ljIiwgJmFkdmlj
ZV9taXhlZF9wYXRoc3BlY19tYWdpYyB9LAogCiAJLyogbWFrZSB0aGlzIGFuIGFsaWFzIGZvciBi
YWNrd2FyZCBjb21wYXRpYmlsaXR5ICovCiAJeyAicHVzaE5vbkZhc3RGb3J3YXJkIiwgJmFkdmlj
ZV9wdXNoX3VwZGF0ZV9yZWplY3RlZCB9CkBAIC0xMzcsNiArMTM5LDcgQEAgc3RhdGljIHN0cnVj
dCB7CiAJW0FEVklDRV9TVEFUVVNfVV9PUFRJT05dCQkJPSB7ICJzdGF0dXNVb3B0aW9uIiwgMSB9
LAogCVtBRFZJQ0VfU1VCTU9EVUxFX0FMVEVSTkFURV9FUlJPUl9TVFJBVEVHWV9ESUVdID0geyAi
c3VibW9kdWxlQWx0ZXJuYXRlRXJyb3JTdHJhdGVneURpZSIsIDEgfSwKIAlbQURWSUNFX1dBSVRJ
TkdfRk9SX0VESVRPUl0JCQk9IHsgIndhaXRpbmdGb3JFZGl0b3IiLCAxIH0sCisJW0FEVklDRV9N
SVhFRF9QQVRIU1BFQ19NQUdJQ10JCQk9IHsgIm1peGVkUGF0aHNwZWNNYWdpYyIsIDEgfSwKIH07
CiAKIHN0YXRpYyBjb25zdCBjaGFyIHR1cm5fb2ZmX2luc3RydWN0aW9uc1tdID0KZGlmZiAtLWdp
dCBhL2FkdmljZS5oIGIvYWR2aWNlLmgKaW5kZXggYmMyNDMyOTgwYS4uYWEyMjlmZGVkOCAxMDA2
NDQKLS0tIGEvYWR2aWNlLmgKKysrIGIvYWR2aWNlLmgKQEAgLTMzLDYgKzMzLDcgQEAgZXh0ZXJu
IGludCBhZHZpY2VfY2hlY2tvdXRfYW1iaWd1b3VzX3JlbW90ZV9icmFuY2hfbmFtZTsKIGV4dGVy
biBpbnQgYWR2aWNlX3N1Ym1vZHVsZV9hbHRlcm5hdGVfZXJyb3Jfc3RyYXRlZ3lfZGllOwogZXh0
ZXJuIGludCBhZHZpY2VfYWRkX2lnbm9yZWRfZmlsZTsKIGV4dGVybiBpbnQgYWR2aWNlX2FkZF9l
bXB0eV9wYXRoc3BlYzsKK2V4dGVybiBpbnQgYWR2aWNlX21peGVkX3BhdGhzcGVjX21hZ2ljOwog
CiAvKgogICogVG8gYWRkIGEgbmV3IGFkdmljZSwgeW91IG5lZWQgdG86CkBAIC03Miw2ICs3Myw3
IEBAIGV4dGVybiBpbnQgYWR2aWNlX2FkZF9lbXB0eV9wYXRoc3BlYzsKIAlBRFZJQ0VfU1RBVFVT
X1VfT1BUSU9OLAogCUFEVklDRV9TVUJNT0RVTEVfQUxURVJOQVRFX0VSUk9SX1NUUkFURUdZX0RJ
RSwKIAlBRFZJQ0VfV0FJVElOR19GT1JfRURJVE9SLAorCUFEVklDRV9NSVhFRF9QQVRIU1BFQ19N
QUdJQywKIH07CiAKIGludCBnaXRfZGVmYXVsdF9hZHZpY2VfY29uZmlnKGNvbnN0IGNoYXIgKnZh
ciwgY29uc3QgY2hhciAqdmFsdWUpOwpkaWZmIC0tZ2l0IGEvcGF0aHNwZWMuYyBiL3BhdGhzcGVj
LmMKaW5kZXggMThiM2JlMzYyYS4uZGE1NjBhYzdhZCAxMDA2NDQKLS0tIGEvcGF0aHNwZWMuYwor
KysgYi9wYXRoc3BlYy5jCkBAIC0zMzYsNiArMzM2LDM3IEBAIHN0YXRpYyBjb25zdCBjaGFyICpw
YXJzZV9sb25nX21hZ2ljKHVuc2lnbmVkICptYWdpYywgaW50ICpwcmVmaXhfbGVuLAogCXJldHVy
biBwb3M7CiB9CiAKKworLyoKKyAqIEdpdmUgaGludCBmb3IgYSBjb21tb24gbWlzdGFrZSBvZiBt
aXhpbmcgc2hvcnQgYW5kIGxvbmcKKyAqIGZvcm0gb2YgcGF0aHNwZWMgbWFnaWMsIGFzIHdlbGwg
YXMgcG9zc2libGUgY29ycmVjdGlvbnMKKyAqLworc3RhdGljIHZvaWQgd2Fybl9taXhlZF9tYWdp
Yyh1bnNpZ25lZCBtYWdpYywgY29uc3QgY2hhciAqZWxlbSwgY29uc3QgY2hhciAqcG9zKQorewor
CXN0cnVjdCBzdHJidWYgbG9uZ2Zvcm0gPSBTVFJCVUZfSU5JVDsKKwlpbnQgaTsKKworCWlmICgh
YWR2aWNlX2VuYWJsZWQoQURWSUNFX01JWEVEX1BBVEhTUEVDX01BR0lDKSkKKwkJcmV0dXJuOwor
CisJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUocGF0aHNwZWNfbWFnaWMpOyBpKyspIHsKKwkJ
aWYgKHBhdGhzcGVjX21hZ2ljW2ldLmJpdCAmIG1hZ2ljKSB7CisJCQlpZiAobG9uZ2Zvcm0ubGVu
KQorCQkJCXN0cmJ1Zl9hZGRjaCgmbG9uZ2Zvcm0sICcsJyk7CisJCQlzdHJidWZfYWRkc3RyKCZs
b25nZm9ybSwgcGF0aHNwZWNfbWFnaWNbaV0ubmFtZSk7CisJCX0KKwl9CisJYWR2aXNlX2lmX2Vu
YWJsZWQoQURWSUNFX01JWEVEX1BBVEhTUEVDX01BR0lDLAorCSAgICAgICAgICAgICAgICAgIF8o
IiclLipzKC4uLic6IGNhbm5vdCBtaXggc2hvcnQtIGFuZCBsb25nZm9ybSBwYXRoc3BlYyBtYWdp
Yy5cbiIKKwkgICAgICAgICAgICAgICAgICAgICJFaXRoZXIgc3BlbGwgdGhlIHNob3J0Zm9ybSBt
YWdpYyAnJS4qcycgYXMgJzooJXMsLi4uJyxcbiIKKwkgICAgICAgICAgICAgICAgICAgICJvciBp
ZiAnKC4uLicgaXMgaW5kZWVkIHRoZSBiZWdpbm5pbmcgb2YgYSBwYXRobmFtZSwgZW5kIHRoZSBz
aG9ydGZvcm1cbiIKKwkgICAgICAgICAgICAgICAgICAgICJtYWdpYyBzZXF1ZW5jZSBleHBsaWNp
dGx5IHdpdGggYW5vdGhlciAnOicgYmVmb3JlIGl0LCBlLmcuICclLipzOiguLi4nLiIpLAorCSAg
ICAgICAgICAgICAgICAgIChpbnQpKHBvcyAtIGVsZW0pLCBlbGVtLAorCSAgICAgICAgICAgICAg
ICAgIChpbnQpKHBvcyAtIChlbGVtICsgMSkpLCBlbGVtICsgMSwKKwkgICAgICAgICAgICAgICAg
ICBsb25nZm9ybS5idWYsCisJICAgICAgICAgICAgICAgICAgKGludCkocG9zIC0gZWxlbSksIGVs
ZW0pOworfQorCiAvKgogICogUGFyc2UgdGhlIHBhdGhzcGVjIGVsZW1lbnQgbG9va2luZyBmb3Ig
c2hvcnQgbWFnaWMKICAqCkBAIC0zNTYsNiArMzg3LDkgQEAgc3RhdGljIGNvbnN0IGNoYXIgKnBh
cnNlX3Nob3J0X21hZ2ljKHVuc2lnbmVkICptYWdpYywgY29uc3QgY2hhciAqZWxlbSkKIAkJCWNv
bnRpbnVlOwogCQl9CiAKKwkJaWYgKGNoID09ICcoJykKKwkJCXdhcm5fbWl4ZWRfbWFnaWMoKm1h
Z2ljLCBlbGVtLCBwb3MpOworCiAJCWlmICghaXNfcGF0aHNwZWNfbWFnaWMoY2gpKQogCQkJYnJl
YWs7CiAKZGlmZiAtLWdpdCBhL3QvdDYxMzItcGF0aHNwZWMtZXhjbHVkZS5zaCBiL3QvdDYxMzIt
cGF0aHNwZWMtZXhjbHVkZS5zaAppbmRleCAzMDMyOGI4N2YwLi5lMzliMDY4Njg2IDEwMDc1NQot
LS0gYS90L3Q2MTMyLXBhdGhzcGVjLWV4Y2x1ZGUuc2gKKysrIGIvdC90NjEzMi1wYXRoc3BlYy1l
eGNsdWRlLnNoCkBAIC0yNDQsNCArMjQ0LDM5IEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2dyZXAg
LS11bnRyYWNrZWQgUEFUVEVSTiA6KGV4Y2x1ZGUpKkZJTEUnICcKIAl0ZXN0X2NtcCBleHBlY3Qt
Z3JlcCBhY3R1YWwtZ3JlcAogJwogCitjYXQgPiBleHBlY3RlZF93YXJuIDw8IkVPRiIKK2hpbnQ6
ICc6ISguLi4nOiBjYW5ub3QgbWl4IHNob3J0LSBhbmQgbG9uZ2Zvcm0gcGF0aHNwZWMgbWFnaWMu
CitoaW50OiBFaXRoZXIgc3BlbGwgdGhlIHNob3J0Zm9ybSBtYWdpYyAnIScgYXMgJzooZXhjbHVk
ZSwuLi4nLAoraGludDogb3IgaWYgJyguLi4nIGlzIGluZGVlZCB0aGUgYmVnaW5uaW5nIG9mIGEg
cGF0aG5hbWUsIGVuZCB0aGUgc2hvcnRmb3JtCitoaW50OiBtYWdpYyBzZXF1ZW5jZSBleHBsaWNp
dGx5IHdpdGggYW5vdGhlciAnOicgYmVmb3JlIGl0LCBlLmcuICc6ITooLi4uJy4KK2hpbnQ6IERp
c2FibGUgdGhpcyBtZXNzYWdlIHdpdGggImdpdCBjb25maWcgYWR2aWNlLm1peGVkUGF0aHNwZWNN
YWdpYyBmYWxzZSIKK0VPRgordGVzdF9leHBlY3Rfc3VjY2VzcyAnd2FybiBwYXRoc3BlYyBub3Qg
bWF0Y2hpbmcgbG9uZ2Zvcm0gbWFnaWMgaW4gOiEoLi4uKScgJworCWdpdCBsb2cgLS1vbmVsaW5l
IC0tZm9ybWF0PSVzIC0tICciJyInOiEoZ2xvYikqKi9maWxlJyInIicgPmFjdHVhbCAyPndhcm4g
JiYKKwljYXQgPDxFT0YgPmV4cGVjdCAmJgorc3ViMi9maWxlCitzdWIvc3ViL3N1Yi9maWxlCitz
dWIvZmlsZTIKK3N1Yi9zdWIvZmlsZQorc3ViL2ZpbGUKK2ZpbGUKK0VPRgorCXRlc3RfY21wIGV4
cGVjdCBhY3R1YWwgJiYKKwl0ZXN0X2NtcCBleHBlY3RlZF93YXJuIHdhcm4KKycKKwordGVzdF9l
eHBlY3Rfc3VjY2VzcyAnZG8gbm90IHdhcm4gcGF0aHNwZWMgbm90IG1hdGNoaW5nIGxvbmdmb3Jt
IG1hZ2ljIGluIDohOiguLi4pIChpLmUuIGlmIG1hZ2ljIHBhcnNpbmcgaXMgZXhwbGljaXRseSBz
dG9wcGVkKScgJworCWdpdCBsb2cgLS1vbmVsaW5lIC0tZm9ybWF0PSVzIC0tICciJyInOiE6KGds
b2IpKiovZmlsZSciJyInID5hY3R1YWwgMj53YXJuICYmCisJY2F0IDw8RU9GID5leHBlY3QgJiYK
K3N1YjIvZmlsZQorc3ViL3N1Yi9zdWIvZmlsZQorc3ViL2ZpbGUyCitzdWIvc3ViL2ZpbGUKK3N1
Yi9maWxlCitmaWxlCitFT0YKKwl0ZXN0X2NtcCBleHBlY3QgYWN0dWFsICYmCisJISB0ZXN0X2Nt
cCBleHBlY3RlZF93YXJuIHdhcm4KKycKKwogdGVzdF9kb25lCi0tIAoyLjMxLjEKCg==
--000000000000dde88005bfb3c243--
