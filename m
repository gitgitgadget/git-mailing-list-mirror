Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B61A207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 22:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935348AbcJFWlb (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 18:41:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33692 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935328AbcJFWlY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 18:41:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id i130so82849wmg.0
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=qvej+mj5AhDuub/1Ps3cNryoJW7zNpdl8k8Bq9NdEoc=;
        b=uJhoupPAB98yPBW2pJEXu6+ZbkiSEKBEWIdkYjz8YC26EOXtaD8IR/ga44mZ9n30fS
         OA9/YR9h0lwauZmToxTRDEcJozvh4hBVEpGao3/BBy4GYS6kKGwfm18Ob/q/cVT/ro1S
         p5S+w/jMGxEwPXAkemZbWz826MKEn0QXvrFB0rDQbyH1j3r548P3a/0zA4RQ9trhUmXz
         AsQ2tVGv51I6v7Bz4ayqAwnwBSQOoLPTW6U12mmdmatuAChlA/VZhxtpvg2FS5QJS+ct
         Mw/yK7qRrDqoH1W7MPQOCUQKAlxC0eFI1r/scVxOWWfH/T3sqKxaVwb9w7ZYLqIwlsC3
         mc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=qvej+mj5AhDuub/1Ps3cNryoJW7zNpdl8k8Bq9NdEoc=;
        b=H1yNEFpMsBvq9CR99E2Y1m2VaswHmSBW960UEDIgBPoE4PDOX7zT/TrNjUeieP6kHn
         3TBFNpz1cDPdBB1mWRlMvbEVVO2aBDx8B4t4X3hXn5QdjgPKnlv5Cp3Swu2jSFiTIZKu
         0cZAsE93UJHhoGJszISgSbpxkrHTCN/3uKZmeWQXN2osbS7GQOCormoSPtkApT665SFk
         4J21Wz/ovioMkMTyKNLLJUEnKEeIKEFHbzFM2G36u/n8WBagT0ZlErXq6KULUmZeaoLm
         0QIz6w9oLp/5WKw/KYhcBdMRRAi6N+J5xtIvddbdKMtD0V9HFkXbG7ZcuMthXOLm+c1O
         s0dg==
X-Gm-Message-State: AA6/9RkY+JW27SX2lHhX6153q4ATYjaz4rEXBBTJIWfFEeqsMHnHwqd2GSu95nKMiK1DQw==
X-Received: by 10.28.4.74 with SMTP id 71mr17520636wme.19.1475793677692;
        Thu, 06 Oct 2016 15:41:17 -0700 (PDT)
Received: from [192.168.1.26] (dat198.neoplus.adsl.tpnet.pl. [83.23.19.198])
        by smtp.googlemail.com with ESMTPSA id x135sm193396wmd.0.2016.10.06.15.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Oct 2016 15:41:16 -0700 (PDT)
Subject: Re: [PATCH v2 05/25] sequencer: allow the sequencer to take custody
 of malloc()ed data
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <cover.1473590966.git.johannes.schindelin@gmx.de>
 <942aa559a0af9b52e079c5c78fa313f49b87d50d.1473590966.git.johannes.schindelin@gmx.de>
 <xmqqzinc295y.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610051338530.35196@virtualbox>
 <xmqqeg3tjn7n.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <28935e27-5ba8-c261-ba44-424f7b91cdda@gmail.com>
Date:   Fri, 7 Oct 2016 00:40:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqeg3tjn7n.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 06.10.2016 o 21:23, Junio C Hamano pisze:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> If you prefer to accept such sloppy work, I will change it of course,
>> feeling dirty that it has my name on it.
> 
> I do want neither leaks nor sloppyness, and I thought that was
> understood by everybody, hence I thought the last round made it
> clear that _entrust() must not exist.

Also, the *_entrust() mechanism in v1 was quite sequencer-specific,
rather than be a generic mechanism.

> 
> Let's try again.
> 
> We manage lifetime of a field in a structure in one of three ways in
> our codebase [*1*].
> 
>  * A field can always point at a borrowed piece of memory that the
>    destruction of the containing structure or re-assignment to the
>    field do not have to free the current value of the field.  This
>    is a minority, simply because it is rare for a field to be always
>    able to borrow from others.  The destruction of the containing
>    structure or re-assignment to the field needs to do nothing
>    special.
> 
>  * A field can own the piece of memory that it points at.  The
>    destruction of the containing structure or re-assignment to the
>    field needs to free the current value of the field [*2*].  A
>    field that can be assigned a value from the configuration (which
>    is typically xstrdup()'ed) is an example of such a field, and if
>    a command line option also can assign to the field, we'd need to
>    xstrdup() it, even though we know we could borrow from argv[],
>    because cleaning-up needs to be able to free(3) it.
> 
>  * A field can sometimes own and sometimes borrow the memory, and it
>    is accompanied by another field to tell which case it is, so that
>    cleaning-up can tell when it needs to be free(3)d.  This is a
>    minority case, and we generally avoid it especially in modern
>    code for small allocation, as it makes the lifetime rule more
>    complex than it is worth.

Great writeup!

> The _entrust() thing may have been an excellent fourth option if it
> were cost-free.  xstrdup() that the second approach necessitates for
> literal strings (like part of argv[]) would become unnecessary and
> we can treat as if all the fields in a structure were all borrowing
> the memory from elsewhere (in fact, _entrust() creates the missing
> owners of pieces of memory that need to be freed later); essentially
> it turns a "mixed ownership" case into the first approach.
> 
> But it is not cost-free.  The mechanism needs to allocate memory to
> become the missing owner and keep track of which pieces of memory
> need to be freed later, and the resulting code does not become any
> easier to follow.  The programmer still needs to know which ones to
> _entrust() just like the programmer in the model #2 needs to make
> sure xstrdup() is done for appropriate pieces of memory--the only
> difference is that an _entrust() programmer needs to mark the pieces
> of memory to be freed, while a #2 programmer needs to xstrdup() the
> pieces of memory that are being "borrowed".
> 
> So let's not add the fourth way to our codebase.  "mixed ownership"
> case should be turned into "field owns the memory", i.e. approach #2.

On the other hand the _entrust() mechanism might be a good solution
if the amount of memory was large, for example order of magnitude more
than what would be needed to keep ownership info *and* borrowing would
not be possible for some reason.

But the _entrust() mechanism reminds me on one hand side of memory
debuggers like dmalloc, Electric Fence (eFence), or valgrind; combined
a bit with garbage collection.  Namely, when we are in a library call,
record all allocations (perhaps by redirecting alloc functions), then
free those resources at the exit of library call.
 
> 
> [Footnotes]
> 
> *1* It is normal for different fields in the same structure follow
>     different lifetime rules.
> 
> *2* Unless leaks are allowed, that is.  I think we have instances
>     where "git cmd --opt=A --opt=B" allocates and stores a new piece
>     of memory that is computed based on A and store it to a field,
>     and then overwrites the field with another allocation of a value
>     based on B without freeing old value, saying "the caller can
>     avoid passing the same thing twice, and such a leak is miniscule
>     anyway".  That is not nice, and we've been reducing them over
>     time.
> 

