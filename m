Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A2E91F51C
	for <e@80x24.org>; Mon, 21 May 2018 03:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeEUDOj (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 23:14:39 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37599 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752730AbeEUDOi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 23:14:38 -0400
Received: by mail-wr0-f196.google.com with SMTP id i12-v6so1345415wrc.4
        for <git@vger.kernel.org>; Sun, 20 May 2018 20:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OkBNZrhZkzewjtmIh+7PfSOkVHS3EgdGzgsjzDm4iUQ=;
        b=tQCtbdzCtiOoaMJ+ns67kvMUPQot002z7Hvy0ILvWa+00LZ4BUwxOONqfstT/lEPDO
         47580MYDpxw+h7rkY1aEif07fJaYlPITmeG4uDyM58kUSbLV+pUHbnrMaH8BFPydTPCH
         x38RHAap/ZU6svOAT2tE3iRhil6I+KBET/Q2Vxsyk0HJjSvRkCNMo9RpW4IKpZKTX4CA
         EXaBLwT3Y2mMARKkVOsBRgV8g9v7m41l3lIuYlaQHxITrYX8Ev0cYeVYQN8PZMPWQAd/
         r68IapMeH1i6X4s8m5r0kTUX2cmgFGi5Hsz46oozfrBNe1xGBZiF5Nm/55tKlf13DKFa
         QRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OkBNZrhZkzewjtmIh+7PfSOkVHS3EgdGzgsjzDm4iUQ=;
        b=gqm3W4z0CfGXRAAoaFwb/qB21DvfpCMJ89B2xxNVOWeCQjX/8ONyaeMWc24B9WAD+J
         uphhtYrTWYi5u9oW7GBfklJCV0jKoVJv/SDmgE1jc1Em4PFgLpR7huoGyLuHhA32NY+p
         TfSOpymXYQoUKMj40M19N4qMa7m/0+/oV4Lh6Dq8vvzQka11wPvcLyRyRNMCOCKXAeS8
         Tm5zEd/uBsx+9HPJ88J0+V88KOlarGzIx6zExPns26b+4JszxnOgWtAzP37/lBvGmHmy
         jejk1Klw4m06D9Ds6mlcS1f39s1kov0ne57OrbwDmr/yHqPI+3rJqA/0nxPrbwrFpQYD
         HDEQ==
X-Gm-Message-State: ALKqPwdXeOrdIpUNmDcvP/9lNFXt4CCn/i2WAsTrtMpD5Q5TDYtUR3mW
        QiK2R4Uim47DDUlrG2d/jZE=
X-Google-Smtp-Source: AB8JxZqgfmInPuSK2ze/UAC3EP/L0DO/A2PbvSpJTWtM4rHZ0/wZUwa87RJ6TNNuJVlvVvsJP7MPnQ==
X-Received: by 2002:adf:da4b:: with SMTP id r11-v6mr13746651wrl.154.1526872477296;
        Sun, 20 May 2018 20:14:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j76-v6sm40543396wmf.33.2018.05.20.20.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 20:14:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] apply: add --intent-to-add
References: <20180513175438.32152-1-pclouds@gmail.com>
        <20180513175438.32152-2-pclouds@gmail.com>
        <xmqqo9hjc6er.fsf@gitster-ct.c.googlers.com>
        <20180520063424.GA3062@duynguyen.home>
Date:   Mon, 21 May 2018 12:14:35 +0900
In-Reply-To: <20180520063424.GA3062@duynguyen.home> (Duy Nguyen's message of
        "Sun, 20 May 2018 08:34:24 +0200")
Message-ID: <xmqqa7st3dk4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> >  	if (state->check_index && is_not_gitdir)
>> >  		return error(_("--index outside a repository"));
>> > +	if (state->set_ita && is_not_gitdir)
>> > +		state->set_ita = 0;
>> 
>> I think this should error out, just like one line above does.
>> "I-t-a" is impossible without having the index, just like "--index"
>> is impossible without having the index.
>
> I was hoping to put this in an alias that works both with or without a
> repository. Do you feel strongly about this? 

"git apply --index" that silently applied only to the filesystem
files without telling me that I am in a wrong directory by mistake
is a UI disaster, and that is what the existing error we see in the
pre context is about.  I do not think of a good reason why "git
apply --i-t-a" should behave any differently.

