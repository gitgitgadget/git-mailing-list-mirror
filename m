Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3741F454
	for <e@80x24.org>; Fri,  2 Nov 2018 11:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbeKBUzY (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 16:55:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37084 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBUzY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 16:55:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id z3-v6so1697999wru.4
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 04:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l+245m93pwOMiQOMmMqtl99oQTdg6E1+cgPRoRPlR2U=;
        b=gLR2JRkiFN02jDwqpE/oGuW5eJ656KIzT9m1px8LekWZSsUPdEoArjilsIuAgxq6Uy
         3tS8vU/yUqb7b0P1x0RIA4P84KaguGlp+YbHRuslMMb/2QC1yvO8NBXHb9p1Fnng5Yqy
         KcnUlE3bWOhnvIx9Ft9U5hziy6Rc5hXXVz/Bndy70peQ9wT2eRa7/Ps2bzxFG7P5QARN
         wNXN+AdQkUYGZQqIhhXhNhpUov1l8lTuuGZEEIouSxiCXSiaD4X43OljlKMigHRHa+mw
         6D8xZDvfdwVWQJEFuvisK4ZmYpyHwf/Kw1TRwXZbTqohYP/8SsQAOuw4AlTfRFDS5Eyi
         +5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l+245m93pwOMiQOMmMqtl99oQTdg6E1+cgPRoRPlR2U=;
        b=YX0nhwqFrWqOv/2MNj/NroXlssUa3geul8uzCIzBuh8ANQf9cpVgPpI2xkTr7qu87m
         Lw/0K8lekti/U/5WUDwq2ZH5MrZebUqOwG+w81P0sj226mwiaEVYFkl9Yc58I+lna82m
         mXj92a6gbnPdwmYEifequmWAHyhCWr7ilhYOpdNn7cRT8czQPszvgyNVDGsFPChBTGs3
         o/9uqxDb1T62FBRc+oc+UO7UQGlCQaSS8mGKnBSZgOnog3pjLvH7X3UZpo668sDFrURU
         UlUHDUyiPH3qkItgiqJ04QZCVR88kCHCnHRVylABGGV4DKMI74T5rhl95fBNOYGV8xSg
         Dd+w==
X-Gm-Message-State: AGRZ1gIespy8hElEWJC+8n5CokU3Bo/EpcrQqDWJ4ZByGfa8S1Iz56zO
        STOlL1Wg6o/wHTmJ41b9fJY=
X-Google-Smtp-Source: AJdET5ehNwQPiXDV0Kn4tTyGEVjDIXbTMiIFfcWABO7L61yCm/YXlGqUtGaGTodlhkKOdmwavQZQ5Q==
X-Received: by 2002:a05:6000:1202:: with SMTP id e2mr9367766wrx.315.1541159307363;
        Fri, 02 Nov 2018 04:48:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x8-v6sm82403286wrd.54.2018.11.02.04.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 04:48:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/9] saner xdiff hunk callbacks
References: <20181102063156.GA30252@sigill.intra.peff.net>
Date:   Fri, 02 Nov 2018 20:48:23 +0900
In-Reply-To: <20181102063156.GA30252@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 2 Nov 2018 02:31:56 -0400")
Message-ID: <xmqqh8gzpuns.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... it seems rather silly that we have xdiff generate a string
> just so that we can parse it from within the same process. So instead I
> improved the xdiff interface to pass the actual integers out, made use
> of it as appropriate, and then in the final patch we can just drop the
> buggy function entirely.

Acked-by: me.

Thanks.  This is exactly what I wanted to do for a very long time,
ever since I did the original xdiff-interface.c
