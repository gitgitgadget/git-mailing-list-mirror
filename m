Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70654E92FF8
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 09:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjJFJCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 05:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjJFJCR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 05:02:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2299993
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 02:02:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b9faf05f51so104743166b.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696582933; x=1697187733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IsrntlD6J9SvIe8pO7W5BHlyQW4LbIVdyhHilawyqY=;
        b=VPa+kjAq43rMuyQG87dKZvbF7Ve01MhgWkcWFvn1lH/mrp0jklKHayTHGFGbHZEF1P
         1XFT2apfQAaFxuYnQjkHhuMTAUAA+VyrQ1s/HgiaPP9e6Y7sZNOrdSE5s/n+El6f51ZI
         ZYARGrUBy98BPEZyiPNvzt5ibAVa46IN5aNXfwXZx8+1+HFUY92111hxBDVFCRGe24UR
         Grb764JBSS99UVKhTxhFsd9r5q/iFdr3D9QpVwlgVPI2wLHYnTD5IBWHq0vUAF736OF0
         shIc2dwnl5vGCdVnuhtERNhgyM3l8AFmABcBsvCcuA1Bo+CL5eQi1L+b/vyw190n3wXv
         9PYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696582933; x=1697187733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IsrntlD6J9SvIe8pO7W5BHlyQW4LbIVdyhHilawyqY=;
        b=WefRdc4J3tseCHkMzKhsPEuq+VeUjex9vUdFasrukNAznh6brZs1WE5ZhwWXIj4SPQ
         wRGFPooO/lidXte2AASFbqulpiHe4GsfnAcEYSuR3xcVbHpO8ZEkOSEqazG1/N0a+EVD
         cerjJCgsPEljYpZxIQM2SlbAh+wI1T+10ZKpb27O4Sva3k1ohruJQJBly0ssO2TQO54K
         IooWcyJFShPULS/oOo76sPdB/ZUfuM7KBiD7nV6KDy36hOLudqxSjTFi/vB6WZkpflar
         C5sRwYZPSYGxSKLH3Mzzr7rQ4omLv06pChxZGkL3JUq1R633b8nyAaQ4DIDkF6egtIn+
         AkSQ==
X-Gm-Message-State: AOJu0YyQMY4Dpa9cBFsjDhz2MfxlVI7DJosh54D1WvIhs6Xtr2hNnSmk
        9KHJyftV08aNO/7En+DFnYSE4BZsUpheXl+wl/A=
X-Google-Smtp-Source: AGHT+IF7zD3cUf9SD+Nkiyf5zz3Tm5sf6pH9U3ElpVWKRNPWKXox/Ic1Ev15znqlwX1oTK7R7gG0EgomK8bocpvlJ7U=
X-Received: by 2002:a17:906:1ba1:b0:9b8:7746:f180 with SMTP id
 r1-20020a1709061ba100b009b87746f180mr6721240ejg.73.1696582933193; Fri, 06 Oct
 2023 02:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <CACS=G2z84_-WkWa-BnK8bNNqb9z_o37BC3-kb_NkrjzAL=r4Sg@mail.gmail.com>
 <xmqq7co0elnt.fsf@gitster.g>
In-Reply-To: <xmqq7co0elnt.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 6 Oct 2023 11:02:01 +0200
Message-ID: <CAP8UFD1cd5YZqAxYbYUMNkAYJLLGjBpNe_NK5nVq3eLxxSDzEQ@mail.gmail.com>
Subject: Re: How To Pick And Work On A Microproject
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Naomi Ibe <naomi.ibeh69@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 6, 2023 at 12:42=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Naomi Ibe <naomi.ibeh69@gmail.com> writes:
>
> > "Select a microproject and check that it has not yet been taken or
> > discussed by searching the mailing list. Public Inbox is your friend."
>
> Yeah, that is VERY unfriendly.  There is no mention on the pool of
> microproject ideas from which you can "select" here.  I wonder if
> some HTML link is missing in the sentence (i.e., clicking a word
> leading to a page that lists what you can select from), or it has
> always been like this.

This sentence has been like that for a long time. I have just improved
it to the following:

"* Select a microproject and check that it has not yet been taken or
  discussed by searching the mailing list. Please read all the
  sections below related to finding or selecting a microproject."

I have also made it clearer that the list these sentences are in is a
"Summary of the steps needed to complete a microproject" by adding a
section with that title.

> Later in the same document, I see
>
>     How to find other ideas for microprojects
>
>     First check the specific page(s) or information about Git
>     microprojects related to your program that should have been
>     published on this site or on the GSoC or Outreachy site. But then
>     still read on everything below!
>
> which is much more realistic, as long as the "specific page(s)" are
> well curated (which I have no idea myself, as I have never been in
> the mentoring pool).  Naomi, have you checked and found such a page
> on Outreachy site?

There is no such page as I haven't taken the time to write one. But I
have added the following paragraph just below the above one:

"It=E2=80=99s also possible that we haven=E2=80=99t taken the time to put u=
p a page
listing microprojects ideas for your program. The pages we used to
create for that were named =E2=80=9CXXXX Applicant Microprojects=E2=80=9D w=
here XXXX
is the program name and a date, for example =E2=80=9CSoC 2016 Applicant
Microprojects=E2=80=9D for the GSoC in 2016, or =E2=80=9COutreachy Winter 2=
021-2022
Applicant Microprojects=E2=80=9D for Outreachy in 2021-2022. See the follow=
ing
directory to find these old pages that might still be useful:

https://git.github.io/Historical-SoC-Outreachy/"

I am not sure how others feel about this, but I think it would be
better in the future to not have to prepare such pages, and to just
have a section with a number of examples of good microprojects on this
https://git.github.io/General-Microproject-Information/ page. It will
be easier to update this section when we know about other good ideas
or better ideas, or when we want to remove an idea that we don't
consider good anymore, or just update an idea.

> Then it goes on to suggest finding a bug report, but I tend to think
> that fixing them is way oversized to be a good microproject.

I agree that it's oversized for most bugs. I have just added the
following paragraph at the end of this "Searching for bug reports"
subsection:

"Also some bugs are difficult to understand and require too much or
too difficult work for a microproject, so don=E2=80=99t spend too much time=
 on
them if it appears that they might not be simple to fix, and don=E2=80=99t
hesitate to ask on the mailing list if they are a good microproject."

> And finally it gives a casual mention of good+first+issue, which is
> probably the closest to what _should_ be listed as the first place
> to try (sorry, I however do not know how well the list is curated,
> either, but from a cursory look it looks legit).
>
> https://github.com/gitgitgadget/git/issues?q=3Dis%3Aissue+is%3Aopen+label=
%3A%22good+first+issue%22
>
> There also is a mention of #leftoverbits in the document, but by its
> nature, they can easily become stale or irrelevant, and they tend to
> be more real issues, and I would expect them to be unnecessarily
> harder than what dip-your-toe-in-the-water-and-say-hello
> microprojects need to be.

I have just added the following at the end of the subsection about
#leftoverbits:

"As for bugs, and many things really, you can also ask if you are not
sure it's simple enough to fix."

Thanks for reviewing the doc!
