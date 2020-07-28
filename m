Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFDAC433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615A920786
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P88bkbIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgG1UcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgG1UcG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:32:06 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1378C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 13:32:05 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c25so15875752otf.7
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 13:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tu/o+j2248hZ9BzEf3epMgeoMO2hLglbPwHs8OVj310=;
        b=P88bkbIKlDJr9ScXG8s7Ad5rFGJEkY45rC4H11lE1N9uJ7Mjc7N3fB/o14QjT/mvn1
         NHQL96YP4DD8lMtudEBzNuI7ByM+yV7HpRV061duTvwmzx+vZUC/UqZIfLXmbdVrAvCn
         5BaLlZ5ms3iCM7VPMCNWuSCubyzbB/MibovifgHEDGRNoteT9DrHtab0cukXlHznzL7D
         6VFaqNehev3JIbRE7NjeUoyOyKKTejnsguq7VwbrEcdPyGwzmMMs9H2AHYLqWqq/Pra2
         QPpckl4OkeGQz4JMkcSbm3dd7ydnrv6P8kMeT/yaOZS/uRDS0sX7oe2DWITIlD//7Lo8
         o6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tu/o+j2248hZ9BzEf3epMgeoMO2hLglbPwHs8OVj310=;
        b=LKHHWBfp0wehDkfcA25PD5Qq5NngqyyobWmB/WGD8xSCT/Yc/cF5Th+IwtI7D0IhMI
         aW4fmLx5pckr1L3nRFeNyLqA2vTfUJXsq/x0xrXubfQUfR9uIprWhXKaECp5qqghRjIP
         BwsmtQD3jfNf7LeKAkcS+T506v90A+Ngh0gUeBY3nLTY9HVXF8ZWlIYZmu3QQ6jVhBEe
         +W8iGO+xrVue+RZ1hBonxqF/lIBG1kATR0r64Vj+cUifGY2oHAZFgcdc3VPQvy2tgJzJ
         mBxXqX6uzBwYT7nZFIk2h0LQx1MX0/uvedCXjrBJOqK2G82jzvuKMnzxbweIBzk0Y/3v
         ETcQ==
X-Gm-Message-State: AOAM530XKzQNmu1rMaDdtCH6prMFyLY0OoWCXSe2SlF1mYQAhHtYhawU
        zkeHAWIlagxQo/R3/EO6FvWBtXW+0Zz72OBF7Iw=
X-Google-Smtp-Source: ABdhPJxe9fT6zsC/0Fm4zqPta2vxOQa/GhC3MwpueWj3IbmKt/VON5MRRU7a2DZdqxnbE4kd5WEneufzc3JACDYOshY=
X-Received: by 2002:a9d:7352:: with SMTP id l18mr23847265otk.177.1595968325021;
 Tue, 28 Jul 2020 13:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
 <aeb116c5aaaa23dfefbc7a6f4ac743a6f5a3ade8.1595882588.git.gitgitgadget@gmail.com>
 <xmqqeeowfu75.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeeowfu75.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Wed, 29 Jul 2020 02:01:53 +0530
Message-ID: <CA+CkUQ9nqW8=GuvNapsySf=EXm8c02qKV2xMrwvRY-Kd9Yy9mA@mail.gmail.com>
Subject: Re: [PATCH 1/5] ref-filter: support different email formats
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jul 28, 2020 at 4:21 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Hariom Verma <hariom18599@gmail.com>
> >
> > Currently, ref-filter only supports printing email with arrow brackets.
>
> This is the first time I heard the term "arrow bracket".  Aren't
> they more commonly called angle brackets?

Yeah. Sorry about that.

> > Let's add support for two more email options.
> > - trim : print email without arrow brackets.
>
> Why would this be useful?

It might be useful for using the ref-filter's logic in pretty.c
(especially for `--pretty` formats like `%an` and `%cn`)

> > - localpart : prints the part before the @ sign
>
> Meaning I'd get "<gitster" for me?

No, you'll get "gitster".

> Building small pieces of new feature in each patch is good, and
> adding tests to each step is also good.  Why not do the same for
> docs?

Yeah, I agree with you. I should have focused on documentation too.

> > +static struct email_option{
>
> Missing SP.

I'll fix it.

> > +     enum { EO_INVALID, EO_RAW, EO_TRIM, EO_LOCALPART } option;
> > +} email_option;
> > +
> > @@ -1040,10 +1044,26 @@ static const char *copy_email(const char *buf)
> >       const char *eoemail;
> >       if (!email)
> >               return xstrdup("");
> > -     eoemail = strchr(email, '>');
>
> The original code prepares to see NULL from this strchr(); that is
> why it checks eoemail for NULL and returns an empty string---the
> data is broken (i.e. not an address in angle brackets), which this
> code cannot do anything about---in the later part of the code.

