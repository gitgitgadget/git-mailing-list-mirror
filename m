Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793331F404
	for <e@80x24.org>; Tue, 13 Feb 2018 17:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965390AbeBMR5T (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 12:57:19 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39522 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965158AbeBMR5S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 12:57:18 -0500
Received: by mail-wm0-f65.google.com with SMTP id b21so17565580wme.4
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 09:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=k/URmF4It2YRFvRGJY+/5ah+ZEl9VPgz+6efSdk+hUA=;
        b=TPzbfdudMncyZZm7zZtfiK8tqHTxcLjQuvRpjqWQDlm9u57pzEVSeGHN9BEi5fypPQ
         q5F3pGt0SjehsPecXlwZzZdRp9g0dpy+nPt3ZxcT2jpsbhvw0w6KgmVWD9APL5DywArb
         ECEKXl8+zzVAdLN73nOm2sL8XIfV35mfB66RQpMibk94tpdj83bEQihZ+FktVoLQ36uh
         K+oihxIcaXbFSX2/NSHfj8G1jKeDT3r35hFRl5VQZ1JO5wW9OoJFibqSaSFxSiROmumr
         I/VNhQ+WZtcPgxX1ii0hqT4cJsMRAlLH3AoxqedFQv2hpirDwONn3VpzHQToC8mY7GUH
         oK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=k/URmF4It2YRFvRGJY+/5ah+ZEl9VPgz+6efSdk+hUA=;
        b=eJTJdQ6sf4lUxrpK8/9oz0IPpCbYhQE9dQjI+kDc8Dsm5cE9uep6DOEpWhat93gxII
         VqW/DCj5nWjaUZVUAYeDr3pKgxDPDXIyyuq7UQw2t1YXRu0kEQVaK++dHpw+nbSecuyp
         y0l3paC03HStUKZYGBrxQHz4fqDLBTLr1yUI6k6EdWLRLKWjkVgbn09vr64wNBj6k1ir
         I7E58xA6sjmYrc5iQOpD8C6iar+bRxfEYA5leqzxmRHemmhP71twFPzLucWeRtWs5aSk
         TmC9QzAx2bYAXi7gY2D4uCj8w3xDpObwDhMN4UzkApAZexOyFcgp2tOxA7bjGVRApiQD
         9Rxw==
X-Gm-Message-State: APf1xPCVorvvO9WjhUgZ/eIGt1S/iQbv83cWmSt+JCpyD0jCmL+LOhiq
        jtwInuwfUV73SY6oR66W72s=
X-Google-Smtp-Source: AH8x226Nw5P2adTKlJ6sGDmWrVMq7i64IY0Pz8+X2dvqc52hGhff/7KKwG66HSysEDR/+B+2cyqW6A==
X-Received: by 10.28.177.215 with SMTP id a206mr537511wmf.145.1518544636683;
        Tue, 13 Feb 2018 09:57:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 123sm10425099wmt.31.2018.02.13.09.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 09:57:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] dir.c: ignore paths containing .git when invalidating untracked cache
References: <20180204093823.3671-1-pclouds@gmail.com>
        <20180207092141.4312-1-pclouds@gmail.com>
        <20180207092141.4312-2-pclouds@gmail.com>
        <c755e388-89a5-fc0f-f872-16fd5d5686b0@gmail.com>
        <CACsJy8AHa6QDmWu7TFjgW7m0pHysYkZq_WJ1QOVBVYaT4XdL4Q@mail.gmail.com>
Date:   Tue, 13 Feb 2018 09:57:14 -0800
In-Reply-To: <CACsJy8AHa6QDmWu7TFjgW7m0pHysYkZq_WJ1QOVBVYaT4XdL4Q@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 13 Feb 2018 17:00:50 +0700")
Message-ID: <xmqqinb0rcw5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> It's very tempting considering that the amount of changes is much
> smaller. But I think we should go with my version. The hope is when a
> _new_ call site appears, the author would think twice before passing
> zero or one to the safe_path argument.

Wouldn't it be a better API if the author of new callsite does not
have to think twice and can instead rely on the called function
untracked_cache_invalidate_path() to always do the right thing?


