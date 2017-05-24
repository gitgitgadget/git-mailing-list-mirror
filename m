Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D0B20281
	for <e@80x24.org>; Wed, 24 May 2017 01:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758894AbdEXBoE (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 21:44:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33598 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758528AbdEXBoD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 21:44:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id f27so31107989pfe.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 18:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rIOM4Vs1o8tI37cCNPQDxPsDUztdhYWjJvQxPuBqG+Q=;
        b=ONvDBzevB/RNaZjbByW6G5JcfNJu3Ggodq+c2l/vXUIDkcuLgizh9d9c3mrq64rUVq
         9EJetibz4XqNDr3h5prclOHT7ThWIwzTYnkOpy2nCh1gxIBAScp9cf+mW4jZqsCYfoul
         IatMRAFjiWuiaLKPwfaXt69frIijCDYOzmWjNyMFS6fhlzGZeu1uxqM4NhOGLzX9ohWz
         G49QFanOq/n/T3tPUrnAxizrJqboqVX/j0fFh9MmvdW913pM+s+Z8R0pghr6mombQdj1
         dtlDI8YQxyxy7NiFi/vb7Z2bYmaXfUe3SAl+jCJ+LD2GndKQLBzV9kjtNg6lK5yD64I5
         oHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rIOM4Vs1o8tI37cCNPQDxPsDUztdhYWjJvQxPuBqG+Q=;
        b=JMW6gLGA4tDfwXJlGEfVoy5VpLnHI7iojN2mGI8hZynabiR2mwzjk1uChNCPgLyyNb
         p2uuBE1HaqQ76OHDDzc4yN2peM16sm28QaYlt+nE61wvpqQLU0I1lCj3uLAsX749PtH4
         xYuI0Cu/YvzC6TsH9/Ca+YJzQTrvl+1X5QODwafqX4/RBN5O0qwl3Hw3zb2MRnI0FiCl
         jARhp5OOKAfKjbHBgZQwJ7gKFTQSuM5lsxuiiZL7Lo5AaJa0APCWDRv7f5HIWK60qfYb
         sG6X1wp3VoyguYcY1FANl1NhWgEss2j1yHvpFUo8A4IXQuwMQf7B+A3fuGEVBI2vclxV
         fF2A==
X-Gm-Message-State: AODbwcAcBuNACr+NAffgFDqD5tlAFCafK5/77fj6DQUskQ1tiO5h1IRF
        S2nCHG9y59aOjA==
X-Received: by 10.99.189.9 with SMTP id a9mr16332014pgf.9.1495590242856;
        Tue, 23 May 2017 18:44:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id n71sm4108689pfg.46.2017.05.23.18.44.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 18:44:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     ch <cr@onlinehome.de>, git@vger.kernel.org
Subject: Re: Passing revs to git-bundle-create via stdin
References: <76491764-cd43-ef7f-fbfc-939a15f2fb77@onlinehome.de>
        <20170523164641.u3rd7bgc7ifvu2su@sigill.intra.peff.net>
Date:   Wed, 24 May 2017 10:44:01 +0900
In-Reply-To: <20170523164641.u3rd7bgc7ifvu2su@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 23 May 2017 12:46:41 -0400")
Message-ID: <xmqqwp97hvvi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think what's happening is that git-bundle actually runs _two_
> traversals using the command-line arguments. ...
> ... It was just a way of confirming my
> guess about the double-read.
>
> The real solutions I can think of are:
>
>   1. Teach git-bundle not to require the double-read. I'm not sure why
>      it's written the way it is, but presumably it would be tricky to
>      undo it (or we would have just written it the other way in the
>      first place!)

If I remember correctly, the reason why it does the double-read is
because it wants to cope with things like "--since".  There is no
explicit bottom of the DAG specified on the command line, and the
first one (without "--objects") is done to find "prerequisites" that
are written in the header.

Then the packdata is generated, which does another traversal (this
time with "--objects" option).

So perhaps the right way to fix it is to keep the first traversal
as-is, but update the second one (I think write-bundle-refs is the
culprit) so that it does not use the user-supplied command line
as-is; instead it should use the positive end of the history from
the command line with the negative end set to these "prerequisites"
commits.

I said "command line" in the above, but read that as "end user
input"; the list of rev-list command line arguments given from the
standard input is exactly the same deal.
