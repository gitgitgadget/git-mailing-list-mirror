Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78B721F404
	for <e@80x24.org>; Thu,  1 Mar 2018 18:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033980AbeCASlZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 13:41:25 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33434 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033831AbeCASlY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 13:41:24 -0500
Received: by mail-wr0-f194.google.com with SMTP id v18so6989774wrv.0
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 10:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Juq9M7k+6jaxJ0/xnWzOWZnsyJ5WM9vR2AHHVYO9X64=;
        b=ZLrMbexIU4gNW6no37aI+fJ8P7AT766zfcIgbHgj64CjKlIa/UL37mgB/Twj6fgJzc
         3KFymjIuUoZ4vYO5rpwoCWdLyAOJQHq31/aY635iCieKZz+v8HusZgBHxlNgjtTRqq44
         FVn5AwNLsvJUazJ1zab57rvOvfPZF9t0lItqeqPPof+7K9Id7q2YQs9TvjC3c0VGSGKK
         4pfkwy8Wiq1U2F7+bczx2CholeRUiMbXH7o0Z/F+gnxswMHqOwhIxtZLcshBfA5vW9oc
         RXeELxIksrwFHkVY1pp3GWdXfs1lLiKXjdxjq0vjy5P4dPQMy0NvEVYV+unOZx2T9U4V
         EZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Juq9M7k+6jaxJ0/xnWzOWZnsyJ5WM9vR2AHHVYO9X64=;
        b=s5LtF8dxECxovEN7UzTPRD980xLm0BmCYXZw1lvnD1pMI2CnuFuU3nnRUc8Jj9yKhg
         KEAR6IPokDylMq/V5sNCXd2WyVoYxi7lJUBJOf2rbRQIlzGPEwyvBOIrfYQpH1sEqBCj
         BiUwETVEYJ4GPk8ga+7vBcZwtlC+FOyHMXeauOhQ0k6i82IFtTJ+Pf8I9GDy8dMDCrV9
         0nG6xOECM4mjB9VtVtmp/5qxbvmy4a0Ob2fVa8NV8Au0K3V+kJs6dq+CVAetMsDnqr+1
         QUCxnj27Pdxms+eG1NqT1zPbEGlQIaslzqLWKaCb4BS7YYZbmMqp+vfLydj6yACFhlcL
         CPsw==
X-Gm-Message-State: APf1xPCoTHMcav52R8DSuRAYzzg+xnZto6bR38cRZ0Jx8JSdlRqw/Pxu
        P0eDxQte9cDsrfNXvaBez1E=
X-Google-Smtp-Source: AG47ELuSuzazeko4jD07L+GkhqCIlqhCNuVo14YugD1SPtjQSS90zEpEQXJHBnoFJHbYCSbvrzIujw==
X-Received: by 10.223.176.201 with SMTP id j9mr2860084wra.210.1519929683250;
        Thu, 01 Mar 2018 10:41:23 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p21sm4722878wmc.43.2018.03.01.10.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 10:41:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 00/35] protocol version 2
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
Date:   Thu, 01 Mar 2018 10:41:22 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com> (Brandon Williams's
        message of "Wed, 28 Feb 2018 15:22:17 -0800")
Message-ID: <xmqqlgfbhc4t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Lots of changes since v3 (well more than between v2 and v3).  Thanks for
> all of the reviews on the last round, the series is getting more
> polished.
>
>  * Eliminated the "# service" line from the response from an HTTP
>    server.  This means that the response to a v2 request is exactly the
>    same regardless of which transport you use!  Docs for this have been
>    added as well.
>  * Changed how ref-patterns work with the `ls-refs` command.  Instead of
>    using wildmatch all patterns must either match exactly or they can
>    contain a single '*' character at the end to mean that the prefix
>    must match.  Docs for this have also been added.
>  * Lots of updates to the docs.  Including documenting the
>    `stateless-connect` remote-helper command used by remote-curl to
>    handle the http transport.
>  * Fixed a number of bugs with the `fetch` command, one of which didn't
>    use objects from configured alternates.

I noticed that this round is built on top of v2.16.0-rc0.  It
certainly makes it easier to compare against the previous round
which was built on top of that old commit and it is very much
appreciated that a reroll does not involve pointless rebases.

For those who are helping from sidelines, it may be ehlpful to
mention where in the history this was developed on, though, as
applying these on the current 'master' has a handful of small
conflicts.

Thanks, will replace and will comment on individual patches as
needed.
