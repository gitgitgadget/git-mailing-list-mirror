Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D0BC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 18:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5532496F
	for <git@archiver.kernel.org>; Mon,  4 May 2020 18:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JaZSvUtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbgEDSKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 14:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732076AbgEDSKc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 14:10:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B453C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 11:10:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d17so173134wrg.11
        for <git@vger.kernel.org>; Mon, 04 May 2020 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aKUNCFqjP63bKaygscQNIfFJ+kxHW6HnDOFGcdbc42o=;
        b=JaZSvUtRlRyuP/hsYPOFWLcFuz6bM2TqELiQQmOj+9OK/S9L7TPPn01vR5WuUsSM0x
         liNM3pR52UnmnqVNse7ET1kROdkGUKAavA7JfzSsaGiGDR89olhjqlf4eQdndS8y7W5m
         IkfqGfsNV30wp+ZhmrbyRMDCWPPNdoskHHtYqezaW3fA7sUOxA5Jn1sAsdbvrBAmAnHv
         f20caEkir0yrTakyFL/AI79SFqQs9e6VKrFLxdfwBSi2SV1UOJQp8pqwvYx+EJOi8W2d
         SflO8Jj19PgPZRkhIj+oxhYTP57u1EPzfOzzi1aglDBjPm9AkN26UsdpyTSH6L7fjIlN
         d1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aKUNCFqjP63bKaygscQNIfFJ+kxHW6HnDOFGcdbc42o=;
        b=J9KUzg/hcxRLMlvosg6I4bnspuTdmyFNDS+KhCOIzFj9Bvmsoc7o2ovA3f09U/ZzOo
         JMxJGoi0LMVlgovI7Jd2Yhk3Hb920OgoQLyBwl09a2OJpUdSy7qRz5xscKds7DhdOVxy
         9xxg1N0WAJx2bxRdVgKx7/I1AHi6O8uJwgt8ISMnrFBn0L4Vwj0WzPa5x5YVx7apU0ax
         2xoVLmw6tXhi1UiAXmQvWHprK6TBBNSPN8JghnN8q4f5mNIzdna07uzwI94P++CIrNA8
         Ika3VOYhurOKE2f3AlvChfoaMM39CxX2C7ioHfbVzjnxjG1sHpEPQE/xTPQaLSelUjml
         0ajA==
X-Gm-Message-State: AGi0PuaEdwLH46AoViO81it4eI9NagSOmorJNRjO2Sq+l5utTNbsyS0w
        2br9tQt8ffWYNa+lXt9KcnJmi8Rq4o1I8POF4Zjbj1cp4OQ=
X-Google-Smtp-Source: APiQypJmXs1zJdiIX9FAOGZjlIHmmkJH5cNQDFrCObKE5iW6HspqfxTtEWcCV8zo8mRkfBxLD8yLthyhN4TnqzscWcc=
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr655521wru.12.1588615830962;
 Mon, 04 May 2020 11:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
 <pull.539.v10.git.1588018418.gitgitgadget@gmail.com> <bc89bcd9c8c9b33e517a21bbe7c441538e288ebc.1588018418.git.gitgitgadget@gmail.com>
 <20200430212410.GF77802@google.com>
In-Reply-To: <20200430212410.GF77802@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 4 May 2020 20:10:19 +0200
Message-ID: <CAFQ2z_PG=EDCpyZoPU6=crbfYUa3DMU_TG7=S2hjeOJYfGGf4Q@mail.gmail.com>
Subject: Re: [PATCH v10 03/12] create .git/refs in files-backend.c
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 11:24 PM Emily Shaffer <emilyshaffer@google.com> wr=
ote:
>
> On Mon, Apr 27, 2020 at 08:13:29PM +0000, Han-Wen Nienhuys via GitGitGadg=
et wrote:
> >
> >
> > This prepares for supporting the reftable format, which will want
> > create its own file system layout in .git
> >
> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> > ---
> >  builtin/init-db.c    | 2 --
> >  refs/files-backend.c | 6 ++++++
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > index 0b7222e7188..3b50b1aa0e5 100644
> > --- a/builtin/init-db.c
> > +++ b/builtin/init-db.c
> > @@ -251,8 +251,6 @@ static int create_default_files(const char *templat=
e_path,
> >        * We need to create a "refs" dir in any case so that older
> >        * versions of git can tell that this is a repository.
> >        */
> > -     safe_create_dir(git_path("refs"), 1);
> > -     adjust_shared_perm(git_path("refs"));
>
> Is the reftable completely replacing the refs/ dir? Or is the idea that
> the refs/ dir is only used by the files backend? The commit message
> makes it sound like it's an additional format to support, so I'm a
> little confused. Why does the other currently-existing backend not need
> the refs/ dir at this stage?

I've dropped this patch from the series; it probably was from before
the compat hack that is described in

  https://git.eclipse.org/r/#/c/157167/

for further clarification: reftable doesn't used the refs/ dir at all,
but we still want to not confuse older git versions.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
