Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,RCVD_IN_RP_RNBL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589821F453
	for <e@80x24.org>; Tue, 19 Feb 2019 22:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfBSWg6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 17:36:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45049 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfBSWg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 17:36:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id w2so9135730wrt.11
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 14:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uLH0zp1OqiJa2Xc74I+ahx52c/mQLX8f4eQN5+HyzZY=;
        b=V85N54i63YUzdOLLd4OW5xqsl8C1jwJnd2LJlUHORV0TuoaQHpdYasRHCOLRHWSaRU
         jfeRkRjW40G1/Z2MYjDyg4FhRvmM87I1+9BMErTqwwkl+2/uxfrWmehN8CnTkOceIauH
         ++4gMg4dUuy/gUGVCRpIGGsK6owIR7F4bzGLIxeJrruHC82gpRIB3KNgSUt3/cyIM0k8
         +wj7H3jqwHIWoJcmkE0SZ+eY0O9XaPqLIq3riEeUNcvNgywOUcWZm7pVSFOgD3W0Tb0q
         JHNuvryYwTa/oN7gPFT3aBLqmTITH6t3o3KObu2v8TJp81zUAGlT7CiRXR8bP/1IALm1
         hX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uLH0zp1OqiJa2Xc74I+ahx52c/mQLX8f4eQN5+HyzZY=;
        b=J8AZ5XdrWhgVap4EgjHhfGM7PdAjHGR/AEiPsoors2ysYk7uJcj/rc32CeuuxlXcO8
         6if2Gn7mJkwpCiyfiUDZwbDy4nNY76zCmS9q+lHWwguOAt3Gan6XafddYLd+7ES6Uc2O
         1glSCkWRR+o0v0RUwRxZV/eB15rvaqPkgBAeiYHT4CjznrHSYIH4MPJVQh4Qxc9L4CRL
         9WFd/N/gOmg0sLvlNYYa7UCbkdzQbhfHitPrHCUwldq6N95mQPh73UiJsYh3qcWTan/B
         2gibHt+6FH4saifzfG8BHn6G5cOcZyN+1ipywNjgR4X76r8sl2Uikv7i7DaF5riDG2E4
         Kw7Q==
X-Gm-Message-State: AHQUAuZAkMHm82oQ5hmutbMRQt8VKAcF/jkLxCd1wbjDiaTfCEk3SyhX
        bVJ2Vq/sR8jKrxlgfzt2SgRgTCGo
X-Google-Smtp-Source: AHgI3IZCUMOJTG5uiK4fvDxO2YvJyFVUtG/KqNXSJKeDBSqnOZFweEgxVHrM/FR1Yi5I49Bnd7QY2g==
X-Received: by 2002:a5d:6b8f:: with SMTP id n15mr22711000wrx.110.1550615815309;
        Tue, 19 Feb 2019 14:36:55 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d24sm55231470wrb.47.2019.02.19.14.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 14:36:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] checkout: add --cached option
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-7-t.gummerer@gmail.com>
        <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
        <xmqqva40lps2.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
        <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
        <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
        <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
        <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
        <CABPp-BGkJOgKqE_vHsA1fkjQ80U10Hv7-HCvScq7WOgj1UF9=Q@mail.gmail.com>
        <xmqqsgwj1ts9.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGp53DrP6=FpYpxy5cmWkcygCz_nrunXisC55KV1ydyXg@mail.gmail.com>
Date:   Tue, 19 Feb 2019 14:36:54 -0800
In-Reply-To: <CABPp-BGp53DrP6=FpYpxy5cmWkcygCz_nrunXisC55KV1ydyXg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 19 Feb 2019 14:24:28 -0800")
Message-ID: <xmqqsgwjz9q1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> As long as worktree-only mode does not lose track of a
>> previously-untracked path in the index (perhaps use the i-t-a bit),
>> I do not have a strong objection against making the worktree-only
>> mode the default.
>
> Could you unpack that for me a bit?

Suppose in an ancient version v1.0 there was a file called
README.txt but these days such a file does not exist (there may be
README.md added though).  By default, the command does not stuff the
contents to the index out of the tree and instead operate only on
the working tree.

  $ git restore-path --source v1.0 README.txt

At this point, you are assuming that README.txt will become
untracked and the user needs to manually add it.  I was asking if it
makes sense to at least make the index "aware of" it with I-T-A bit,
and I am leaning towards answering "yes" to that question.


