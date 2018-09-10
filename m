Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE6331F404
	for <e@80x24.org>; Mon, 10 Sep 2018 19:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeIKATZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 20:19:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38982 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeIKATZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 20:19:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so22671880wmq.4
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sX4HyjECQAnfpDjx3wbyKKGnuSFr3zE1XO45QcejshQ=;
        b=tct0fikE3c7srbsahf2FZkBjR3b9bWFSlsMo6WWZmaBuveo0bejFo3Zak3cWgNdRYq
         T6dBSDVL3GUQ9BORhrJYcrC9EndaNaC3hQlBXmUQdCIHIO/oPdZWIeqxoO5KpDIFBz0O
         goKzdKNRBx3/UVP1AX2yYB9She+jiNKXT6t/FUj3UokjGa4kv5ltaWjUVG7e7Ebu1tYs
         X+XQvV+ibCSdWVdsJwn3mbQY41VdOG20Smoc06OUkErtbVmI9GkXbxTj+Jip2jF/NAuM
         2kavNjK+ABxXcC/Ag1t09YCWR8HgxLEX0B2t/kM1MZK4IKU17uT2S9a1isESHZ5r7JJ0
         Fs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=sX4HyjECQAnfpDjx3wbyKKGnuSFr3zE1XO45QcejshQ=;
        b=ItckaSqPYS2AS4fo/P4rSmdJcU7EZ6Fl7Swlr88HrR/erLyFdP7Jn3VJZpTl5ioEfG
         7FVb4EvPVwHkREBmq7QCritOU0Gxa0dtviD2ujC0hLplyJX0sKXJ8lqmzIeWJBbK0dY7
         NyWFkIIIbb6OO8E/ok9soTAG6q7aqpZvAcV8vhn5vZow1dsA8tHXcMrNdoSztKwDHjDn
         9VPEVieuReR9NJeR5bg1BdR13P6gk/jsrIHvIdlf9Xpthvxu4H8uNbvi5sBJ3HEYKMM4
         +zONA1fHCcmaLUaeRYRV/xTOKFeo7I20vUEJwC0GJmhkLs73avNy2VMYe9Sh01QrOj2p
         jPjQ==
X-Gm-Message-State: APzg51Aah/T5x4wwiHrOunRkikXCF/VsxpOJFlrGotJIvTIWjcxW52M6
        gW8ZhmNjbEY5CyZeqxwcaew=
X-Google-Smtp-Source: ANB0VdaHseDOTbYxaMskvfxzhpL3lVFOc5qPSGZqUObKx1gH69gvklgXxagbbVbljtoGPM/HBa4adg==
X-Received: by 2002:a1c:3bd4:: with SMTP id i203-v6mr1605453wma.73.1536607428653;
        Mon, 10 Sep 2018 12:23:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q5-v6sm20511971wmd.29.2018.09.10.12.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 12:23:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/4] un-breaking pack-objects with bitmaps
References: <20180821184140.GA24165@sigill.intra.peff.net>
        <20180821190701.GE30764@sigill.intra.peff.net>
        <8736uud0gq.fsf@evledraar.gmail.com>
        <20180831225558.GA22917@sigill.intra.peff.net>
        <20180901074145.GA24023@sigill.intra.peff.net>
        <87d0toqyj6.fsf@evledraar.gmail.com>
        <xmqq1sa1uwd7.fsf@gitster-ct.c.googlers.com>
        <20180910184817.GB20678@sigill.intra.peff.net>
Date:   Mon, 10 Sep 2018 12:23:47 -0700
In-Reply-To: <20180910184817.GB20678@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 10 Sep 2018 14:48:17 -0400")
Message-ID: <xmqqwortrwak.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Either is fine.  I am not moving 'next' beyond what is necessary for
>> this release cycle during the pre-release freeze period, and because
>> I thought that Peff was in favor of squashing in the changes to the
>> original when the next cycle starts, I haven't bothered to merge the
>> fix there yet.
>
> I think Ævar's point is just that the current tip of next is badly
> broken if you use bitmaps, and it's worth hot-fixing that in the
> meantime.

I know that ;-)

My point is that anybody who *needs* handholding from the upstream
project (i.e. not Ævar, but those whom he is trying to help with the
suggestion) should not be looking at 'next' during the prerelease
freeze.  They should be looking at 'master' instead, and that is why
I am not spending more than minimum cycles of my own worrying about
'next' during the prerelease.

In any case, I think the final is ready to go, almost.  I still need
to do the preformatted docs, though.

