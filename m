Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F7F41F803
	for <e@80x24.org>; Mon,  7 Jan 2019 13:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfAGM4S (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 07:56:18 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33437 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfAGM4R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 07:56:17 -0500
Received: by mail-io1-f66.google.com with SMTP id t24so216470ioi.0
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 04:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X3LHEKWZO21kvqMwVKapn089ctGUnpr8pGB/iwP+liQ=;
        b=fhPpkEQJGRTbanAjY0xzObNPYBWJeIeK01LomVX9c6N/wUM+SeY+WrB5XjDIRfNHE3
         El4+8H/xfStc2qBYWz8LtY+k2sHQW8VQs3lOGIyyABkuGcfClMcqJqpI/DUEHSjh+q8C
         CfOrFG2nHtiRvrfwVCqPEGEcINH7Z2qXu5iCZXcKAIter0UG5rjFt7WVakEDxE3rr/kT
         gcU+bboWQv+Yuz4OCqeCxWed4V0YfkW0k7p6kN+YhvcyTopcXl3EbKBUh49AVsGNIxBZ
         AOo8pKGc/KsOc6lc/kwVPRSL50uZX4vaZ+g6mVk97zdK4+99O8R+eanxqbeVb1KSa3hW
         3iyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X3LHEKWZO21kvqMwVKapn089ctGUnpr8pGB/iwP+liQ=;
        b=MTzzWlHapGyIazfufTBr/VpYzO+6CbNBCtZ9WJwFGzzNpsWKjb5KNGyPMnA8Xr6sWz
         imT/p1iD+ZMN5yuHf1RkZBAL5g5Rq0GHBByMrbZltZXXBt4IdRwcY7g7RBwqeqIXBEKF
         pS240MPn5XCW44WSE4Pb0xX9o7h+jXfjux/sVuxcTfn3CVXiT4xb9bSzc7qW7fywhsdy
         jY7wRxQJ/EE1sJ65f8wuxIPnFDP1Gg1ymCfRt55kKrmVBL6bxMzFx5FrAYevC9TICmbw
         8/fjwRBg2zIG14MXPLPmDuZz5XxXteu4LnBcfs681CLiTBRJQ4cvT50gSmMr6UtG4dCJ
         jpww==
X-Gm-Message-State: AJcUukdVxk7jluCDnVwv+3HxJvmiUVRU80iBqE4rLdgtIKZ7uM7uvMCO
        FEXQl3yjZvKa0qnlP21adWAXBJGdaItViIKdz9ZMJcRr
X-Google-Smtp-Source: ALg8bN61rEd9mEBLbt9wBK47hcICndQ444s8BULV5uM0AhIQ9SquEMq55lA+UxMrRxi/U4VxovQ03E4JXEvqiZKl+LA=
X-Received: by 2002:a6b:ef0b:: with SMTP id k11mr22285902ioh.236.1546865776348;
 Mon, 07 Jan 2019 04:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20190105055153.3256-1-pclouds@gmail.com> <20190105055153.3256-3-pclouds@gmail.com>
 <CAN0heSoRSgZVZ=NE6eof4dusEhfdz-eSiht06rGKb=GELvm86Q@mail.gmail.com>
In-Reply-To: <CAN0heSoRSgZVZ=NE6eof4dusEhfdz-eSiht06rGKb=GELvm86Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 7 Jan 2019 19:55:50 +0700
Message-ID: <CACsJy8DLFOyh3pvPPhkAVMFMT=wnfOBWuDN9dUr6sUNaNe=3TA@mail.gmail.com>
Subject: Re: [PATCH 02/10] repository.c: replace hold_locked_index() with repo_hold_locked_index()
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 5, 2019 at 9:34 PM Martin =C3=85gren <martin.agren@gmail.com> w=
rote:
>
> On Sat, 5 Jan 2019 at 07:07, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <p=
clouds@gmail.com> wrote:
> >
> > hold_locked_index() assumes the index path at $GIT_DIR/index. This is
> > not good for places that take an arbitrary index_state instead of
> > the_index, which is basically everywhere except builtin/.
> >
> > Replace it with repo_hold_locked_index(). hold_locked_index() remains
> > as a wrapper around repo_hold_locked_index() to reduce changes in built=
in/
>
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 7c7f98c72c..ddb3230d21 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -8,6 +8,7 @@
> >   * Clone a repository into a different directory that does not yet exi=
st.
> >   */
> >
> > +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>
> I think this should be in patch 10/10.

Eck. There has been a lot of fixups in this series. I guess I fixed up
the wrong commit.

> > -int hold_locked_index(struct lock_file *lk, int lock_flags)
> > -{
> > -       return hold_lock_file_for_update(lk, get_index_file(), lock_fla=
gs);
> > -}
>
> > +int repo_hold_locked_index(struct repository *repo,
> > +                          struct lock_file *lf,
> > +                          int flags)
> > +{
> > +       return hold_lock_file_for_update(lf, repo->index_file, flags);
> > +}
>
> `get_index_file()` BUGs if `the_repository->index_file` is NULL, but
> other than that, this looks like a faithful conversion. Do we want to
> keep that check here?

Better than segfault :)
--=20
Duy
