Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866701F453
	for <e@80x24.org>; Thu, 25 Oct 2018 01:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeJYJnT (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 05:43:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38869 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeJYJnS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 05:43:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id b14-v6so4565001wmj.3
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 18:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hctdJlrMakBusQjoOKTMz9Xv48riR4LuO+A4ezMv5sU=;
        b=Tn4mz1EGzkJt7bWBnreWTWWJCxny/gheA2z68eb509Z78ZMBJo7Nz7A9uQBfn1H3/f
         jgjANBG/WVWY45wn2fgbJJt7z/qzwn3H4aag/Gu9gtV9TibsJDM+NQrdwXbMujoJ+ROz
         xisQ2IUJhgNz005J83HMH+Bq2UFDXy4cyftk2Ao+I/smbWEIg1bMUnaw96qMTyrUptVO
         70boEN70lGxbBS3iv29Puq4OJWG5i9EKtqIcNzH/6ufKflnET9nF9IiyuKXJZBYUX4Yt
         1tuFcUH0fBB8Icaae6xhi44Hwa0RtSqwzNEf0gqx+XP17Jpkz0jZ5z/4yhBaKSEH3Xt+
         dYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hctdJlrMakBusQjoOKTMz9Xv48riR4LuO+A4ezMv5sU=;
        b=hJEPcT4grJGagJOJh/CEGBpvxU0UgSCxT6++LREIxZJuc4QGakHXAb3+7Z3Pr2lOsG
         GdHSuDI2flJ22qzIlwBy+5tgCbjtFzQBghuIVrlL6g5KsFaupepp2gmVfp4kUHrCPSY6
         apntoeJNBXxxL35gh/318rsx/yopZXFGVvzoiy0julMFOVCLy1sIniMfpkFbuL7F2a/i
         k+pPYcvLK3tz1G8oIcK/jtWTrGF4eX7Dcj15qHqaKewWmXK/moathaJIzl2Hn6eZ2aY1
         7hiXi7QNzFr47pjqrTNVbig8hUDSB13wnM0hgso2dxp4F36k2m/oPeUwZvY+bD3POtew
         vBtg==
X-Gm-Message-State: AGRZ1gIsiNpK4uGL+3ZcRKqmMQTw0FdG1iDS/uYJPhxqa+2CZ8N/WgBp
        bxBEpDLUm7aB6GuN76+R9LOSCe9cc3w=
X-Google-Smtp-Source: AJdET5e5FGIdfJAKyAGLZ6eqjcgvnJ10U8yVmCI33rzrWxx5RaIFvd4YUKRPWFhuoY/IVyQ+ys+tSg==
X-Received: by 2002:a1c:e713:: with SMTP id e19-v6mr4630505wmh.21.1540429971641;
        Wed, 24 Oct 2018 18:12:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r134-v6sm3636333wmg.9.2018.10.24.18.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 18:12:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/3] reset: add new reset.quiet config setting
References: <20181017164021.15204-1-peartben@gmail.com>
        <20181022131828.21348-1-peartben@gmail.com>
        <20181022131828.21348-3-peartben@gmail.com>
        <CACsJy8Dcf8OknyMaSZxOaib54jLSSt71XXjTZD3UjgnH6J7QFA@mail.gmail.com>
        <e1f50b07-b3bf-0805-fcc9-692331dd170a@gmail.com>
        <xmqq8t2oqchi.fsf@gitster-ct.c.googlers.com>
        <CACsJy8Bkx5QS_4QV13FHpbZmhO=0oc3_BsBPQKdtjq6aouALFA@mail.gmail.com>
Date:   Thu, 25 Oct 2018 10:12:49 +0900
In-Reply-To: <CACsJy8Bkx5QS_4QV13FHpbZmhO=0oc3_BsBPQKdtjq6aouALFA@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 24 Oct 2018 16:54:06 +0200")
Message-ID: <xmqqa7n2n81a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> OK. Just to be sure we're on the same page. Am I waiting for all
> config changes to land in 'master', or do I rebase my series on
> 'next'? I usually base on 'master' but the mention of 'next' here
> confuses me a bit.

I was hoping that you can do something like:

  $ git fetch https://github.com/gitster/git \
            --refmap=refs/heads/*:refs/remotes/broken-out/* \
	    bp/reset-quiet master
  $ git checkout broken-out/master^0
  $ git merge broekn-out/bp/reset-quiet
  $ git rebase HEAD np/config-split

once it is clear to everybody that Ben's reset series is ready to be
merged to 'next' (or it actually hits 'next').
