Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C1DC61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 21:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjBNVpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjBNVp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 16:45:28 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD8429400
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:45:27 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-530b85f118cso98997b3.9
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yFNXYo++t5qVEQSgtr+ZIaf3/b2RF6oNBQGXZFwRZog=;
        b=VhlOILmpP0wykswpzdOTM/qnR7AExGgVQqd3nUA2aikqbphqmQYsEzkRlk6cy7i0JO
         H315VdQcwux9s0CP0DTapfoEmMvbn7E3r+E+5BI1Q0iaZuM5A43WscYL9FYXttmEyVux
         JHpw/Pn8C2lZxi6yvJhLmt9h2GYg3nRGkqh4T/3m/wTyGqP2EDVvQesrYMEjE66R/51A
         BbkCZgAfjb3T83n42LCqz69oZCIEyz1pMGvAgbyENvQA5buPsWN0tc41P9KQ4GEJy1/+
         mYrtS8P+PoM0C4CbavDRHH6PMdjiR3c/Yde/pCa4bT14+u8MXuQb/mB6yqJ6+12ikpo4
         cU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFNXYo++t5qVEQSgtr+ZIaf3/b2RF6oNBQGXZFwRZog=;
        b=m5n7TzKw+zcgoRmh97DfbJj7w2jzQJSDSAsKTs0YwR9llkrXc7eq+mrm5UVZ3BUZVz
         sDXLX/kMYNpmocalT+Xdr8UdVXdgkbjYJFZGSV2R92fKIykQSeo8CtVw8W8KIE2JJYrn
         PNI8qqNikotgOFrX5P9pELy/TmBQzL9igcZVNXoheN06V4PrhL2Qr9jwdXSA5+3uI+jH
         R0ePWIDm2fAC8f+eyZD2GtSu9uh95OdIxyAdmgTp1fRCVNU3kFDj3/BURM+B80FEOYyY
         6edlACy1IBWj562WSXdvLizF21qcBCdSzll4Gd+em+KgJJ27W5ojdnRl8gGeSvvP4QC/
         evTQ==
X-Gm-Message-State: AO0yUKXQXOCYxdtwsI6AdrtKOrE/TzW8zE9VbcOy1sw5eRHyGlMgrKEG
        Q7UykxFGJJ7UwqzD06B7Mk2p0M0kGHH+4OJXgr5A7zaBjYbrXDos
X-Google-Smtp-Source: AK7set+EijbT/MzdhYLZgQE7Wyph5Dnvot/XHwvvwJntk0PrRS2LsdAMjyYOoQa7uVPuzE+6Kn3Twv+UhmBIT2Fke/A=
X-Received: by 2002:a0d:c187:0:b0:50a:87fe:1e45 with SMTP id
 c129-20020a0dc187000000b0050a87fe1e45mr5358ywd.338.1676411126160; Tue, 14 Feb
 2023 13:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
 <20230213182134.2173280-7-calvinwan@google.com> <Y+qgwHx52DSAfsEb@coredump.intra.peff.net>
 <xmqqilg57zxq.fsf@gitster.g> <Y+ux3DEd/p5emFWs@coredump.intra.peff.net> <xmqqr0us6we1.fsf@gitster.g>
In-Reply-To: <xmqqr0us6we1.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 14 Feb 2023 13:45:15 -0800
Message-ID: <CAFySSZDU0NG5Bod=5soNKXfiN08y2jCKYwdVO2Feo2bDGQU2gQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] add: reject nested repositories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 8:32 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> >> If we are keeping the escape hatch, it would make sense to actually
> >> use that escape hatch to protect existing "git add" with that,
> >> instead of turning them into "git submodule add" and then adjust the
> >> tests for the consequences (i.e. "submodule add" does more than what
> >> "git add [--no-warn-embedded-repo]" would), at least for these tests
> >> in [3,4,5/6].
> >
> > Good point. I did not really look at the test modifications, but
> > anywhere that is triggering the current warning is arguably a good spot
> > to be using --no-warn-embedded-repo already. It is simply that the test
> > did not bother to look at their noisy stderr. And such a modification is
> > obviously correct, as there are no further implications for the test.
>
> I did not mean that no "git add" that create a gitlink in existing
> tests should be made into "git submodule add".  The ones that
> clearly wanted to set up tests to see what happens in a top-level
> with a subproject may become more realistic tests by switching to
> "git submodule add" and updating the expected "git diff HEAD" output
> to include a newly created .gitmodules file.  But some of the tests
> are merely to see what happens with an index with a gitlink in it,
> and "add --no-warn" would be more appropriate for them.

I'll take another pass into the modified tests from previous patches
and pick out ones that are not specifically submodule related tests.

> >> Also I do not think it is too late for a more natural UI, e.g.
> >> "--allow-embedded-repo=[yes/no/warn]", to deprecate the
> >> "--[no-]warn-*" option.
> >
> > True. We have to keep the existing form for backwards compatibility, but
> > we can certainly add a new one.
> >
> > I kind of doubt that --allow-embedded-repo=warn is useful, though. If a
> > caller knows what it is doing is OK, then it would say "yes". And
> > otherwise, you'd want "no". There is no situation where a caller is
> > unsure.
>
> Yeah, if the default becomes "no", then there isn't much point,
> other than just for completeness, to have "warn" as a choice.

I don't see a point for "warn" as well. The default "no" case should
carry over part of the deprecated warning from before.
