Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA51620248
	for <e@80x24.org>; Mon, 11 Mar 2019 07:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfCKHaN (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 03:30:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35582 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfCKHaN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 03:30:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id y15so3164367wma.0
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Uwk0U5OmgN1GoNcZ866mW7eqgF6QtUepXQTPSG1BIDU=;
        b=QHnMOBDOV3q0KZ9I1OVYZ+B7D9DCq2S3QPWqWSAJJrhyRKPnM5XoH5pX/dRbIBkQDy
         94oIrkL9Lx8FhStL9Cv4aH29Clf5JV42alkxiETmuWdEOEs5WXTF0+6PQVJOWF2R2lSO
         OdxS2203UlrsZtmi24/2bTv195tdkH3BPGLmCaanrQKqfO7wDw/RqypaoLv03gc4r6cq
         kXziOBrTxn4/ihQ3FO6b+rLI6B3CkZoH2maSi2/9xyCkiMzaCls5Nq2VV2nR29G+THPl
         B4kMzcM6OUhktLNiQ7KgNHML/4WY8+2/gZ6QYdLo7oEz7JH17gu2cNdaHpyO1+Lyutpc
         29Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Uwk0U5OmgN1GoNcZ866mW7eqgF6QtUepXQTPSG1BIDU=;
        b=AhgewMrGomlLFHpzB45dSND4cZUA5qhDYuNXxYlFf3qOCbNLDlVu4KhfDc3ldM/H5I
         cTR48yL1DQjQv26Vny/IKJa4NwBg5CT+uyZNwW5ePkHqohJFW7T0zymkBrP6TGMyWvGy
         F0RdxYL/k6Pb70foG5xDzkC21d1tUcl5R47lAE/bb6vTUI6OjpP+vBCRTba2j974Wut4
         HKC93y+ktR1rediHYEh8zk4qVj+l/5xFWXF2EXMZtQHpwHcIJljcw5JE9nimWDr1K+h/
         SYFKfdzrQl2Rguh1dTflwoZAOBwDgR7/q6Ap9+kKW5oAYdLdP3nWSqQVtHHhaOxlPgUX
         uohQ==
X-Gm-Message-State: APjAAAVWW5dMugxHBejUguz7jDHvdeXBs1YjuC/vZnc7oieiiQvVnDhu
        rH9OLygT7qUwP6iWA7OgL5g=
X-Google-Smtp-Source: APXvYqxdtOmxqB+9vaJgG5kk/1zvZuIdRY1xh5et05LUUj4bQu1TiJONogqCX3MWa63nd34zjobB7A==
X-Received: by 2002:a1c:1d56:: with SMTP id d83mr16877301wmd.67.1552289410551;
        Mon, 11 Mar 2019 00:30:10 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z6sm11925921wml.40.2019.03.11.00.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 00:30:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH v13 18/27] stash: convert create to builtin
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
        <20190225231631.30507-1-t.gummerer@gmail.com>
        <20190225231631.30507-19-t.gummerer@gmail.com>
        <20190307191836.GB29221@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1903081630040.41@tvgsbejvaqbjf.bet>
        <20190309182610.GD31533@hank.intra.tgummerer.com>
        <xmqqimwqmbba.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 11 Mar 2019 16:30:09 +0900
In-Reply-To: <xmqqimwqmbba.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 11 Mar 2019 10:47:37 +0900")
Message-ID: <xmqqd0mxkgvy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> Subject: [PATCH 1/2] stash: pass pathspec as pointer
>>
>> Passing the pathspec by value is potentially confusing, as the copy is
>> only a shallow copy, so save the overhead of the copy, and pass the
>> pathspec struct as a pointer.
>>
>> In addition use copy_pathspec to copy the pathspec into
>> rev.prune_data, so the copy is a proper deep copy, and owned by the
>> revision API, as that's what the API expects.
>
> It does make quite a lot of sense, but do we need clear_pathspec()
> at strategic places after we are done using these copied instances?

Another thing is that this also needs Dscho's fix to pass down the
pathspec that was originally given, not the parsed part.
