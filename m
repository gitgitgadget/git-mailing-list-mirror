Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26613ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 17:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIIRHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 13:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIIRHU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 13:07:20 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C22B9FA87
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 10:07:20 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so5926070pjq.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=5OZjebRqM9YRT5F2wG8vjZaxF0UoDiHCpCzF3qCVmD0=;
        b=cEkHUoUZ1l4ZgGXzEBz75VURiVtSN2rRJNyeB3G7TIw28CGTUN5gAHQlCDV6/kdMpC
         jHAEG9TpQYbxzPx4WtUbjDlcnbNSJk3XZW5BnFlMD/OLPBfHXPWsl/NgCLawLUhD8fJF
         /Ic+1+SdpgyzigWXHm3uxAkf4lB91ypHP0oTzcZ+bCvLuHCVDAEaUaM2kDlWVqSzNT8q
         q1Kvrz+qp/wlU3VlbYkI6rZz+MXwlAlHTD5PQBullNAr6Zau8GktzsUrJIu7uHhHSLy0
         LYLubaTYrOnvlIWNsgBjBIwmOcWLjC0JHfX/+JEwPjYqVuO3ukLiSruG5G3qzeV8rCpj
         IYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=5OZjebRqM9YRT5F2wG8vjZaxF0UoDiHCpCzF3qCVmD0=;
        b=5/JEpOzorsceaxbYTX7ic2/cS5b0lrrpLpF2nR+BvpfGSLQ35TH+LoyxSZjJ9nkBgE
         7Fh8FfQnFpVayOTTq63yz+LprdFIIIPMxqqYpvzaMXt071uT8ULiL4WylFDOiazGEBLz
         yhTX223kakHGMeALEYu3x4FvKvbA1sAfrV2P8XT+Bd3dJvA6QfOdqqt2OMs+zyEH5Zns
         XH87QjlCDJh1DO5PfdHdeBxL/qnNwMN0avvUMDm/msb34A9yeytRtSxz6y8v7nm4uen8
         zTVc2b4o7f8R4cL+9zI6gx5nss5CEgMcLZj9sySeZnu9ee5JBSkVdwZ7S7kODIYQGmOD
         oXCw==
X-Gm-Message-State: ACgBeo38ihI8DCiBQ0Oyml+yEEXhGu/ec+K+uqaB3atfsZIgsiIcuFxn
        AHXKeoVy6KFpScfFmbfXTmJjrTwBBNM=
X-Google-Smtp-Source: AA6agR6rMJCq6x5GxfcjkXi2oyH0Zz8pgY3QwiHDSmwxMlY5V2UR9ijCTN/4boNRq2jIBy6+WFLVgQ==
X-Received: by 2002:a17:902:7602:b0:172:a064:4a2f with SMTP id k2-20020a170902760200b00172a0644a2fmr14488022pll.56.1662743239398;
        Fri, 09 Sep 2022 10:07:19 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id fv2-20020a17090b0e8200b0020063e7d63asm662363pjb.30.2022.09.09.10.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 10:07:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>, Denton Liu <liu.denton@gmail.com>
Subject: Re: git mergetool, merge.tool, merge.guitool and DISPLAY
References: <CAPMMpogZd_em4_Fdk0sNFqAXqH19VOVyw3WsNT2LHsQNOb0_rw@mail.gmail.com>
Date:   Fri, 09 Sep 2022 10:07:18 -0700
In-Reply-To: <CAPMMpogZd_em4_Fdk0sNFqAXqH19VOVyw3WsNT2LHsQNOb0_rw@mail.gmail.com>
        (Tao Klerks's message of "Fri, 9 Sep 2022 13:56:24 +0200")
Message-ID: <xmqqpmg4lbnd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> When you configure your tools, you can configure "merge.tool" for the
> default, and "merge.guitool" for GUI contexts - so far so good, sounds
> consistent.
>
> However, once you've configured these two settings, "git mergetool"
> will never select the GUI tool you've configured unless you very
> *explicitly* tell it to, by specifying the --gui argument. The
> sensible auto-selection based on "DISPLAY" disappears.

We've had merge.tool almost forever but merge.guitool is a more
recent invention in late 2018.

> The upshot, as I understand it, is that the only way to get a GUI when
> I'm connected with an X session, and get a terminal-based mergetool
> when I'm not, without having to be aware and issue different commands,
> is to accept whatever tooling default order is hardcoded in
> "git-mergetool--lib.sh"

60aced3d (mergetool: fallback to tool when guitool unavailable,
2019-04-29) says something interesting:

    The behavior for when difftool or mergetool are called without `--gui`
    should be identical with or without this patch.

So, either we broke that promise since then, or the above commit was
already broken, or the tool was already broken before that?  In any
case, I do not think of a good reason why configured .guitool is not
automatically honored and .tool ignored when we know we are in an GUI
environment.  In other words, the choice of the tool should probably
go like:

    are we in GUI? (determined by an explicit --gui, --no-gui, or env)
    if so
	pick one from configured .guitool (or from the fallback default
	list of tools)
    else
        pick one from configured .tool (or from the fallback default
        list of non-GUI tools)

I would think.

> Is this intentional / is there any logic here, or is this just
> unfortunate, a result of the auto-selection evolving more
> intelligently than the built-in explicit "--gui" selection, over
> time??
