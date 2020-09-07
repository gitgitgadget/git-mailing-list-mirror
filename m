Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B02C43461
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 18:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9466E2145D
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 18:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/Sh5Zr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgIGStU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgIGStT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 14:49:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F079EC061573
        for <git@vger.kernel.org>; Mon,  7 Sep 2020 11:49:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z23so19278498ejr.13
        for <git@vger.kernel.org>; Mon, 07 Sep 2020 11:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfss7/AUaoeixbmWxe5jxkd/rLXw0tdMava14K1i8q0=;
        b=E/Sh5Zr9mVWtaAe7YPFHlGUfQ7Ja8GW4lAl8zEXhbEoqKSsQntnZrBJrWNkMCpNBp8
         49Oq4l50vhXtRGJG/b/e+yYN26e9GefHZQ2VR2qzfxnbnaak+XDuUHSUSm7X417Le7qX
         6VKA8ABAE20O0J5+pXg2dxJWUboDfSPXpB7MuxYVrkBfGVKCCowKKhjcQxCBUo9WZBIr
         3YpO/SPoJV5ZvCK1qyFRu7xNYds2H2C6ZKjieNIC98zcJsQTBAU/hFKNQqIk5seJJ7yr
         vYUL56YuEoaPqQBylGgxSoUkbqNQFPLNUfsK5sHI2L1/NDwqFfxFNjvKZaR8RVR+tqN5
         PZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfss7/AUaoeixbmWxe5jxkd/rLXw0tdMava14K1i8q0=;
        b=hron653LFmGn+18QlQWQrQlyRW+VjKhIhU9gyvpEWviDzC/MQmvJYWcbhp1SHsnObd
         WF/odxFuHewItBWxv/JRd5qy4OMYyGgkGV+0nGoffF2eyOwZj04c03npJ2uTW2ccOlCr
         JZo7gh9a0RzPmGY+iGSxmnOUI+w82ykIAdJMaGf3uZWjug7on3gUrDiRHtJDJA/6wvJR
         AmgrZkzRaI/dt4HBzbqZDTMCDBgDkjoR7p6hI7P/GFSko7poqRNAxuFPlUb+FCCqpnba
         vG1lq0sBF8RJxqPy/oEq6w2CJSLhfPjzjjqa6RN4HgBXlgEPRpb6lpNoHdrWwsXSupb2
         /97A==
X-Gm-Message-State: AOAM530ZXFMRu8EQ31V1By1umk5Y2ur1rJl/EJaEQfA3q4eGdZrd4Cza
        1hYq+pLzrD+p6Ezsh8umgYocCrU25r6fdxmeZHtUjqV9DPA=
X-Google-Smtp-Source: ABdhPJzylOoQziy02jqGGIaGMvfu0wijLBYHD+OzShFyG8Wo7V8XJGibXPvj8qmQYrVQgiEsdmB1yT98CqaEpWDpXmE=
X-Received: by 2002:a17:906:1c5b:: with SMTP id l27mr23271912ejg.283.1599504554592;
 Mon, 07 Sep 2020 11:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <C5HAJYI9RDPU.1CPN4E1JCQCAQ@homura>
In-Reply-To: <C5HAJYI9RDPU.1CPN4E1JCQCAQ@homura>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 7 Sep 2020 20:49:03 +0200
Message-ID: <CAP8UFD1wS9GDhek0Rbo=E+csf_u32D+22EsLom=AFu5D1pAYYg@mail.gmail.com>
Subject: Re: Proposal: server-advertised config options
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 7, 2020 at 7:06 PM Drew DeVault <sir@cmpwn.com> wrote:
>
> The basic idea is that the server could advertise some config options
> which it recommends the client sets for a given repo after a fetch. Some
> possible use-cases for this feature include setting:
>
> - format.subjectPrefix to 'PATCH my-project'
> - sendemail.to to the mailing list address
> - push.pushOption to recommended push options

It could be useful to suggest promisor/partial clone remote config options too.

> Upon cloning, each recommended config option would be displayed to the
> user, and they would be prompted ([Y/n]) to agree to set that value in
> the config file for that repository.

Maybe the default should be "N" instead of "Y" for more security. Also
when not using a terminal, it should do nothing by default too.

> Additionally, there would be a
> config option which white-lists a list of config options which are
> automatically agreed to without prompting,

This might be dangerous if this option can also be proposed by the
server, as it could first propose a big list of white listed options
to the client.

> and each config option would
> have one of the following states:
>
> - accept-silent: set the option without printing a message
> - accept-verbose: set the option and display a message
> - prompt: prompt the user to set this config option
> - reject-silent: silently refuse to set this config option
> - reject-verbose: refuse to set this config option and display a message
>
> We would default to reject-verbose for all unknown config options and
> include a set of defaults which specifies the appropriate trust level
> for various useful benign options (such as the examples above).
>
> The implementation would involve advertising config-advertisement in the
> fetch protocol. Both the client and server would have to agree to use
> it. If the server supports it but the client does not (in the case of an
> old client), it could fall back to printing the list of recommended
> options to stderr.
>
> To choose which config options to advertise, a new option would be
> introduced (uploadpack.advertiseOptions) for example, which has a list
> of .git/config options from the remote repository to forward to the
> client.
>
> This would be a lot of work so I'd like to float it for discussion
> before getting started. What do you guys think?

My opinion is that you might not want to start working on all the
above at once. It might be better to start small and safe while
leaving the door open to further improvements.
