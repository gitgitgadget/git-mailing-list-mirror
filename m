Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80740C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 18:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BAAC20658
	for <git@archiver.kernel.org>; Mon,  4 May 2020 18:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bocoup-com.20150623.gappssmtp.com header.i=@bocoup-com.20150623.gappssmtp.com header.b="KHjCqnW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgEDSbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 14:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729762AbgEDSbo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 14:31:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF22C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 11:31:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id b8so148660pgi.11
        for <git@vger.kernel.org>; Mon, 04 May 2020 11:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bocoup-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQwpIo2T6YSHaab5z8a1q+PSQt7rZPECrVD/V+1EQr8=;
        b=KHjCqnW1QmcuakE3Odb9BQ2V49PgxQY9FJPq6hz9ZbAphzFsjfh0MReJ0c06PwKtSo
         yP3+i1iPb0An9gnJmaaZlx9zfW2bkiAVuhRCtG/HRodGmrZ6oBRV5g/8rAj/HlrDZUwS
         OE7TzrMGYlBDldlpvJ4z2NnVdB2QdV5efmllVGRBU2ZlvyVt0Lvbiqb97OHZhk25g9Mm
         eFEH5KGT9lz/bXYojkvOkuiUM+KtvPKVjkUVR7qmPbQZSkmQr6+gK4JKwc4cId5RyOtV
         V/FtnFPADZK9cxbros5z/DodmGT9siwdzgs8sjQdH8t38VHMpc1UBlBBePJ9J0TmH62m
         0p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQwpIo2T6YSHaab5z8a1q+PSQt7rZPECrVD/V+1EQr8=;
        b=bivdJOF0xgfgF5pRY0bkr3SAOOV8/VhiZRfV76j+1CRXOL9po2220bfSZ+6SH6Lts9
         AhOCa6KiJVntEsQHODf9KAU8uohiauG0JRCOR8MUw8xjw9gC0jwExOVznMzomRwcAsRm
         Bu3r0D5nJb3m9dXdIJ4+6X4tfEpRa8Pu3C/tsl8OzM0+6Zr0EjWMqx/TCOL+2BCVTEVx
         m7aokOYIonFClS5mYBtMpFfVR6GVxxyrvbhpLXARy/vvNE5AKtSESlXgfMAyoG1L8ml4
         y0Q6pg1SGD6bt5zhLe6ldw3r/N6lZUdXPS0g1a79ftMZgMWDK9bQlwVrpZNT6f6JlzGC
         adUg==
X-Gm-Message-State: AGi0PuZ2LlOnIgL6s4GfjuJLkQvuX34bptcb7ijpVRBacdgPOY2xFLO3
        C32G36w6kheoTPqsaCXFIASh8QlSvLMdUcpau1WtDA==
X-Google-Smtp-Source: APiQypLIv64yapHknV/JD2TjgqBNyhm40r72d4FOgof9rM49JpE9PZef11oOPmISNr9O2Coqg8r5MFurXq0L0BZMtlM=
X-Received: by 2002:a63:155f:: with SMTP id 31mr328433pgv.0.1588617103418;
 Mon, 04 May 2020 11:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200504174548.r3zaftqcq52yhd2u@chatter.i7.local>
In-Reply-To: <20200504174548.r3zaftqcq52yhd2u@chatter.i7.local>
From:   Simon Pieters <simon@bocoup.com>
Date:   Mon, 4 May 2020 20:31:32 +0200
Message-ID: <CAOAHyQxuRwGpKtBNy3YiocgdktsJ+FJR9Oj35qENh0P7ZGn2+g@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Simon Pieters <simon@bocoup.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 4, 2020 at 7:45 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Mon, May 04, 2020 at 07:20:33PM +0200, Simon Pieters wrote:
> > "master" is an offensive term, as it can be interpreted as being
> > slavery-origin terminology. See
> > https://en.wikipedia.org/wiki/Master/slave_(technology)#Terminology_concerns
>
> Git doesn't use "master-slave" terminology -- the "master" comes from
> the concept of having a "master" from which copies (branches) are made:
>
> https://simple.wikipedia.org/wiki/Master_recording
>
> The concept predates the music business and goes back to middle ages
> when a guild master would create a "master work" or "master piece" that
> the apprentices could use for study or for imitation.
>
> https://en.wikipedia.org/wiki/Master_craftsman
>
> So, while I wholeheartedly support using inclusive language, I think git
> is in the clear here.

Thanks. This may be so, but it's still the case that it can be (and
has been) interpreted as being slavery-origin terminology.

If you decide to not change this, then I think it may still be good to
add something like the above to the git documentation (like in [1] and
[2]), so that projects using git are less inclined to change it for
their projects, and maybe the people who are offended by it would be
more comfortable if they know that the project maintainers are aware
of this issue and could explain why this usage of the word is ok.

[1] https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-aiddefmasteramaster
[2] https://git-scm.com/docs/git-init
-- 
Simon Pieters
Bocoup https://bocoup.com/
