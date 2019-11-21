Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63CEC432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 19:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820592068F
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 19:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmBMOHRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKUT4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:56:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45917 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUT4G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 14:56:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so2235124pfn.12
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 11:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xLLAjARKxRthxAgJLnq6EHchMIsXs9Ka+l6EFh4CbDo=;
        b=YmBMOHRdAwvo+gL3npzZjvSn/vXRQi6DQ3//8cci530SFifPNPuIvEecOqpDtJgYEJ
         2UeGjbZJWHWqkRbXd8TNu8uLQbwQXidFg1eYek7b9W0zZFsr0D8T68vgQwZWrjJZ0Yls
         wds7B+SKHXP4PCqBikQ/zloLCr6hmksCu4YtPXYN8CCG12C2oMle+/ji06om8nUCvgO8
         589q4VgNjETa4kqRwm8DR8ToGm9p8cfN/Jk9rnbry9zh946YgMdz5ZEFGxsfH1KPUIdO
         OuthRrYORyPzqFNYMVQUVJOnB29jPOr+acwWsEUKPAAud6bYrFrtjyuXOKaLPpJVywVc
         yPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xLLAjARKxRthxAgJLnq6EHchMIsXs9Ka+l6EFh4CbDo=;
        b=V91f9+/fSzgVIO5VaNA3VT6hnkikqOkuODbBplRok5sInKShsubLy5TE2h2P76RyeC
         KJ8fJuppbzgPMhG27CXIjr+lIHBjKJ53g/PFNO17b3pV1/mDGwDQmX9AKemCV4qCXmNx
         FWvbPnjRK8P++5ndeRRk0P0WXUr/hnQjYskyTGW+KUc9CvJFajyWfwM8XfkUtt7gzyRR
         9a0H8wVhAOk0t2IMcP7aqbmJOVAJK4ZlmLAfdstkO1Z/em5UnKVcz2cpBJgGTPder5Fw
         EZRxIwFwQSatEsymAzaQEfqEsRO5QNbpn/M5O9LzZnhJfAARxaAHSRNw5bd7HT86vnUM
         xVOw==
X-Gm-Message-State: APjAAAUbvrQNz+wMEbrl1qi54y5f9+ao9f6HiISwr7NvlpuHDg8xYs0+
        e1ML2/tfhiFPSSz+6r66yeEbcbqYixBqAYE83qdmlQ==
X-Google-Smtp-Source: APXvYqzl8SpXZCIKjrt1pq0npy6A108y7twx3BzPKQA7a+yIwaVgejmw04rHYwYBQEHZsMR/yQiKtxt67DHaikh/fC4=
X-Received: by 2002:a63:e20a:: with SMTP id q10mr11357151pgh.383.1574366165366;
 Thu, 21 Nov 2019 11:56:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573670565.git.martin.agren@gmail.com> <336eaa77e4974f84ea1eef473672e1d300f3a43d.1573670565.git.martin.agren@gmail.com>
 <xmqqy2w9951v.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2w9951v.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 21 Nov 2019 20:55:53 +0100
Message-ID: <CAN0heSo3E0g_ZhHb64cisZQu9hfF31sQEyyZB4X_eRyiFtv4mQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] builtin/config: collect "value_regexp" data in a struct
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Nov 2019 at 06:22, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > `git config` can take an optional "value_regexp". Collect the
> > `regex_t`-pointer and the `do_not_match` flag into a new `struct
> > cmd_line_value`.
>
> A "struct cmd_line_value" sounded, to me at least during my first
> reading, as if it is about all command line options, but that is not
> at all what you meant to imply.  Is this only about the optional
> value-regexp (if so perhaps calling it "value_regexp_option" would
> have helped me avoid such a misunderstanding)?

Yes, that's right. Your suggested name is better. Thanks.

> > Rather than signalling/judging presence of a regexp by the NULL-ness of
> > the pointer, introduce a `mode` enum.
>
> OK.  Tangentially this makes readers wonder why the existing code
> for key_regexp does not follow the same "NULL-ness" pattern but has
> a separate use_key_regexp boolean.  It appears that the original
> code is quite confused---it is totally outside the scope of this
> series to clean it up and inject sanity into it though ;-)

Yeah, I considered doing such a cleanup, but opted to try and stay
focused.

> >  static regex_t *key_regexp;
> > -static regex_t *regexp;
> > +static struct {
> > +     enum { none, regexp } mode;
>
> We often use the same identifier for a struct and an instance of the
> struct, taking advantage of the fact that they live in separate
> namespaces, but lowercase enumerated values like 'regexp' that
> collides with the field name (and possibly a variable name used
> elsewhere) smells a bit too much.

Ok, thanks for sanity-checking.

> > +     regex_t *regexp;
> > +     int do_not_match; /* used with `regexp` */
> > +} cmd_line_value;
> >  static int show_keys;
> >  static int omit_values;
> >  static int use_key_regexp;
>
> > @@ -283,19 +288,21 @@ static int collect_config(const char *key_, const=
 char *value_, void *cb)
> >  static int handle_value_regex(const char *regex_)
> >  {
> >       if (!regex_) {
> > -             regexp =3D NULL;
> > +             cmd_line_value.mode =3D none;
> >               return 0;
>
> Now we are back to relying on cmd_line_value.regexp staying to be
> NULL after initialized, which is the state before the previous
> patch.  If the end result is correct, then it is OK, I think, but
> then the previous step shouldn't have added the NULL assignment here
> in the first place.

Ok, noted.

As I wrote in my reply there, that made the whole thing not a 100%
refactoring anyway. I'll drop that one.

> > +     cmd_line_value.mode =3D regexp;
> > +
> >       if (regex_[0] =3D=3D '!') {
> > -             do_not_match =3D 1;
> > +             cmd_line_value.do_not_match =3D 1;
> >               regex_++;
> >       }
> >
> > -     regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
> > -     if (regcomp(regexp, regex_, REG_EXTENDED)) {
> > +     cmd_line_value.regexp =3D xmalloc(sizeof(*cmd_line_value.regexp))=
;
> > +     if (regcomp(cmd_line_value.regexp, regex_, REG_EXTENDED)) {
> >               error(_("invalid pattern: %s"), regex_);
> > -             FREE_AND_NULL(regexp);
> > +             FREE_AND_NULL(cmd_line_value.regexp);
>
> Hmph.  !regexp in old code should mean cmd_line_value.mode=3D=3Dregexp
> in the new world order after this patch is applied, no?  Should we
> be treaking the mode field here before we leave?  I think it should
> not matter, but thought it wouldn't hurt to ask.
>
> In collect_config(), cmd_line_value.regexp is blindly passed to
> regexec(3) as long as cmd_line_value.mode=3D=3Dregexp, so the invariant
> "when .mode is regexp, .regexp must be valid, or collect_config() would
> never be called for such cmd_line_value" is rather important to
> avoid crashing ;-)

Good point. No-one will be looking at the struct when we bail out here,
but we're just one missing "if" away from that changing... Might as well
try to leave things in a sane state to reduce the possibility of this
biting us in the future.

> > @@ -372,9 +379,9 @@ static int get_value(const char *key_, const char *=
regex_)
> >               regfree(key_regexp);
> >               free(key_regexp);
> >       }
> > -     if (regexp) {
> > -             regfree(regexp);
> > -             free(regexp);
> > +     if (cmd_line_value.regexp) {
> > +             regfree(cmd_line_value.regexp);
> > +             free(cmd_line_value.regexp);
>
> Likewise.

Thanks.


Martin
