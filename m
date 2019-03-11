Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9FA20248
	for <e@80x24.org>; Mon, 11 Mar 2019 01:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfCKBrk (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 21:47:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38771 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfCKBrk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 21:47:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id a188so2679804wmf.3
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 18:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b1Pageouu+hnX8q/CRjw07FZMYuR8TRI70hn+uIxgkQ=;
        b=UlBnZeVEtIGarikftn/6zexX1ZTiR8AbANZ2qwLOg0Aq5YFRwuBVxlSSWAQ7BSEDwp
         X5WYpuCrWIvuTEE3860DVDSGu5Wnhi4yQtA4U+q2krvQ+6oUOiGOEjcIdwfHh+zoAe4W
         aQPUFaLv7pRCxSoZ2L3u/koV4aHdtUKWMD70QXmQirP+ktiXMwxyjBE3YMXlNM1m0Jdj
         hUCcAlNZv4fM+Thot0AaMyPASn4e2FO+JcHUMn43f15BOKBNHgFs/ICd2+/C6XfCPTLD
         fS1DwKAxZyCiTwz9y7Rr7He4d95noebkH0es9GozYhygzuxKsG0mpge14qxUvottKPK5
         RhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b1Pageouu+hnX8q/CRjw07FZMYuR8TRI70hn+uIxgkQ=;
        b=psxKy0L8pPcbMAiDzPkz9bGYK+eL1QCkaG6L9A5DyFCZYpvcckfDaxqDmP8QzWicYV
         wcTKBaKIYayXwMlPR57ChXVZDSb9wjdRhRVjVNyus5sZmaLpodX35YgKtTBLXehNQtBA
         U7eDGK5GaqziHa4nlxRon/T6yMgtIcSwGm8YXR6XTxtbXl42+uYpXesJ/jrklZjcY/d8
         loIHMP/joQibhPQFi3oQ4q1a556ql7JhBQ9l3zIKkK8zOX5mmeSVdy0OAl29Rfba6Zcc
         ffdnhMRsfbxMSrTRnCFFav4Vs8bOVWr5EgjR97t+MmiJ+svUSXna4EdmesrXXqM0rr7h
         gvDw==
X-Gm-Message-State: APjAAAVoWXFtApYQm85xcDICnfJIp05HTf9WpFfnpX4rbUyde+dGFFuj
        HzqiiUwHSZZ5su60gy9f+18=
X-Google-Smtp-Source: APXvYqzqAtT9FNv0IuZRojvVPCCt+aZJW1qcym23ISZDYDV+nH+zhfK3uUaQ1WKNtiCEzfm01QsRhQ==
X-Received: by 2002:a7b:cbd3:: with SMTP id n19mr14702483wmi.131.1552268858436;
        Sun, 10 Mar 2019 18:47:38 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id u17sm16150396wrg.71.2019.03.10.18.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 18:47:37 -0700 (PDT)
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
Date:   Mon, 11 Mar 2019 10:47:37 +0900
In-Reply-To: <20190309182610.GD31533@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Sat, 9 Mar 2019 18:26:10 +0000")
Message-ID: <xmqqimwqmbba.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Subject: [PATCH 1/2] stash: pass pathspec as pointer
>
> Passing the pathspec by value is potentially confusing, as the copy is
> only a shallow copy, so save the overhead of the copy, and pass the
> pathspec struct as a pointer.
>
> In addition use copy_pathspec to copy the pathspec into
> rev.prune_data, so the copy is a proper deep copy, and owned by the
> revision API, as that's what the API expects.

It does make quite a lot of sense, but do we need clear_pathspec()
at strategic places after we are done using these copied instances?
