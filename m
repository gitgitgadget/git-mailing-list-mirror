Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710E0C433EF
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 19:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhLaT1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 14:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhLaT1o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 14:27:44 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D37C061574
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 11:27:44 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o6so111603768edc.4
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 11:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwSEAVMAfBRNSxMNx8vUp7QGc40qoLoFI8irPcbq7aQ=;
        b=n8ggCYrPk41ip68gqQuEl38L9JGL8IfSjswufF6x5T+jBhkpF1GR1xifcjQ/bBOR9e
         W+vbw1vsEBCcJ6hVvo6tntHTPmzPcsEQC5yFcoy9uBLg14WupQPABlqEQDPUzjG8rTLu
         zY3YlI0OpslhCaHCsinuHyv/sRJqFttQEPcAqfSe9Y0/uaNipYciUMUJrsiZ18ns6xWp
         2mfRQMeRO+aJ7X3tStOil/hdOY/gnaWEmlDiz1bGFstK+Fa028it41GmdMtjf5dP0tTH
         4IdxDsMj01ukMxLcexn331T90mbIWFX7fqNAUBTqe4fH/YYcGXi+LcFLLjH8fE6GpWUC
         a1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwSEAVMAfBRNSxMNx8vUp7QGc40qoLoFI8irPcbq7aQ=;
        b=YcuvDEJwa16Bngkb0N4AeoS1ecWiBRDhmcqOQSKqzMoTztAjqOOpY9zEx5HQumrUyH
         ggAg0ObL7nOuSGU/A3whSZfhVOIqOyPaK63VpSW8TXNVeBkUOxg1ScTpW0JxtNysaAsh
         9K2BFStxsg4Jf+n/55Stx9jjlaRe97L5vpeECbZ+wy5dzCvXfUvlSKgoPuGPslgeF3Kn
         j33G0ANZJUJxynR55tqRlwNgbHaDrgRVou3H67DBsRYyyj96Zjlxw/GwBXj+b4htvfq+
         kOFhP7Q86BmUFOazxx/4Ukl3n3F5y0rchRpSxuoIx+8X6PR9N+4+IWf67vyE0A3mk23g
         OsKA==
X-Gm-Message-State: AOAM530++UX6gRe1dUDowWniKgfrg1zdx49bvZCBZgduE4wUut9nA7DU
        kBYa09ksZArcxAzs0AIApS5xqSO8CSBaU2qmSvM=
X-Google-Smtp-Source: ABdhPJwYR6cEtvK/lZmC5gJJq2MMU/9gICnNmMQe8MdnAAvSfY1jGBdyObrvo5Q6ZqO/hEKotyG6Fx+UnTnttaORvDI=
X-Received: by 2002:a17:907:160e:: with SMTP id hb14mr28821248ejc.328.1640978862719;
 Fri, 31 Dec 2021 11:27:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <a7f3ae5cddaed61a618a5fa2f9d9c888e0dd7d99.1640824351.git.gitgitgadget@gmail.com>
 <cd190111-1930-9538-a844-4d9aa08d98b0@gmail.com> <e6728ed1-52c6-05eb-e816-a9d919d3e9d1@gmail.com>
 <63bb7366-71f6-d4c3-529f-c52d3610c1cd@gmail.com>
In-Reply-To: <63bb7366-71f6-d4c3-529f-c52d3610c1cd@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 31 Dec 2021 11:27:31 -0800
Message-ID: <CABPp-BGun+v3BCuutPW2L1q3wzdB+Etuh_0Jz1aFanivZmyXWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sparse-checkout: custom tab completion tests
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 31, 2021 at 2:30 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/30/2021 11:19 AM, Lessley Dennington wrote:
> > On 12/30/21 7:43 AM, Derrick Stolee wrote:
>
> >>> +    (
> >>> +        cd sparse-checkout &&
> >>> +        test_completion "git sparse-checkout set f" <<-\EOF
> >>> +        folder1 Z
> >>> +        folder1/0 Z
> >>> +        folder1/0/1 Z
> >>> +        folder2 Z
> >>> +        folder2/0 Z
> >>> +        folder3 Z
> >>
> >> This tab-completion doing a full directory walk seems like it could
> >> be expensive for a large repository, but I suppose it is the only way
> >> to allow the following sequence:
> >>
> >>     fol<tab> -> folder
> >>     folder1/<tab> -> folder1/0
> >>     folder1/0/<tab> -> folder1/0/1
> >>
> >> (Hopefully that makes sense.)
> >>
> > Yes, it does.
> >> It would be more efficient to only go one level deep at a time, but
> >> that might not be possible with the tab completion mechanisms.
> >>
> > When you say one level deep, do you mean that from the sparse-checkout
> > directory, tab completion would only show the following?
> >
> >     folder1
> >     folder2
> >     folder3
>
> That's what I mean by one level deep at a time, but I also am not
> sure that that is the correct functionality. I would leave the full
> expansion as you have now as the design.

I think one level at a time is better and is the optimal design.  By
way of comparison, note that if I do the following:

mkdir tmp
cd tmp
mkdir -p a/b/c/d
touch a/b/c/d/e
cd <TAB>

I do not see a/b/c/d as the completion, I only get "a/" as the
completion.  If I hit tab again, then I get "a/b/".  Tab again, and I
get "a/b/c/".

I don't think normal tab completion recursively checks directories, so
it'd be better for us to not do so with git either.  However, if it's
hard to avoid automatically completing just a directory at a time,
then I think a fair first cut is completing to full depths, but call
it out as something we'd like to fix in the commit message.