I think this commit still takes care of NULL.
After the switch-case statements, code consists of:
```
if (!eoemail)
    return xstrdup("");
```
Which checks eoemail for NULL. And will return empty string if address
is not in angle brackets.
Same applies for local-part too. If '@' is not present in email
address, it will still return empty string.

> > +     switch (email_option.option) {
> > +     case EO_RAW:
> > +             eoemail = strchr(email, '>') + 1;
>
> And this breaks the carefully laid out error handling by the
> original code.  Adding 1 to NULL is quite undefined.

Yeah. I'll take care of it in the next version.

> > +             break;
> > +     case EO_TRIM:
> > +             email++;
> > +             eoemail = strchr(email, '>');
> > +             break;
> > +     case EO_LOCALPART:
> > +             email++;
> > +             eoemail = strchr(email, '@');
>
> The undocumented design here is that you want to return "hariom" for
> "<hariom@gmail.com>", i.e. out of the "trimmed" e-mail, the part
> before the at-sign is returned.
>
> If the data were "<hariom>", you'd still want to return "hariom" no?
> But because you do not check for NULL, you end up returning an empty
> string.

I never heard of email address without '@' symbol. Thats why I
returned empty string.

Will fix that too.

> I think you want to cut at the first '@' or '>', whichever comes
> first.

If email data can be without '@' symbol, then I guess "yes".

> > +             break;
> > +     case EO_INVALID:
> > +     default:
>
> Invalid and unhandled ones are silently ignored and not treated as
> an error?  I would have thought that at least the "default" one
> would be a BUG(), as you covered all the possible values for the
> enum with case arms.  I wouldn't be surprised if seeing EO_INVALID
> is also a BUG(), i.e. the control flow that led to the caller to
> call this function with EO_INVALID in email_option.option is likely
> to be broken.  It's not like you return "" to protect yourself when
> fed a bad data from objects---a bad value in .option can only come
> here if the parser you wrote for "--format=<string>" produced a
> wrong result.

Christian <chriscool@tuxfamily.org> also suggested me the same. Will
fix this too.

BTW, on master "{author,committer,tagger}email:<xyz>" does not print any error.

> > +             return xstrdup("");
> > +     }
> > +
> >       if (!eoemail)
> >               return xstrdup("");
> > -     return xmemdupz(email, eoemail + 1 - email);
> > +     return xmemdupz(email, eoemail - email);
> >  }
> >
> >  static char *copy_subject(const char *buf, unsigned long len)
> > @@ -1113,7 +1133,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
> >                       continue;
> >               if (name[wholen] != 0 &&
> >                   strcmp(name + wholen, "name") &&
> > -                 strcmp(name + wholen, "email") &&
> > +                 !starts_with(name + wholen, "email") &&
> >                   !starts_with(name + wholen, "date"))
> >                       continue;
> >               if (!wholine)
> > @@ -1124,8 +1144,16 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
> >                       v->s = copy_line(wholine);
> >               else if (!strcmp(name + wholen, "name"))
> >                       v->s = copy_name(wholine);
> > -             else if (!strcmp(name + wholen, "email"))
> > +             else if (starts_with(name + wholen, "email")) {
> > +                     email_option.option = EO_INVALID;
> > +                     if (!strcmp(name + wholen, "email"))
> > +                             email_option.option = EO_RAW;
> > +                     if (!strcmp(name + wholen, "email:trim"))
> > +                             email_option.option = EO_TRIM;
> > +                     if (!strcmp(name + wholen, "email:localpart"))
> > +                             email_option.option = EO_LOCALPART;
>
> The ref-filter formatting language already knows many "colon plus
> modifier" suffix like "refname:short" and "contents:body", but I do
> not think we have ugly repetition like the above code to parse them.
> Perhaps the addition for "email:<whatever>" can benefit from
> studying and mimicking existing practices a bit more?
>

For "email:<whatever>",
even If I parse that <whatever>. I still make comparison something like:
```
if (!modifier)
    email_option.option = EO_RAW;
else if (!strcmp(modifier, "trim"))
    email_option.option = EO_TRIM;
else if (!strcmp(arg, "localpart"))
    email_option.option = EO_LOCALPART;
```

Thanks,
Hariom
