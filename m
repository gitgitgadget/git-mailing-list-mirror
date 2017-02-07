Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB9E1FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 20:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbdBGUhx (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 15:37:53 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36530 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753798AbdBGUhw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 15:37:52 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so13002970pgf.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 12:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0S6sMoBZAHAqTePCyAuEPJQ6+MjfPlZrH9tPmbDMdZY=;
        b=uxwWwm5yIOfgx5DU6osGAwTAqKCKQ6Ddous+RccKvi1rRNdIPRbPWbrzzrZar/IL4L
         nVQgizXjazNMU+kGzINs9M//yJP177BItcpRk8eRhws3WTDQIAtKBFGjtdU/TJXczIyE
         VCmFjAsuUfdbM8Mve3yi3guDzu7WP3oEtMVfY7riWu5fYR5TJgMxnRoCQMZDcrHuG5nv
         AZ6x7t1x4+m3KX89z0OE0e2r5MuPZTkDZIH8UeGglVub78InUtkjD3iuiOz37ZfTzteo
         Q1/gAJBpZeBldh8KNHFQ1JzxCzvEh2EA6LnL3AIWiJfJ9QWKlHVzGpjHBtUrnb1o/E5I
         UMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0S6sMoBZAHAqTePCyAuEPJQ6+MjfPlZrH9tPmbDMdZY=;
        b=SWZioeEniAFEohckAP4So7mkWrZtp2yxyWtPffwFTkdaJYnVoPLX5ebtiz0RDv+5yP
         vcjTVs+m4cgnEhidFDORnay6sRBW1Y5DD4WwawLJXEjV6mGxxBXQvI4JrMUqkgfpWaXg
         pfqmAQYWZ3XW7oNI6a2VIPMj6PSMUqzvgoAAZXdL8SRpzePRyu95jNs9TjVY5n1eEhCd
         ltl2mUOSpZ96T7MxVzXbHBy+m+i3dZaVKBw5Y5B3Y6M4f2TFFjEYwrQzNJApJPfdZcEl
         vqmbZvtpHvPrjb3Zbd5ZfgYSIypALvxgv7X4AFTVzivAjPuGgcXzhsh4BNJDKmIjs6Dm
         3m7Q==
X-Gm-Message-State: AIkVDXLWfeFJxGxMm5j7+FcQuZUgxodiDMrr+jlsjuNIMv3nCTK6jcNqSf12ndnxDtr+dA==
X-Received: by 10.98.158.210 with SMTP id f79mr21858793pfk.145.1486499871811;
        Tue, 07 Feb 2017 12:37:51 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:1564:f4f3:f1b4:c9b2])
        by smtp.gmail.com with ESMTPSA id b7sm13688659pfg.53.2017.02.07.12.37.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Feb 2017 12:37:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] grep: use '/' delimiter for paths
References: <20170120171126.16269-1-stefanha@redhat.com>
        <20170120171126.16269-3-stefanha@redhat.com>
        <xmqqpojhwf2r.fsf@gitster.mtv.corp.google.com>
        <20170120235133.GA146274@google.com>
        <20170207150414.GD8583@stefanha-x1.localdomain>
        <xmqq8tphzr41.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 07 Feb 2017 12:37:50 -0800
In-Reply-To: <xmqq8tphzr41.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 07 Feb 2017 12:24:30 -0800")
Message-ID: <xmqq4m05zqht.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

Sorry, one shouldn't type while being sick and in bed X-<.

> I am not sure if you are shooting for is "work correctly" to begin
> with, to be honest.  The current code always shows the "correct"
> output which is "the tree-ish object name (expressed in a way easier
> to understand by the humans), followed by a colon, followed by the
> path in the tree-ish the hit lies".  You are making it "incorrect
> but often more convenient", and sometimes that is a worth goal, but

s/worth/&y/;

> for the particular use cases you presented, i.e.
>
>     $ git grep -e "$pattern" "$commit:path"
>
> a more natural way to express "I want to find this pattern in the
> commit under that path" exists:
>
>     $ git grep -e "$pattern" "$commit" -- path
>
> and because of that, I do not think the former form of the query

s/do not think/do think/

> should happen _less_ often in the first place, which would make it
> "incorrect but more convenient if the user gives an unusual query".
>
> So I am not sure if the change to "grep" is worth it.

Also, it may be fairer to do s/incorrect/inconsistent/.
