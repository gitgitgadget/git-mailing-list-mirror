Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F6E71F404
	for <e@80x24.org>; Fri, 20 Apr 2018 17:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeDTRtc (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 13:49:32 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35458 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752682AbeDTRtb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 13:49:31 -0400
Received: by mail-yw0-f169.google.com with SMTP id l133-v6so108267ywb.2
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/j6+pGvK9tmSGj9uJoMsPoghH+OfhxnoIl7Dr7D8dZ8=;
        b=VDDvRZgYhb5k8CYJMcU1AYdWYOFgQeJ4YJEnQR8aIFeJroJWarGlYY+vejnBu1eDZK
         t8fopzmeETqHEfNS5BIW1L8jROssm9VLtBpL3vu6o7BSXSdwj2dg/A4FUq4+EauVs2DS
         F5o4rcS3rvfi4jc/nm0z58JyeDG7pc8PRcC1cpc7BbtSgoQuEmKI/9+4aTJSZxw4vXUy
         iUJ1L5cDlYd4zAt1Fgn37okz1OoTG9iinCLfoSEJuEe8ruLCcy4H/4AQez8Xp637/QLc
         ZyucSXZaEtKgaEINrv45lMu8r6wCw+SL96xmUH2ISijM/C6Xfj0FvqFhGwVqPWkSZs5u
         8foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/j6+pGvK9tmSGj9uJoMsPoghH+OfhxnoIl7Dr7D8dZ8=;
        b=YGsmcFYK1jH6n7Up6uZ5YNWmYCB8jzz87j1P19jzt5Giir5f7ZfyX1udZ6C+0bwmie
         oPVxY1f4JLBJLaTCHtL1JH2Sn4eQgbyhFj9VJsr+Ae+oPKf+/WzRZBeVq597gP3pMAf2
         JWT9ayxSNADPYng6mkVnb52ZlD48mKU23GFwH+Q93XXuLBadp+rVdkapfEF0plC5pnk4
         824frM2PiQRepPPD2WURVTiy9Nqakf04XfnfccLXdjaDD6+4/p8NniwRBeehg8OyKMYA
         YTseopmFSMIQWhEjzjYVmn5UymkQFiAUHMLTH34329D/DvgIVOlChWAH5R5fuRe5LAdV
         2tSw==
X-Gm-Message-State: ALQs6tCd6Snei1Mwxb4nQlSe+7ynDl55A/+zqu6wh5u8bNcQXAdAmMJQ
        NafuuSyWNwv8fabZ/fFBxF0JVsUuXg9iM6feSQosYw==
X-Google-Smtp-Source: AIpwx48xAGPNpxmdKyEzLVGMgo8eYfbnRqGoRyIhKwx+q04Do1+V/33bnMKx/0IFU0r4mK3HKlDm/SJEWWXgLIou60M=
X-Received: by 2002:a81:370c:: with SMTP id e12-v6mr6464340ywa.340.1524246570853;
 Fri, 20 Apr 2018 10:49:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Fri, 20 Apr 2018 10:49:30
 -0700 (PDT)
In-Reply-To: <xmqqwox5i0f7.fsf@gitster-ct.c.googlers.com>
References: <20180417163400.3875-1-jamill@microsoft.com> <xmqqwox5i0f7.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Apr 2018 10:49:30 -0700
Message-ID: <CAGZ79kbOQLkNZxHbR0bDwVHbT0x47v8qp81E2WFm72HdZJ4ZRA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Allocate cache entries from memory pool
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jameson Miller <jamill@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> base-commit: cafaccae98f749ebf33495aec42ea25060de8682
>
> I couldn't quite figure out what these five patches were based on,
> even with this line.  Basing on and referring to a commit that is
> not part of our published history with "base-commit" is not all that
> useful to others.

I'd like to second this. In the object store refactoring, I am at a point where
I'd want to migrate the memory management of {object, tree, commit, tag}.c
which currently is done in alloc.c to a memory pool, that has a dedicated
pointer to it.

So I'd either have to refactor alloc.c to take the_repository[1] or
I'd play around with the mem_pool to manage memory in the
object layer. I guess this playing around can happen with
what is at origin/jm/mem-pool, however the life cycle management
part of the third patch[2] would allow for stopping memleaks there.
So I am interested in this series as well.

[1] proof of concept in patches nearby
https://public-inbox.org/git/20180206001749.218943-31-sbeller@google.com/

[2] https://public-inbox.org/git/20180417163400.3875-5-jamill@microsoft.com/

Thanks,
Stefan
