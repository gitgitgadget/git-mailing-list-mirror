Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 226B020248
	for <e@80x24.org>; Thu, 18 Apr 2019 00:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfDRAiL (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 20:38:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43224 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfDRAiK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 20:38:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so605887wrx.10
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 17:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jZBuUYKzsz3YIB7wRqInocryx3NyxkzkxL2qJDR5hAI=;
        b=MT+Ee0C747sXedS9nUrMrMEaR7DQxv6HHHipdY1FbH71ZDdpF3SS/hKATV2gGcD9pw
         PUjfodJwW3oRFWoa+wlmeYm2E3BP4UsP9ZxyOE2WjdzvEuXIuoG7Yynm0vD+n4S9+tj8
         8+I5X7UlRRwua5eRbwfVtg51v9ERVQiy+AGWG0JMhz7jG+AdmH4VNrmJltXGBl/t8Nfx
         Vd/4l7+N+lg9PZwjR8KOzownFU7UNObbZbB4IH708qKKdQpB+QAlSaMTKH6ba1aF9vUt
         qIioCMojFxaj9WVTxEjXUs+aeBHnTx23mF37FhdafNR2hLOSWMCAtI0KFy1KVDLl0f29
         ljuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=jZBuUYKzsz3YIB7wRqInocryx3NyxkzkxL2qJDR5hAI=;
        b=F3Zgr4FtHUwfUSxQIz/rv0K48RM/msm4e+PRbt+dwT07YB6afRZSwa/2a+gLFoqWig
         O21Bbc+fIbaBK48lGnoCsVXnAAILY0FwleBgA2SR/YfeqFxkxigrDskOwBrMs5dtFV9s
         V6wwGL5a2n2sMgO0MCoGXgZGcU7TeDCZJX0kXmzL89dAPMeCJ8n3WILAZDhr2/BD/sE0
         c/kNEzsLKjqDwlrVrLEa9FXmtMCBzS5+USjXPGuXCL3bciUHYYJMbJ/D7WOr4wm15QyW
         yIydw21xQ0nal+JK0tOAhkyuO+MAuKUpcrd07qrH4UhmPUBooY4Bum0LgeEy3c/SCfLk
         PRSQ==
X-Gm-Message-State: APjAAAWNiwRRuZF6JnGtWevamQHwlES2BJ6FHWWtHK44/PaIgmGnMCv+
        BXL7mrF3DhmGQnrl55OAzNs=
X-Google-Smtp-Source: APXvYqzo9Yg/NJxVRiWNPK86WVCjTZ9ph8EAvRZvwJbZX3iKtStBUKbch7mDwAW1/djy3qI4huuIWg==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr12423873wrm.277.1555547888686;
        Wed, 17 Apr 2019 17:38:08 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w11sm448685wre.15.2019.04.17.17.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 17:38:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 00/16] Add new command 'restore'
References: <20190308101655.9767-1-pclouds@gmail.com>
        <20190411131218.19195-1-pclouds@gmail.com>
        <CACsJy8A9xfR7FheOHUoywNz_D7W1X1fv=mUBz-uu82CGZqYfVA@mail.gmail.com>
Date:   Thu, 18 Apr 2019 09:38:07 +0900
In-Reply-To: <CACsJy8A9xfR7FheOHUoywNz_D7W1X1fv=mUBz-uu82CGZqYfVA@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 17 Apr 2019 17:04:26 +0700")
Message-ID: <xmqqa7gojggg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Apr 11, 2019 at 8:12 PM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>>
>> This is the companion of "git switch" and is based on that topic.
>> This command peforms the "checkout paths" from git-checkout, git-reset
>> and also has a third mode to reset only worktree, leaving the index
>> alone.
>
> It does not have to be done now. But I'm just wondering, does anyone
> think adding --dry-run is a good idea? This command is destructive by
> default, so careful people might want it, I dunno.

Yeah, "give --dry-run for anything potentially destructive" may be a
good general principle, although we'd need to know where to stop.
For example, I am not sure if "git reset --hard -n" would make all
that much sense, as the sole point of running "reset --hard" is "I
made an unrecoverable mess---get me back to a clean and known state
no matter what" and in that context, "let me see which files in the
working tree will be removed and checked out of the tree-ish and
which paths in the index records a different blob than what is in
the tree-ish, before deciding if I still want to stay in the
unrecoverable mess or I want to get out of it" is something you
could request, but at the same time, there is not much point in
actually asking it.  Of course, a --dry-run that is not used often
simply because it is not all that useful in practice is fine to have
as long as it works correctly---I am saying that it's not something
I'd personally prioritize myself.

It would be an excellent addition to "restore-path" (and also to
"checkout [<tree-ish> [--]] pathspec") to give "--dry-run".  Not
just because it is destructive, but because unlike "reset --hard",
it is selectively destructive.  Having a way to make sure that the
given pathspec touches only the paths that the user intends to
recover from the tree-ish or the index would be valuable.

But it is a new feature, and I'd think it can (and probably should)
be done as a follow-on series outside the main series you have been
working on.  Let's make sure that we have the basics ready by the
end of this cycle.

Thanks.



