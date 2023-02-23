Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B1FC64ED6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 22:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBWWHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 17:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBWWHw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 17:07:52 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED66559F
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 14:07:51 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso805152pjb.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 14:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Tma/PSTpwIVVhPleJ3fCYaw3yOuWhfm7IsCq0fsF3I=;
        b=iXIN7iW7nKuQpN3ZfeJs1VUD5jSgmg1LskOkDLou8NbWP/2ZniPHBInLsAXAZo8VkB
         cD87dfc9Ju7FjRLdL77T77EnAxb1Hse0z5TDDfZ70BZXrb55oJMkZZ+gdYkq1JvkdeyK
         NhP9AYIxftx32qS9rp1Xq5jeGj+jVJ0J6Zs4iCXE1Q0R4U2WSw/AS3yxt8t/YZvlP3+o
         BTa2xdxCtg1MeSoWrM4QdU6+NY0GP071rMaSDyGal7k+CceCVDJiccNqpZRIEEwHJIPo
         CXs6K4kXG8Qz/kt8u26efLD1q4kh3abxNox05khRcZ9nQFR0b0WSIYr2/GH8g4lnDTba
         40YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Tma/PSTpwIVVhPleJ3fCYaw3yOuWhfm7IsCq0fsF3I=;
        b=sFFkk1Sa4FDDjq1RCt3HIeRXI7yrvmPNEym48cujS24KRUXIUL4zFhkZu6HhapvW32
         0TBjK4W6rrE3QoxLg/GT12FzrRQpuoPL5gyMMi/IlsZdbnS6MCAiJPUtUyOzrhFCmsVQ
         OIUO6E6YBYN3p4TxPZYYbdM8R1twcOY8jmnaTZsJA3WeyyZdfFa/pQDE0bSDdK18GQoq
         3PE/r7xQE80hWfDgm1lyKMmcEmZdQsLeaFGqWPiZ1+vfNtySQFUJwhtCh+VS4mpR0CK6
         oWlqSslzUHzYsdPUenxBDM+SjS0rkkyQCOu3o/TGC0mMDTfuyPTVfXM9WvX4WElBzSOv
         J4DA==
X-Gm-Message-State: AO0yUKWBW7+ZHbHfBp1QgEvPrBWBbsRx22z5jP8TzUZR1spywxA/jTOZ
        jTkEVJwVbuiU0PIAzYynI/A=
X-Google-Smtp-Source: AK7set/P/Aj51TwFuuY69Yl92Y9c3RzNGcBuFEzWB7qwvPdIuwrzO6e9xpi+EkPrtgLBu2xE05w9Jg==
X-Received: by 2002:a05:6a20:cf5a:b0:c0:1fcc:ca1f with SMTP id hz26-20020a056a20cf5a00b000c01fccca1fmr3933588pzb.39.1677190070885;
        Thu, 23 Feb 2023 14:07:50 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id i13-20020aa787cd000000b005abbfa874d9sm6776783pfo.88.2023.02.23.14.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 14:07:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH 02/16] treewide: remove unnecessary git-compat-util.h
 includes in headers
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <adafa655432dd13d1c727522377ac9a4b515b76a.1677139521.git.gitgitgadget@gmail.com>
        <xmqq1qmg899v.fsf@gitster.g>
        <CABPp-BHizCj2e454w3vtHrDNip3Rm-gUMT0oJiAsbkAvr_QvVA@mail.gmail.com>
Date:   Thu, 23 Feb 2023 14:07:50 -0800
In-Reply-To: <CABPp-BHizCj2e454w3vtHrDNip3Rm-gUMT0oJiAsbkAvr_QvVA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 23 Feb 2023 11:53:45 -0800")
Message-ID: <xmqqbklk6nnt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I think for sanity we should do one of the following:
>
> (a) make C and header files both depend upon everything they need
> (b) consistently exclude git-compat-util.h from headers and require it
> be the first include in C files
>
> I think things get really messy if we let half the headers follow (a)
> and the other half are forced to do (b).  I was pushed towards (b)
> before, but now that I've worked on this series, I think there is even
> more reason to go this direction: this work I did during this series
> shows that if we allow a mixture of (a) and (b), then empirically we
> end up with C files that don't include git-compat-util.h directly, and
> those same C files likely include some headers that don't include
> git-compat-util.h at all, and if the other headers are included before
> the indirect inclusion of git-compat-util.h then there are risks that
> things will break in very subtle ways (as pointed out by Peff in the
> above-linked emails).  So, I'm inclined to go towards (b).

Perfect.  Can some of that reasoning be captured in the proposed log
message of [02/16] to help future developers?

Thanks.
