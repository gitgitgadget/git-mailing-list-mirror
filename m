Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBF3C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8871208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVZpeNkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgGaUM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgGaUM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:12:27 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0A9C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:12:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c15so13509293edj.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UH05EsaBhsCdwbMNqPIgIS0wboj+vUru1Pd6l/isvY=;
        b=YVZpeNkAst0l7Ku0TO7DJ3LFnYTiKfzxi9HL+auG4Bpzn4mw8Cjtqs+fi4nqBgoW7+
         oiwpif5E/PglYeU3y1RdJLmdw0B8vgD26ZYkpDOr1Bd5I8kHxasEi/x/3oE7xkAEEZa2
         VrevLGL7Hr0Sz1lYd+zb1vumVdIyW8fzKUH8Q0pzY6eQgxL0YCzNAd3Z6eHnglPMgS/2
         dXB78FHkyh/1VcvDb2ZrqaLi62hA85bpJWz8QYA9QdlMI+bR0MumUdM8PMjYU+vLfiBs
         srfyDM7ptnx5CLMBkQowMYJR0N9YWQD0cakoHfpnfBk98ZuWnuTdk7xMStAP3l3eC01G
         wFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UH05EsaBhsCdwbMNqPIgIS0wboj+vUru1Pd6l/isvY=;
        b=AlxQ1bTUscucfi/UWUUNyONxvUVPK6RxMhhqa8otvv5nNmq9YaPW+pZYlqfwyfeiA0
         fypfBZKYiFGRNpXvamjKJ4TZgmdJykv+VXeL4hSv9fE3ZGlGr7TTrboHbD5oJ+jSLx6G
         f5H+ewMXo7zF4i2u4RPpIZGg/Z6LyrYdKQbAWfWEfdaxlR/n5594jwX1MLY+fJnw7OTL
         cUBfqXAm3kSZGEz8Z3abM7BwNCXDe0iZshQBgt8s6CzwTDUGZ7Z9OEzG/ELoi2ULGkiv
         P9IqD1P2HuJx3eMZ2uCIKkXEYpR5xTmW+hKbr3RxIdXwLPnraAnjhkHkLz2oJ/u1fIbt
         FXwQ==
X-Gm-Message-State: AOAM531xmjlBrMw2ACLDnHTdSkBxZHkLTOsWVmSU8TLcwz8hGnf3HCIK
        AdYz1kNcGALr3CxOzzrMFPyx8hgzyZCC10mJssE=
X-Google-Smtp-Source: ABdhPJzX3brWcYVNMtf1/FSeYSVKyuMK0rakfCypGU3iT9DnmxcxVzcVhj6gFvLu+NIA9RnBxQC5QpLSQ/cyxgleLl8=
X-Received: by 2002:a50:e844:: with SMTP id k4mr5370526edn.237.1596226345783;
 Fri, 31 Jul 2020 13:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200710164739.6616-1-chriscool@tuxfamily.org>
 <20200716121940.21041-1-chriscool@tuxfamily.org> <20200716121940.21041-4-chriscool@tuxfamily.org>
 <21bb2dad-5845-8cee-8f6a-1089ef7cae3b@gmail.com> <20200731174547.GC843002@coredump.intra.peff.net>
In-Reply-To: <20200731174547.GC843002@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 31 Jul 2020 22:12:13 +0200
Message-ID: <CAP8UFD15+p+xKwJ=B9WVsrc+2TvLHKmu78SBCLUFZVSYoTtbbg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] ref-filter: add support for %(contents:size)
To:     Jeff King <peff@peff.net>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban and Peff,

On Fri, Jul 31, 2020 at 7:45 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jul 31, 2020 at 07:37:22PM +0200, Alban Gruin wrote:
>
> > > +           # Leave $expect unquoted to lose possible leading whitespaces
> > > +           echo $expect >expected
> > > +           test_expect_${4:-sucess} $PREREQ "basic atom: $1 contents:size" '
> >
> > There is a typo here, and $expect is written to `expected', but
> > `test_cmp' wants `expect'.  Fixing those mistakes does not reveal any
> > broken tests.
>
> I thought at first you meant that the typo was s/expected/expect, and
> wondered how this could possibly have passed. But the typo is
> s/sucess/success/, so we were in fact not running the test at all (and
> were generating "test_expect_sucess: not found" messages to stderr, but
> outside of any test block. Yikes.
>
> Thanks for spotting.

Yeah, I copied a suggestion from Junio in the last iteration without
properly checking it. Sorry about that and thanks for spotting and
fixing it.
