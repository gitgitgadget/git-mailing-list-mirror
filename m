Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF32A1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 16:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754530AbeGIQHy (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 12:07:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54592 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754525AbeGIQHv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 12:07:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so21609684wmf.4
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xryPGVm5b8r3cuw9oQdUm+4IbA03KoojDnu1BYO48N8=;
        b=kxw3/by6ygH9ue6OhB/ZWKz1ZbGoDt3uhiWqe4FJoHq+TvdTwk7hvJPGabsR5Qs9NG
         n5l2tUPcA+Vlq0uodczCRxcwZueut98lbYoYexS5R4R/EJ2Ea7hyTjiCqPsMbvBuhL26
         DLIQ1P4/eWzYuwqUlr1avsJtvrUEbFZUqb1jyfdASYVOeubYLGHB44+GFvmd2EHcmh1l
         XtYRZKnSJM9lc+HJGWy71sxf0JXrdyprcHXvXoq92T+4v1jlH6L5Le7UF8UGv7ElBjwG
         N2tIPKHdXY/vDn8vqLl+V1hzd+l1wD7gpYXY36ig32Kg6UMXTO46Jxwl8CaLUP7SOzbb
         a+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xryPGVm5b8r3cuw9oQdUm+4IbA03KoojDnu1BYO48N8=;
        b=FlXROHrNSsLmes/G1kd/mZHBXIqdFsjq479/I9Vi/uY0k6gKdtbiIWflSL+TlV48tW
         KQpFEPqjMLgwr6KAEiJDE/tRw/TzUz9F2GmIQooxjNj1yFcvRUUp45x/4NpBuj2YAi4X
         ru2uFvt4GoQ8QCHB/HJy2MS0CFjShkxrjA0wnkAEteylgM1OQqJrCeHf/cItHMqcH8ts
         mN8t3MHybO+jbLzMKPKbjHZzGZlp/mo2bRyTPXtQ2VHNqI2j218kT6+B2bZd5rUjPnGF
         aZFhD+QVjzZGFyT1VY86/h/oWBRqZrwJbLD4MRTVsN6nVYunzucF4NbTfzSsp7E7qEXd
         PL5g==
X-Gm-Message-State: APt69E0EOTIrshMMwpAIFoP6NX+LEpmSCh78YVXsv40Fv0/NU67Ii/iu
        7rTh1758ESvx6Ccp5NTleOk=
X-Google-Smtp-Source: AAOMgpfqxiWRGvYBRLJQ54mIWuLbdvXq1G/8U+ZUTZG5EJCZQP6fGPu6g8UXLzN3mj1Ts/znWMxneg==
X-Received: by 2002:a1c:8587:: with SMTP id h129-v6mr9185726wmd.105.1531152470218;
        Mon, 09 Jul 2018 09:07:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k188-v6sm24239179wmd.47.2018.07.09.09.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 09:07:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH 0/2] Avoiding errors when partial cloning a tagged blob
References: <cover.1530905323.git.jonathantanmy@google.com>
        <20180706193847.160161-1-jonathantanmy@google.com>
        <xmqqk1q8jfak.fsf@gitster-ct.c.googlers.com>
        <20180706212957.GD6195@aiede.svl.corp.google.com>
Date:   Mon, 09 Jul 2018 09:07:49 -0700
In-Reply-To: <20180706212957.GD6195@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 6 Jul 2018 14:29:57 -0700")
Message-ID: <xmqqpnzwfl4a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>>>> When cloning a repository with a tagged blob (like the Git repository)
>>>> with --filter=blob:none, the following message appears:
>>>>
>>>>         error: missing object referenced by 'refs/tags/junio-gpg-pub'
>>>>
>>>> and the resulting repository also fails fsck.
> [...]
>>                            Naïvely, I may expect fsck to follow the
>> same principle--when it encounters a reference to an object that is
>> deliberately missing, refrain from complaining, regardless of the
>> place the offending reference was found, be it inside a tree object
>> or a ref.
>>
>> Perhaps that line of consistent behaviour may be impossible due to
>> the way the reference is stored inside a tree object and a ref?
>
> Yes, exactly.  I believe this is why we did not treat refs as
> promisors when we introduced promised objects.
>
> We could revisit that decision and make refs into promisors, storing
> any extra metadata on the side.  That would be a more invasive change
> than this series does, though.  In the model used today, where refs
> are not promisors, this series is the logical thing to do.

I think that refs in files-backend is a bit hard to update to
annotate with extra information like "is this merely promising or a
tip of the connectivity graph?" and agree that we should not make
refs promisors.

Such an otherwise unreferenced blob could be made into a promised
object by the promisor repository, though, I think.  It can include
a synthetic tree that points at such a blob in the pack stream data
if it knows that the resulting pack will be marked with the
.promisor bit, and by doing so, there is no need to update the
client side, no?

