Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6A7202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 23:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbdGLXym (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 19:54:42 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35600 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdGLXyl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 19:54:41 -0400
Received: by mail-pf0-f194.google.com with SMTP id q85so4941599pfq.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 16:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kfmDlfRGNKoyG4tlzgxawIL+xvgeBOt1lfrFz4/Q9QE=;
        b=QxsIkiZiYzt9g9vKjsSox0bKSQkbO+xzBv5cFZAA1a8wdCUIBpWl8Azy1+d+NiKnw5
         2CpuDQ2CukTdPgRAy5m8l5MZqbxTb7v6YKBpa6O4j1XDaG8hKEGGIhJIOgiW1QDjBnHc
         d/TZG3VA5pXfNZxJCbSUZRoACrkpX2To27FY360IHMnnhysURBxj5Ohjrfd8AbbA8oeP
         7yaurtDt0woxFSFnxoOOfUGqDdJrS1Fa9eFHmEo+uMy7tNYse/PLbTody+QCwZN0/MbF
         H0orGIXPdwbROGDomN5SgQlwzBOxZm5i/z2REX401redcyYiWoDwtetK9yGP4ANgENRz
         IM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kfmDlfRGNKoyG4tlzgxawIL+xvgeBOt1lfrFz4/Q9QE=;
        b=ZIXuE0H+9d5wm8Kgy4yZdGuciHbFQMUF+OiYe3MUu7r78D2w5t6jmTA24QekRo+/vN
         wj/iES4Sba5mWWQ7yp1iaWQWxBzS3YmcuM2rDDr+ZQlcRxJTozbsIuBvh2E4P01Gslv+
         V7+oXlpwg1MGgukuWIkb4T95tADsCMJi0w/08eDdWUt37clweDX7+atO5D4IveWDOoWn
         AT02WbYDzICnA/N9tUj0EClovc6Wz7Vv3BQ3Iem/drDwukHHr2YFbl3T90rElsvuuWSu
         YWjQCNYEJBWoykE6TG2qoAq3Xnma59t5LRnm9KppE21M9V+gWY98dwbQn2X7g6uts46p
         v/oQ==
X-Gm-Message-State: AIVw111rIKgCyYFSf/QQtNTPnadrcyqUwyfJRKTERBmYzBBvv3eQOmL9
        gb2iputkr1+0+AGZ2Lk=
X-Received: by 10.84.128.102 with SMTP id 93mr6882568pla.21.1499903680618;
        Wed, 12 Jul 2017 16:54:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8c0d:cddc:dbb9:7a95])
        by smtp.gmail.com with ESMTPSA id z74sm8270287pfd.112.2017.07.12.16.54.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 16:54:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
References: <20170711233827.23486-1-sbeller@google.com>
        <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
        <20170712205734.h77fgbbkavwpkr4h@sigill.intra.peff.net>
Date:   Wed, 12 Jul 2017 16:54:38 -0700
In-Reply-To: <20170712205734.h77fgbbkavwpkr4h@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 12 Jul 2017 16:57:34 -0400")
Message-ID: <xmqqa849yzwh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I could see somebody arguing that format-patch should respect a project
> preference, since its primary purpose is to communicate your work to the
> rest of the project.
>
> But then you could make a similar argument for other diff options, too.

Yeah, and that opens a whole can of worms.

We let projects to ship clean/smudge or textconv filters and also
mark paths to which these tools may be of help, but we do not let
projects to automatically enable them in the cloned repository.  The
projects must _tell_ the user how to run the last step (e.g. "There
is a tools/setup-my-clone script shipped with the source; running it
will add necessary configurations to work better with our project").

I do not think usefulness of diff.orderfile is being questioned, but
I think it is something we should treat just like any other thing
that affects repository configuration.  A .gitorderfile that allows
the project to behave as if we allowed to auto-enable just one thing
in the clone, while not allowing others, a source of issues and
unnecessary headaches later.

Besides, diff-order is *not* the only order that matters in the use
of the system, and we _will_ regret the name ".gitorderfile" later,
as people would start making noises about forcing ls-files and other
things to also show the list following that order.


