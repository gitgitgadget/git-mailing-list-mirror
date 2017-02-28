Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A70EC202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 23:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbdB1XN4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 18:13:56 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33736 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbdB1XNz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 18:13:55 -0500
Received: by mail-pg0-f67.google.com with SMTP id x17so3343479pgi.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 15:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SOiNMopwqTzQr3g0j/N+305EBYNQ0GDCaabk/r9eDK4=;
        b=ZDVJeFpz3TfwvPGWe/Vhj8/delj+bPNiYPoXftusal9Lc0epuBSPefSdPbJsGmnQFq
         jI/J8ggxkCXCnPGQwGrO7kBmCaINc0oH8IWgvDS+Z5Q3qn4QwOyxe8etQM5bWiAukVnD
         Lq+QNZmZjIThVItU7dwejCa1PfpdNdXbPdQEG53kv4DAjYjigmXR9GN1DjnfCXBOvbQn
         n1xMANqxjDYKwBoeNUv91Ase4R/nWaYNVBYvrJNnh8EWUmQqC9c+N1PuWGo/JVsbQFLC
         tG0Cvkuf/wR7BpBXhGNWOWZEtVU/wN11cawiFlwdQzNA7Wy2nyPh2D2mVgDR8QNQrh/2
         7XXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SOiNMopwqTzQr3g0j/N+305EBYNQ0GDCaabk/r9eDK4=;
        b=HAQF0bzEeJTwQf7O/ntlQppzFDDIKgFNQNp+15MsQvlySJfb0PEQ1H9fud7rd3Qpj5
         kAf0kwEGKdpoAylFy22OlWJc9T1+7eb8os+GFT82NPlDQSNPb+u3SaOvJRfbqqt42fww
         Il+C4iIwcjJk+Jsk0t3xgnPtCVwlalgEQL7PkdsOO6te3kXQTB3nhN/9KvgnTcJ+AO7G
         gFm+e//TIXiag4AIYRW2PiDAOo1LazCsGczo0Y1aJwpce9peEC0F+j/miC59npRbXy6b
         l5cKIJdx/bQzMrqcYe8IAfx3gyVHk8BsxRLNzlzZp0x4KK02ouQ28r1CQPIqWGrpqskc
         ofVQ==
X-Gm-Message-State: AMke39mUsitxUnc0dhn5CGBvPDNl9tlY15fctxGB4JO3NR9d5NyJWx7a79CxrZjRz/6cjQ==
X-Received: by 10.99.7.13 with SMTP id 13mr5164910pgh.121.1488323565935;
        Tue, 28 Feb 2017 15:12:45 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id p6sm6219891pgn.40.2017.02.28.15.12.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 15:12:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, peartben@gmail.com,
        benpeart@microsoft.com
Subject: Re: [PATCH 2/3] revision: exclude trees/blobs given commit
References: <cover.1487984670.git.jonathantanmy@google.com>
        <cover.1487984670.git.jonathantanmy@google.com>
        <7082d91f30663b2e6d7fb1795c5ea37d3fe3446c.1487984670.git.jonathantanmy@google.com>
Date:   Tue, 28 Feb 2017 15:12:44 -0800
In-Reply-To: <7082d91f30663b2e6d7fb1795c5ea37d3fe3446c.1487984670.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 24 Feb 2017 17:18:37 -0800")
Message-ID: <xmqqa895j4er.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When the --objects argument is given to rev-list, an argument of the
> form "^$tree" can be given to exclude all blobs and trees reachable from
> that tree, but an argument of the form "^$commit" only excludes that
> commit, not any blob or tree reachable from it. Make "^$commit" behave
> consistent to "^$tree".

So with this:

    $ git rev-list --objects ^HEAD^@ HEAD ^HEAD^{tree}

should be a round-about way to say

    $ git rev-parse HEAD

;-)

The expression wants to list everything reachable from HEAD, but it
does not want to show its parents (i.e. ^HEAD^@) and it does not
want to show its tree (i.e. ^HEAD^{tree}), so the only thing that
remains is the commit object HEAD and nothing else?

I agree with Peff's comment about objects that may appear beyond the
boundary (i.e. merge base between interesting ones and uninteresting
ones); whether that inaccuracy matters depends on what you want to
use this for---if you want to hide sensitive objects it does, if you
want to reduce the network cost without incurring too much cpu cost,
it probably does not.



