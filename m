Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C51C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 01:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146A961156
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 01:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhIVB3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 21:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhIVB3H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 21:29:07 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C02C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 18:27:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p29so4994402lfa.11
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 18:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dOFitDnJIPoFdO7MblEPBEMWoDyK2OqEuow3BU7d8vg=;
        b=QbBERcozTL6xY3m4+t3trU1Blzkn7WVpPR7oIwXy7FNS39weYGSncybguIW0iAsjVc
         oo2EWJ14L0LYL912deAuIjNmGLWyHNhepT1cmnD1ZpXynnw/fxj7Q0Vuhi0WOBgkGoG3
         OK/vrB5kGNv1BAnAFdoImZUSqwLc0+yb8XPsNB9W6TwGlaf9UUr3cN0ceb0FFrUQCDEO
         wP26+Y8aYirpPwsDiueuhVJEhzzeA4XrzikPOzy3z9Xcb0Ntn4PmT9mQ43K35Mpc7NFK
         xgzfNcwjzh9hG4d7pnC/xCU5cQhfoqW8KOb/DcS7d0uRn7ankwqFj5njBi6ZP/+7N2Hq
         3PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dOFitDnJIPoFdO7MblEPBEMWoDyK2OqEuow3BU7d8vg=;
        b=B5qwiJY3jYO+alKLRQqGBRVeGw7YsaQHkfVKThve2xxlmWGOi4JxdxrD6VNmzHTqNW
         08GmLfHSBQaIQcAH6eYo89pJuAMkaHzFhbcJvFJRS6/iIGZp2VtHvNUW5LUQejr0KkTC
         ZihLaKlNNnYPgrsjkGdImbIMDtbFioI8ro8SH7gONMgUtRBTO2t5703Y3+oiQLDRbW5A
         LsO1bQhUdf1g+o4puBL/dWOXoJqe6f8t4EGvZ3RGj5rNYqGjzGvgR32zjiR/PIl+Xzqn
         FmGT+xaGk7jNahqC2YWBlR9TKmC04Lyeaz4TJGtlji95G5p0+ALW4ukgoiOjXd2nfkxi
         QCfA==
X-Gm-Message-State: AOAM532DPK2GKsgE0QJK/q/jjYki/8eyBdsOl+XVUVNcyPfFMXmbH0uC
        zRKrpZAKWGZMVEyF5hpdFieS3MldTW7EHdR/twk=
X-Google-Smtp-Source: ABdhPJwODr/A9e6YK/e/bRM1B0ORBDas27v4dPfx78yELKkSeZnan0eK0DMz5hZb97aiEPF0eCYzDAw+dpv466LvFZs=
X-Received: by 2002:a2e:97ce:: with SMTP id m14mr3876216ljj.73.1632274056650;
 Tue, 21 Sep 2021 18:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
 <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com> <f7f756f3932cdbca587de397598758c685bac29a.1632176111.git.gitgitgadget@gmail.com>
 <87ee9h8p0a.fsf@evledraar.gmail.com>
In-Reply-To: <87ee9h8p0a.fsf@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 21 Sep 2021 18:27:25 -0700
Message-ID: <CANQDOdeV4JuE8jnkzLmK6VfFj1t-+EOzvn=GD-ejPdS6unc66w@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] update-index: use the bulk-checkin infrastructure
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 4:53 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Sep 20 2021, Neeraj Singh via GitGitGadget wrote:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > The update-index functionality is used internally by 'git stash push' t=
o
> > setup the internal stashed commit.
> >
> > This change enables bulk-checkin for update-index infrastructure to
> > speed up adding new objects to the object database by leveraging the
> > pack functionality and the new bulk-fsync functionality. This mode
> > is enabled when passing paths to update-index via the --stdin flag,
> > as is done by 'git stash'.
> >
> > There is some risk with this change, since under batch fsync, the objec=
t
> > files will not be available until the update-index is entirely complete=
.
> > This usage is unlikely, since any tool invoking update-index and
> > expecting to see objects would have to snoop the output of --verbose to
> > find out when update-index has actually processed a given path.
> > Additionally the index is locked for the duration of the update.
>
> Would you really need to sniff the verbose output? If I'm streaming data
> to update-index now it looks like I could assume before that
> update-index would have done the work if I managed to fflush() to it,
> since it's processing a line at a time and doing the work in that
> line-at-a-time loop.
>
> I.e. you could print lines to it, and then do concurrent object lookups
> knowing the data was written already...
>
> I think this is probably fine, but that case seems way likelier than
> someone sniffing back the verbose output, presumably for the "add" in
> update_one(), but that's called in the getline_fn() loop...

Does fflush really guarantee that the reader has picked up the input from
a pipe across all environments?  Even if a reader picks up the input, does
that mean that the reader is done processing it?

Do you think I really need to revise this comment? Maybe leave a terser,
'this usage is thought to be unlikely'?

>
> All of this makes me wonder why this isn't using tmp-objdir.c, i.e. we
> could have our cake and eat it too by writing the "real" objects, and
> then just renaming them between directories instead. But perhaps the
> answer has something to do with the metadata issues I raised.
>
> And well, tmp-objdir.c isn't going to help someone in practice that's
> relying on this "update-index --stdin" behavior, as they won't know
> where we staged the temporary files...
>

One motivation of the current design behind renaming the files is that
some networked filesystems don't seem to like cross-directory renames
much.  It also so happens that ReFS on Windows also prefers renames to
stay within the directory. Actually any filesystem would likely be
slightly faster,
since fewer objects are being modified (one dir versus two).
