Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9568C4332E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 19:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E582073E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 19:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgeXxI6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgCWTbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:31:14 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:40380 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgCWTbO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 15:31:14 -0400
Received: by mail-ed1-f49.google.com with SMTP id w26so11350614edu.7
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+MytpzR0Ptco6lhW5ypgQc62YhMvyT9RlFOpOBvwqW0=;
        b=VgeXxI6LzQb7DX0/uKd70cKMowww/39So2v0LBiAN2wvQ2thuJEWE8GVmpyPGOW9Up
         iq2/RsX9NfIAEeAWP5wvpfEpVodDS+E8WFbP6dnSaNsX9PH21EVXSyKU0EYin4HaNoHp
         UEtRcfdslQAxqZIgWN1FVZM5d7gBfvQFQw1GcOhK4eDIXFZqKom3OjIYmKU/MIqtMMc3
         Gr+7Ne4SFENhZJHp1pY2SyR5uENX6dLMmElGM7NwcYXU+X3jdjeByKLhCBooywkbcmyI
         TbQtTHlYEEE70YhMi84vJ3cbAJxF73jDW44rJqYWK/NZSfXTpeWkQvEpBaDOqzLBx5tg
         i6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+MytpzR0Ptco6lhW5ypgQc62YhMvyT9RlFOpOBvwqW0=;
        b=V7TSHm8W4/xk2E8zIA7lab/Z44NJR/gqtHrjqClmc2wijHl7EfFPruUzvE9+Xc5WVB
         to+xeS1IGVa1ojHAOMht0DibQKjJHRZvyJBEIeUjsg7O/QsVD00x1IJyQ2N7H9Ay3uai
         ziyijKJsHYkvg2Z5HHRxGCgpg/p6EP9y2qfkRbawYm66F+nlLcPpt6FCbK2tcooiVj6X
         ToLe+mLZsnMAoYCrSyzkoppwE70ekueExdycgAoCSO2NIz8ckmT6BUoBNRgLDgOLWVg2
         1QYJl3wcWbBSSoRe9z8UhDQyZgAcyKsgb0iChVmT3wpCTiLzi4rett4PEB/mWuKCOUu5
         ICIA==
X-Gm-Message-State: ANhLgQ1VJXElH8CzHCYZUPZSWK13iL3OgDqtrFw9gcWqsbIXIBQcLScp
        xx4KB+PZQHsW7NUCq0Px1BIKcLesnYhmxDHDmkk=
X-Google-Smtp-Source: ADFU+vu+fVtqNkcJchOr4OTei3aPL/1tt61CuPl2IjwN4KAXAjHDSqyTRWMyWBfZMtUFz2WBOojOujTb0aDoqAv6yiM=
X-Received: by 2002:aa7:d4d1:: with SMTP id t17mr3432346edr.362.1584991872240;
 Mon, 23 Mar 2020 12:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNOEmugZDWpvAHsOzmm_Fqo_Vj5GcC--GfTg3JHPm701HjBXA@mail.gmail.com>
 <CAP8UFD2bgzvc2K2Sj4HSeXo16kB8D8se=+=Y7gp6FN+4Y3C1BQ@mail.gmail.com>
 <47a1db25-914a-2e59-c0a6-6d0ff77bc2aa@gmail.com> <d676674d-7ab5-b476-8dbb-2b3323db2c89@gmail.com>
In-Reply-To: <d676674d-7ab5-b476-8dbb-2b3323db2c89@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 23 Mar 2020 20:31:01 +0100
Message-ID: <CAP8UFD3fAQyiXsO0w_uG6Oe8EfvkL6=ijUqHp4j8GD8A50Jo+g@mail.gmail.com>
Subject: Re: [GSoC] Query regarding Microproject
To:     Shanthanu <shanthanu.s.rai9@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 10:49 AM Shanthanu <shanthanu.s.rai9@gmail.com> wrote:
>
> I found the solution to my issue. The main error message I had got was
>
> > Expected FS format between '1' and '6'; found format '7' at
> > {hidden}/git/perl/build/lib/Git/SVN.pm line 310.
> After some online searches, I found out that file system format 7
> was 'understood' by subversion 1.9 (Filesystem formats section in
> https://svn.apache.org/repos/asf/subversion/trunk/subversion/libsvn_fs_fs/structure).
> That's when I realized I was using version 1.9 of subversion.
>
> When I downgraded to subversion 1.8 (which understands file format 6),
> all tests passed.

Great!

> So shouldn't the test file itself have mentioned (say as a comment at
> the top
> or in a separate README) that it was expecting subversion 1.8 or lesser on
> the system? I am using Ubuntu 18.04 and by default the package manager
> installs subversion 1.9.

It would be better if the test could be fixed to work with subversion
1.9. Otherwise the test could perhaps check the subversion version and
run only if subversion is version 1.8 or lesser.

> This issue might also be present in other git-svn test files. (I haven't
> checked
> though, not sure how to run just git-svn tests)

Maybe with something like:

$ cd t
$ prove --jobs 8 t91*-svn*.sh
