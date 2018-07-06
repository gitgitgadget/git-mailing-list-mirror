Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6178B1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 20:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754060AbeGFULC (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 16:11:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54895 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754036AbeGFULB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 16:11:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id i139-v6so15804008wmf.4
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 13:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=i0g8FdVmcJd2TIuThZo65X1FJVLgBOrg6CDDMkY2NE4=;
        b=HRra+g1Mtffq550yqS2UvyEERmYHZfhtBcPfnZvLsgv+UhCRwXev2lOW7CtyY03Nsw
         OFYBw5HSUhwpFfr62gaxWUs02cqB48IhpI296U10i/VQ7STeIOGBcVXKh3S4jYQH56sV
         Xj6HxpfQ6HEqg8nJddTVVMxr9tbRW1k5kTURUPL0P8svjJewXNkphCJWKdrfGmSlZ8eo
         Lwhrjc1tIxCjDXc0SQF/hXCjDZEOrZSC5/+X+0+S+nqZCVJCnxJZvkU2K+7DnByKqS9q
         spE5MXKR07m/kkGfRX43VRushiAvT8WoArynWVzOe0+vLiU8SF580yrMEp+GgQ0DFold
         g2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=i0g8FdVmcJd2TIuThZo65X1FJVLgBOrg6CDDMkY2NE4=;
        b=NC/HqKqbvgcmoaYL6izaLJSki7ASJuc+zUoM19lm3r5HMnR3JPw80s3hi3ZfU14GYt
         2/0hm39LTDozdwD6I74Rzh/qfQ0NzKPV7tgHBZnPDjndzKcEebZdpLNvrdK2YV4xNXCs
         hCKyh5NmUeKtFsx4aELXQLkKXXixsHinKJU8dpk58cjRjhQ4S+yErLb15SNxAZ0Ov/DU
         o1JJo9PDqhJyLfLD+lMB+GLZ9BlkV+8Ns1cUb4FID2TpkeBNDFrDzmR8+tPir1V0h+zD
         kSgRq4CdOCENtxgd92xlYeON08hwuXuHa/W8ju88+pRhqOas3BFzqS2155PfzfmLJGak
         pjmA==
X-Gm-Message-State: APt69E3khaYPX/798BrAk/ZFPklxzRAZzt9Xwqh+9I+NRTYsj5kjx6bv
        yELHYdj5S/nsyq/rFNSj5AURpY8z
X-Google-Smtp-Source: AAOMgpeN/iQlE+6UalVsqIO/g3YMGVgJHA3Bm8nSF0upHLsFHHJiQqz+kUq5lywF4q4soZn6TATKCQ==
X-Received: by 2002:a1c:b756:: with SMTP id h83-v6mr7924343wmf.8.1530907860479;
        Fri, 06 Jul 2018 13:11:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i6-v6sm8002251wrr.2.2018.07.06.13.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 13:10:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 0/2] Avoiding errors when partial cloning a tagged blob
References: <cover.1530905323.git.jonathantanmy@google.com>
        <20180706193847.160161-1-jonathantanmy@google.com>
Date:   Fri, 06 Jul 2018 13:10:59 -0700
In-Reply-To: <20180706193847.160161-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 6 Jul 2018 12:38:47 -0700")
Message-ID: <xmqqk1q8jfak.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> When cloning a repository with a tagged blob (like the Git repository)
>> with --filter=blob:none, the following message appears:
>> 
>>         error: missing object referenced by 'refs/tags/junio-gpg-pub'
>> 
>> and the resulting repository also fails fsck.

Hmph, the approach taken by these two patches smells bad.

When a blob is deliberately omitted with --fitler=blob:none, the
fsck that encounters an entry in a tree object that is about that
expected-to-be-and-actually-is-missing blob does *not* complain and
that is by design, right?  Naïvely, I may expect fsck to follow the
same principle--when it encounters a reference to an object that is
deliberately missing, refrain from complaining, regardless of the
place the offending reference was found, be it inside a tree object
or a ref.

Perhaps that line of consistent behaviour may be impossible due to
the way the reference is stored inside a tree object and a ref?
E.g. a reference to an expected-to-be-missing blob still lets us
know that the missing object is expected to be a blob, but a ref
only stores the object name and not its type, so we can tell it is
missing, but we cannot say it is OK to be missing because we expect
it to be a blob, or something?
