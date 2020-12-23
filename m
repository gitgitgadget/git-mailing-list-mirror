Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37802C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 13:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D6E22571
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 13:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgLWNi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 08:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgLWNiz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 08:38:55 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7749EC0613D3
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 05:38:15 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id j20so14993968otq.5
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 05:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=w74y14i91hezbc+JtNDI6UKGtk4P9VH3T6zlOU45GT4=;
        b=OF1zVsU5y1Fm1AaddIVazZ8RIJlJhkVPGiV9miHn5YMpCqYoUZekcnqscP5ikkBR6B
         YNE09jnSD0Gtj40gLY9XF1Jv3hWPt1vskRon5LYrwTbskvGh6giQ6GJE5CvavU2EABG6
         FaMIab6Nn+jFX0ekweGdrdbMxWiDJ2cQjb8XwS1ULn6TpY2iw4qj+Dj1r3e9R1lpZBTc
         FlFRCjJaKunWy4DjI63kCsqULi6a4gwipZdEVl08o+pmGQFDJQ592u1EcIE0JjuuZD/T
         wabTNiAj63kGVedNFQrlYGnWGzQKbvE+OqBM3Z5CVzH/zjgEAkefpoz/joA8Nsaz0Kt+
         jOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=w74y14i91hezbc+JtNDI6UKGtk4P9VH3T6zlOU45GT4=;
        b=aqaqRGjJoeAHvgcVceP4iKNCoCg7gzRb+vGV3Gexmo1FMUWgC6Xro0BSUc+Bn9BQQ5
         9RPhklNiTjhkDn7tzRH0o4BHJgdbLIt97JEl6JasSobSjlyFtOObjH020ZmQk4FDqEXc
         6R6TnrGIclstxb9iB3uYVh1UdyEaJ+AJgDkCzIIsuCBUt6Jn7OwojGiFGgcKoKjOjVud
         afKtk7j/y3Y5CDsa1j6pcjwW6sWZDfDpFNLO6n3d0GqKuxNDNBc3n0Cv7bVj6tPfUYre
         8uEFGP6ktgR9g4r+ZK74n8mniFa0PenoLsiCwpqvViYC9TeYTvTk5HJ4cah4my1jtIPc
         88WA==
X-Gm-Message-State: AOAM532DS1WvJuG/bniOd9svPAX6gqmxmf9O9C021rTXk7EG7n/tWs39
        dj20jrSDyI3aezgoT+gLilQ=
X-Google-Smtp-Source: ABdhPJzVqcwAJ8a1w8AM7ImgUeZB6tvbienPbjNPKxTvhT/2Ovqb7LqfQi68WsAzqwg256eb5Raqeg==
X-Received: by 2002:a05:6830:3154:: with SMTP id c20mr20480648ots.286.1608730694863;
        Wed, 23 Dec 2020 05:38:14 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l21sm5480996otd.0.2020.12.23.05.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 05:38:13 -0800 (PST)
Date:   Wed, 23 Dec 2020 07:38:12 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>
Message-ID: <5fe3484465fac_198be208bf@natae.notmuch>
In-Reply-To: <xmqqy2hoanps.fsf@gitster.c.googlers.com>
References: <20201219140621.1961760-1-felipe.contreras@gmail.com>
 <xmqqy2hoanps.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH try2 0/4] completion: bash: a bunch of fixes
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > This is just the bug fixes from the previous series.
> >
> > These should be pretty obvious and straightforward.
> >
> > Felipe Contreras (4):
> >   completion: bash: fix prefix detection in branch.*
> >   completion: bash: add correct suffix in variables
> >   completion: bash: fix for suboptions with value
> >   completion: bash: fix for multiple dash commands
> 
> It seems that this tickles some platform specific glitches in the
> tests (the detailed CI report can only be seen when logged in, it
> seems):
> 
>     https://github.com/git/git/runs/1597682180#step:5:35614

I found that output very hard to parse, but I think I understand the
issue. It's interesting.

Apaprently macOS uses zsh by default, and in zsh, this:

  local sfx
  echo "'${sfx- }'"

Prints an empty string.

That's because in zsh "local sfx" is effectively "local sfx=''" which in
my opinion is a bug.

I did catch this issue for zsh some time ago.

I contacted the zsh developers a while ago, and that triggered a huge
discussion, since they don't consider it a bug, but they are working on
tentative changes. That's another story though.

My previous series with 26 patches didn't trigger that issue because I have
fixes on top of of __gitcomp so suffixes work correctly, and the code
can eventually be changed to:

  local sfx=" "

That makes the completion work correctly for both bash and zsh.

I see 5 courses of action:

 1. Drop the offending patch: this is wrong because the bug is still
    there, we are just not checking for it.
 2. Add a BASH prereq just for that test, or test_expect_unstable (we
    would need to add extra code for both of those).
 3. Add the fix, but not the test for the fix.
 4. Backport my __gitcomp to make the code work for both shells.
 5. Update the patch series to include all the changes up to the point
    that is fixed.

For me obviously 1 and 5 require the least work, but in 1 the bug is
still there, and in 5 the patches might get stuck more time than
necessary.

Either way I think the real problem is that not enough eyes are looking
at these patches, so it's unclear if and when they will be merged.

The issues are real though, and they are present in the current code.

Cheers.

-- 
Felipe Contreras
