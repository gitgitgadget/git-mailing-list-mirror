Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82AC20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 02:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbeLKCm0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 21:42:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37187 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbeLKCm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 21:42:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so610019wmd.2
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 18:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=i3A6DxmWA7a0yY0kARhyWgCkKfXJMaJ2b8Lgc8GA/l8=;
        b=mjsQuV8++w6EQAtxAJR0WADffn4P2YW/0xN9DsrHMFd2bsQ/1hiYYmj2o+RL9ru5/k
         Pd9FRmnNOHjPhyvq6KwaI7n9Yl8cIyfFf1Lw0yiNP+IPQ26AAadm1BrPbIJCJ4pLj8vH
         YusRc30ra+dHMUSdjOKRAYVjFWxjZDSURHskf03lXYjNVtLP9ODaowNQwNNiG9s3E0kO
         YtcpjOEABsAyJFRo3fAT96+Slxv1Asx1oBzdE8LjY6PTjAO1N9RlNeAEXq4hOk5LKK6N
         QRp2KARHHJjyV7o0CWydBfEPVUI67aij2ilL8MJs5lyt6Cw2v6UQxSG4UwPGfp8ew3S7
         xNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=i3A6DxmWA7a0yY0kARhyWgCkKfXJMaJ2b8Lgc8GA/l8=;
        b=ta5ZuuzcCDwIj6TBUTAU8/bjFqYbtDtfERcu1DErjcK1r3PSV4ltfBI6R5jzaL/Jbd
         cqS4EdXoSod1WpYWYKVm6OviPC8Z/0AWqdhVZL1Xrh2zUqMDnw6sMuV2/Km1Mp1jCYWB
         sknXnveIDLYww5FX2NrLqu/R0UsomDdeq2+wJM+VQKb/xlhLZKm4Wdjj23Ra5CTh9RCC
         qN8MCokc9v5uPkEacYusoLFxJGlCqz5KHTzr6dFYt9766QqMsaAUrdSACOkASEHCphxF
         D5LKnUuF4TGYpBK1nF4RTu84wU3ti43hLWImZxT+vT+Nu8oyQxlwr29TtM31vw7dpCcu
         W86Q==
X-Gm-Message-State: AA+aEWb2RyIDHfNoMD1kW4WoT8y2VkEzKpwq3P5qcN3Auqk3POvuiWoU
        8v3E/YJqYQBSQejxT2c2NJ4=
X-Google-Smtp-Source: AFSGD/V7kDT4q8kjKdcwsTt9unPY7kK2np05kjXZv5PKqu9OCTQ/MhcicBfgapWILN9Z84euhAopXQ==
X-Received: by 2002:a1c:7619:: with SMTP id r25mr689397wmc.7.1544496144454;
        Mon, 10 Dec 2018 18:42:24 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l6sm1362777wrv.70.2018.12.10.18.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 18:42:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/8] read-cache: add invalidate parameter to remove_marked_cache_entries
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-5-t.gummerer@gmail.com>
        <CACsJy8AiQvu8W4=2HLKMdg+n2HiDrcLvKPRurKvziXaJdqefRg@mail.gmail.com>
Date:   Tue, 11 Dec 2018 11:42:23 +0900
In-Reply-To: <CACsJy8AiQvu8W4=2HLKMdg+n2HiDrcLvKPRurKvziXaJdqefRg@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 10 Dec 2018 17:08:56 +0100")
Message-ID: <xmqq7eggn5rk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I'm still a bit scared of this invalidation business in unpack-trees.

I too was (and I suspect that I would realize that I still am, if I
take another fresh look at the current code) afraid when I did the
cache-tree work and decided to invalidate it as a whole upfront.

> The thing is, we handle two separate index_state there, src_index and
> result and invalidation has to be done on the right one (because index
> extensions are on src_index until the very end of unpack-trees;
> invalidating on 'result' would be no-op and wrong).
> ...
> Yeah I think it's because cache-tree and untracked cache are already
> properly invalidated. ...

