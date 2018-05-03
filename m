Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D23200B9
	for <e@80x24.org>; Thu,  3 May 2018 17:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeECRr6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 13:47:58 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35865 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECRr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 13:47:57 -0400
Received: by mail-pf0-f180.google.com with SMTP id w129so9877288pfd.3
        for <git@vger.kernel.org>; Thu, 03 May 2018 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ixUrIWvpv6r7bbJ8avtcVTQFdtheNOL9vMo6bMbcz0=;
        b=jbNRcni+J6cC80R/3crcwfdNkRJA6TlJHSVAyB3tk8Er8L9uLAihPBVwu3EPWiFIgz
         fXGJozVvvuxb18+T5XgK1kfmXHUuMS7dystW1SD615PM4x+XRBY8RfgM0Z5+SRTKLvTw
         0t2B1B3f3KVMdJBMtDqvbhnek3u5kZOulqHipPsulT8HX7fef3KHjbCrH7jWcmvVtYm9
         pZabRq2ZDSU2MTpbRT9aPpiJm/f2uww7YMGm7CZF1rqOdn1bv+OJ+7WxS0ngT3u1doAQ
         gm9Z+BU2cdtSavdNfWn8BXET43WDV83QWBJ7r1n88y82JSmQ6DpFHQSflIAYEwMlv7a5
         eGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ixUrIWvpv6r7bbJ8avtcVTQFdtheNOL9vMo6bMbcz0=;
        b=jgpxSxct0Ivwf3lCryT4vuZrSln1CFRfMrkcyuN4fiKlwvpHva8z3FDP0Xc3J002+O
         O0hSKV8e8MtA0WQTcO1RdcGw6U1VbFqY2U9t90nHGmSYDCHKAnLzdUCITcQDITJNUbes
         sbZe1cUdM23zgV+/zeA4GmcSsL/seggVI7Vzm4u+hH7iM5ZBm1MDugHXNNjFRP2vt+wa
         Sf0cU7I0DA1o9VcKjzLsdu0DMWKa+qR82yLOOgZm5froATpzlz/S95T4XuazNHijL/gP
         OAEGXda7kW6rft5QFXArzi+bLU5I+KyLaqwDwOWQ5zlXh8tISFA6g199QixfGRXwZncZ
         P6nQ==
X-Gm-Message-State: ALQs6tCAx0KXMRk2Vq61JXX882jLmy1Zg5EdOVlm+f4oWKpkzcomo4Y0
        VT/6PUagYb1aKQOM/8NEh6rKlXhmd7k=
X-Google-Smtp-Source: AB8JxZqI/3mGGOfRaGkOrPJFtaEIYgWsCkHfYxXfJw4D/WrBrX6P5O2UktfEUihrgg3770/IMJOfnA==
X-Received: by 10.98.26.78 with SMTP id a75mr23766091pfa.84.1525369676687;
        Thu, 03 May 2018 10:47:56 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id f5-v6sm22275219pgq.77.2018.05.03.10.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 10:47:55 -0700 (PDT)
Date:   Thu, 3 May 2018 10:47:54 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, christian.couder@gmail.com,
        pc44800@gmail.com
Subject: Re: [PATCH 1/5] submodule foreach: correct '$path' in nested
 submodules from a subdirectory
Message-Id: <20180503104754.6aefd8ba38eb5a8871281b01@google.com>
In-Reply-To: <20180503005358.89082-2-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com>
        <20180503005358.89082-2-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed,  2 May 2018 17:53:54 -0700
Stefan Beller <sbeller@google.com> wrote:

> From: Prathamesh Chavan <pc44800@gmail.com>
> 
> When running 'git submodule foreach --recursive' from a subdirectory of
> your repository, nested submodules get a bogus value for $path:

I know I said in a previous e-mail [1] that we should use $path instead
of $sm_path, but now I got confused because the test shows a difference
in $sm_path, not $path. Maybe add "(and $sm_path, which is an alias of
$path)".

