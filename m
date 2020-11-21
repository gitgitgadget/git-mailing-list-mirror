Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B40C2D0E4
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 01:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9192237B
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 01:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXNpMc0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgKUBxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 20:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKUBxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 20:53:25 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D533BC0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 17:53:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o15so12776487wru.6
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 17:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzYGzbEajEr4mvbGk1s/HVH0GtVHndCPMQ4pPytRP7A=;
        b=pXNpMc0AGxLSF4Zk/DrJ6mP8dEhiW0ox252uBKoO1rFQ+hFdoiNO/xqGfORj2nQIM7
         Wm74VOWlZUPchW0IHxMCxqa+H5aLKY2BXlsMiEFR83ivuD8YPXeTvg0AffVh03/ddPMy
         E75XlmLovUStPRD5CsLDaTjGBIDRT2Al2a/sFO4LYvvB/iG3O2chv2UmD2i91vaqkHlx
         R+IP82OAMD18G+Sf8GqoQ9o6FuGms/PtOVKnc8yrr9TMkcn7znGvnY1kIBjUekZ+JPIl
         QMZvOh3N9CiEVl71hDMEewcPXNu9US4F+ODL5Osi874/RAq86UVu9SJbAZgMj7b4ogFw
         EwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzYGzbEajEr4mvbGk1s/HVH0GtVHndCPMQ4pPytRP7A=;
        b=mK+xdTY/hmKxNWqThPhH6I6znyukgBZEq6LnIeN0UQECy2pY/2Zer+qnvwRGujgXA2
         zXVTgvozzILYSGiz4JTbmOi4GMzgysE5LE/P4hFVPBJeUNdbbiu5Gyd2o+yhIbpWUf8c
         kiQ9K1epec2T7oI+WJ+g2GNyzWGwgBpw7k5vhmFv7CR1lVXS06s3OgCJYGiZ9f185RNn
         jCYojQjAux9hOBNM8or2Kqy8iOTUX+oXOAlTG2woQMmci5Tb/+HWZf/Kij0JFKYNlElY
         tFPt5oeuWzq38P58w8DtNgHbCO0u3MZalY8HNR5zAxQcd4fL7b44NVqL46Bbfc7ClxmV
         T4/A==
X-Gm-Message-State: AOAM5323k6CJUBgbNTYbiAwHg5qca72GSYRos3wR3h7DgWsvFyrTFv5T
        owwr3mdYoihPVv6vUn6OInxN/0/YTJnsueSHVLc=
X-Google-Smtp-Source: ABdhPJxo4dTOwf+W7Ln3D+0llH0qnrRRuORJyuPDbCGsYs36ALVKwrNuhcYBGu0aktD4fXPysDTMh/KBelWB2D5pxqM=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr18689781wrr.319.1605923602532;
 Fri, 20 Nov 2020 17:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20201118091219.3341585-1-felipe.contreras@gmail.com>
 <20201120235203.GA353076@coredump.intra.peff.net> <xmqq3613tuwy.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq3613tuwy.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 20 Nov 2020 19:53:11 -0600
Message-ID: <CAMP44s2yi2v8ghoQ7ZsuxnFU66Hps1DRn3a1ytqBOqS2+pzLsA@mail.gmail.com>
Subject: Re: [RFC/PATCH] Add fetch.updateHead option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dominik Salvet <dominik.salvet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 6:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > Thanks for working on this. Regardless of whether we change the default
> > behavior, this seems like an obvious improvement (and I do think it
> > makes sense to eventually change the default; I'd even be OK switching
> > it to "missing" in the near term).
>
> I agree that "missing" would be an easy thing to take, and I do not
> mind seeing it made the default in the near term.  It won't break
> existing expectations too much, and can even be seen as a bugfix for
> the current behaviour by making "init && fetch" a step closer to
> "clone".  Beyond that to modify what the end user already has is a
> much harder sell.  For some it may be an improvement, but for others
> it would be a breaking change.

Changing the default to "missing" breaks a lot of tests. I already
have the fixes for the tests, but this can be seen as an indication
that the expectations of users would change.

I never knew of this $remote/HEAD feature, and searching forums some
people seem perplexed by its existence and ask how to remove it.

So, if the "missing" behavior is the one we are targeting (which I
argue we should), we probably need a warning before doing the flip, so
that users become aware of the feature and are not surprised by a
sudden $remote/HEAD popping (or repopping) seemingly out of nowhere.

Cheers.

-- 
Felipe Contreras
