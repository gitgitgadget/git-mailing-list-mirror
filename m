Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88ACC433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 22:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiBLWZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 17:25:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBLWZz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 17:25:55 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B8260A84
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 14:25:51 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id 9so15789508iou.2
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 14:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=daQDKUvN/qmqtrl8gBAmk9u5UqzKj/WxKZbU8wDJVSo=;
        b=gDn4aaDnwnthOrbORJ9UiJHgrhxTS9z0ClVIiNrDOwyu0NNLZcXYi+kojpJSjvvVBX
         6QFrR2YGojWiZBFgWMIVc/7HHqKgehq33UJcrA9tNM2nC3Nzbc/BbLWn31iB2Ujh92y4
         Jai2CpfnhVm5ajez+2nFdwPKsdrTIsB9d3Dr+TjKlQ1qvYJVtsJ4rV2Vk5wX7YUWwD14
         VINQv7L1vP85nKAEvDaTI0AHl+Lec0BPkUcr3WAS2z0/JG2XQ/i9sk0nnf6ilm5AosCc
         bfYoxjO2K8nyZi/5ta8CB1y/FMSqxdPiKJYsGckfbr0I4Lf3jS7mZ1BjWQfoo0aT35SA
         vOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=daQDKUvN/qmqtrl8gBAmk9u5UqzKj/WxKZbU8wDJVSo=;
        b=Xr9hDkVEJkTlZzdOrmjbrLXRUNT37P9DrrLUhrWo4sXZniHpEKbPNuFqqJG+9pQQ0l
         bznyBqe9EM6n1RDCwQFI1+OIGkCEPqPVt6xMXnhJvUGrstu+MHsJd2/Ag6yGC+y9XxvV
         RY9zCcw51REKiepUiY+4HHblSQN90ytqXk5CFsLqr4sx1LfI9X+NtnczCgKHuiIkbpLm
         4V6FE+qTSoYrCHBYUvfu+wjZO6wsvyOxgHcWV3tNDxVNUHcY/MnIDfDNvbdE4Dv5ma6Z
         V1L5u1LJmudyyFMtIM8adzFqEx5R6ouukg63x4XPY/HslY7kCmqWst6uHePB3ECbU9Pt
         rOqQ==
X-Gm-Message-State: AOAM531CYrscNJtunwPE+/dswjIRzsU/SuChLAxuEzIkOXMt8b0aUysb
        dqkiF+HUsXIPDoGnG0YXA36YGGPFlak=
X-Google-Smtp-Source: ABdhPJytVSdEidniENK2qhEFQ+DMpP2cx01HzZAnS4a+rkVwwStl514OZU78DoDvYGFee4GFVR2PCQ==
X-Received: by 2002:a5e:c20b:: with SMTP id v11mr3872990iop.197.1644704750932;
        Sat, 12 Feb 2022 14:25:50 -0800 (PST)
Received: from EPIC44019 ([199.204.58.10])
        by smtp.gmail.com with ESMTPSA id a4sm14767934ili.80.2022.02.12.14.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 14:25:50 -0800 (PST)
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2112202324110.347@tvgsbejvaqbjf.bet>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Sean Allred <allred.sean@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Custom subcommand help handlers
Date:   Sat, 12 Feb 2022 16:23:52 -0600
In-reply-to: <nycvar.QRO.7.76.6.2112202324110.347@tvgsbejvaqbjf.bet>
Message-ID: <87tud3wwlx.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> I think you might need to be a bit more careful than just looking whether
> the command in question is a built-in or not. It could be delivered as a
> script or executable inside `libexec/git-core`.

I apologize, yes -- I used 'built-in' as a synonym for 'distributed with
Git', but this of course is not how this project uses the term :-)

> Of course, this might break existing users' setups where they ship a Git
> command together with a manual page.
>
> A potential remedy against that would be, as you say, a config option.
> Maybe defaulting to the manual page if `help.format` is `man`, otherwise
> defaulting to passing `--help` to the command.

It's worth noting that Git for Windows does not distribute a
manpage-viewer :-(

--
Sean Allred
