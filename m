Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D93C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 10:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A70223D25
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 10:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgLJKB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgLJKB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 05:01:58 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DFAC0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 02:01:18 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id w5so1062970wrm.11
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 02:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UW07kAmR1wTDUgH4MVSZ7wggdP77BUL3q0+qGf9y9ko=;
        b=Dww0EKJohGn9AgAB3oOMfOHchFoWm3l2GhXYbZkyhne52R+SwqbLpYb1HnbMcx1COj
         VOdvVY83f6wUz7PysncvF2+cEUK2wD+xvnZQKy1/yTlzhioarFNMmeLY9N5bn3qGfaHF
         uqylPgK1Xsf/e+s65HCWrvqm6gBEUQYvtZJdRf5QVeavGDBMjybbxuGklOdDAkKMOMA3
         1vBXtqDdtHJBlWifS/Of7f0Fj7OoxviSiUZ0No0kuJ94d8HiQ/v6tjqOuMDEwdi1033D
         9Oep/DKz+lBfevbnRy2GV+mHB+p2PyyNNtywFoQj5+MImxLNmmhairSTJyhztKBn7Nn5
         mulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UW07kAmR1wTDUgH4MVSZ7wggdP77BUL3q0+qGf9y9ko=;
        b=KhTpztUEupgd0aQf1gmO1j06DLCC5g+tEzRl6vSkqaDKkDD12P4yDA/YXQdeD51ok9
         kGziBxKWdWovysgLUZfQQ3xeq3oeB+994IdogkAvfkQJEyE37qitYT+fr6emfdmBRBVc
         QOCxrf+f5wmvDWu8y+JpFCPyenPZecCKpeGtR0fWGLmkZrpiU5quiYutb68XSqPG0HYs
         4R7O2DwLMcrfbH3lmfP5PsqQGjUI0RbNBqgIwxNpZd8+UNI/WlASIm5FFiamDtZwhaWL
         reoB9s/XCi+jwfxbKkmUI1rFtTjaqhSIVw2aqkyf23if1V+ZqT6ea2chgFoi7I2xdWJ6
         9QFg==
X-Gm-Message-State: AOAM5335x2KXtQZMF/h2Y8kVDqKckjQMaMzmdN25Ef9Gvm+eZuSCTptz
        FLUMDuUD/mGRDAXj+XHR+743klGTr6VcGNLUuI8=
X-Google-Smtp-Source: ABdhPJxBinRC0xujZMgmNtO3V4m8nLyB3YcsgeDiMvVBGcPCR43qXZfJ4yBym6Zk9mfZYrEowZ3ksAGvTuyahJPqJYM=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr7050967wrr.319.1607594477087;
 Thu, 10 Dec 2020 02:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
 <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
 <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
 <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
 <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
 <xmqqeek2cc14.fsf@gitster.c.googlers.com> <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
 <xmqqpn3lbhxn.fsf@gitster.c.googlers.com> <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
 <xmqqlfe99yvy.fsf@gitster.c.googlers.com> <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
 <xmqq360h8286.fsf@gitster.c.googlers.com> <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
 <xmqqy2i86ok1.fsf@gitster.c.googlers.com> <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
 <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
 <xmqqy2i6w45c.fsf@gitster.c.googlers.com> <CAMP44s3NNDL+zJjaukV9D2dJyU=ugSrnWz9o-whO9hKnBTxAow@mail.gmail.com>
In-Reply-To: <CAMP44s3NNDL+zJjaukV9D2dJyU=ugSrnWz9o-whO9hKnBTxAow@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 10 Dec 2020 04:01:06 -0600
Message-ID: <CAMP44s3KAn-cSt0nD+kN+FAYceMZvyMsG4zj6cBfMfxzOzDFxw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 3:08 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> It's not about what I want, it's about what the project wants. And I
> think it's pretty clear what the project wants:
>
>   1. git pull to eventually fail in non-fast-forward cases
>   2. A grace period before that switch is flipped
>
> That's it.
>
> My proposal is the only one (so far) that gives us that.

Not to mention that part I is not even contentious. We can improve the
situation of users *today*.

-- 
Felipe Contreras
