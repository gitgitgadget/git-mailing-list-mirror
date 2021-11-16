Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D509C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB8461BF9
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhKPFPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhKPFNU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 00:13:20 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651C1C0B1931
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 18:12:40 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id o1so6261490uap.4
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 18:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kNNgc9eUBkTyzPU4TP1OW1Tz/K6FnEgQEUjcHkAL7V0=;
        b=bwxw8SFMa/Qj+oUXqQ+BRhoLB2bTII+m7jOwPR9WeDOJ7LUjhfwJPDTYVC2n4/OWzO
         4f2fjmG9yjNkapiVoMcR3kqo0wBNYJGeUZ/V78unKiZb9mAtBjxYBERwi+jLQ3xDGo4s
         C2HGhOuPpOmFZTZy2Ir2zPMPE7XwN0D/nU89L2sW21IPxfdj5hyCnS1h05+vytTMGR1e
         7BvsLxsEY/X7JYj4ZbqAwlGdTLUr3aOpMvkry0lupQt4L/yprOMVm0ObZM6hAAWLXsc2
         PcTDXQb99eq29Hoy/aMbDG1SOSssTI6oqCiWo47i54KjqWPjMGquU6WkJWrrAhns1zQE
         38ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kNNgc9eUBkTyzPU4TP1OW1Tz/K6FnEgQEUjcHkAL7V0=;
        b=Rv3fEsuru61uXDwnOAI1IDW62hwXaCJohQxpy98VrrzxigTMu2uIGWrpFNjTz4VHdi
         6iwtsI8+wl9PH0961n0kVoFpNWqhs7Di57Gk9qZazK0P0s8xtDUgAw4JGCQu69QjS0oR
         NWYmHegg82LUC3fo7lVHSpaEc2w2THKNp7p8PHialCXzEnC83HbCZT2d8HHG2iuKms9f
         r8dL7k16sPo46XFQdZ9Pb+d0N6dyeDYmHF+PLPRGkGJdZfb6yUD9MU43TNpx1Uqws0z3
         aYopwwKBhb410+y96AdCAi8u6O+nX2jz/9LpHM3zgmnz8WI7xvO5mIt1WHXNPWm9QKYU
         /QSQ==
X-Gm-Message-State: AOAM533RbU5lFfk3DpxJuyT8fTOuGCMYdOSH2Yrtm1OrqXLCz0y6u2Mo
        Wd0NC6/IZkVOumEl1JbzT2Lz50cPprdMZ/lrAyY=
X-Google-Smtp-Source: ABdhPJy7Jpz6jVD0+1U06LtEqgnE8OBIUIFAceNz+6EsL9UpN6K4cev5ObjgDfA8jq4ENKBFL+pPrAewDWvMaDbFOaA=
X-Received: by 2002:ab0:14a7:: with SMTP id d36mr5391526uae.96.1637028759447;
 Mon, 15 Nov 2021 18:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com> <877dd9i1zj.fsf@igel.home>
 <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com>
In-Reply-To: <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 15 Nov 2021 18:12:27 -0800
Message-ID: <CAPUEspiobsM2HYhi47zcAR+eRveF24mGA+ozUsYGpNCc-D9F+w@mail.gmail.com>
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I can't remember much of the details of the bug, and it seems PCREv2's
> bug tracker went private, or at least I can't view
> https://bugs.exim.org/show_bug.cgi?id=3D2642 anymore.

It was shutdown; all new development is now done in github[1], old
closed bugs were not migrated over though but the fix is pretty
straight forward if it needs backporting[2]

I would have expected the less risky change from Ren=C3=A9[3] to be
released though, but might be a good opportunity to take a deeper look
at the underlying problem and also have a likely solution to both the
regression and the original bug.

Carlo

[1] https://github.com/PhilipHazel/pcre2
[2] https://github.com/PhilipHazel/pcre2/commit/f8cbb1f58df05f175a6898f35dc=
18e26be6362d0
[3] https://lore.kernel.org/git/0ea73e7a-6d43-e223-ab2e-24c684102856@web.de=
/
