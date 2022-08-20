Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19A4C32792
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 00:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244831AbiHTALH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 20:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiHTALF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 20:11:05 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF64E1155BB
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 17:11:02 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c9so3232439qkk.6
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 17:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=D8GSGIPw3sXst4hvRB6qX9Yt/JLmmcTLkkHjUf4BphA=;
        b=oeG+ulSQXK96CIoXNo4xkbZ9cmXMdySBAtWHwqMsbYhDPdOMy8Rkv4LsnYoVLdxNCa
         W2s2orUE8MXjLP48K3gkhU8bEuqpxuX6sgqDNqNaEe9EixS/jj7m0VHB1K6lmVVxDnmY
         xYQN4xenbDA2pAAGakdMldQQwRQyOlgiJtJJVv4W1pjCjrjHAtlNyBxhZR7/32cFXmjq
         zOQZx2pQIYxvrYklM+5YVJWp5ikg6dx3yshUIvGo+kMn2Ma6ouoUV+Vl4CSVtgo9WVOK
         aZVzErKCv88AZ85brx5xkJbVFYZhemlBxaZNS1ByCHhGrHLZLD23Wv57lqvI6Gz26OFa
         XYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=D8GSGIPw3sXst4hvRB6qX9Yt/JLmmcTLkkHjUf4BphA=;
        b=CnVMlioYDn7oZqNh1bnE0GdOMMjCsp25Df9kfJIEC2jPHdpRbrpMOaK2h/J1HxjX9W
         cneNTDmM5dOSg/Z14Ui/gPTLL54fdCJgwgJLPdfnDEI/01yV+ij4U7kzRRS+nZjWjiqz
         0yD3uHzs0JIrZTvCMfha4CTXveHEURVBuAitvB+aJDqafpd2CCLhBqjNo6dBoHfypajj
         4jDoNskp3aJTUOH5lEqcio/uL5Byio3qZicTVFfWC5qk3w4w4243af9IKGFku7LbF8K/
         K3fGhQST31x8XcUi+yctY7Lylria3qF3XqCFqqZyd/KrWzaHPsJoA7P6pX7LO4wWjnRn
         NzsA==
X-Gm-Message-State: ACgBeo2I9eSdvUMXuEZZ3sfEJbGVhSPvfb6YhU8vTBbdUt0zxIQdZnyk
        yCpZHAWvikCHw+FUY6cGR3lnh5BylJUDVKCjUf4=
X-Google-Smtp-Source: AA6agR4W2s6Hjk3mFTYwR81JzRszh5b1eVDwIWVqm6PrbgJNbFKq7akw0sUYzQPyrs8u5oNEvxZqiYBCw+d4TTW66Dk=
X-Received: by 2002:a05:620a:1902:b0:6b8:d90e:cef7 with SMTP id
 bj2-20020a05620a190200b006b8d90ecef7mr6858530qkb.131.1660954261807; Fri, 19
 Aug 2022 17:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
 <pull.1303.v3.git.1660883290.gitgitgadget@gmail.com> <b810b3c8a2a7a9d121fc7c0438b4e4f3679557da.1660883290.git.gitgitgadget@gmail.com>
 <xmqq7d34m84p.fsf@gitster.g>
In-Reply-To: <xmqq7d34m84p.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 19 Aug 2022 17:10:50 -0700
Message-ID: <CABPp-BEvDjBqPxrAEzUXaLFWcwK+UmVH7bDXZm30RRrjv++Gxw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] revision: allow --ancestry-path to take an argument
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 10:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >                       ancestry_path:1,
> > +
> > +                     /* True if --ancestry-path was specified without an
> > +                      * argument. The bottom revisions are implicitly
> > +                      * the arguments in this case.
> > +                      */
> > +                     ancestry_path_implicit_bottoms:1,
>
> The above comment explains why this is called "implicit" very well.
> The earlier round used "need", but the word missed the essense (i.e.
> ancestry_path argument is implicit and not given, so we need to
> compute bottoms and use them instead).  The new name is certainly
> better.

Yep, I agree, but all credit for this improvement goes to Jonathan;
this was one of many good suggestions in his careful review.
