Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD421C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B306661378
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhELES0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 00:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhELESZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 00:18:25 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE166C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 21:17:17 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id f184so923178oig.3
        for <git@vger.kernel.org>; Tue, 11 May 2021 21:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=zUlRTYytMse5ATY4V+uWQPjYe5ZgGsXWt9DFb5LftF4=;
        b=n35Fc4VjfsuQkUxdwhFZZsCkXWRpGn4QyxDAP3Re1BAmabOdRqUlNhHQxRg7nYpXql
         Tik4WlOqwpeHSWabc2YRu0ZwGBT0TtUtsMwiLvi+yXgE/HPkORiBN4HvGR4JONChPKJ6
         G0FaVx4FO9SfUlBIraCtORd/E9ERXkbghdZU2NZckMRK/Dd3diZzRm4O8Ctn/RxMXHQl
         P6GJcaQtLvep5QohPwQuSppvc1So77ifr+KaCM6K9KgHkLNniPofq+A2TzpDCl8tuPyz
         j5u+6pe7LdIQB2Fn4gLmuGQs+LwtKpkhm5FkyY0iOQH8g4yEI+RwZhYdD49xT/kVxS1S
         1dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=zUlRTYytMse5ATY4V+uWQPjYe5ZgGsXWt9DFb5LftF4=;
        b=WpTaMm5pLDR7KKqJLoQyZlNEVd8Zp/weOUCPxbiAASkorqziPSiAh8Jv03kUOKNF2I
         Ysn9Z5kmRQp36rmPjiRNcGexwMWkMEIc2ulQgpnYdyH0y97xKGgu7c2qOhMPZlWdrIRN
         kJ37BsRVFSfsKjuvLj+21PyzKLQqxDx2Rm9anAlh3J8bfT00USsNlDqzC02i3CqXhZ5z
         3lJ2t3dl5i3PW1FaT7AEGApCGbHVDAdZu/dYk515QjxVd+ZXoXt0pR4Q8UnV1mOMV1XT
         ltd2+o1+orhv2nlS5LGQv0Jy0HRkZQAAJO7dXo6r5AbMYDJ/W9DX5AApBCovY1X7Yz0r
         0Cgw==
X-Gm-Message-State: AOAM531gyYbpuE6cLaRY6CElFXTaJs+POBadyJMcnekcud8RoZAT9sor
        aRUQt63/TxDoIFVfUmffKqg=
X-Google-Smtp-Source: ABdhPJxwF//lJmS95V5kCAtDOUf2pAnMKwxENpCH2GGNmovYjLD620hsRAOIQJ92WboI6KI/nnky+A==
X-Received: by 2002:aca:314b:: with SMTP id x72mr6327235oix.71.1620793037274;
        Tue, 11 May 2021 21:17:17 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id s85sm3749934oos.4.2021.05.11.21.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 21:17:16 -0700 (PDT)
Date:   Tue, 11 May 2021 23:17:12 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Gregory Anders <greg@gpanders.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Message-ID: <609b56c84a65_678ff208f1@natae.notmuch>
In-Reply-To: <YJs2RceLliGHI5TX@gpanders.com>
References: <20210511191510.25888-1-greg@gpanders.com>
 <609ae32e3b9f_60649208e0@natae.notmuch>
 <YJrsTu5YtGNpQvZh@gpanders.com>
 <609b0017a323b_6064920888@natae.notmuch>
 <YJsDAnHcnro6Gfk4@gpanders.com>
 <YJslulEQFvPkyo/R@coredump.intra.peff.net>
 <609b2aa26aa5b_678ff20893@natae.notmuch>
 <YJsuYAc+NniTWBc8@coredump.intra.peff.net>
 <609b34d66a0bc_678ff2083@natae.notmuch>
 <YJs2RceLliGHI5TX@gpanders.com>
Subject: Re: [PATCH v3] git-send-email: use ! to indicate relative path to
 command
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gregory Anders wrote:
> On Tue, 11 May 2021 20:52 -0500, Felipe Contreras wrote:
> >> > I think simply sendemail.command is perfectly fine.
> >>
> >> Aren't there many other "commands" run by send-email, like --to-cmd and
> >> --cc-cmd? It probably should indicate somehow that it is the command for
> >> sending mail. I agree it does not have to say "SMTP". If it is meant to
> >> be compatible with sendmail, then maybe "sendemail.sendmailCommand" and
> >> "--sendmail-cmd" would work.
> >
> >Yes, although I find sendemail.sendmailCommand awfully redundant.
> >I would prefer sendemail.mainCommand, but to me sendemail.command
> >implies it's the main command as opposed to all ther other commands.
> >
> >Just like there's many presidents in USA (of companies, organizations,
> >and student unions), but when you say "the president of USA" it's
> >understood which president you are talking about.
> 
> I agree with Jeff here. While I also find sendemail.sendmailCommand 
> redundant, it makes more sense when used as a command line option:
> 
>      git send-email --sendmail-cmd <cmd>
> 
> Conversely, `--command` is more ambiguous and less clear. Explicitly 
> using `sendmailCommand` makes it clear that the user is specifying a 
> command that is compatible with the `sendmail` program.

So would `git send-email --sendmail <cmd>`.

To make it clear, I think the options are:

 1. `git send-email --sendmail <cmd>`: `sendemail.sendmail`
 2. `git send-email --command <cmd>`: `sendemail.command`

I lean towards #2 since I think most people do a configuration and
forget about it it; they will rarely use the --command argument.

What I'm really against is:

  sendemail.sendmail-command.sendmail = sendmail

Cheers.

-- 
Felipe Contreras
