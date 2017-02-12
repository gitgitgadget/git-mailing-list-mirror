Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8261FAF4
	for <e@80x24.org>; Sun, 12 Feb 2017 02:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbdBLCvV (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 21:51:21 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33013 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbdBLCvV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 21:51:21 -0500
Received: by mail-pg0-f65.google.com with SMTP id 194so6274164pgd.0
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 18:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5wQdzDMkKcc29adKUzpWP/1o7f+B7UGasPjMCXXWCPk=;
        b=su0gi/YmdhsnKPMC/TgMfy5DDNkHFc/PcgWNQvJwu9231rS9TDpoROvJhBf6UMpkiL
         uLj/ZKueLVQeXu/C2WWIUSBH8Oex+pj5xZKitlhRRw6try4ssxsGowoYU0RSAc4ZFryt
         JqhOKMyt0diFHvZRAc+YHXJHAZLjW1Ft8TyqwosgxPo3cXQjGzAR1tcw71SGZZlnsgRS
         m/n/g8GlUYBQzpX2IMtrKbjbrnzT6ujlevVLSeoECBuRbtBZ1ldsmuU04PTTSkgO85WS
         AISWzAB3uLWnLRtMXo6iKkWYJZ3hyC/dFipHYi0MoC5ayzFNlMLU3YobAGnM5G9IeMWN
         O8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5wQdzDMkKcc29adKUzpWP/1o7f+B7UGasPjMCXXWCPk=;
        b=rnqjTId9dURT8aOxw41ttU6zTCwHxPhBaDW+N/XtXCaj/Ri5eeDnimJ1zI3l6oC53x
         zJ8exNX2EvXuolu9pwgMp4Ky2h5rk3kLbyb63JJWt6tqALMtkDtPPkvQhPqUrRKx2ZZf
         2c6sy+z3p8P6RzX7xKxdceaH+xtH7ta//o1a4a7KwJkPBx+QhopQWAlxKEWvNZSglU0N
         /H0jk8nxE4kZtwhzbCNijdHJVpvMzgrYIxQEvEUsoUg7Z2K28TiCeoWBYd2MOd7Krx96
         bePqWRPQEvT3EE4zqx/evmu+SCZEnW2SvdZrfkBZjMS03nhOMFQVJtXlY8uSQw4TevVt
         v5gQ==
X-Gm-Message-State: AMke39lRmonb5iQcyeD7ILNZFjNeylBuJLgBLXOyVydsEBxDRsY2EE9EdIsM9ufzo6WNsQ==
X-Received: by 10.99.112.75 with SMTP id a11mr19259581pgn.7.1486867880072;
        Sat, 11 Feb 2017 18:51:20 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d4bf:82d:ab5d:5a31])
        by smtp.gmail.com with ESMTPSA id e4sm13103911pgc.45.2017.02.11.18.51.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 11 Feb 2017 18:51:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [RFC] send-email: avoid duplicate In-Reply-To and References headers
References: <20170212003432.GA19519@starla>
        <xmqq60kggp8r.fsf@gitster.mtv.corp.google.com>
        <20170212021208.GA16358@starla>
Date:   Sat, 11 Feb 2017 18:51:17 -0800
In-Reply-To: <20170212021208.GA16358@starla> (Eric Wong's message of "Sun, 12
        Feb 2017 02:12:08 +0000")
Message-ID: <xmqq1sv4glzu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> I think it is sensibleto give priority to the --in-reply-to option
>> given from the command line over the in-file one.  I am not sure if
>> we want to drop references, though.  Wouldn't it make more sense to
>> just add what we got from the command line to what we read from the
>> file?  I dunno.
>
> You're right, existing References in the bodies should probably
> be prepended to current ones, as their order should be
> oldest-to-newest.

If you were to go that way, it may also make sense to demote the
original In-Reply-To you find in the file to an entry in the
References list, if it does not already appear there.

I didn't check the RFCs, but I think your original motivation is to
ensure that there is not more than one messages to which the current
message is replying to, iow, to ensure that there is only one message
that is In-Reply-To, so appending would not be a good solution there.
