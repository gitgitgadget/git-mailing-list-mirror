Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60312C32771
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 07:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342C62465B
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 07:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GN6Wk1bX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgAVHfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 02:35:00 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42668 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVHfA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 02:35:00 -0500
Received: by mail-vk1-f195.google.com with SMTP id s142so1675289vkd.9
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 23:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBIBtkknE8IuDysdw1RVeQAgjMwuGa1o8pjhz826wnM=;
        b=GN6Wk1bXm/wmj6WIDOmGaDWnBu92sToaO6NPB+1XY417FbwV7Ya5DEZiH4G/tQe9Dg
         odRvm+iDfkVhTGkhgA5+SbBgaNhiN8e7nQydj/PG6R0CIZ8k9szjW7tzVlEbHXFI4iNg
         9xUCtEHhvkWJvnu7FRvZIu3qb4RyhqF202tSiNu/K5EEsNNpW0xzK5L74pzjMPojsl/M
         W1QtIyKkalPL3Izmz6pQ8InkOaP5chkYbOnBm97zuUhbz8TVXEediYoefI31GrAlTW9f
         s9iqFWQO4QZPJej7ragjCjdZkpr+FROyyVmd7SAy3m1nqZdXawgP5zQOJOW0rLCQt4Lp
         Wecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBIBtkknE8IuDysdw1RVeQAgjMwuGa1o8pjhz826wnM=;
        b=g4pxxltyuHI9l8DD3nHoKhdtU9KTYrmD7nhzZD7luLdevPTJY/a8leexrW9jUyhE+p
         G0kNO20D5e/5sqZxu1483GbybnQ+bHd5/mYojtgjrsDkLk0zS/O3yAHLc7YLC9dA60RU
         fl+1aHEolL4NkKhrwhptei56bA5+QD6DqxTpwRq6mfz9U0VkCnzyskcJGdAZREd4DvV+
         7XbZt4MMTDk8z8+fJzhYJUcPt1QDeBINygnywrI4QS6MJx3k9HA47VK9SZfFoZT788/H
         d37gm/lWiETJiUHsm/Ug6ftu4ZZuBiQ800Vf0x3Bhyd4S8SihgTYEIGnTjymVyLDlsIJ
         sI0g==
X-Gm-Message-State: APjAAAXgLoCk9eBbubqld7LsBIWCWjLbrsYEp5PDW9eSE/87VWr7EJKT
        5LkWGPdzAm2ly43jfKK5q7w7LeTUDD9xnZQ3wug=
X-Google-Smtp-Source: APXvYqwDYg0bB+PDYFAzqCs0soLQgMFa7fwd+8DmQLlZmjlYZHyrvU/4SS3ANlimgrER3GDz+P2tZGUHVp1n4YDekAo=
X-Received: by 2002:a1f:6041:: with SMTP id u62mr5522309vkb.23.1579678499495;
 Tue, 21 Jan 2020 23:34:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579598053.git.bert.wesarg@googlemail.com>
 <f9da9aac7edf6f682592592fe8f450a5801fb012.1579598053.git.bert.wesarg@googlemail.com>
 <xmqqv9p475ns.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9p475ns.fsf@gitster-ct.c.googlers.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 22 Jan 2020 08:34:46 +0100
Message-ID: <CAKPyHN0_AVOo_6bdHvy_J9ebnBpSD2NECBiLZ7g=4TcMvfZgYw@mail.gmail.com>
Subject: Re: [PATCH 1/7] pull --rebase/remote rename: document and honor
 single-letter abbreviations rebase types
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Junio,

On Wed, Jan 22, 2020 at 12:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
> > When 46af44b07d (pull --rebase=<type>: allow single-letter abbreviations
> > for the type, 2018-08-04) landed in Git, it had the side effect that
> > not only 'pull --rebase=<type>' accepted the single-letter abbreviations
> > but also the 'pull.rebase' and 'branch.<name>.rebase' configurations.
> >
> > Secondly, 'git remote rename' did not honor these single-letter
> > abbreviations when reading the 'branch.*.rebase' configurations.
>
> Hmph, do you mean s/Secondly/However/ instead?

thanks, that now reads smoothly.

> > @@ -305,17 +304,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
> >                               space = strchr(value, ' ');
> >                       }
> >                       string_list_append(&info->merge, xstrdup(value));
> > -             } else {
> > -                     int v = git_parse_maybe_bool(value);
> > -                     if (v >= 0)
> > -                             info->rebase = v;
> > -                     else if (!strcmp(value, "preserve"))
> > -                             info->rebase = NORMAL_REBASE;
> > -                     else if (!strcmp(value, "merges"))
> > -                             info->rebase = REBASE_MERGES;
> > -                     else if (!strcmp(value, "interactive"))
> > -                             info->rebase = INTERACTIVE_REBASE;
> > -             }
> > +             } else
> > +                     info->rebase = rebase_parse_value(value);
>
> Here, we never had info->rebase == REBASE_INVALID.  The field was
> left intact when the configuration file had a rebase type that is
> not known to this version of git.  Now it has become possible that
> info->rebase to be REBASE_INVALID.  Would the code after this part
> returns be prepared to handle it, and if so how?  At least I think
> it deserves a comment here, or in rebase_parse_value(), to say (1)
> that unknown rebase value is treated as false for most of the code
> that do not need to differentiate between false and unknown, and (2)
> that assigning a negative value to REBASE_INVALID and always
> checking if the value is the same or greater than REBASE_TRUE helps
> to maintain the convention.

Its true that we never had 'info->rebase == REBASE_INVALID', but the
previous code also considered unknown values as false. 'info' is
allocated with 'xcalloc', thus 'info->rebase' defaults to false. Thus
it remains false.

While my change may set 'info->rebase' implicitly to 'REBASE_INVALID'
I also changed all truth value checks to '>= REBASE_TRUE'. Therefore,
(and I must admit) incidentally, I did not introduced a function
change. Both versions handle unknown '.rebase' values as false.

If this is the expected behavior, I will add a comment to the line,
with that finding. If not, I will map 'REBASE_INVALID' to
'REBASE_TRUE' in that case.

Bert
