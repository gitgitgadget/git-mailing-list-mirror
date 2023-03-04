Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3FCC64EC4
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 16:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCDQS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 11:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDQSz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 11:18:55 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C61E062
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 08:18:54 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id h3so5334586lja.12
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 08:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677946733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TyGe7mv764r3cOtjcIBFer3jFDQVBqezJRTG8gkqdNI=;
        b=IliwXMrmz+WyKxnKU60MxppLBHPUl0xIcV1S7IzeGVrj9qIR8+tH+RTolOMKyBVCN1
         zDTgMJ6UbPK00ewX65UbTjjfznZiyY0o/t6ccyQ4Tw3YZyrd61UflCXUYcoFNvqBp7FC
         PeyDPXm7JNajkUAsxUzOeYf3GlV9JG1Ofrseb9nmSC7lysa8nNvWiupCc6/3wYP3BToW
         qTG/w9cHRxujB9pZGU1k0kYsbp+7a22QuJ9Yq+VJT6xHRK7+7Uy45zp7Qa9EVY0PU9TZ
         Z+NbugdQwyuqMNA/LXtOy0lfLKMJdMUt2AFjfxQOHsyxzeOHMnrmeBtbCpHo4MKaPo7o
         6AeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677946733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TyGe7mv764r3cOtjcIBFer3jFDQVBqezJRTG8gkqdNI=;
        b=wXwfdYiMDizTv5i5eiTrJcixsq+L3y4pab4ftnMWY1DAXY/F55NxaJ5OzYp4lQ8fBb
         hanXboeudMayAgDq4XrjeSlHep/K51NIpDOE8F6WORBHCTy4+gvN1QIKKV6hcOlQq/B3
         9q/dggIAeiKMtQ+AgiiYYQAd19i0UVcbfLsfeQCFfrPTvYUsrMhSonKID9SgOyHSvmbo
         oau9N/MR1usx0wgPEwwiC2LeVLpHqS0GwIztn4vqSYRUS77q01sRJnX/gK/AnBADKOvn
         k7ZEzWg7NNWhb6O+Stqp2O2HiEYmATCBbYdaFc37lBQRYkUUaYyNCvWkzV2BULOPR6Zf
         sY8w==
X-Gm-Message-State: AO0yUKVImtkXY1j4FlekbPDO9vqJXERaYCYZlnCWw214XIFNUww9uL/I
        t5UX2ecAzXBKgyQlAFN8iOj0ZdoqWAArpxiuXJE=
X-Google-Smtp-Source: AK7set+VYFs1tCsZg8Cv5OnTtdnR7rUz3/5mWeoxqrwByHeV1i121AAo+C1zV1taOZ/0eKUIMCDV3+9PsC7lHNZ6k+c=
X-Received: by 2002:a2e:b98d:0:b0:295:a372:1db8 with SMTP id
 p13-20020a2eb98d000000b00295a3721db8mr1612406ljp.1.1677946732469; Sat, 04 Mar
 2023 08:18:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
 <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com> <887967c1f3fd6f03cf1d0bb3c19ed16819541092.1658391391.git.gitgitgadget@gmail.com>
 <xmqq35eul95b.fsf@gitster.g> <ZABNceY3cSWNb75u@F407C5W6RY.office.atlassian.com>
 <CABPp-BEJmnAB4QX_HMnNaZ9vEh_mKiqka_uZRm_E_LNuOBiFsg@mail.gmail.com> <xmqqmt4vktx7.fsf@gitster.g>
In-Reply-To: <xmqqmt4vktx7.fsf@gitster.g>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Sat, 4 Mar 2023 10:18:40 -0600
Message-ID: <CANaDLWLaOm-oow_-wMS3w0z=5O3uau3xZrXHboxLC7CZV+iFQQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] merge: ensure we can actually restore pre-merge state
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Ben Humphreys <behumphreys@atlassian.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think switching to `git merge-tree` would provide you _much_ bigger benefits.

Supporting evidence: we have an automerge pipeline running
on our gigantic monolith at Salesforce to keep some shared
branches automatically up-to-date with their upstream. We first
built it with a version of Git older than 2.38, and we were doing
checkouts and running good old 'git merge' and 'git push'
commands. We didn't measure since it wasn't in production yet,
but from memory, each merge could take maybe 30s to a minute,
the checkouts could be really heavy sometimes. And of course,
after our initial fetch (which we still do of course), there was also an
incompressible multi-minute initial checkout.

We updated our pipeline to run Git 2.39, and we switched to doing
no checkout and running 'git merge-tree', followed by 'git commit-tree',
and then 'git update-ref'. Now, each of those is about 5 seconds,
including re-fetching the branches before starting in case they very
recently changed. It made a gigantic difference to us, thanks a lot
to everyone who worked on this.
