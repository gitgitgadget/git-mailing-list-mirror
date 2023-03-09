Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9564DC64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 15:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjCIPcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 10:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjCIPcL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 10:32:11 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D77F05D1
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 07:31:52 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id a32so2233817ljr.9
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 07:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678375910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFp42b4lQRkReLefAzh+w7oWUNw1vA0Qpigi+qzkrVA=;
        b=k6KTuXRc0tI+l3IFYw+xdUbvsUfVMhs6j8YHLtkafUNcghz+KN+baIMI8iBhOctYJR
         ZZwJteQ2i9cfB08DpjLURS28uL6tXytMqm5gEZF9IHXjKZpZqDg54qZRDs26qFsOyQMU
         3IT1I4nwPRX+5xdPY1xxwluupGLT/5XvdK2+vZdv1SmB4KUNafyjhFtuaM47BfyTMvh5
         8yQhchb2SC32hFpBDkCrnQNkQLDohbpi2Y1JpxpERs+IYdM87VRGMkbtsE7mzSceEh/J
         ShLnoqPWkAO5WbVaV9XjnrOLDuHmojyLLQwCXhqPge+3QnZf1EDmYPWbdFaapFCHMyQI
         ZhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678375910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFp42b4lQRkReLefAzh+w7oWUNw1vA0Qpigi+qzkrVA=;
        b=Sfe1u64gZSKua96+bshSdpxl3sij/NLMGFHvjQupgc7fSJ8g0Mmnjg473FCa7SyBYe
         iO0B0cyXWOS3V4Tj5oUUryXTAo2Z5EwvYkKmOk0wkJ3nOvefEdqClrQqjSjW5dqu1oO4
         x9IRRUH8zrf2N9rIjvKGjBW/WzqCD0EROuS0VpjkZYv8Ysf1XJ4A7CzocSc6D6Su8XqP
         6lmQqeh+CJE5mbZHQiqhX4zu2j2KO8IYM2j3X+xkMPInJz4blQbCAhhsCrGWrS/UyCtI
         h8QJfOaSZY/8N+vGbN4m9jC6OiXlYvEmlTCnYryVSUO6ljQAZXKUT2dFk/ZNHQ53YJkH
         J9uQ==
X-Gm-Message-State: AO0yUKXwWR/rDJRaH4Bt8srmhTaIIbK48A3kfz/K2nbTHrzoS5qpQUws
        0AaYChi88Y6vg8RZscTTvSJckepcYYVCS9DWdiI=
X-Google-Smtp-Source: AK7set+z696yiBTV7DWGFaMSH1fP7xTrIC59gMXY9bePmwqeOLTJr1JKFmEu8uSiJpcK/ZBguuRTGod5gFaIYzpPMzw=
X-Received: by 2002:a2e:bc0b:0:b0:295:acea:5884 with SMTP id
 b11-20020a2ebc0b000000b00295acea5884mr10993294ljf.3.1678375910158; Thu, 09
 Mar 2023 07:31:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
 <4b231e9beb43e4fac6457b9bf86e4c1db39c4238.1678283349.git.gitgitgadget@gmail.com>
 <xmqqmt4nt8k3.fsf@gitster.g> <xmqqilfbt552.fsf@gitster.g>
In-Reply-To: <xmqqilfbt552.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Mar 2023 07:31:37 -0800
Message-ID: <CABPp-BGCgD+9s788YYmzvFHah0kik5QxbYPvWWf6mG--Pd5KPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] builtin/sparse-checkout: remove NEED_WORK_TREE flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        William Sprent <williams@unity3d.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2023 at 11:27=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > But you did not find a place the feature you wanted to add with
> > [2/2] would fit better, perhaps, in which case, somebody else may be
> > able to suggest an alternative in their reviews of that step,
> > hopefully.
>
> ... oh, or perhaps the list would reach a consensus that mixing a
> subcommand that does not require a working tree is not all that bad,
> which I am personally OK with, too.  I didn't at all mean to say:
> "this shouldn't be a subcommand there, do it somewhere else".

I'm of the opinion that having sparse-checkout-related functionality
all fall under the 'sparse-checkout' command makes sense.  In the
past, all such subcommands happened to require a working tree, but
William has come up with a reasonable one that doesn't.  So, I'd be in
favor of this mixing.

I'll try to get a chance to review these patches soon, perhaps this weekend=
.
