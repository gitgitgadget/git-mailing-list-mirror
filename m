Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00349C2D0B1
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 11:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4B820674
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 11:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8aPEdHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgBDLzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:55:32 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:33516 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgBDLzb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 06:55:31 -0500
Received: by mail-ed1-f44.google.com with SMTP id r21so19561644edq.0
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 03:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wa1bOMa2XWScxmvQXE9xcIjw1XUUrN4tVT7iJY1PaPQ=;
        b=U8aPEdHqOwurlKMqsLEyNycSMTyZ6L/B2VjF1jo8clSQU5vl7vwp47xS7oybz6pvb7
         A9JJQqQD55rEhUVBSOiKvpupj+bWo3jfFnKRvxFzb4sqe83FbfLn7hwFBEInLbHPMA++
         V3FvTJGux+oKZsKn2cO/3x5c6kanY7afeYWUPHPfLaCucGoqHHrADxQtj7sxIebeinXn
         hZrVUJMCRIKkFt33GYeXpvTnsj7qmFFtJ551RyjnE+ksYY33eBmGS5oCvqPzuwmnMfWB
         EWcEwSHejYnq/iFUC+rkqVmesHOC38mYiyOWNR2S9yq5rsPD+Ue+g7LLvDz8KgpiDveb
         sY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wa1bOMa2XWScxmvQXE9xcIjw1XUUrN4tVT7iJY1PaPQ=;
        b=BVb9icZMh/75fg/5q6j77Le3dbk52KQvZ6OfPzZE0Z9J38Bq9/8bQkORAynDayvOPB
         AtTvBT6j8DN/3U1sk8HEMB0/D35vDGwfqatosp+UQH5gdHqubTfAcTnKw9zx3/9RESi7
         gL9AFEF29jxGz3l62SIdBOvTcC/JG82vP3nfKRguwCmp/z2e/q32cqZ5oIq/wQNnWTue
         KwgtEikdU4CsClIMYChJ94nwqif0KPwzZXEYYA3Zo/D4duUGlVfV+ZZ1cx6H1WoB64Hc
         Pbk493iReLLaLsVneF0gL6qAUyyEK7685f6BB9DNHTmBkLL1nYKj72uU1ZckWf661zUe
         uVEQ==
X-Gm-Message-State: APjAAAUmmUAicsC96vCJr0M4pqEuxJzxHXjINVPqRab+HoIb6PRYEzvB
        1NrqvAn4QO42PgRAqOSj73fKqrukGf3Wr2VQGx0=
X-Google-Smtp-Source: APXvYqwTQVjwdf/+83U+2gnWrlwsrF3rea7qx13STRsgpvSO6C5n1R3w27A7SmbJTgsb/5shlvro5Akc36MxdJh3Ymo=
X-Received: by 2002:a17:906:8595:: with SMTP id v21mr25922206ejx.28.1580817328520;
 Tue, 04 Feb 2020 03:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20200122053455.GA51054@coredump.intra.peff.net>
In-Reply-To: <20200122053455.GA51054@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 4 Feb 2020 12:55:15 +0100
Message-ID: <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com>
Subject: Re: GSoC and Outreachy Summer 2020?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 22, 2020 at 6:34 AM Jeff King <peff@peff.net> wrote:
>
> I notice deadlines are approaching for Git to apply for GSoC (Feb 5th)
> and for Outreachy (Feb 18th), though we still have some time. Do mentors
> have sufficient bandwidth for us to participate?

I am willing to mentor or co-mentor someone for GSoC.

(Sorry about replying only to Peff previously.)

I also just added the following file, made from SoC-2019-Ideas.md:

https://github.com/git/git.github.io/blob/master/General-Application-Information.md

As with https://github.com/git/git.github.io/blob/master/General-Microproject-Information.md
the idea is to not have separate documents for each year and each
program (GSoC or Outreachy), but rather point people to the same
document that we should update regularly.

Thanks,
Christian.
