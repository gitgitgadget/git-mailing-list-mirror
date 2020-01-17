Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D3CC33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3A62083E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IUhyTE7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgAQUUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:20:48 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35669 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQUUr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 15:20:47 -0500
Received: by mail-vs1-f67.google.com with SMTP id x123so15650339vsc.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 12:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRktknmQtWZ8/7YOlrmaU+DfOUS+Cf0r5lTJvqS534U=;
        b=IUhyTE7eiNcrmF4FPdtvbnetmJ1CVBRUJgyh2h4MMqwSmMVm1XRy+uRZgMgX48V7Pw
         h6l+XcBnXSKo1sieaqwI196vJdzr394gPmfL+S+KFRhv+gk3XcnVDa1UyEs+1KU5Vfks
         Ob8/ufFaxParlQc/315qtf7A0VcAKF+a3rssweHp1qn4vjEpkLC5LpB4FnYEvxujFuKV
         KlCJrcnCW7VGZtrLh8MlsvMAt+mknSvOAV/2Cg5vpI4313B5iiqg5UtHpa2dvvdyJN0Y
         79gzpYMB8EsLQ8lZ75320S5Ui/A++HE7R/qKr2tRmUXj8blz1uaZx6WLsifkYgUFxvKN
         Kf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRktknmQtWZ8/7YOlrmaU+DfOUS+Cf0r5lTJvqS534U=;
        b=CkdeQVnXo+HcmbiMkBbXIMwR+YhAH2SmGn6QIGhhnjP4BuHrtxXp1sv3MOArG5zipI
         rkC/covaJpOVK5Yddx3AGJAbPj40yxqzIdLKekpolk2BmknG94h7yZsit+55PM6dLOu+
         32xFb/I9VVM+yZoGBRDx9VL4y6sqdIFhwGO+bwyCW6JFAtMrCTWyrPzkSFtRPQWDai6F
         V0tHJ0GUODYpug3jxBScIaSudQ4jcF4iXm6huH3xh6mY+w1SnT00o7dQNHSEMq4NxX1L
         chYfcrAahly0jL54Kp1YTR2RVybbWhYItHa1ZuXlkKhSnBDf7DHqlsD1jHryk/mWIvEw
         C4aw==
X-Gm-Message-State: APjAAAWClR4ib5XZ7vj5GbdwV7G//gahfec1n3cMrtpyMojX1vvbx9Ox
        N/ZbZr8wmrY4SfJk6HEv7F6frqSlSHqeyzX91fU=
X-Google-Smtp-Source: APXvYqz9FxkuttNz9n+m8ihXQ1k0KCJzUpDiV1UdDQQDoljM6qNWAlESkgNZ0F094sgmfQeHTmNNtfxH9js7Qqg+Ezk=
X-Received: by 2002:a67:ec41:: with SMTP id z1mr5976269vso.197.1579292446760;
 Fri, 17 Jan 2020 12:20:46 -0800 (PST)
MIME-Version: 1.0
References: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com>
 <ffc8ffc6ede731b182d32a81d044428566acc625.1579253411.git.bert.wesarg@googlemail.com>
 <xmqqeevxex7a.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqeevxex7a.fsf@gitster-ct.c.googlers.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Fri, 17 Jan 2020 21:20:35 +0100
Message-ID: <CAKPyHN2RwpWhBkTUwERSns0B0Vg7r7CTmhe8p0mZRNeNw4Aagw@mail.gmail.com>
Subject: Re: [PATCH v2] remote rename: rename branch.<name>.pushRemote config
 values too
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

On Fri, Jan 17, 2020 at 7:48 PM Junio C Hamano <gitster@pobox.com> wrote:
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
> >               }
>
> This is perfectly fine for now, as it follows the existing "now we
> have handled X, and Y, so the remainder must be Z" mentality, but at
> some point we may want to make sure that we are protected against
> seeing an unexpected 'type', iow
>
>                         ...
>                 } else if (type == PUSH_REMOTE) {
>                         ...
>                 } else {
>                         BUG("unexpected type=%d", type);
>                 }
>
> as we learn more "type"s.  Better yet, this if/elseif/ cascade may
> become clearer if it is rewritten to a switch statement.
>
> I was about to conclude this message with "but that is all outside
> the scope of this fix, so I'll queue it as-is " before noticing
> that you two seem to be leaning towards clean-up at the same time.
> If we are to clean up the code structure along these lines, I'd
> prefer to see it done as a preparatory patch before pushremote
> handling gets introduced.
>
> Taking some other clean-up ideas on this function, e.g.:
>
>  * key += 7 should better be done without hardcoded length of "branch."
>  * By leaving early, we can save one indentation level.
>  * name does not have to be computed for each branch.
>
> the resulting body of the function might look more like this:
>
>         if (!skip_prefix(key, "branch.", &key))
>                 return 0;
>
>         if (strip_suffix(key, ".remote", &key_len))
>                 type = REMOTE;
>         else if (strip_suffix(key, ".merge", &key_len))
>                 type = MERGE;
>         ...
>         else
>                 return 0;
>         name = xmemdupz(key, key_len);
>         item = string_list_insert(&branch_list, name);
>         ...
>
>         switch (type) {
>         case REMOTE:
>                 ...
>         default:
>                 BUG("unhandled type %d", type);
>         }

can you give me an heads up about your expected number of patches for
this clean up. Rather detailed or just one?

Thanks in advance.

Best,
Bert

>
> Thanks.
