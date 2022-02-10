Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D82C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 03:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiBJDLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 22:11:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiBJDLS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 22:11:18 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCFA1EADE
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 19:11:20 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id u13so4618088oie.5
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 19:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aEEbaFIpQSPjX/YKfW+YvJj+KS3gMu+QrqcRsxmDM08=;
        b=MJTr7sQWOJApUp4JhxOZH1z+UwijKc0024tNZ6uh9eqVuo7dzDjHl3F2hgmsxQLH9d
         RO9WWAS273xFML3YoNAeIsLBLaz0wmXNGhtF3o/al8PfUoI8AAUnIZ7aVIDLCFCnBIFL
         t1hu/+N4/12/ElaloWVbfCuAwlKBa3biarC5VsPphyL3Ghpu98Fs4GNp8yLiIvK7850Y
         gi6wJcIjI9A0ZTSmXUS4PAxex0JmEbCJ6bZdZAW7rZXHkpHW28KkHa57m0NuzImwGM87
         3zJkjAXdFxzk3HRjvHw6DDkm+Vhi7SmuLVrkeLQFOXSzQNgfLZfRU/qlwE8mC5uQHfRk
         nxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aEEbaFIpQSPjX/YKfW+YvJj+KS3gMu+QrqcRsxmDM08=;
        b=rl5mvlBFuVb69DnI0enKq9FsWyil4dsSqV1YWqyU6hPHe/lyiyClOnlyr9xafKYREd
         1D6x3Do9tg2OG7+/kYFZXlM7QnyGUPDcDfWayplwqfjrP4onRnUdWGxEsznfOzGCVm81
         Hb4qJdnSdxETMHpQijGU7NSy1soLD4QVozT8kPylMA4EfG8uPjKx6ZW2NN81mSfCbvzz
         ZTB/pQ5lGnkgZOsM2EpWV6NUyH5TRULxcFVJ9vV6O/A2rro5uBSvlZ14rWMVlX6NHHo+
         THRRBbXa7BbyZRwjbWaTymFteH7//0dFCF3EhKTjAlVcTRFKgoUHm578TsnCaVBFEGOW
         TI4w==
X-Gm-Message-State: AOAM530ycDqpf04QwBBp35OCiwso5ph6rl8vt7QO1OmIveeLJDGa+/PA
        wOufMGq+kx1HuOUl0ABrMokCEF7+8Acku14iCde9LN1V
X-Google-Smtp-Source: ABdhPJzqckfsj2LnAuoPPQayBY1xI3jxSo02APzbvbdbTEPeIbt5ykmkNemOQryulxquzSI1H0ZOqHbkehO2XsURlGI=
X-Received: by 2002:a05:6808:d47:: with SMTP id w7mr222887oik.78.1644462679913;
 Wed, 09 Feb 2022 19:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20220121102109.433457-1-shaoxuan.yuan02@gmail.com>
 <20220121102109.433457-2-shaoxuan.yuan02@gmail.com> <Yer/oEZK6TBFSsde@nand.local>
 <xmqqr190g6gd.fsf@gitster.g>
In-Reply-To: <xmqqr190g6gd.fsf@gitster.g>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Thu, 10 Feb 2022 11:11:09 +0800
Message-ID: <CAJyCBORHE2+UMKYFfKArgK68fAT=pKVabVmfifzg--rHAFkaqg@mail.gmail.com>
Subject: Re: [GSoC] [PATCH 1/1] t0001: replace "test [-d|-f]" with
 test_path_is_* functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Since I didn't see this change in seen or next, do you plan to apply it?

--
Thanks,
Shaoxuan

On Sat, Jan 22, 2022 at 4:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> -    if test -d "$1" && test -f "$1/config" && test -d "$1/refs"
> >> +    if test_path_is_dir "$1" && test_path_is_file "$1/config" && test_path_is_dir "$1/refs"
> >>      then
> >>              : happy
> >>      else
> >
> > Looks very reasonable to me. Indeed, this line comes from 6adcca3fe8
> > (Fix initialization of a bare repository, 2007-08-27) which predates
> > 2caf20c52b (test-lib: user-friendly alternatives to test [-d|-f|-e],
> > 2010-08-10) when these helpers were originally introduced.
> >
> > I thought that we could probably just shorten this to calling
> > "test_path_is_file" twice: once for "$1/config" and a second time for
> > "$1/refs", but that assumes "$1" is non-empty. And to ensure that you'd
> > need another check, which amounts to the same amount of code overall.
>
> I had the same thought.
>
> Since the first "$GIT_DIR must be a directory" matters only when the
> caller is crazy enough to have a bare repository at the root of the
> filesystem and to think that it is a good idea to say "" is the
> "$GIT_DIR" (in which case, "test -d ''" would fail, even though the
> tests for /config and /refs are checking the right thing), I do not
> see much downside from omitting the first one, but I think that is
> something we need to do _outside_ the topic of this change, which is
> purely "modernize, using the helpers we already have, without
> changing what we do".
>
>
