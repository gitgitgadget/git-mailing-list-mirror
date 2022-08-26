Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ABEECAAA6
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 16:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbiHZQsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344809AbiHZQs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 12:48:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49401E1909
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:46:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o4so2138001pjp.4
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=Aikevtz0kZBccZBmT/xCbweTfTtJg4wQOI8vHI1oyiI=;
        b=gmheK/HZuchjNoeUbIxCA2d3YFIp9XfKIzqjstPQrzlDZnb1pPVoREyA/Euc4Oep97
         f+O6hN2L52DnwSCxVCRBA1gGm79xOQjbspQsB/GbYRoih3/mZy1RRUJYxPH54e4gS3NN
         pyqvUXqUtUnlGORHM1dBS8cSsFKFn8cBUiU/k0zZdPLKFOKlZI6qrOk//TGrFZukaEvm
         bSzoIcNu2K6dP2mU+ovuFd7QoPISlzJ4GcCx6EDQ53zcbG+2mhPSAK1XYO5S+cpDX+cN
         IFFlQchxdo7ZvkbAv8XwBBay2QPUcs/rxidIBN43G+HrgQNARWUgf1zWidZlELpJ8oY6
         JbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=Aikevtz0kZBccZBmT/xCbweTfTtJg4wQOI8vHI1oyiI=;
        b=ELBsQFPrbFbleghfI65GtYuNkdG/bv/CMQtjyj2OAxoxut6vnpsS4kznwwNK8ZGzWG
         PI3VzrgdgmMjUH5whwsZjTA5Z01tDcvbXWeIp4txLNkijGWlLTTCFFqtEJO4Djm7zsbP
         fHgYDttWHR6eauwd+85tgQAVQ2Kxc8fXEVZZZ9yYfRR4Btaf42DYzZwfHRrQ1Kdye/SD
         wbqGs5PKk5ly0OcSLdGypHdUBf8Opdlz3cKJnHGVyNYl7JxMKyc84194pzhA2LvufmOf
         j4ajJpNW6NWZS+MaAmz/aT7RDPnAqbiqfA/EvPECfc8eTKOGUj4ipsUiS0dckEp9wmfq
         kIWQ==
X-Gm-Message-State: ACgBeo02CWVsTAGM2+dzHTKjcfa0B6Qpaaw9LLoeXMiIxBe+T3KGF11U
        YWihHkUWATCgchxHTIyF4Cs=
X-Google-Smtp-Source: AA6agR7jy9codl8cjha/IilbJG9Mi+NlVh47M2kPyc/IT6/qaMVMTQQ+wBDFAoArFuJ6oXACxl6BBA==
X-Received: by 2002:a17:902:7586:b0:172:d0de:7a3c with SMTP id j6-20020a170902758600b00172d0de7a3cmr4580753pll.38.1661532415260;
        Fri, 26 Aug 2022 09:46:55 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h6-20020aa79f46000000b0052e6c058bccsm1982911pfr.61.2022.08.26.09.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:46:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
        <xmqqwnax438x.fsf@gitster.g>
        <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
        <xmqqfshl3pbp.fsf@gitster.g>
        <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
        <Ywh6v8oo3nRl/O5h@coredump.intra.peff.net>
Date:   Fri, 26 Aug 2022 09:46:54 -0700
In-Reply-To: <Ywh6v8oo3nRl/O5h@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 26 Aug 2022 03:48:15 -0400")
Message-ID: <xmqqczcnymtd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> But the fix here isn't to delete unused.cocci, but to hold off on the
>> UNUSEwork D() patches until we figure out how to make coccinelle jive with
>> them.
>
> Yeah, my general skepticism and disappointment above notwithstanding,
> this seems like the best path forward from here. I tried a few other
> tricks (like --macro-file and --iso-file), but if its parser chokes, I
> don't think there's much we can do about it. Even if we wrote a patch to
> coccinelle itself (and I have no interest in doing that myself), it
> would take a while to become available.

If it is just a single unused.cocci, I would actually think removing
it would be a much better path forward.  UNUSED() that renames to
help folks without checking compilers would help noticing bad code
much earlier than unused.cocci many contributors are not running
themselves anyway.

