Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA69E202BB
	for <e@80x24.org>; Tue, 12 Mar 2019 06:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfCLGc3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 02:32:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41154 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCLGc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 02:32:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id p1so1310433wrs.8
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 23:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wJ9wjucR1/M7mJZiZCQwJqFfAc/ligJmD/00I3JRxz0=;
        b=fzYwneSIUiZjlZ41SUB29Kwdsl5HSY2a7rq/MoKkpL5hCaBHs0JMPcsvoXQVlQFThE
         HCsXzZzmpMkIdg7ebjQ7tTHh21GZ3LVx5pIOlrkmtJyv+AVYqfoiqhBSWsdUm4lZGP67
         5MZ8StPPPAw0RBUyUlB2yck9/c91kcm3jTml/zUbxVodqh2kDhcjHUq/+gwzeAEwoa1F
         pDwfF3clMWYOk7c+zlYhjzsPmH2knbFSzt0wgvDwRV2GHkTkDdMOwGHkYE5WVaF9RUtw
         Uh3wA5s3lDMeCd6fgymIIIPCnrL4iaPKv2K5FQzg5j/LiOb5iKosVeqQIJJxcVWr+0pG
         3ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wJ9wjucR1/M7mJZiZCQwJqFfAc/ligJmD/00I3JRxz0=;
        b=jIWqxKBNTr4fv6gtcIvMgfM55f8HaVRZbKuIIVFQiRjI+mRoIE6YEwY74+m7Vejkcs
         A+5oEuexRlfLBIb4MhGUFyaqst65FfWsdH2A+P+3yWvThfxxjDMmBfA9qVWiR4zEZbdF
         les1O1KlpkZumVzaEI802IzefhNPS0UGKbJEL+/x6cRLvD697yVm8BWx/2gFObImFs27
         tLhm4REZTl9KMgQHTqSRogngkMPfyWJAPVEt1EIcz+6Zp3/KcSyrTCIeJ6oUgsb+wgMU
         sfsiXy5m7cMYSSqA0qDEUTz9KWAhcPSTMTJAFjoUrvVXvLOAE7YvjbgbxosTqvDtkqz+
         1L2g==
X-Gm-Message-State: APjAAAX79ZLk1e+P/KHWJrsLxdi7kclFyNSYDgCNyF8XNTybapHWz2k7
        lW+Lz/Ft29rH6TqtYWcLKWo=
X-Google-Smtp-Source: APXvYqw546bbPhJGhRrsrXh5XwRwmtx/TM28pxNhPI5hjkigedhCRwPlnemAA9KhphlMoSHXeSfNEA==
X-Received: by 2002:adf:c7c6:: with SMTP id y6mr22162626wrg.217.1552372347286;
        Mon, 11 Mar 2019 23:32:27 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t18sm1526285wmt.8.2019.03.11.23.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 23:32:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Yagamy Light <hi-angel@yandex.ru>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 1/1] worktree add: sanitize worktree names
References: <20190305120834.7284-1-pclouds@gmail.com>
        <20190308092834.12549-1-pclouds@gmail.com>
        <20190308092834.12549-2-pclouds@gmail.com>
        <CAPig+cQYDuKrRwf9GrGZUTnH=BgSyp8Rmh7ON1p+0qOrHxpe3Q@mail.gmail.com>
        <xmqqbm2ikk4q.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CqN=Uu-Fez7T9evazitVopXt2dkQ1rGzKwh94tdiUdvA@mail.gmail.com>
        <20190311223936.GA24989@sigill.intra.peff.net>
Date:   Tue, 12 Mar 2019 15:32:25 +0900
In-Reply-To: <20190311223936.GA24989@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 11 Mar 2019 18:39:36 -0400")
Message-ID: <xmqqa7i0iow6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Another option _is_ to actually make it reversible. I.e., use "%2e"
> instead of ".", which would also necessitate replacing "%". I don't know
> if that has a huge value for this use-case, but it's a nice property
> that two sanitized names can't collide (unless they originally
> identical).

Yeah.  That is a good property to have.
