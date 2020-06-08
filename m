Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93FCC433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 14:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3E72072F
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 14:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBJMlswo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgFHOHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgFHOHn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 10:07:43 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1021CC08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 07:07:43 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m21so13520108eds.13
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NwEU2Zvwy1Zl8OP4wiHajMvj8bDl6BCVlv3Nexj5fDw=;
        b=VBJMlswogZM4FrDXLog7ALD6OoA63kKxurLngQ0f+J4+EC3B/ooXWtu55dLF1kACUP
         LaVW769CtEuwuL2RqxuoY2SRggTkhk9FnVVXyzcT/M9XFj5EABsk0RTD6mA3g1bscE1O
         cRMxLPA7sBp8pROL797uNJo0jFctRLG8BUCrJ8xTM0EKXQOnF5+/ZtXhzIjXZfQkB1VQ
         KlYP+Gze1ATwNg28XQvbnL9JrLrNhjplLAZCqhLInuqCka50f3es9+dxKlqL1orZQgYz
         gp7zDBzMu2CTw3AfUPXqizJ6rEXOCiZn9aAp3ygAYzCHCh5aQgElVfIxPBkUjkC1ILB6
         ulbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NwEU2Zvwy1Zl8OP4wiHajMvj8bDl6BCVlv3Nexj5fDw=;
        b=WL7dKjYTWsijbZY2RVTuXeWotL2ISaNAuhOeDmUA7+WjboBPbuJ3WMmQggI71QXkar
         aR98lmE+kUqTEzAZcnhmsjezFJmmHB6xz6XRmUP8Ez4lbqx8s728astIuCAZaPX6S9mo
         DhOCCGTx+qQr9CM2E1nOaYzsfc7SZwogW9QQVEn+j+rD8+3VgTaTEu1ER68stphuJVja
         DjDFR1I6iVO4syCO3mTLdM0WHxkvxQ+SCinOF4ZbJWV6gV/uI4n1jlZuR4em2OiRhUzZ
         H1fIxDqYqVRR/juvf/ZtSAONegYK+qOcAHuBedEpGXwKCKAwCESdrTe8ykMcqoBje4bK
         QBOA==
X-Gm-Message-State: AOAM532zxIc5Lx3BEu+wsAkt+obZ84MksRRuri1RTSLsCMcJw7r2Pfbb
        6u7YP23/QXka9NdTqenlqQ6eAhGP
X-Google-Smtp-Source: ABdhPJwoC4KV2A4xcKzlm1yMpdm4QQ5vHWEc6VvLld3HV3QL16SUopIu6o8mc0bnCU0bvnjqVMiiNw==
X-Received: by 2002:aa7:cd4b:: with SMTP id v11mr22918704edw.356.1591625261376;
        Mon, 08 Jun 2020 07:07:41 -0700 (PDT)
Received: from ?IPv6:2a00:6020:22ff:ae00:d228:1423:c030:9e9? ([2a00:6020:22ff:ae00:d228:1423:c030:9e9])
        by smtp.gmail.com with ESMTPSA id l8sm10889525ejc.85.2020.06.08.07.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 07:07:40 -0700 (PDT)
Subject: Re: Bug: git worktree remove and overwritten directory
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <89526b3a-297d-591d-6e12-48580d697ed5@gmail.com>
 <CAPig+cTU8+N6Chimpoa2_T-TcXxw-3B9-9pjCLz7WeOh472P_A@mail.gmail.com>
 <dd7c3a11-6537-74ec-053c-0c9c946c5f19@gmail.com>
 <CAPig+cTpcgunPNKrzfqKYRb3gVhYff7UiBza-xaTH9GqH_Y+gA@mail.gmail.com>
From:   =?UTF-8?Q?Jonathan_M=c3=bcller?= <jonathanmueller.dev@gmail.com>
Message-ID: <bfc471e6-c82e-ba22-79d1-349e071c6b17@gmail.com>
Date:   Mon, 8 Jun 2020 16:07:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTpcgunPNKrzfqKYRb3gVhYff7UiBza-xaTH9GqH_Y+gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08.06.20 08:42, Eric Sunshine wrote:
> On Wed, May 20, 2020 at 10:28 AM Jonathan Müller
> <jonathanmueller.dev@gmail.com> wrote:
>> On 20.05.20 16:22, Eric Sunshine wrote:
>>> Git tries hard to prevent the same directory from being registered to
>>> multiple worktrees, however, there is not much it can do to prevent a
>>> person from shooting himself in the foot by making changes like this
>>> outside of Git's control. Thus, this seems like a case of "if it
>>> hurts, don't do it".
>>
>> I agree and didn't expect git to "work".
> 
> I just posted a patch series[1] which enhances "git worktree prune" to
> detect and deal with multiple worktree entries referencing the same
> path.

Excellent, thank you!

> 
>>> However, "git worktree" could possibly do a better job of helping you
>>> recover from such a situation. In particular, I think it should be
>>> reasonably easy to enhance "git worktree prune" to detect this
>>> situation and automatically prune the non-main now-bogus worktree
>>> entry.
>>
>> At the very least, the somewhat confusing error message could be
>> replaced by a "you messed up the worktrees, please delete the
>> corresponding entry in .git/worktree" or something like that. But
>> enhancing `git worktree prune` would be better. It was, in fact, the
>> first command I ran to try and fix the problem.
>>
>> As said above, I think git worktree remove could issue a better error if
>> it detects multiple worktrees with an identical path.
> 
> Hmm, the message it printed complaining that you tried removing the
> main worktree seems pretty accurate since that extra worktree entry
> was indeed pointing at the main worktree. I suppose it would be
> possible to have "git worktree remove" also perform "corruption
> detection" so as to present additional information which might clarify
> the complaint. Of course, if that is done, then it would make sense to
> make all "git worktree" commands likewise report corruption. However,
> I haven't convinced myself that we need to go that far. Anyhow, the
> posted patch series[1] addresses the immediate problem.
> 
> [1]: https://lore.kernel.org/git/20200608062356.40264-1-sunshine@sunshineco.com/T/
> 

You're probably right. Fixing git worktree prune to handle the situation 
is sufficient for me, as that was what I tried.

Thanks a lot,
Jonathan
