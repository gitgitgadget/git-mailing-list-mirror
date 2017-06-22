Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EF9720802
	for <e@80x24.org>; Thu, 22 Jun 2017 22:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753740AbdFVWDu (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 18:03:50 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33187 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753701AbdFVWDt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 18:03:49 -0400
Received: by mail-pg0-f53.google.com with SMTP id f127so13270469pgc.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 15:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e7YmhV3yqpPvikvoVV5AzXaV6uglTOZQxHcAKS4a/04=;
        b=Ib/GfZ3NQXigxND8beegTYV1SpPii5Obfs3Ul7puDdhcTiy1DO2r5m8dddBTOjpHSz
         KraRHrfdSB9Y9dfuEAzN7DksLd2Vy+yI8FXi3JnFzcUI1AO7id/juIUTRzJCV9uPtHbP
         e9dtdqW9d6GwEUtXszrFFcK1XtUZZi0dYanehPLNKVJ+hBu2kbYfAH+HuYSCdfkQYfg8
         pUa3Mwal2wrKKPua753lVdrASzfV6Q51UEeTEq25uJfumwV6XRBAzStf69h4iqOJ+dl3
         yPzHgjSez/8wnq2gvwNCxa9BovpceyNgl7HxxLQCOAhef4sH1IIwylbC/o6Pi4ofEirn
         X5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=e7YmhV3yqpPvikvoVV5AzXaV6uglTOZQxHcAKS4a/04=;
        b=Vx2vRyKxYYoNGXHmtcIOi/XyKQmmdgmLFXwgyYOdW9P5q+OU1VXV1XVTBIwuWYWFsL
         r9HYboJh2UlHrYrBzZtCxU46k5fRvdYc03pS657kdsH0hBE0YdAFTmpduGJp8dmaKywd
         VOHveLAtVcQnzO+4yIyKYJLZqAA33FJKYlew4Tu8gFauRM7iRYdJlM76rpQTkkgevpzY
         O9+npV1yQ1KL3Hcsk93KZnjXtP3JoOnrzGS9Zfqa3JfmNkQU7YawG4TEUv5SlIl56ZRZ
         mBbDvOkBQFu6Ms1d2WxV1thO8Q6jh/dQKTeC3WtUtE1hMrYYOvBW/H6sCY6J38APlQVm
         o9qQ==
X-Gm-Message-State: AKS2vOxv5o49r9JDZxjt3JVYfGI6C/rxQuKO8ggE9fTng2dwmyYLppS9
        b59HZAs3NKCDRg==
X-Received: by 10.84.128.78 with SMTP id 72mr5264087pla.161.1498169028231;
        Thu, 22 Jun 2017 15:03:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id t128sm5314544pfd.64.2017.06.22.15.03.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 15:03:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] name-rev: Fix tag lookup on repository with mixed types of tags
References: <CAGHpTBLXrrt0DykbCQHqp2up_BqOVftc8_8Towi3sDbh3M12LQ@mail.gmail.com>
Date:   Thu, 22 Jun 2017 15:03:46 -0700
In-Reply-To: <CAGHpTBLXrrt0DykbCQHqp2up_BqOVftc8_8Towi3sDbh3M12LQ@mail.gmail.com>
        (Orgad Shaneh's message of "Thu, 22 Jun 2017 22:42:16 +0300")
Message-ID: <xmqq4lv7issd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Orgad Shaneh <orgads@gmail.com> writes:

> Commit 7550424804 (name-rev: include taggerdate in considering the best
> name) introduced a bug in name-rev.
>
> If a repository has both annotated and non-annotated tags, annotated
> tag will always win, even if it was created decades after the commit.

Thanks.  It is a problem that light-weight tags are unduly
penalized, and we attempted to address it a few months ago in a
slightly different way.  The necessary changes are already in
'master' but not yet in any released branch.

Here is an entry in the Release Notes for the next release that will
come out of the current 'master'.

 * "git describe --contains" penalized light-weight tags so much that
   they were almost never considered.  Instead, give them about the
   same chance to be considered as an annotated tag that is the same
   age as the underlying commit would.
   (merge ef1e74065c jc/name-rev-lw-tag later to maint).