[1] https://public-inbox.org/git/20180206145406.b759164cead02cd3bb3fdce0@google.com/

> There are three different possible solutions that have more value:
> (a) The path value is documented as the path from the toplevel of the
>     superproject to the mount point of the submodule. If 'the' refers to
>     the superproject holding this submodule ('sub' holding 'nested'),
>     the path would be expected to be path='nested'.

What is "the", and why is it quoted?

Also, in (c), you use the same indicative present tense as "The path
value is documented" to describe the current situation, whereas this
seems like a situation you're proposing. It would be clearer to use the
imperative here ("Document $path to be the path from the toplevel...").
Do the same for the others.

Also, whenever you mention "superproject", make it clear which
superproject you're referring to ("outermost superproject" and
"immediate superproject" seem like good terms to me).

> (b) In case 'the' superproject is referring to the toplevel, which
>     is the superproject in which the original command was invoked,
>     then path is expected to be path='sub/nested'.

Same comment about "the", and I think s/toplevel, which is the
superproject in which the original command was invoked/outermost
superproject/.

> (c) The documentation explains $path as [...] "relative to the
>     superproject", following 091a6eb0fe (submodule: drop the
>     top-level requirement, 2013-06-16), such that the nested submodule
>     would be expected as path='../sub/nested', when "the" superproject
>     is the superproject, where the command was run from

How does "relative to the superproject" result in "../" appearing in the
path? I would expect "../" to appear only if a path is relative to $pwd.

> (d) or the value of path='nested' is expected if we take the
>     intermediate superproject into account. [This is the same as
>     (a); it highlights that the documentation is not clear, but
>     technically correct if we were to revert 091a6eb0fe.]

How exactly are we taking the intermediate superproject into account?

> The behavior for (c) was introduced in 091a6eb0fe (submodule: drop the
> top-level requirement, 2013-06-16) the intent for $path seemed to be
> relative to $cwd to the submodule worktree, but that did not work for
> nested submodules, as the intermittent submodules were not included in
> the path.

I think "pwd" is more used in the Git project than "cwd", so maybe use
$pwd here.

> If we were to fix the meaning of the $path using (a), (d) such that "path"
> is "the path from the intermediate superproject to the mount point of the
> submodule", we would break any existing submodule user that runs foreach
> from non-root of the superproject as the non-nested submodule
> '../sub' would change its path to 'sub'.
> 
> If we were to fix the meaning of $path using (b) such that "path"
> is "the path from the topmost superproject to the mount point of the
> submodule", then we would break any user that uses nested submodules
> (even from the root directory) as the 'nested' would become 'sub/nested'.
> 
> If we were to fix the meaning of $path using (c) such that "path"
> is "the display path from where the original command was invoked to the
> submodule", then we would break users that rely on the assumption that
> "$toplevel / $path" is the absolute path of the submodule.
> 
> All groups can be found in the wild.  The author has no data if one group
> outweighs the other by large margin, and offending each one seems equally
> bad at first.  However in the authors imagination it is better to go with
> (a) as running from a sub directory sounds like it is carried out by a
> human rather than by some automation task.  With a human on the keyboard
> the feedback loop is short and the changed behavior can be adapted to
> quickly unlike some automation that can break silently.

As I said in my previous e-mail, this is a good analysis.

> Another argument in favor of (a) is the consistency of the variables
> provided, "$toplevel / $path" gives the absolute path of the submodule,
> with 'toplevel' (both the variable as well as the documentation) referring
> to the immediate superproject of the submodule.

It's confusing to me that $toplevel is not the path to the outermost
superproject, but the path to the immediate superproject, so I'm not
sure that the goodness of "$toplevel/$path" exists. I would omit this
paragraph.

> Documentation of the variable is adjusted in a follow-up patch.

By "the variable", I assume you mean $toplevel? If yes, this doesn't
seem relevant to this patch, since this patch does not change the
meaning of $toplevel at all.
