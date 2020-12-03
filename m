Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB655C6369E
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 01:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D5820B80
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 01:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgLCBpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 20:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbgLCBpn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 20:45:43 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9B8C061A4D
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 17:44:57 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id j10so700165lja.5
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 17:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sH1DF8hE0pzCXEdiiGmrQgy/wJA5WNhKnpFnD4XzjTk=;
        b=CW4Ceo9zkKHrcJ4aBgGDU2RWZlV47rMBz0uN5B14yFQOSLKpEjqlXNlDsmrdJMokuZ
         03CmFwxB4PstZx2oAluzpQanbxzzDW96qUyyltacyLagwYRqmfvMMdVhJzKPLoHrXO0f
         UKhsbQr65nqA7bReHX2ahXwTjRSzBtZJEDAZBSKJTGJ+3KReBTC98OpL4dM7Jg55nVzG
         FMsnPAS6T6wk9YzxOQ3x2mVTqI5b6Lie+AUFwBA2nKkYtkKV0X8ejUqGsWC3k6hFhbOl
         DVmLFveRamgysUW3Qcl84sl50uBSot5qQ5MdU6wQ/KSBiJyBGFrH7Bj+SHYhlFKM/k3B
         PdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sH1DF8hE0pzCXEdiiGmrQgy/wJA5WNhKnpFnD4XzjTk=;
        b=sxNTj6s0xLx6W8qN3q2ZvT7GOJ2hhQOV831wfgLqvQrOHCToaxJJLK7na0Ezs2eBoX
         3DNy4YvtRlsvElFDW2ZkXbrcnIlw3OupovRGB8KyaRIDKwI/7o8CQNSsyfJqoQrSJhne
         owd7ARjvwtxapE8+VkzkDRXMfj7NVo/TCw7zhCItsnCllF3/utUPwbTejjt5R6tJOcry
         2bYiB3qnu+ept6vPwk778BB17dOoQQp2Zus7ZaS/MCzF/H4fPrfpaj1Qn3Qsudjna54O
         Y6cPfvqlfy2mM3XfyXzx4pR/D9W0rwR+2yYrkJDZsfCs1tKbK4rtUBzdlaKY8/tSsyY4
         xHOQ==
X-Gm-Message-State: AOAM531it3CRcsSEFkJH+TY9zwjYYX4BsOlUVctALLqsr4IQu+qPU9DU
        ouPJl8kVdNf+MCC4fos8dtI7E4AJyUYDwuws39p1ZDvS3FRoRQ==
X-Google-Smtp-Source: ABdhPJztqEN0spv1dy7yEEqchl/GmfbQB7guPxKjjlsSZi80prE3dBTezhz81nUFtRhGJVq0swy4qDxv1Q0n08ee0/0=
X-Received: by 2002:a2e:8315:: with SMTP id a21mr252771ljh.29.1606959895664;
 Wed, 02 Dec 2020 17:44:55 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW4yHSTYr0Gwn60tu2c7VY=PJbSbg23Z5Bd_11Do-+juGA@mail.gmail.com>
 <xmqqim9jn9rn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqim9jn9rn.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 2 Dec 2020 22:44:44 -0300
Message-ID: <CAHd-oW4bkQ6uDxY87D-8r0E+756unTzmY8eFv_99z=oN2nu16A@mail.gmail.com>
Subject: Re: Is git-am expected to honor core.sharedRepository?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 2, 2020 at 7:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
>
> > (For some background, I stumbled across this while considering using
> > safe_create_leading_directories() for a parallel-checkout patch. But
> > then I noticed it adjusts the directories' permissions based on the
> > setting and I was worried whether it could be user for checkout.)
>
> Forgot to respond to this part, but you are correct.
>
> Anything that tries to replace what is in entry.c must not trigger
> adjust_shared_perm() on files and directories in the working tree,
> and it is a no-no to call safe_create_leading_directories().

Got it, thanks. I've adjusted the parallel-checkout patch to use the
_no_share() scld variant from mt/do-not-use-scld-in-working-tree.
