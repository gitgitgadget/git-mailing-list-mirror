Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC1C1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 19:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfBGTuc (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 14:50:32 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36704 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGTub (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 14:50:31 -0500
Received: by mail-vs1-f66.google.com with SMTP id t13so710543vsk.3
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 11:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qO4KDluyMLa1j37CPkKkGhuJE0HEJ49lOlgahGzSSKQ=;
        b=FjI9+py2djFUju1bZx1xP/UNxCfOKE19tdZ3whUUo/K/v+nJGN1I4zpNqIIUFDkFp4
         BUG41JtLnliaZVPpHhxrodlMuwid8MhsjYATBbrLVqpLiUaM5geh6jEcoNa2ed5W7Vb/
         hIojCWmwNa/LnSCMZj8Zz07b40eCcNDxGjHr0jxQ0BwWxN2zKei9HbAMHPDbSmqjtVti
         8ojqG6RtO2knmjmgMeLnUBZbKnVVy52bXi3a8eilvCbPk4HZFzj+q6J9kGduqnwHQTEq
         1pdA3Og1k+FqSSp0jEhBGMVLYLxYkf8WxiErulR6QJklFBFnYHd3XkSbMfAk3XgpsYmd
         GogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qO4KDluyMLa1j37CPkKkGhuJE0HEJ49lOlgahGzSSKQ=;
        b=Av+c4I22chYI32PXzE39RGlh59XwHIuSj3WxUnkP4iiWpoL09FrCqimi4STMrGv4GB
         8EiO9q/BWFoB8N5YyqGCEquAwt11yBBzcqYzIHL9nqSo7QaKhehKBOvN/65DzCE2Ane/
         L/FlZk3+3jOAs2Xp1N9irtJuh/p3qppWY0yMWtJ+8R3vSYXT2TPK4cK4Liu1bczFTvhv
         Jrmnikj9d2aq+ZMMenHVWAhgVZ84Nqii3Scw+SFfQC1Ueif0QtV0rV3/8gYS/5lPY5dB
         N5muzlo05JNzkDJ9tKmP0VtCHvtKJ1CJc7ej25Ln6AEKJPhRZGhcAy8NSHKkEgBZBSE5
         N6OA==
X-Gm-Message-State: AHQUAuajArQd32EtcH6RfauSJhJ97KgDGZg401CSlobevjGp9JHPW4sl
        yaJaLoyiNM++uEoAn47BNU1hGkBrwfNaa4aXyA8=
X-Google-Smtp-Source: AHgI3IZNJ+QklCRy/03k9OQGpCWEP94t3VRms2KjPQIiE0+McTpkAWT/ObNVwCXtoXxSsXWfuY1lEy0pNiEoLYpz7g0=
X-Received: by 2002:a67:3edc:: with SMTP id a89mr7196780vsi.136.1549569029869;
 Thu, 07 Feb 2019 11:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20190126221811.20241-1-newren@gmail.com> <20190204200754.16413-1-newren@gmail.com>
 <xmqqlg2vtfmo.fsf@gitster-ct.c.googlers.com> <CABPp-BGyL5BAejK-P-EdscFdH3C6uR7e6CbgNe-9doy-mkw-vg@mail.gmail.com>
 <xmqqa7jarmvo.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7jarmvo.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Feb 2019 11:50:15 -0800
Message-ID: <CABPp-BG4WftXZgbzN48zSo1Z5BcWYjdbz+8hGSGBNJbSsYUzAA@mail.gmail.com>
Subject: Re: [PATCH v4] log,diff-tree: add --combined-all-names option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 5, 2019 at 12:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> > Further, in patch format, this changes the from/to headers so that
> >> > instead of just having one "from" header, we get one for each parent.
> >> > For example, instead of having
> >> >
> >> >   --- a/phooey.c
> >> >   +++ b/phooey.c
> >> >
> >> > we would see
> >> >
> >> >   --- a/fooey.c
> >> >   --- a/fuey.c
> >> >   +++ b/phooey.c
> >>
> >> Do we have the three "rename from fooey.c", "rename from fuey.c" and
> >> "rename to "phooey.c" extended headers, too?  That's what I meant in
> >> my response, but I do like what I see in the above example ;-)
> >
> > Ah, gotcha.  I'll look into whether it's possible to hook it up to
> > diff.c's fill_metainfo() .
>
> Just to clarify.  I do not think these extended headers are "must
> have"; the "--cc" output is not meant for machine consumption, as it
> simplifies the output by omitting hunks that preimage trees agree
> with each other etc., and making the resulting "patch" not showing
> the whole picture, and these extended header lines might only become
> waste of the screen real estate.
>
> So, do not spend too much effort to emit these textual info that can
> be easily seen with the N+1 plus/minus header lines.
>
> Thanks.

Understood, thanks.

I think something can be done here, but I'm unsure exactly what.  From
Documentation/diff-generate-patch.txt, the extended headers for normal
diff mode are:

       old mode <mode>
       new mode <mode>
       deleted file mode <mode>
       new file mode <mode>
       copy from <path>
       copy to <path>
       rename from <path>
       rename to <path>
       similarity index <number>
       dissimilarity index <number>
       index <hash>..<hash> <mode>

and for combined diffs they are:

       index <hash>,<hash>..<hash>
       mode <mode>,<mode>..<mode>
       new file mode <mode>
       deleted file mode <mode>,<mode>

meaning that the ones we are missing are:

       copy from <path>
       copy to <path>
       rename from <path>
       rename to <path>
       similarity index <number>
       dissimilarity index <number>

I think "copy from" and "rename from" should be relatively
straightforward.  However, in a combined diff, we could have both a
modified status, a renamed status, and a copied status, meaning that
we'll need an array of both similarity and dissimilarity indexes...and
trying to present that to the user in a way that makes sense seems
like a lost cause to me.  Does anyone else know how to represent that?
 I'm inclined to just leave it out.

Also, I'm afraid "copy to" and "rename to" could be confusing if both
appeared, since there's only one "to" path.  If there is both a copy
and a rename involved relative to different parents, should these be
coalesced into a "copy/rename to" line?


Thanks,
Elijah
