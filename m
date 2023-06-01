Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFAEC7EE33
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 10:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjFAKKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 06:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjFAKJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 06:09:37 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0726F270A
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 03:07:40 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-53f7bef98b7so579769a12.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 03:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685614060; x=1688206060;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLFs9ULmn444fKWKh0W5biZwdYuZM7URT/9+r0dY6og=;
        b=Re7OpFa3wuh+9Rjv7drGBWXIc8CqJTYjS4C13RBNBTvT6olxMmNNXjzxpy5KOPCHgZ
         OaviHb/ijs5v0c59ZAbe1PQt9JPMNjQBY03LtAH4yUmNBXZbQCrSqVxRzqhcUUrOUqXD
         zyPwIIuSPfwqW455DJzwLxWtX+/H2Ubt3JXsDaJNJw+4Ef9khR73pIpNN/igLdqEMwC7
         4fxMcNM9eE9ZdpaMOIjN4FvpRwh2jTAqVLnKcrJ4u0tegSFaO1KZ8/fZL2Z6TAKCyxZX
         5PuN6X93q1A2Y4CqsYaBWcjzuk2dpMCp8YKhBA++QNqnbpT2ISHk5VaOq+2sh2ffYMAn
         7pnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614060; x=1688206060;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YLFs9ULmn444fKWKh0W5biZwdYuZM7URT/9+r0dY6og=;
        b=fQ1FsQywWaNxKhLj4eitfatp6UTOP0f4YV4ViiomaSJHPeMRFEcuQ3HNgb63e+saB/
         ChxkB5mLiMDf6yaN0PCqKmUkkMSZZSs2BLDUscr6QIEqYRW1F3VfRWHZ/aeRQ5KDX5hd
         pYz315+aOe/dyc2VnNVwXerj85ZtEzBRq2zfu3d022f4GZ07UcpnymibIjq23Ox9p3xn
         EpGrKK4de0Or1yxXvnTNHT8lfxJhGN5uGhaub0u3DUvuPTaktvIiWAMfOnCa9Oral/uR
         OvKtuoWe8/96RUgRL/wBDwFwQeeUF0r9JNBm6+4H/gO3td8Pl9lY7m751LX3KW5bdmbX
         E9Gg==
X-Gm-Message-State: AC+VfDzbIDhYrF3cyDEtSO8I4FgS9Fa1kS3VgyuV+ikqFopVPXHF4RGG
        +O5R8pGZ35tH1/Ag2sTcwH0RDhSSM51EsA==
X-Google-Smtp-Source: ACHHUZ73vwwxOxKA42C4tE/v3PKRGXY+bVUqhCe7tKrYLW5t/6Wm3FntDqSh8GK9ZFGEahVN6NYwlg==
X-Received: by 2002:a17:903:550:b0:1a6:84be:a08f with SMTP id jo16-20020a170903055000b001a684bea08fmr6616464plb.64.1685614059708;
        Thu, 01 Jun 2023 03:07:39 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001a80ad9c599sm2988513plo.294.2023.06.01.03.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 03:07:39 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: git gc complains about "unable to read $oid" but git fsck finds
 no problems
References: <mvmfs7ba4el.fsf@suse.de>
Date:   Thu, 01 Jun 2023 19:07:39 +0900
In-Reply-To: <mvmfs7ba4el.fsf@suse.de> (Andreas Schwab's message of "Thu, 01
        Jun 2023 12:00:18 +0200")
Message-ID: <xmqqsfbba42c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I vaguely recall there was a recent threaad discussing fsck and
normal codepath doing different checks.

Does this look similar to what you have?  (sorry, I am running out
of gas tonight to dig deeply myself).

https://lore.kernel.org/git/20230330181716.GA3286761@coredump.intra.peff.net/

Andreas Schwab <schwab@suse.de> writes:

> $ git count-objects -v -H
> count: 2177
> size: 17.75 MiB
> in-pack: 878690
> packs: 46
> size-pack: 279.84 MiB
> prune-packable: 0
> garbage: 0
> size-garbage: 0 bytes
> $ git gc
> Enumerating objects: 866036, done.
> Counting objects: 100% (866036/866036), done.
> Delta compression using up to 8 threads
> Compressing objects: 100% (144924/144924), done.
> fatal: unable to read e8524e0483c8e65746888368f77f83d7a955ea87
> fatal: failed to run repack
>
> How can I find out where the bad object is referenced to be able to get
> rid of it?  It is not part of the regular history, a re-clone of the
> remote repository does not fetch it.  git fsck --full --cache prints a
> lot of dangling commits, but still does not complain.  The error happens
> about half way through writing out the new pack.
>
> The repository is more than 10 years old and in regular use all that
> time, including a lot of rebasing.  I have looked through all of the
> reflogs, but couldn't find the object there either.  git prune
> --expire=now and git reflog expire --all --stale-fix
> --expire-unreachable=all didn't help.
>
> Then I used the fresh clone to copy over all heads I know about, like
> recreating the branches and replace refs, fetching all reflog entries.
> That did not report any problems and git gc does not complain, but it
> has about 14800 objects less.
>
> Any ideas?
