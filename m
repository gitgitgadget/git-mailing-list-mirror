Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D56BE1F42D
	for <e@80x24.org>; Tue, 29 May 2018 04:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeE2E1w (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 00:27:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40825 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeE2E1v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 00:27:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id x2-v6so29281826wmh.5
        for <git@vger.kernel.org>; Mon, 28 May 2018 21:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=28BJ8Wp8uDLx6RTEUaUuZYk/07Ktf+iby4l2omA/zNA=;
        b=lA04xI58/ApWsDPUfszQ/u7ehUJNEbiZkxRoNgcXwFhdWoTI9la/ch/C3uNtYqy3QL
         pyiiZ9TnzsNoVEuS4KMir5uzVVjIUH/bJefSgIt+48YARG/lDAmhfw3Vml3+QoJP/75B
         rphvgoCBsoY1T/97d4Y8cqGb1SpYTprxtWBWpUgLSzAvSfF/4rfMrbWdeF3lsC8+XrCu
         VFPrUIDs6Djt/JGRulRF3eV/Z4NztEOSw8Fjq1mlGgGaoS175CqdJQdV6FLLzM4uS58D
         0qXIGy8vI98erAkJRRcu/00F1xjzw6ajpghF68KqUX4stme3/6f+Vj5GCv2CqGtv56x7
         69NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=28BJ8Wp8uDLx6RTEUaUuZYk/07Ktf+iby4l2omA/zNA=;
        b=CmxOYGO0Wc2HbvvP46/csArR9ig5BwY3ajYwm2AfotCSJOp4q6IC+1DTezrjErGe3Y
         SIWhzI6pjRHKlOb6NkxuTkY/4mrdtvpQmf6ctWf6B7wx7DVDZmtRuvXvLzaghh9+5yuZ
         n3F1uh5ic5wvyK2dxQWR6fRKf725WKULxYRQv36UoAFNnWx1Ukdp7/19F+/a97rIrWPB
         aE/nk6tDElyWe0hPCSGM3xX62N70mWmqv0bK9rsUVhiSsUD2SPFGf8VFrPumXJtHGxSO
         DLp0NsLd0cZcS9Ux3rYqtihOzEC35DpRJvaG0PgqRzLBExpfcvfkd3XhMOVRuV0EVmWR
         vc1g==
X-Gm-Message-State: ALKqPwd3yVs08s6A4nYCPfmkCHMHWj2tAAS+9w4XuT+6I+XrDthjXt1N
        ckRbIpFu3N85uFt2VEay/v8=
X-Google-Smtp-Source: ADUXVKI8VJCBQ2WJ0D7klhxUTl0+F6hvPbqM9Qxzaz6sknH4TEXxbTX2/9UUTEXC7KBX98HOCM54Pw==
X-Received: by 2002:a1c:c013:: with SMTP id q19-v6mr9971407wmf.49.1527568069809;
        Mon, 28 May 2018 21:27:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j76-v6sm52199464wmf.33.2018.05.28.21.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 21:27:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 00/20] Integrate commit-graph into 'fsck' and 'gc'
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
Date:   Tue, 29 May 2018 13:27:47 +0900
In-Reply-To: <20180524162504.158394-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 24 May 2018 16:25:23 +0000")
Message-ID: <xmqqzi0jgk70.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Thanks for all the feedback on v2. I've tried to make this round's
> review a bit easier by splitting up the commits into smaller pieces.
> Also, the test script now has less boilerplate and uses variables and
> clear arithmetic to explain which bytes are being modified.
>
> One other change worth mentioning: in "commit-graph: add '--reachable'
> option" I put the ref-iteration into a new external
> 'write_commit_graph_reachable()' method inside commit-graph.c. This
> makes the 'gc: automatically write commit-graph files' a simpler change.

I finally managed to find time to resolve conflicts this topic has
with other topics (of your own included, if I am not mistaken).
Please double check the resolution when I push out the day's
integration result later today.

Thanks.
