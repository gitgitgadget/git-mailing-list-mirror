Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E86AC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 13:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5958B23A9C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 13:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgLRNkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 08:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLRNkK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 08:40:10 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9D2C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 05:39:29 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id y19so5391941lfa.13
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 05:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HkWdIzGBxPlT5MlNv8V4rjlqG8XRCnr93IS2x/kBt6A=;
        b=m8qhQ7JxNat+00uo5PVf2QOLl6jaiPTx8IfxH5ttzxUy++SEXqJtk4b+xGdnq7h2Ku
         XdDJk3b8suBnd3D39Rj2L4j9xe9raIH/SlF9G48DBePoBYq27fu8pK3e5ogbHGRuq0j8
         GcX+mNeGyeNsSvU8Dw41ciIGsST/Szu63dr4ID4OYKIrCzGDsLeme3kF6c6I/wn+qEZ7
         8bTygXORXk5OhLb/9lJ0IARNalw20Okd8BB+AgYqdtBZSAY5jAUK3pDYSsN3k03u/UTc
         AmW6ZbTScM4fWDbHnCf7YOk8GX0knX+v07mikV4y0ASuSiUnaxeUShjQtS55vuSdQMee
         FN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=HkWdIzGBxPlT5MlNv8V4rjlqG8XRCnr93IS2x/kBt6A=;
        b=ifaVSYVBD1FU0cDfntnNXUboa3ECv4WWfh1sBtjWt+o6tlbDIDw/9Ijsadli12KmUl
         yQBEkhiSl22Aua7fM5MJ8KdTpoFbCZd5go/jQ2uYXerIREQrV93w1WUMTW84eYRRZxCm
         6zubAB+UgrCAl/YxEuY5YdxeumiE129KWG+6HJlHEjsoNQmGx2Nabd8c91m616kBOmhR
         4h+pkcq2nDv98qCkb/JPKbR2En4mwD6r0R6iFuBQZbfjBUWc9oc0Xd7hMkj9Vkjsbf5X
         LzhiRJMJt0d8bjvq3qrNM0qg3xpH07EBewXFoNiLRb/bbTM6YVE3giGiXqTMESfwCWpA
         o+DQ==
X-Gm-Message-State: AOAM533qN51w+xs7zSJo67VTY6tUlb83pLJEVxr0K1afGGFduBOeHMeb
        KlBYZe0yFsRl+ArBa52Fu2psNw77h0k=
X-Google-Smtp-Source: ABdhPJyFgS+A8Y+G17IW/8EfXW5USXVOOg5wjl6qYWqLQE0m4igiyNKMIz4QNEih6MkJmZ+kxne+5A==
X-Received: by 2002:a2e:7a07:: with SMTP id v7mr1832391ljc.119.1608298767547;
        Fri, 18 Dec 2020 05:39:27 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j1sm925352lfg.225.2020.12.18.05.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 05:39:26 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 00/33] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <CABPp-BH_p50rNgpirpvPSK4ZnPTm4c62iothOF1Qa_7E1_EfFQ@mail.gmail.com>
Date:   Fri, 18 Dec 2020 16:39:25 +0300
In-Reply-To: <CABPp-BH_p50rNgpirpvPSK4ZnPTm4c62iothOF1Qa_7E1_EfFQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 17 Dec 2020 22:54:12 -0800")
Message-ID: <87czz7cjxu.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Thanks a lot for reviewing the series!

Elijah Newren <newren@gmail.com> writes:

> On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> These patch series implement new set of options governing diff output
>> of merge commits, all under the umbrella of single
>> --diff-merges=<mode> option.
>
> With this round, I was hoping to get a range-diff (using the
> --range-diff option to format-patch), so I could more easily see what
> was new.  Since I've been updating frequently enough, I was able to
> generate this locally using Junio's published so/log-diff-merge topic,
> but it'd be helpful if you could include it in any future rounds.

Well, documentation on contributing doesn't seem to mention this. I'll
try to learn it for the future though, thanks!

>
> With your previous patch series, I scanned most the patches somewhat
> briefly but looked at the final patches more closely (the series is
> kind of long, and I noticed Junio had started reviewing the early part
> of the series, so I figured it might be most helpful to jump in and
> cover the end in case he didn't get that far).  With this round, I
> read through the range-diff, and then looked at all the new patches
> and have left a number of comments.  I think Junio reviewed the first
> 8 or so patches of an earlier round, so patches 9-21 probably could
> benefit from someone reviewing more closely.
>
> Overall, I like the direction of the series.  I think it'll make it
> easier to add --remerge-diff later since it simplifies getting the
> interaction between it and -m/-c/--cc/--first-parent right.  It also
> adds some new capabilities you want (--diff-merges=first-parent, to
> show merges as diff against first parent without only traversing first
> parents), and that Junio wants (--diff-merges=dense-combined, to only
> show merges for diffs without showing diffs for non-merge commits).

Yeah, I hoped to address everything that has been discussed.

[...]

Thanks,
-- Sergey
