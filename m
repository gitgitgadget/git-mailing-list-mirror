Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801F11F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391538AbeIVD5f (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 23:57:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41172 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391419AbeIVD5f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 23:57:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id j15-v6so10084875wrt.8
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DS4sbmVFPqReZPdAIZJy+rbHo3i+5ZaR8uS2RYfzFv0=;
        b=FZGtX2mJktEk3F360b5Tv9OGaiIFgKZJl6QP1j4MD2OX0coB3HDFGYe06oK4XrXLDj
         UP4nWUiP9UjsPEfXBRPGh+nHko/vHRF9W6lU/ks4lN716zyE2Nyjdb+LKSzcBFHVKahF
         LUGHxwyTiXLd0YAjGB7Rxtaoqt0jwWeXlXV0jeOrTBuFBZE4uWSMwW+BmAx1J9z1lrFx
         5GCy7PUXi/GB83bUAQlLN0faRXQx1R93SfRjaNgTcsN1Gt7giVwvn6cxKsxwgsr25HgS
         QxWf7ISU2/Rt3O61aUCe6Ba2Eu1CnEkcRNyS162eGvtUrnjymzY4OhJ6XQpFoZghxrf1
         r3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DS4sbmVFPqReZPdAIZJy+rbHo3i+5ZaR8uS2RYfzFv0=;
        b=frSIzKHeo2gzd/YMEcLafMYfARQGST7+JcktFqmCL5UFEH6mdZ5FMiBf0VSEBMy5AN
         ZKraNGuD7ou3wxLMTl4eS2Zi/7LmHqEcjvBnCT+yFnMTZufTW2Tp4PhhFAkXnLT/mLWH
         xgR87UUyGolFwqLcAhBGeLPD+WPZS3i59dHdVnsr+mI5/V3uXJMjCMTmhKdLsEkJtZQz
         DWeBUMJ8iR01UsBwCHRJdXv7TprpM8LxiuCORQYhZUgpyZcBWSZASMcn2i49cdU4ne0d
         jwSd0ofdLDIA1H9q1mjEs1iK7UmcPjaGy4eAJP4i3twNFrH7abGhDh0oyF2s8byNXPli
         xzTQ==
X-Gm-Message-State: APzg51B9LVW/Db4Tr2F7F0XNUEoN8mvnAkp3/2Y8/7ojrEiWxXmzs82g
        qTw4D9umUMj9kJeA+oimYVM=
X-Google-Smtp-Source: ANB0VdZx6QsY0XZBdCs1hJgh68XkExU+mxERS/psYaMHTBXyIkU8+YbHknVX2A6v2/lmpgYl001ZDQ==
X-Received: by 2002:adf:ed04:: with SMTP id a4-v6mr40910130wro.262.1537567604900;
        Fri, 21 Sep 2018 15:06:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s2-v6sm33585325wrn.83.2018.09.21.15.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 15:06:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
References: <cover.1537466087.git.me@ttaylorr.com>
        <cover.1537555544.git.me@ttaylorr.com>
        <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
        <xmqqbm8qv9hy.fsf@gitster-ct.c.googlers.com>
        <20180921213753.GA11177@sigill.intra.peff.net>
Date:   Fri, 21 Sep 2018 15:06:43 -0700
In-Reply-To: <20180921213753.GA11177@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 21 Sep 2018 17:37:53 -0400")
Message-ID: <xmqqtvmitsi4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There's no extension necessary; these should already affect upload-pack
> as well. I agree transport.* would cover both upload-pack and
> receive-pack. If we extend it to check_everything_connected(), would it
> make sense as part of transport.*, too?
>
> I dunno. I guess I could see an argument either way.

Sorry but I do not quite follow.  Are you saying that something that
covers check-everything-connected would the result be too wide to
fit inside transport.*?  or something that does not cover
check-everything-connected falls short of transport.*?  Or something
else?  Either way, core.* is way too wide for what this hook does, I
would think.
