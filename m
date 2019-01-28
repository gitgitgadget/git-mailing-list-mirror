Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EB691F453
	for <e@80x24.org>; Mon, 28 Jan 2019 16:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388384AbfA1Q5u (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 11:57:50 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38492 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388031AbfA1Q5s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 11:57:48 -0500
Received: by mail-ua1-f65.google.com with SMTP id p9so5846922uaa.5
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 08:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W9tlkOm4rw400nWxx8JPQCte/Snh0rZWUA1xC4TwG44=;
        b=dpimOF5vvixtw42owyINrEyJC+d5AA2LqR78EaFyEneovo8eo4ITxVNOyH5P1qVkY6
         dFYJMD3JxzP3nmFwvO5IPesnXrGUSF/Z5zGAsuGJbEVJkraZipTX6vzTOwIQ5mriK9Kw
         6KeFv9G2YN+ZpZMUirGyAP1c17LzOe2yg8Rxvs0ldkHBxzxSU0vr//L4GCEQmMbxVdwW
         3JoWsuW9HmMmSPgGDaiGDtB5LpQhShV0UFDFusfDpwjXicRWFTBTi4niKBSH/6POKMq+
         rLA3RRugLat3i4kNdrbTZkkqNi6JpLU2JJ9PndVPyxhpr0F8Y0O1A7nCa+4AlwPwVwgo
         I9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W9tlkOm4rw400nWxx8JPQCte/Snh0rZWUA1xC4TwG44=;
        b=aEoiZBPwD8SA32Jn1ySj0Ap8dYgIx1/qNBWrCvI3mXMtjR6GuFXfCLxEDa+5vlTgII
         RaHYCEo0bUjGQ7cv/7Q73U4N2KlBy0oljCLF1SInTan4UpiEGqKfwdueNYXFNA5i1i6z
         swLEQknC0w7pvBXeWHDAun3xbIgoKNio3j7shvmMQE85MwiLd/F86okKn+iP2ULcYLkO
         9egjQMXQgAeq4xlW94HvQFBxS8vVzT12+7DvrBDjuDFXGAMvEtirRQyUH68QbwvzJnBd
         5PMCVGEJaWsVbwiHwEPwKigl9xAyjSGuDGfBLHrbt7yVWpZP6GfYirTzb6ftGsmHhVxB
         VJlw==
X-Gm-Message-State: AJcUukdz7o6nf5uDKN+aRxPvIPVKdxzi1Bpkda9Tle9Uxdy3zk2bUuNt
        1A2KlvX2W6hbNeqViqgZ8Xik5dyQducx7hzKkuYtJg==
X-Google-Smtp-Source: ALg8bN4zTjMQBsbW3xKNWd76THH6IhjZWkcvcz3g4vY58xMn/C+hIgXIaH/JslZKSWK3X8LymKM6J+jxGIwwDZX4oAE=
X-Received: by 2002:ab0:5590:: with SMTP id v16mr9383565uaa.132.1548694667646;
 Mon, 28 Jan 2019 08:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20190125222126.GH6702@szeder.dev> <20190127130832.23652-1-szeder.dev@gmail.com>
In-Reply-To: <20190127130832.23652-1-szeder.dev@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Mon, 28 Jan 2019 08:57:36 -0800
Message-ID: <CAGf8dgLzNJLrT-XW25=1SqJiH47hiTNVHf7-sx8efHw5oMnC7Q@mail.gmail.com>
Subject: Re: [PATCH] object_as_type: initialize commit-graph-related fields of
 'struct commit'
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 27, 2019 at 5:08 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> When the commit graph and generation numbers were introduced in
> commits 177722b344 (commit: integrate commit graph with commit
> parsing, 2018-04-10) and 83073cc994 (commit: add generation number to
> struct commit, 2018-04-25), they tried to make sure that the
> corresponding 'graph_pos' and 'generation' fields of 'struct commit'
> are initialized conservatively, as if the commit were not included in
> the commit-graph file.

Thanks for looking into this! The patch looks good to me.
