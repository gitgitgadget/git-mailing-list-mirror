Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2893C677F1
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 17:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjAMRpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 12:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjAMRot (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 12:44:49 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B088DE0
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:32:34 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id s3so14176494pfd.12
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46naP1DKZgzirHqVIt6Jc3MSfDStc2hLFqhJp8fGACs=;
        b=FzUkmYyvWUIsxBLpxXbeAUYHJiQQMUJEkPI4rSmqf9iJ3L642sWW6+IUVzS5Edvm9I
         P5Z09qnQWRaKFMeXd4rYnRTnG/oSPHOND5BKi4G1ccQYqsKZxMSeHZxJgUUTWpq49kcz
         mOL9cZq8xls3gt5fIiN4odNjGtUrVNBvCtWAMu2o0KnPs598Fbbd+wiB94P+fwIcpXJ9
         8d5bJQNUDvQsLDofWwlD7+Y08OyxvbXS+Qp7XYzdrle85dXnsCtzX+JvbE1r00IZKRQJ
         0yc80sfxHVJF/K19MOnGUfq7wKSI5JhB29uHsSqRXC5vZd2nAscf3ig/XES/f4Z3/L7Z
         ZG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=46naP1DKZgzirHqVIt6Jc3MSfDStc2hLFqhJp8fGACs=;
        b=dzyxxDardrYDovZgpPk6u491gWtmyxoXNizahOgiqSwhx6UOHgdaQ9drKkX9ajeLZ5
         Cd38cbgTaa9WWUcAlOfuxORmt2PFmXuDU94rRKwgsEooN+a40Tgrg3XbxD4Oh6qXmalH
         QnT+x1An+0LG+QzZXbDUUDXvT6KjIIMwJx4O7nKjKzPI/vYbtHZCstofFP1nnhfXv5Uk
         ab4bNjlrqhAa1tfTw4hKifJzipL3Oy8y7unskKJLsaX5kehwQGiOcUxrpFJ0WYuwKQ6V
         1CuzRButRPFFC+/gyKWdvxo5ap6z2rEPjilQzoxCwBfj/cp0z1QNcXNX4sQw3ELLa+f2
         SI9g==
X-Gm-Message-State: AFqh2kpzScqLHny0HrySmD6EGcwkPbvtMMerhWV26VMXos4Mc4J7pWYR
        Hny13rjc4iQs2FXch7huyuQjx7eWtMg=
X-Google-Smtp-Source: AMrXdXs+kZ08jN+lfqWigXopu7jsFR2Mnm4qT1Z4F48R9O4HCMg1cqabdg4lNops3u5uXlCdTC8B3A==
X-Received: by 2002:aa7:8152:0:b0:587:d491:995f with SMTP id d18-20020aa78152000000b00587d491995fmr19212197pfn.20.1673631153334;
        Fri, 13 Jan 2023 09:32:33 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h4-20020aa79f44000000b0056d7cc80ea4sm69009pfr.110.2023.01.13.09.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:32:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Jacob Abel <jacobabel@nullpo.dev>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 3/4] worktree add: add --orphan flag
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
        <20221104213401.17393-1-jacobabel@nullpo.dev>
        <20221110233137.10414-1-jacobabel@nullpo.dev>
        <20221212014003.20290-1-jacobabel@nullpo.dev>
        <20221220023637.29042-1-jacobabel@nullpo.dev>
        <20221228061539.13740-1-jacobabel@nullpo.dev>
        <20230107045757.30037-1-jacobabel@nullpo.dev>
        <20230109173227.29264-1-jacobabel@nullpo.dev>
        <20230109173227.29264-4-jacobabel@nullpo.dev>
        <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk>
Date:   Fri, 13 Jan 2023 09:32:32 -0800
In-Reply-To: <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk> (Phillip
        Wood's message of "Fri, 13 Jan 2023 10:20:26 +0000")
Message-ID: <xmqq1qny5oi7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> % git -C bar.git worktree add --orphan main main/
>
> It's perhaps a bit late to bring this up but I've only just realized
> that it is unfortunate that --orphan takes a branch name rather than
> working in conjunction with -b/-B. It means that in the common case
> where the branch name is the same as the worktree the user has to
> repeat it on the command line as shown above. It also means there is
> no way to force an orphan branch (that's admittedly quite niche). If
> instead --orphan did not take an argument we could have
>
> 	git worktree add --orphan main
> 	git worktree add --orphan -b topic main
> 	git worktree add --orphan -B topic main

Good point.  I am not sure if it is too late, though.

Thanks.
