Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A74BC6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 04:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjC3EFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 00:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC3EFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 00:05:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B577171F
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 21:05:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id iw3so16929610plb.6
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 21:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680149143;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0DUD/g5BR7O3ynQY+uVn9xP5hDV+CEnKC7lyzZa7JI=;
        b=gHGHyCtoYTx/fCEVTUxUYHpm/Pixxg4RlFesta1mURAslkTYMzuMxoRba/H8Hp+eDe
         Wdp7Bkx+l9P5krcQK6MLMS0x/zTKCaAyFHDvH3sXgXB/7mDYOh39FJ2zp/bJhrl5rRBt
         UOotr6QQYF8FAeUFqxq1g052X+v5kBWmWZ2BSafIOtzcbW4Q0sxQjHCKwe9baYTCM743
         o/iAaoEl44/M7/oLPZsodFnB9wfoW+dJN2R9Kw3qQMrc8Ez7o3OiEgy12DfAVwqTsZtp
         I7GDYcHtA6wbckXagl9szZuHmGkKN9ksnnna7QXMEQZUF4Iq88LGKs8j9n2ywHI+WAzH
         2mWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680149143;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0DUD/g5BR7O3ynQY+uVn9xP5hDV+CEnKC7lyzZa7JI=;
        b=R5SibWOtZsajSzbAOPFtsBfaxKvslqo/qP6lC59/It9NcXQS6rA6N7wyhiE4C6mKka
         85k0xADxMoiMmLRyUsZQ2c6iyXrTWzT62+n/A72UhP+BYFSQIQSRjPQ8HXorq9trcVVr
         0iVUxw3q5XSk0HN5M3YATYAHv3biCh7J67ZTztJM6rfMT8cBFrZE4CT7pvSci6SrkEIX
         mq22UUy04mYBKoZ6bbDJEyWe8qGC+d8q1yWwaVIcrAyzWWgkXwsmfRiiC6q87OZYbKSw
         68Ql6QJUjcv5OyT03ASaREOwz6VMXV/9yEnFWBvVZJTcotKlhppDoY/jhFKEu6AvKE0l
         zkRQ==
X-Gm-Message-State: AAQBX9eMkio+E9HSI3aqcr6NrZ0wuzf3wCjPw3ZNAcZVDWBKPfv5RGJq
        ZLWzOc6i26KzrDnjYYsOwbQYecOFDzs=
X-Google-Smtp-Source: AKy350bMPUkhxUliAIlaiIJq8+mk0zcCg07Wnf/YzR235eOsQqJhu7jeAGamM7a9+ILjcWxI1Yfm4A==
X-Received: by 2002:a17:902:d2cb:b0:1a1:db10:7ba3 with SMTP id n11-20020a170902d2cb00b001a1db107ba3mr30112018plc.2.1680149142752;
        Wed, 29 Mar 2023 21:05:42 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902edc200b001a1a18a678csm23773870plk.148.2023.03.29.21.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:05:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2023, #06; Wed, 29)
References: <xmqqv8ij5g83.fsf@gitster.g>
        <CABPp-BHia5NO40-j=inCsroYn=J=+Zk12usNzL9keFFqTsghvg@mail.gmail.com>
Date:   Wed, 29 Mar 2023 21:05:42 -0700
In-Reply-To: <CABPp-BHia5NO40-j=inCsroYn=J=+Zk12usNzL9keFFqTsghvg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 29 Mar 2023 21:02:00 -0700")
Message-ID: <xmqqfs9m51ex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Not sure if you want more review, or the notice is just stale.  If the
> latter, some helpful pointers:

Thanks.  It was the latter.

>
> Jonathan Tan reviewed the latest series, v2, here:
> https://lore.kernel.org/git/20230321215653.1615083-1-jonathantanmy@google.com/
>
> (Ævar also looked at v1, and pointed out one of my commit messages
> needed clarification, and that my overall cover letter needed further
> explanation -- both of which were provided in v2).
