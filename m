Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49439C47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 21:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3832495D
	for <git@archiver.kernel.org>; Fri,  1 May 2020 21:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2Daz8Lq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgEAVxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 17:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVxp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 17:53:45 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35DCC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 14:53:44 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id w188so3078454vkf.0
        for <git@vger.kernel.org>; Fri, 01 May 2020 14:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FctAiHgHECdogWUU9MmWFIwuvWozPDEsI8WubTMISjc=;
        b=M2Daz8Lq+S26hFt4dWhlLCfPwM6WGLt2gxqq1gKAS4xQJNz4toYnI9CYXAE7ZVyH9b
         q2yKcJfa2kJTe7m/u3QQf86DSWq5T7wb5pCH6vdgi1P4Vv/HM2SYAMs4/FPANqOAHj86
         EIkCK/ppgyNJobU70Fnsy0yAOPRR48ZclLulVLfjHcJGyxK5PNzaY/DnBA0GjrO1/oYW
         EmntxOQw8KvEeWgRqdxLi8DsgHZYTHifNSh3tEzEU937xhA2ExTsTNz3sv3n84o58LRB
         n4eubviG3Hzf6dbn6Jn7KpHkyaavxQN7WJQamNWfZ8CnYgOpYVfmhnOfm0dY+BYe4LRQ
         M3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FctAiHgHECdogWUU9MmWFIwuvWozPDEsI8WubTMISjc=;
        b=fFy7ikfQvq52tRUeSX9dri1ok5guv31Rdl8hoUzKS1eUejMGVDbYoqHGWTAhLnNYBi
         /IG0oRfOaFXUjnvLphbxDtFbpmKTPt2nfIV1lFyudnVYt77GDutoS6UHRKe/WgFz3cHd
         5EVwZS55qtuf8DSCce9DT5rbi0NQucKjgUpDbv/UL23j6ksUNrNaoHl4RSodHxlH5SGg
         hnJZB51Jk30nVuCyi4Pf6TSm0ug21Tu1UqxnK2GDuTnRt5tq+Pcily0/xT1TlfKUIVY0
         PKB15nIxQ0QRXsoi/6NvW1NL451lzXmcXNjmN/zhSGfbkz2iTGloyh+rDFnDmUaA053x
         rfQg==
X-Gm-Message-State: AGi0PuYwqPZUXQpF7BRRvZlhJlp0ppYVHTQdyzGNDiwG55E+Zna+Uw5k
        AdNgubnqfGFOzJlCoabhj7Pk6qrRIInLKZv2dWE=
X-Google-Smtp-Source: APiQypLWWnwPZyGR+93kGs4iz82Fyq62HXgY697I9JhHgchdWIDgLvcBgOyECCJpO/zKKrZB/EyTgdLa5pXaPu+WsU8=
X-Received: by 2002:a1f:16d5:: with SMTP id 204mr4243743vkw.20.1588370023965;
 Fri, 01 May 2020 14:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200425022045.1089291-1-jacob.e.keller@intel.com> <xmqqsggkpop0.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsggkpop0.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 1 May 2020 14:53:32 -0700
Message-ID: <CA+P7+xpdNtRPOzR09DJNRZagqwEOt3-=mxye3qQk5XQ4guaJTg@mail.gmail.com>
Subject: Re: [PATCH 00/11] refactor git switch completion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 3:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > completion support for git switch is subpar for a number of cases. Most
> > notable is difference between these two completions:
> >
> >   $git switch <TAB>
> >   Display all 784 possibilities? (y or n)
> >   <list of all references and DWIM remotes>
> >
> >   $git switch --track<TAB>
> >   jk-refactor-git-switch-completion master`
> > ...
>
> We've discussed that it may be a good idea to make sure that "switch
> -c", "checkout -b" and "switch/checkout --orphan" complete the new
> branch name the same way, but haven't done anything else.  I'd very
> much appreciate to see the patches reviewed by those involved more
> in the completion script, before we decide to merge the topic to
> 'next'.


It is my intention to extend this series with a notion of reading the
previous word on the command line, and using that to determine if we
are completing an argument for an option.

Thanks,
Jake
