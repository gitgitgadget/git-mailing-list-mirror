Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADC0C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 23:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiCBXyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiCBXyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 18:54:16 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C685413AA36
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 15:53:32 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id 11so3205457qtt.9
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 15:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+6zsAbIWuJAXWdGQhiO9NlgQObaLCVh8EqvbcWlmnso=;
        b=5cXG7OlkisbW1nbZfOrsToJoptKKYF5oF5geZx1Vd2TVE4LxjE0FTTcuO5CkeHxkK/
         2zml0fmntIbcg9XFRz2CspZUGP6/eO4bUQkguCihrnIVl22EjWssIzniztFKgm5EF886
         60wwD0XpMBKb8oBcpsgAARZv4GO0KgRBR4TLnuY8zLU8xXLK0k2ACviL8LaUP9Pjfcyy
         TNmZIw5J1IOo9DFb4GGp5vXAnWZc7TqU/pgtKAjzan1GGVNu4Aw+KaPwLfRgNszsq3sa
         hq4fhPkDJclyj6UT5BvCvKS42jujncgYSr5r+lVVZvRO1h4BZExbm1kSEnIRdb5REQBp
         x0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+6zsAbIWuJAXWdGQhiO9NlgQObaLCVh8EqvbcWlmnso=;
        b=uSXsA+rZpa40fRb3qaGE3LHRWGkXM4HU54MgmeTOEMo1p8QCTUgde0GqdKwcwX7Dw7
         UJZ1c2roR2kSL+ZBGB/UjRTCL7qdZ3gMjq+BF98x9HoUPOal8zhQZS7WdNjcOy7JRU/J
         phpBKqbAL+o0MA6KCcDAGR1aLFlEiR/p7Fwqj77Q6qnKN9fbI2WUBmyAeKAvraYG3VnR
         SoXA9cEtuXCqpGdO1Ar6a+Zidf1xH8bEAnTVuExo7uy1K6mtDwkPehwOAGKunRMh6TJe
         fKgFaALKuehjIsSPeLW0g+EXaz73BTH8vwokqJB7u1yH0m69WmcltBnSkA+MqsMIllco
         /L+Q==
X-Gm-Message-State: AOAM533iS9SyhJVNJtQVO510p4tB0jKyOR1vt+oj/We3IJU8H2nWlIiP
        6xhMONpMG1cCJCYPNjRYG9a4dAL+02oXbzXt
X-Google-Smtp-Source: ABdhPJwrcmNiJQI2wxDlOfG8ykdCkY8i6hAM/9+e/9iKYi/324UUgvFnEWQSutveK4OV8kXsZCUP7A==
X-Received: by 2002:a02:cd91:0:b0:314:2535:6f75 with SMTP id l17-20020a02cd91000000b0031425356f75mr26055337jap.307.1646261713356;
        Wed, 02 Mar 2022 14:55:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u19-20020a6be413000000b0064103112badsm192234iog.45.2022.03.02.14.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 14:55:12 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:55:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        gitster@pobox.com, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] builtin/remote.c: show progress when renaming remote
 references
Message-ID: <Yh/1zFChEXz7r1vN@nand.local>
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <220302.865yow6u8a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220302.865yow6u8a.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 02, 2022 at 08:00:59PM +0100, Ævar Arnfjörð Bjarmason wrote:
> So please have this by "int progress = 1", and have a "PARSE_OPT_NONEG"
> "no-progress" option instead, there's no reason we need to propagate the
> existing UX mistake in "reflog expire".

Yes, I agree that `git remote` is unlike other commands where you have
to opt _in_ to see progress, not out.

But I deliberately avoided doing anything about it here, since this
patch is more about making an existing set of arguments (`git remote -v
rename`) do something more useful than before, and not adding a new
option.

In other words, I felt that because you could already run:

    $ git remote -v rename old new

that it was better to punt on any changes to the option itself until
later.

On a similar note, it would be nice if this option worked on either side
of the sub-command, like how you can do either of:

    $ git multi-pack-index --object-dir=... write
    $ git multi-pack-index write --object-dir=...

But I don't think we should let perfect be the enemy of the good here,
in case you were suggesting delaying this patch until we sort that issue
out.

> [I reversed the order you wrote the following, due to the obvious
> digression...] :)

;-), thanks.

> As an aside I think the reftable code "emulates" the D/F conflicts of
> the files backend, but I'm not sure (this is from vague memory).

Perhaps, though I'm admittedly not familiar enough with that work to
tell know for sure, either. I don't think I have a ton to add to the
lower part of your reply, so I'll stop here.

Thanks,
Taylor
