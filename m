Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABF0C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 12:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B6E20730
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 12:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IC0jQ79J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgAQMiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:38:01 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44187 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgAQMiA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 07:38:00 -0500
Received: by mail-vs1-f66.google.com with SMTP id p6so14698528vsj.11
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 04:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nnr6N72ifMhNcCOp3J90kdNler5LrB6KDVwPr1x4gHA=;
        b=IC0jQ79JYj3n4YO79FXQZPyQU66Cgq6y1tsu194VPAnKurNUrfZ9kkRidirAQo8W21
         kyhBF4b7hjgjilnPjCD5+fkLb4Xcw3geDH4UlfMZ8SMfV6xvN3jmiiX069WgappvA7W1
         2OzxO1UW7HXuGuVkuqGhAaPwwfoZhUvNu7Psg9ew+q258uemEcVblqRjEaZzb0otdI6Q
         +C1ZjGlobPROG8dKCTBeORNv+eYUDIZCJO789q7Cln1TnLrs+QC79yz8/BrxoeVzj2bm
         Mj9VKnXmNq2i3ZVAoT2S+Ey50obV5tozSTgJDjZHdUUWlI0oi86Lg2PNKX/9tEX6CUNH
         TlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nnr6N72ifMhNcCOp3J90kdNler5LrB6KDVwPr1x4gHA=;
        b=Cgb+9wvCYoSuWLeje0ZWHzXGAew8LVHV8sG2Z0uj3YWt/R2oRk+fTR6P0nuoEILrwT
         xK3ozcZqYmdDkLlS2w6LVxpNl8s+1w9CwFD/SKwtngq/8SeBUNu7DmPUaToclFVR7u1X
         8Yz23s0KnAcJVELZpiaCyMYIKjuihXt9E+V2ojQVU9oMa37pn+pCMDRrlxTDTQoum46+
         X3l42MVGQpRfzyzspWvQ4zfAp8RudSUkm2Ge/cPpdunvXttt9xXj/D95sGfL3dXhzLjQ
         m53Jg8vI+BduZaoDg3OOYZF89RbrBP+Al79LR3eas2V3d7h+3/emxjwohdI0K8ssQDtJ
         J9OA==
X-Gm-Message-State: APjAAAWBNoyjLlDSHdksrjzET9cU2m3m+6mnXrCU4imkC4jSOAJ4xgYd
        thG+WZfl0+CKWIpdH3Ud3VGjRYot7P0syyYJbyk=
X-Google-Smtp-Source: APXvYqwtc5oXHqIQOBkjC+x/J8PU1sVgi/lGL0Y8cJTKxhwH+Yb+a4gsEGzGw52sGwRUFbOqtljIO+QzJtIwe0QjNHw=
X-Received: by 2002:a05:6102:7a4:: with SMTP id x4mr4429337vsg.85.1579264679323;
 Fri, 17 Jan 2020 04:37:59 -0800 (PST)
MIME-Version: 1.0
References: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com>
 <ffc8ffc6ede731b182d32a81d044428566acc625.1579253411.git.bert.wesarg@googlemail.com>
 <nycvar.QRO.7.76.6.2001171245300.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001171245300.46@tvgsbejvaqbjf.bet>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Fri, 17 Jan 2020 13:37:47 +0100
Message-ID: <CAKPyHN0eTa9LC35oqsy0Dce0qpOJAx159HR+QyguDt_NZ2he_w@mail.gmail.com>
Subject: Re: [PATCH v2] remote rename: rename branch.<name>.pushRemote config
 values too
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Jan 17, 2020 at 12:50 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Bert,
>
> On Fri, 17 Jan 2020, Bert Wesarg wrote:
>
> > When renaming a remote with
> >
> >     git remote rename X Y
> >
> > Git already renames any config values from
> >
> >     branch.<name>.remote = X
> >
> > to
> >
> >     branch.<name>.remote = Y
> >
> > As branch.<name>.pushRemote also names a remote, it now also renames
> > these config values from
> >
> >     branch.<name>.pushRemote = X
> >
> > to
> >
> >     branch.<name>.pushRemote = Y
>
> Should we warn if remote.pushDefault = X?

AFAIU, the value of remote.pushDefault wont be renamed yet. So you
suggest to issue a warning in case remote.pushDefault is X. But as X
does not exists anymore after the rename, the value of
remote.pushDefault is invalid. So why not rename it too?

>
> Other than that, I am still okay with the patch (even after the
> re-ordering of the enum ;-)
>
> Just one more suggestion:
>
> > Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> >
> > ---
> > Cc: Junio C Hamano <gitster@pobox.com>
> > Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/remote.c  | 17 +++++++++++++++--
> >  t/t5505-remote.sh |  4 +++-
> >  2 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/remote.c b/builtin/remote.c
> > index 96bbe828fe..a74aac344f 100644
> > --- a/builtin/remote.c
> > +++ b/builtin/remote.c
> > @@ -251,6 +251,7 @@ struct branch_info {
> >       enum {
> >               NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE, REBASE_MERGES
> >       } rebase;
> > +     char *push_remote_name;
> >  };
> >
> >  static struct string_list branch_list = STRING_LIST_INIT_NODUP;
> > @@ -269,7 +270,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
> >               char *name;
> >               struct string_list_item *item;
> >               struct branch_info *info;
> > -             enum { REMOTE, MERGE, REBASE } type;
> > +             enum { REMOTE, MERGE, REBASE, PUSH_REMOTE } type;
> >               size_t key_len;
> >
> >               key += 7;
> > @@ -282,6 +283,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
> >               } else if (strip_suffix(key, ".rebase", &key_len)) {
> >                       name = xmemdupz(key, key_len);
> >                       type = REBASE;
> > +             } else if (strip_suffix(key, ".pushremote", &key_len)) {
> > +                     name = xmemdupz(key, key_len);
> > +                     type = PUSH_REMOTE;
> >               } else
> >                       return 0;
> >
> > @@ -305,7 +309,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
> >                               space = strchr(value, ' ');
> >                       }
> >                       string_list_append(&info->merge, xstrdup(value));
> > -             } else {
> > +             } else if (type == REBASE) {
> >                       int v = git_parse_maybe_bool(value);
> >                       if (v >= 0)
> >                               info->rebase = v;
> > @@ -315,6 +319,10 @@ static int config_read_branches(const char *key, const char *value, void *cb)
> >                               info->rebase = REBASE_MERGES;
> >                       else if (!strcmp(value, "interactive"))
> >                               info->rebase = INTERACTIVE_REBASE;
> > +             } else {
> > +                     if (info->push_remote_name)
> > +                             warning(_("more than one %s"), orig_key);
> > +                     info->push_remote_name = xstrdup(value);
>
> It makes me a bit nervous that this is an `else` without an `if (type ==
> PUSH_REMOTE)`... Maybe do that, just to be on the safe side, even if
> another type is introduced in the future?

I'm not a friend of this last 'else' either, but it was so to begin
with. I'm all for changing it to an 'else if'. Though while it is
impossible that 'type' has a value different than one from the enum, I
would be even more comfortable with having BUG at the end.

Bert

>
> Thanks,
> Dscho
>
