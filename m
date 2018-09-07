Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D2001F404
	for <e@80x24.org>; Fri,  7 Sep 2018 09:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeIGO3f (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 10:29:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34525 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbeIGO3e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 10:29:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so14344940wrd.1
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6VlOlXj9UJRNmhrFhENiH1ovkm7LsV+NE5OEaZrCNj4=;
        b=uvoPQZM2tapgiTpJIC4FVm62+v0/xiaMSnN1EstILAnRcgr20wcL7sgVPsOFXkJAe2
         vQYKaH0jQ6prG2tgz9r20IgogyMJsoVLV/2Y9SVoex9P2ca4hrw0tKQuvp248LYqDfxv
         PDDNSWS3TOHCxN5Rf1adJNZqQbibvkl6VODm+LWLtP+W8R8WhIt1Xf3CNVUXOn2+M5UV
         JKxYfMAmm5m0lTxH1EjcF0em3KuyUUQDSn8JQQ9Ho0n0QRUFeGaIOHh84aIOInQlAjV0
         4dQ1wufY0YHEeEIQ4xA8PlzJuyd8qUlELsAQxHgGOp5L+8Eq9WkC6gUsDc37kXZlpXif
         0SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6VlOlXj9UJRNmhrFhENiH1ovkm7LsV+NE5OEaZrCNj4=;
        b=DSGZYlu6f3RjdETUj+3uilJm8lPcNl/m702/tzr/vlwRHIeyqFeTwPxfo/rLEYD0PM
         zozOJeDchum7k3TURe6TsKcy8hITsc+ARvtcFRHHFe9cLefqLhPzsfdDvB2wF2UZa4b/
         6rdCdWmODjxhmSmV6t4DYs43zPFOyQwXAkoapblb9HhlwKMfPq7KkV2NvXFKHza87C98
         4wnjFZi+ChlfxFHa8X8X46JX8ErlPIcvn4a6xkyxbLJCPVSnASvO0vsR8PuV/SJokHx9
         0JsR6n9V7XbJZCFLKrV40+uQcrhO3QR8mOc9LeA7BqmdT0guT102wmlk3PVNLLt+Ssd5
         jN+w==
X-Gm-Message-State: APzg51A1Om2f0iFD77CJShMfls1cF237Ldcn2oyj5xvBJCaNlqgc0FQa
        ft2D7/uZlh1i5oUpO8KBDCM=
X-Google-Smtp-Source: ANB0VdYRdGoGDbAep2cg0e2IQkmfsUX4K8hjXewgj+p0Tw6yc2GJ9TrwRKCvskyXz74sLllhkN41vQ==
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr5831433wrs.137.1536313764343;
        Fri, 07 Sep 2018 02:49:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w10-v6sm9149587wrp.31.2018.09.07.02.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 02:49:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org
Subject: Re: [PATCH] http-backend: allow empty CONTENT_LENGTH
References: <20180906193516.28909-1-max@max630.net>
        <xmqq1sa6z3zp.fsf@gitster-ct.c.googlers.com>
        <20180907032740.GA20545@jessie.local>
        <20180907033831.GB1383@sigill.intra.peff.net>
        <CAF7_NFRg8wOQ0JbjkJ2gpxKs+oh3s8qXVSPfsWSth2tiUK39hw@mail.gmail.com>
Date:   Fri, 07 Sep 2018 02:49:23 -0700
In-Reply-To: <CAF7_NFRg8wOQ0JbjkJ2gpxKs+oh3s8qXVSPfsWSth2tiUK39hw@mail.gmail.com>
        (Max Kirillov's message of "Fri, 7 Sep 2018 07:59:26 +0300")
Message-ID: <xmqqsh2ly6vw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> Actually, another reason for the latest issue was that CONTENT_LENGTH
> is parsed for GET requests at all. It should be parsed only for POST
> requests, or, rather, only for upoad-pack and receive-pack requests.

Not really.  The layered design of the HTTP protocol means that any
request type can have non-empty body, but request types for which
no semantics of the body is defined must ignore what is in the body,
which in turn means we need to parse and pay attention to the
content length etc. to find the end of the body, if only to ignore
it.

In any case, hopefully we can fix this before the final, as this is
a regression introduced during this cycle?
