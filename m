Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651C9C7EE23
	for <git@archiver.kernel.org>; Mon, 29 May 2023 19:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjE2TIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 15:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2TIU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 15:08:20 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4281ABE
        for <git@vger.kernel.org>; Mon, 29 May 2023 12:08:19 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5341737d7aeso3170666a12.2
        for <git@vger.kernel.org>; Mon, 29 May 2023 12:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google; t=1685387299; x=1687979299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=va8746K6HlcoPET1eCtExmYb8dDxYDUK1A6TOiRm9U4=;
        b=m4XOH54qSIgk37vwOjDRNUizukFgX7vu3fK+M2DVM4Y74J77H8wmcqzeoYCZlMYAGv
         jdxUDxeuBQknQxylgv3rGokaHTimctYs5DYxD7ZiHmEXYqhOcW2Ei/2e2P6qC3u9zqXa
         60UViDylexwA/upFYVlfYkyDUe8kHC4KU/JkBK81kxmZtBFstr+RW3XhL6oMO1c2QIXJ
         7oLYv80RtqPkchYrBwTU5GCOsV6gOvgOeyjQvt/xg7HPbEbAl6aELdooyEOwQWKQrGgG
         7z7FfZWNZ9YYjOotsxraPChoVNvgrXbiIUCkYpFTB+DDdaSlFonzcYz2sosbtM4qfHen
         60hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685387299; x=1687979299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=va8746K6HlcoPET1eCtExmYb8dDxYDUK1A6TOiRm9U4=;
        b=c4vDj8KLHrrNxZAwnw9vE0DiCwyntIxNfSeinlzdWjP6SMfQ9kX+rJ2mxG/RtBfSz7
         tYNwd7/mUu1foWDrCcMTYLgV2qoeMUi4mCNihI4kF6C6l8A5zFHpvAzqjSnjOJ+pT9T2
         Z6ECQVT3KpdGnJSDI3gvENpt3b9Pib7sPMTUuFUvB9JbxnC8ozOYoiRHS2U+KsOHNa7R
         H6+KV2JWsKNm5EHGn9QiLPfDr0geg/lPd2GyBiYPkywYZE2kase6Iw+VTdQVYOo4d4TK
         PWK6pdcQWSkKjM4hJiyXXsYsY0la84bw2/quK1oT7Q+md8/zZ6hlpIViaxURu6yarpR4
         MixA==
X-Gm-Message-State: AC+VfDzEcONKvPM+Yyx1dVYnW95p0gOXMI0eFHEB2TISk/kE4derUcZh
        vq4Ch+v/3CvnFKuwMU60Si9jG7MYzKlLS9SzJ0Q1ibYnrZchXGwLv1+cpA==
X-Google-Smtp-Source: ACHHUZ6T+/y5A4MwcwiaARCN1JVcYp9tETzXswAFnT3q+ja+2IQRYXatg+LjNk/7klHUqIn6eDcb69Y4spFbZ5h+tVk=
X-Received: by 2002:a17:903:550:b0:1a6:84be:a08f with SMTP id
 jo16-20020a170903055000b001a684bea08fmr59915plb.64.1685387298676; Mon, 29 May
 2023 12:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
 <CACoUkn6F_=JR5SYBWL2sVDxDVAZbxcV5Ruif6wLba-_q_QNiZg@mail.gmail.com> <198eea19-fc40-de0c-8854-3cdc94925f32@gmail.com>
In-Reply-To: <198eea19-fc40-de0c-8854-3cdc94925f32@gmail.com>
From:   Paul Jolly <paul@myitcv.io>
Date:   Mon, 29 May 2023 20:08:07 +0100
Message-ID: <CACoUkn4TOGi7xojSatEowF0CcFJHJof+F5XR-QtPTL5iznZDKw@mail.gmail.com>
Subject: Re: Automatically re-running commands during an interactive rebase or
 post commit
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Many thanks for your response.

> I think you could get around this by using a script that wraps "git
> rebase". Something like

That's an interesting thought. I will give this some thought, thank you.

> I did wonder if you could use a custom merge driver (see man
> gitattributes) for the file with the checksums but that would be run
> before all the other files have been merged. Another alternative might
> be to use a custom merge strategy that runs "git merge-ort" and then
> cleans up the conflicts in the checksum file. You can specify a custom
> strategy by naming your script "git-merge-foo" and passing "-s foo" to
> git rebase.

This approach with a custom merge strategy is very much closer to what
feels like it will work best.

I just gave this a try, and I seem to be falling at somewhat the first hurdle.

I have a custom merge strategy working, insofar as I've written a
script that is being called. The script simply wraps "git merge-ort"
as you suggest.

But I can't seem to work out how to actually run 'git merge-ort'! I've
tried 'git merge -s "$@"' in my wrapper script, but doing so my custom
strategy behaves differently to if I use no strategy, which seems to
suggest I'm doing something wrong.

Do you have any suggestions/pointers?

Best,


Paul
