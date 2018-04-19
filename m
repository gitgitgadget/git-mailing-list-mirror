Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6D71F404
	for <e@80x24.org>; Thu, 19 Apr 2018 20:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbeDSUjW (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 16:39:22 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34522 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753328AbeDSUjV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 16:39:21 -0400
Received: by mail-pg0-f50.google.com with SMTP id p10so3041532pgn.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 13:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8Ao/9aJThtm/iirJb3p9f3OERQ4DJLsi0rzH1T9zJZ8=;
        b=Nof47V0rXh8wRUCW7eifjVpmFWMHjWCwDiDcQ/SNj6jRxWM3qbkg1EKyPQ0EJ5r5xu
         9yRitLKwm8ymMa3Pxkt+L5eLYC8St7gS+lI2zeswiO2NxBI6BhXdYbEpkGc6zvyYZwGj
         MENHuqHjvi53tJmYG7rVvYWBsJ2Uv5bRjvfgGP+EYza8+iYhkGK3QiItnb6+MAfkMFRT
         0IH1SzAM7FFjXVH4DiUISwfBR1WfLQFtCX1AH/3QXvSU0ZkLD9iL9FOjxOpyZyqv9k3R
         wegiJlCX5qLcyXYsRjmV0d5wJcr/tlMOkY3Vor6yMJIoZCi4cKfGadSnOlyT7j7gnzQC
         bpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8Ao/9aJThtm/iirJb3p9f3OERQ4DJLsi0rzH1T9zJZ8=;
        b=XMC8EmFl9UleTSTrZLU3d18MBkZ+jJgQK4hyH9Abf2uxRthFdApRBjwo7gF7vfYzt4
         ps49Z5YNoZdAfzM0UapoVo81awlOOHby837cQqKsuceRTcKb+ZSifV+UtE+bLWUJDXLh
         PRNhp+lro3pY+syRSMSBhgSqGC0lNT65inLdu/9oJwOkEJOFAbQ5ItPOT9sOOnKXliBP
         c6PmWCfTYJ4OngqRh9WLFjBGyngb01HhaUOGgFQlItdpQ+EIa+b3HbdT25qD4Hm8Sw3Q
         ytw9bX9gcM4wXNndmL/nzxT9oA+SsgiQiFWhVlzWINuLNpG9pG0MuRhN5YSiTT+IVtk2
         w61g==
X-Gm-Message-State: ALQs6tCnDMI32zx91XQad9ce6WY28BmZpr/7tzDN8BUR390Fe89fftYF
        s0UJUSLlqgVG1lOcTbZIKiG3JTW/UXa/0yWxkWE=
X-Google-Smtp-Source: AIpwx4/1q7O2AxKXRT04Lcpmsip30/PeuCOmzCGiPeKrqhRSkNYEZL52Wc8hsu1P3A9zbRAwFRuA+/dRvhOni8G2ZbY=
X-Received: by 10.98.237.17 with SMTP id u17mr7096064pfh.78.1524170360930;
 Thu, 19 Apr 2018 13:39:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Thu, 19 Apr 2018 13:39:20 -0700 (PDT)
In-Reply-To: <20180419175823.7946-34-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com> <20180419175823.7946-34-newren@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 19 Apr 2018 22:39:20 +0200
Message-ID: <CAN0heSquJboMMgay+5XomqXCGoHtXxf1mJBmY_L7y+AA4eG0KA@mail.gmail.com>
Subject: Re: [PATCH v10 33/36] merge-recursive: fix was_tracked() to quit
 lying with some renamed paths
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19 April 2018 at 19:58, Elijah Newren <newren@gmail.com> wrote:
> +       /* Free the extra index left from git_merge_trees() */
> +       /*
> +        * FIXME: Need to also data allocated by setup_unpack_trees_porcelain()
> +        * tucked away in o->unpack_opts.msgs, but the problem is that only
> +        * half of it refers to dynamically allocated data, while the other
> +        * half points at static strings.
> +        */

Timing. I've been preparing a patch that provides
`clear_unpack_trees_porcelain()` and fixes all such leaks. (About 10% of
all the leaks that are reported when I run the test-suite!) My patch
conflicts with this series for obvious reasons. Figuring out the
conflict resolution might be non-trivial, and I suspect it would even be
an evil merge. I'll be holding off on that patch until this has landed.

BTW: s/also data/also free data/. But since I'm promising to get rid of
this TODO quite soon after this is merged... ;-)

Martin
