Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C97E320989
	for <e@80x24.org>; Thu, 13 Oct 2016 22:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757083AbcJMWQi (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 18:16:38 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33061 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756324AbcJMWQf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 18:16:35 -0400
Received: by mail-qk0-f179.google.com with SMTP id n189so118796308qke.0
        for <git@vger.kernel.org>; Thu, 13 Oct 2016 15:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S4MOGBBi958xvXjuxcCvdzOqFP9jmTycrxIjesLg4cE=;
        b=Dh3/FkAklJeffjoyJ+lbuJwnai/GsbHW0XW4N85mKvFEdHx5esUuSQ42YgarLk8fnM
         iyPWwGqJqXwLH8NDa0ljB7B0kvD8bPZudAL3ILTPdeRvTKN5d7kbCxHecgFkFx3D6H6i
         mjFLe6X1zgcvt/QbOSTURVNQGPhDAf25ONB7nbn3zEerxvGv6hpFUeC+RlpR3fXViOs8
         JhRXqkVaMW1SMdBrU8i7ljslEM4zfcJLQ2gjzVY4wDIPAurHQFrOvs5qM6TCCFjrGrQH
         6nXsYtDhAHXCuIn1CDfdFn8eAu2C48llTy2mYCOmxB5kXSQddVdT5/KWUcCvIWuinfQi
         JiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S4MOGBBi958xvXjuxcCvdzOqFP9jmTycrxIjesLg4cE=;
        b=V6r5egUevDuYRkaJ18JS4JpY+xVsWmminBqqptJ2D2b+Qt+t0YpKlUI7qd/n+JpfpI
         M7ZKdaZZe7r/PUgJ+YC+uz7lnIuPYHOxHrs8R1F7ZkgF+ZA7wtMro7tXGlLhCEVYPTlt
         NIVstxzE6rLjyR1j4jxmeISWraayg+X0fl2cg44W0K2to7CZQtTQz0wRdf/xliZX4ghm
         r0XwHZARIA3faTyMTeEfjKu74c8xd22lg3nOnnV5L79KNL+n2P6uWGnb3d8bzAjI389w
         OK+zxkM8NOU+3UU4lSpbjAFcQFC5GYlSYm2dNrXi4aqfqSyKFdNLyV0Bp5q5zU7LMkbD
         H6PQ==
X-Gm-Message-State: AA6/9Rl2qtVXKM/Rnj4X84Lsj2Penh7dcLOpcgxkPLudif21Uk4sjGLTbZ7LvpL2mTBc+AcJ0ez3SF5c7z/j8dbK
X-Received: by 10.55.184.2 with SMTP id i2mr9991420qkf.47.1476396515487; Thu,
 13 Oct 2016 15:08:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 13 Oct 2016 15:08:35 -0700 (PDT)
In-Reply-To: <CAGZ79kYEefzKJT5TLXaGV0ZYoW=OUzrRBPTOovDG0ofO8-i5Jg@mail.gmail.com>
References: <20161012224109.23410-1-sbeller@google.com> <xmqqfuo116t0.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYEefzKJT5TLXaGV0ZYoW=OUzrRBPTOovDG0ofO8-i5Jg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Oct 2016 15:08:35 -0700
Message-ID: <CAGZ79kasCEWijdUe24mTy9n--BX2=ar4V-hvjXHqEm2sVzjk+g@mail.gmail.com>
Subject: Re: [PATCHv3] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Oct 12, 2016 at 4:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> so I am hoping that we won't have to do this uglier variant

---8<--- attr.h:
...
struct git_attr_result {
    int check_nr;
    /* Whether is was statically allocated and cannot be resized. */
    int static_alloc;
    const char *value[FLEX_ARRAY];
};

/* create a pointer pointing to a git_attr_result with a given size: */
#define GIT_ATTR_RESULT_INIT_FOR(name, size) \
    struct { \
        int check_nr; \
        int static_alloc; \
        const char *value[size]; \
    } local_##name; \
    struct git_attr_result *name = \
        (struct git_attr_result *)&(local_##name); \
    local_##name.static_alloc = 1;
...
---8<--- e.g. ws.c:

    static struct git_attr_check *attr_whitespace_rule;
    GIT_ATTR_RESULT_INIT_FOR(result, 1);

    git_attr_check_initl(&attr_whitespace_rule, "whitespace", NULL);

    if (!git_check_attr(pathname, attr_whitespace_rule, result)) {
        if (ATTR_TRUE(result->value[0])) {
            ...
        } else if (ATTR_FALSE(result->value[0])) {
            ...
