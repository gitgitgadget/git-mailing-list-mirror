Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79D4C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC09C6101A
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 17:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhJHRcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 13:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhJHRcW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 13:32:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B6EC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 10:30:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v203-20020a25c5d4000000b005bb21580411so748693ybe.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=N+y3TG6XbGgssrOffBhTNkAy/jsuWM98E141RPoSc4Q=;
        b=mCgmPrPbphXMk2SaVfI7n3qe08b9P8NJIRPbWRjGRVqqbgdaXFdFggbC5F1FaxTRuy
         2R0EjOE3c0rfx1SFHo8bTnoA/kOAiRX29S3erosCOJCR4tktI+gNibgrDpDHCw5OIPQQ
         Q7NKTFStSJOmz5MBuChp8X25g8LwzW6OSxkcQqF5sq09+X4EVbYg5+5l0433WeMe/2zu
         X3CaI/FSKm7UO5gcgfBxMMBKYRAwJFdmlEEmURNGNZfRV05CuDiwFY8FEpuF81u6xtCn
         EhXHOik05smdd7iBpE3wHWSI8iNQvHsTGoUEqmnAXDIC/qTHS4GUo9VU/bpc1iCXpdbh
         IPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=N+y3TG6XbGgssrOffBhTNkAy/jsuWM98E141RPoSc4Q=;
        b=oOshBbvKHmQ0PYLYtN0OO+YN7HiqyH5K0daq5fsRAZK8iiyFwb3lybUY8FJGc5yURX
         AIE1+q5eo/u5DoNU99vn/lyGr1RAHEmW4gcsAnViaHXhHn5VmdqWsX2YRVPAfYZXg8Gs
         igXASn11mmRVPn2GV8lFA0LgLY0yeilECiwqTUY3KOR7RCK3Ev89oiOGGfMRGipKEszs
         KQSKiX9KVisDPzQPVvVfbfnkOJ8EBsEidd0ttGjW4fo2AqCVdzg4yYnrC5SsIw+Hms/S
         I9+BzjoHdGLPTQ6QgWLYQ2iEdnKIT7kO/dAhg67RYUVnzgIPwC3PuJMS7QL6LFj0XoIS
         BoKg==
X-Gm-Message-State: AOAM531f02aGhEbebf9xX2aoAZolVlCp0rSL0XA3mgqouhwWjsSFcE0v
        XLtPXrieiM5kMgDahiBNZGn9R5PpZh3OJg==
X-Google-Smtp-Source: ABdhPJxhoZtsOBpiQlRAWuMxWqVqTxAtvaHc4Vcf94cqvjDe7CeZmeRMy1fLiz9qEdJpjX+vz11OOllNPOzKww==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6902:120a:: with SMTP id
 s10mr4117953ybu.453.1633714225759; Fri, 08 Oct 2021 10:30:25 -0700 (PDT)
Date:   Fri, 08 Oct 2021 10:30:26 -0700
In-Reply-To: <xmqq4k9so15i.fsf@gitster.g>
Message-Id: <kl6lo87zxw3x.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Subject: Re: [PATCH 2/2] remote: add remote_state to struct repository
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> -static void add_pushurl_alias(struct remote *remote, const char *url)
>> +static void add_pushurl_alias(struct remote_state *remote_state,
>> +			      struct remote *remote, const char *url)
>>  {
>
> I am not sure if this is a good interface.  It allows a caller to
> obtain "struct remote *" instance from somewhere, and feed it with
> an instance of "struct remote_state *" that has nothing to do with
> the "struct remote *", no?

Valid point, this interface should not be so easy to misuse.

> Instead, shouldn't "struct remote *" _know_ which remote-state it
> came from?

I am less certain about this. The pattern of
container->contained->container is convenient for callers, but requires
very deliberate maintenance and the reduced separation might promote
thoughtless use of the interfaces e.g. "Should I use struct remote_state
+ name or struct remote? Eh doesn't matter, they're equivalent."

Instead, we could converge on a pattern of:

* struct remote_state + name when the caller does something in the
  context of the remote's repository.
* struct remote when the caller doesn't need the remote's repository

I think we might do this in slightly different ways for branches vs
remotes.

> I didn't look, but I suspect that there may be similar problems with
> other structures like "branch" in this change.

Looking into it, it appears that only static functions pass struct
remote_state and struct remote at the same time. That gives us a lot of
leeway to clean things up inside of remote.c.

The same cannot be said for struct branch, that will be much harder to
clean up. In fact, rereading patch 2, I missed many implicit references
to the_repository in the branch functions, so the pattern of struct
remote_state + struct branch would actually more pervasive than it seems.

However, I suspect that we don't need to pass around struct branch very
often. We may be able to maintain referential integrity by passing the
branch name instead.
