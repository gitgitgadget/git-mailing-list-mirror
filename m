Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9214C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 08:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D1665014
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 08:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhCEIae (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 03:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhCEIaM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 03:30:12 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8DEC061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 00:30:12 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id e19so1826040ejt.3
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 00:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/MpQnU4WLAxbHGKE225bXkkFwGgDgru5e/Ox0rQM4s=;
        b=D8mcVzqYcQkdX6/XLc93d3B5gvu5yQ304AMjoQgbIejk8AMg5haZLghfcC7sucC7BK
         Lmo/KX33ByJ0eowPTFmDadSfh9x+GUXO1FGCe/jhJBKa7A8l9rUYanA0a1JQrqq8yu1y
         lvryzBraH56DK96XJfSPXpRdEekPhQyCyLmgv/5bZLEDJGvTdvNHpUZ1ZDZm4bnIlh2N
         qlSEq1t3n1PV25w6Nqei4FwiFA0aeMlD4M0Tj3+8Js0KGirb4Lv6exw+2mt8rDjOsSzS
         craklScRFTu7jPjgC/BJuPwkkkAfu2FtN7jRlCQqAfgrv17fvr3iHqDlEGhu26F8gTlo
         18aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/MpQnU4WLAxbHGKE225bXkkFwGgDgru5e/Ox0rQM4s=;
        b=cwO01KdWqK3SyYMnLxrFVUFuxB2CVKGE0RsssM5NWV1ydGbhNnPYTmy6rdFUbDWmAk
         bmPZOdqsQwSWVlYyyubV5S34w9SY15NtXapd+CpAvjFVmaE1dqfJ8UWjRoGwz1zfcEPU
         yK87wkoh0wZVeZWgWTy42HwVKdZokQLn8a9jVZQkzawZsEcoqfBozZkF84BSnPX25r6F
         aWSPO+dAG5WDhb/e//V5n9obZSSIj8vgtLzvfCXYHNOwrT/wjJ4U6+DOifY2CATDAf1S
         q+psMwfgVy5o9bRvqYG0//p3mv5Wgq+PLKaPyrLsy+do0ILgL7Jf7n/7LgGLs3teivEn
         rUZg==
X-Gm-Message-State: AOAM533yHG9SSZiDDqZjvS6z/dbdCoqzqSWF7IzTI3v8jL+Y3As4VFsa
        YsBWXeI69VNyd0GJx56KjLndinFl6LpQ4N2Zb+CH9cG1LTQOoA==
X-Google-Smtp-Source: ABdhPJwVChjviWeFEmlTKx42UbWfwvKWAiFUmMaGrWGmm2KCPHH4OTAV+1JFMr8v/16JbiBggFCZujhy7wRssbRrcEc=
X-Received: by 2002:a17:906:79c7:: with SMTP id m7mr1234462ejo.337.1614933010768;
 Fri, 05 Mar 2021 00:30:10 -0800 (PST)
MIME-Version: 1.0
References: <CANXojczh98ax2KwsaJg4CkusgrUWvhH0yG-u6oSW9nwwMLz_iA@mail.gmail.com>
In-Reply-To: <CANXojczh98ax2KwsaJg4CkusgrUWvhH0yG-u6oSW9nwwMLz_iA@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 5 Mar 2021 00:30:00 -0800
Message-ID: <CAGyf7-HuBHC64rL-NBRS_HDD3dbyedV-LKOeP+=k2ZVxpDOLbA@mail.gmail.com>
Subject: Re: Possible to use git over custom ssh libraries?
To:     Stef Bon <stefbon@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 5, 2021 at 12:14 AM Stef Bon <stefbon@gmail.com> wrote:
>
> I'm working on a set of network services using SSH, like SFTP, backup,
> fsnotify, (text/video) chat, connection forwarding using my own SSH
> implementation. See:
>
> https://github.com/stefbon/OSNS
>
> Now I want to also provide support for browsing remote git
> repositories using my ssh libraries, which will provide the transport
> layer.

Git doesn't use any SSH libraries directly, as far as I'm aware. It
forks ssh and that does what it does. Git has an
ssh.variant/GIT_SSH_VARIANT[1] toggle can be used to tell it a bit
about how it should expect ssh to behave so it can assemble the right
command line.

That implies you'd need to use your libraries to build at least a
minimal ssh command you could configure Git to use. GIT_SSH[2] can be
used to tell Git where to find the ssh binary.

>
> Is it possible to use git in combination with my own libraries? Or do
> I have to use libgit2 for that or something else?
>
> Thanks in advance,
>
> Stef Bon

Hope this helps!
-b

[1] https://git-scm.com/docs/git-config#Documentation/git-config.txt-sshvariant
[2] https://git-scm.com/docs/git#Documentation/git.txt-codeGITSSHcode
