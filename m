Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCF2E1F51C
	for <e@80x24.org>; Mon, 21 May 2018 04:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750781AbeEUENB (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 00:13:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50615 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbeEUENA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 00:13:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id t11-v6so23035392wmt.0
        for <git@vger.kernel.org>; Sun, 20 May 2018 21:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RSjFBeszv72y4rEKH1Iunnojg2N9FmEeCOtZY0rlhEg=;
        b=RreK4k69KDPDEegSuIRECUAUNtWjuJ4INj2ibnCHCIGS1p9ordmRg2La66G3GJyZ0Y
         b1siHDyeZ6+B+aQiGKv6WM3CpRJpN3RuEV1KHqyRdQrlWN1joZ7fagvnHCHAZOjUNRXh
         77JavZw26Er2ndWr3wI8TN1cP/dh9M8SKJ2EjVtKpUUvPaFXue5T1oiANzoMv033xlmO
         IRjkJxCBjaDo4FnyVt41mVAoeOlVjNPxu/cQJGE6Jez78BJe6nWKc0iO4PSNrbPN4Rj1
         bSS8cotuvxzmYBCU+u6c5WhmehDzN/fql17/hRvBNEVBfppTV49QutHNnM4q7vvOQFMt
         Hr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RSjFBeszv72y4rEKH1Iunnojg2N9FmEeCOtZY0rlhEg=;
        b=HwZ06SI3ZlF6aT7Iv3q8Hg/GEqnZ2of+mbyzyUM8KH3PXWcjK2IN22jlHwJZ33/H30
         buynRtFO1fo7vZekhiOUCnY92LqEp9s7lT/t+YpP2hlJX6rVCK92fPta1HgfizjRkHh4
         3j+1JXkCXo4XSko0K+kqTnZbUe+DRVGUXf53sWBYwVzACfyEOGTWOqmiCL6dA0YJ1o0T
         GzOiXm+I4WNWzW3LVM4MWYP2M5NxR8v7t4zfGA4y4UyrREqA4kY7xCrVGwQWC3O/DoUw
         IPWBAhAAO+HSlrzuzdLmJF9N9YoL/x3dfG9I2WYDxrN252bSWQ4MmWCjD9K5gzoTABc/
         MVqA==
X-Gm-Message-State: ALKqPwfdhEWGCKKgjlNIUEyr6mmyvkKQIwQbR4EruCeL0J4KKtMyrUCq
        aicW1G00TuJblgiHheG652A=
X-Google-Smtp-Source: AB8JxZqXb+fp+RttTMW37mhBvI6qfn9GAQqArJxIYmQAbQduIb0T54XTUY3we7OkMIpdYL86PzkD8w==
X-Received: by 2002:a1c:2d06:: with SMTP id t6-v6mr8744361wmt.155.1526875978896;
        Sun, 20 May 2018 21:12:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w40-v6sm23157224wrc.69.2018.05.20.21.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 21:12:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Leif Middelschulte <leif.middelschulte@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] Inform about fast-forwarding of submodules during merge
References: <20180517184008.25445-1-sbeller@google.com>
        <20180518194802.28355-1-leif.middelschulte@gmail.com>
        <20180518194802.28355-2-leif.middelschulte@gmail.com>
        <CABPp-BGGe3r_QiC5264xkj0cp2Vu6WoLQZeDGEJi4eOpUW9z3g@mail.gmail.com>
Date:   Mon, 21 May 2018 13:12:56 +0900
In-Reply-To: <CABPp-BGGe3r_QiC5264xkj0cp2Vu6WoLQZeDGEJi4eOpUW9z3g@mail.gmail.com>
        (Elijah Newren's message of "Fri, 18 May 2018 14:25:26 -0700")
Message-ID: <xmqqzi0t1waf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Thanks for continuing to push on this.  This looks good so far (to
> me), but I was also hoping to see the analogy between these messages
> and "Auto-merging $FILE" for regular files mentioned.  Both Junio[1]
> and I[2] pointed out this similarity, and I think this
> similarity/analogy is useful additional motivation for making this
> change.

... meaning that it should be discussed and named as the primary
reason why this change is a good idea?

Re-reading what Leif wrote in the first paragraph, I tend to think
that "the more recent version may break us" Leif gives is not a
particularly convincing one.  After all, if we did not change the
commit bound at a submodule since we forked, while they changed it
to something else (either old or new), even though our changes may
have been fully tested with the version of the submodule we have
been testing with, it may break with the version the merged branch
has been using.  Such an update is cleanly and silently resolved at
the tree-level three-way merge, but the risk of breakage is no
different to the case this patch adds new notices to.

More importantly, the same "the changes we made may get broken by
changes in areas that are textually unrelated they made" will happen
without submodules.  Content-level three-way merges that resolves
cleanly at the textual level may need to get semantic adjustment.
Do we treat clean 3-way content merges as suspicious and give a
similar warning?  That smells like madness.

But as you said, we give "Auto-merging $FILE" notice to clean 3-way
merge at the content-level for normal files, and there is no good
reason why we should not do the same for submodules when one
fast-forwards to the other, which is an analogue to the
content-level 3-way merge where one branch's version is a superset
of the other ones.  And that is quite a convincing reason why a new
"Auto-merging $SUBMODULE" notice is a good idea.

> ...
> Also, by analogy to the "Auto-merging $FILE" comparison, the "to %s"
> on these two lines feels out of place.  Users can just look at the
> submodule to see what it was updated to.  In a sea of output from
> merging, this extra detail feels like noise for the standard use-case,
> unless I'm misunderstanding how submodules are special.

Now you meantion it, that part of the message does look more like a
debugging aid than a feature that helps actual end-users.  After
all, if our side did not change the commit recorded for the
submodule while their side changed, we do not report the result of
such a tree-level three-way merge that takes what commit they had at
their tip.
