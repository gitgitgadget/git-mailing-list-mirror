Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1C901F404
	for <e@80x24.org>; Mon, 16 Apr 2018 17:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeDPREj (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 13:04:39 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:42058 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeDPREi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 13:04:38 -0400
Received: by mail-wr0-f182.google.com with SMTP id s18so28033033wrg.9
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MtptCPcAptuZ2qV83VCJfbsPKLXpD11mGEENPB3xnoA=;
        b=RabanHSZ5pVcV9U0ghMJ2tavBpm7+9cLE/gPoqG7Dw3W9qCwH/xit2Tk4iIwA7grGl
         wroDRaAOROop0jn063CS6C1RnJhrVqBKw0ECKABw48mBg2nUyQEvZNxvABJMNeKDT8g2
         nZHIB3F/RPNqkORnsPPb+cR+4L3IQwgVxprUO5G6NBbVbpjvJFEt73OKQG4aX/Rq1EK1
         zwGfsQxBvHOyp4Shq9eAnSoVjNomjgDNTtWNzSEwg7m6zsxnGsO2zGdrDJLffX+vjtwr
         s5x+pQxDr9J95QFG5Q/UQQdTURj6PsB0Nxe1WBKDqkLM6ZluE9yKQ09/Ppi85oa2P0Oh
         BDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=MtptCPcAptuZ2qV83VCJfbsPKLXpD11mGEENPB3xnoA=;
        b=ZPoC8rpQzVTAfdZXLCgeEQFNYpaKSNlEJJ5+s2nReJVcQooYDrxhdfWaHx5ogklDk7
         klZy9wuh8SYYQqnjkNA5NASZmUkqHF9uG1DftqUd+srYjmOQIDGLFQLX0/OURuWXPC1K
         iJKrzIIDkoky+zidoCQdcNysBVImHk/WrgIyTYFiUNvJpmNRyfHPs4v2EtuJZCpXkIO/
         b1FIVNrvm0yX1TIKcPY33IQevybA8h7cOQBZ5AEa+gPsI5uPePlUR8ZDXoona/11ATaL
         pWZLAcJhS4TiMtETs2OwBYsgUeazlAUxOLSe9UvcgbQyarpXUXc9cNmm/FccwbyincmF
         cp8A==
X-Gm-Message-State: ALQs6tDX88cvcaCNGN/0xtGr6OxsWVi7/5NFVaZ99DHAswM4uhthpSP2
        dUCeTm+6yCiM9GJIzNUezFw=
X-Google-Smtp-Source: AIpwx49ITsIOIXgzs162GZpRu341b2XWxscrPqRWsGuNhnHz2KlBIl0YUoYCWUysdQ39Po935P4SLA==
X-Received: by 10.80.185.65 with SMTP id m59mr16589616ede.276.1523898277271;
        Mon, 16 Apr 2018 10:04:37 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id i15sm7527070edb.56.2018.04.16.10.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 10:04:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, mgorny@gentoo.org,
        rtc@helen.PLASMA.Xg8.DE, winserver.support@winserver.com,
        tytso@mit.edu
Subject: Re: Optimizing writes to unchanged files during merges?
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
        <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com>
        <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
        <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
        <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
        <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
        <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
        <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
        <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
        <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com>
        <CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com>
        <F1738316-71EF-4053-82E5-F009F491CCE8@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <F1738316-71EF-4053-82E5-F009F491CCE8@gmail.com>
Date:   Mon, 16 Apr 2018 19:04:35 +0200
Message-ID: <8736zvf5gc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 16 2018, Lars Schneider wrote:

>> On 16 Apr 2018, at 04:03, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> On Sun, Apr 15, 2018 at 6:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> I think Elijah's corrected was_tracked() also does not care "has
>>> this been renamed".
>>
>> I'm perfectly happy with the slightly smarter patches. My patch was
>> really just an RFC and because I had tried it out.
>>
>>> One thing that makes me curious is what happens (and what we want to
>>> happen) when such a "we already have the changes the side branch
>>> tries to bring in" path has local (i.e. not yet in the index)
>>> changes.  For a dirty file that trivially merges (e.g. a path we
>>> modified since our histories forked, while the other side didn't do
>>> anything, has local changes in the working tree), we try hard to
>>> make the merge succeed while keeping the local changes, and we
>>> should be able to do the same in this case, too.
>>
>> I think it might be nice, but probably not really worth it.
>>
>> I find the "you can merge even if some files are dirty" to be really
>> convenient, because I often keep stupid test patches in my tree that I
>> may not even intend to commit, and I then use the same tree for
>> merging.
>>
>> For example, I sometimes end up editing the Makefile for the release
>> version early, but I won't *commit* that until I actually cut the
>> release. But if I pull some branch that has also changed the Makefile,
>> it's not worth any complexity to try to be nice about the dirty state.
>>
>> If it's a file that actually *has* been changed in the branch I'm
>> merging, and I'm more than happy to just stage the patch (or throw it
>> away - I think it's about 50:50 for me).
>>
>> So I don't think it's a big deal, and I'd rather have the merge fail
>> very early with "that file has seen changes in the branch you are
>> merging" than add any real complexity to the merge logic.
>
> I am happy to see this discussion and the patches, because long rebuilds
> are a constant annoyance for us. We might have been bitten by the exact
> case discussed here, but more often, we have a slightly different
> situation:
>
> An engineer works on a task branch and runs incremental builds — all
> is good. The engineer switches to another branch to review another
> engineer's work. This other branch changes a low-level header file,
> but no rebuild is triggered. The engineer switches back to the previous
> task branch. At this point, the incremental build will rebuild
> everything, as the compiler thinks that the low-level header file has
> been changed (because the mtime is different).
>
> Of course, this problem can be solved with a separate worktree. However,
> our engineers forget about that sometimes, and then, they are annoyed by
> a 4h rebuild.
>
> Is this situation a problem for others too?
> If yes, what do you think about the following approach:
>
> What if Git kept a LRU list that contains file path, content hash, and
> mtime of any file that is removed or modified during a checkout. If a
> file is checked out later with the exact same path and content hash,
> then Git could set the mtime to the previous value. This way the
> compiler would not think that the content has been changed since the
> last rebuild.
>
> I think that would fix the problem that our engineers run into and also
> the problem that Linus experienced during the merge, wouldn't it?

Could what you're describing be prototyped as a post-checkout hook that
looks at the reflog? It sounds to me like it could, but perhaps I've
missed some subtlety.

Not re-writing out a file that hasn't changed is one thing, but I think
for more complex behaviors (such as the "I want everything to have the
same mtime" mentioned in another thread on-list), and this, it makes
sense to provide some hook mechanism than have git itself do all the
work.

I also don't see how what you're describing could be generalized, or
even be made to work reliably in the case you're describing. If the
engineer runs "make" on this branch he's testing out that might produce
an object file that'll get used as-is once he switches back, since
you've set the mtime in the past for that file because you re-checked it
out.
