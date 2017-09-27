Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72DDD202A5
	for <e@80x24.org>; Wed, 27 Sep 2017 06:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750971AbdI0G3k (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:29:40 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:44919 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdI0G3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:29:38 -0400
Received: by mail-pg0-f43.google.com with SMTP id j16so7241877pga.1
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 23:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LndE8z6RKVvgIi/EPfJk2bp+huglLIJZ77751oK98TU=;
        b=gBxjbCXFSU1BR3Ozm0oBu3dgk7JuLeL6gXGHpnRta4sv9tI36Y+xbkq8u6rGBmndDz
         LKNhkm6bj7I+dSWFrKJThmmSB7Nbn4L739BhiTJ6joqA444ZE+d8mCYwCAG4FF+ky4sp
         Nt9Eqt99LHRLioS2pOxP9ro77RBLAst0RTEkD4E/8LgztQgPSAx7D9zKsWbHO24U2CTR
         +qIGtm20wnCIvnrJ21vz2s2u7EQE9dStc2fn3pBQuwZePeYk3C8tbu8A6ohhl+JqVo7e
         cNRi4kvj6Twzw63hrCrzSv923Qf1dobpnkqwFLuUk88hXu1Qvgnyv1tlu+f4kVlyRllC
         dE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LndE8z6RKVvgIi/EPfJk2bp+huglLIJZ77751oK98TU=;
        b=Cw+mFgfjxHhi83lNTHu5qR6mcfAhR4kklVrsHOOQ2HUeBcAIihnE1MNnLpnqZgHXNR
         L8BVsjkSxd3fcLtLOPWtjh4QavTJSHaagpHy55kl5Vv7XBZ7g0spneZr5ZV+jCypIny9
         +J5ijo24GR7+qEZImSDvjCLx49c4vpXYEIScHfGZtlPABfFUpSxgkdqfQIERJvGIILh/
         U/VfRrprga9zTyHm2If+Z2RCfmfVcfQbGGFhVkKLDYoFJmt4GJqVHrga9mKD+ahA+6cI
         Ct+R2QMXQVASt7mM7XHZs3JbNUvHOjixEkneoGCFNG3HgqS31bBbPZloNxsaXIxa0yTa
         /Ldg==
X-Gm-Message-State: AHPjjUjjp48Sf8vq5Fo6cjt9UEVYwUlEQVnHTHyvYE+dwTUCgp/g/wUP
        n+iOutZKo47aTFgXptkqA2I=
X-Google-Smtp-Source: AOwi7QDnPSv8LXWe8EmKx97vIvuPSr/k/ywLdAT4U+zTibiNAOh0UGrNs7jyxbjkNqPMR6sFU72Fsg==
X-Received: by 10.84.244.73 with SMTP id e9mr377650plt.112.1506493778058;
        Tue, 26 Sep 2017 23:29:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id y5sm19011245pfd.89.2017.09.26.23.29.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 23:29:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 7/9] connect: tell server that the client understands v1
References: <20170913215448.84674-1-bmwill@google.com>
        <20170926235627.79606-1-bmwill@google.com>
        <20170926235627.79606-8-bmwill@google.com>
        <xmqqk20k64r4.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 27 Sep 2017 15:29:36 +0900
In-Reply-To: <xmqqk20k64r4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 27 Sep 2017 15:21:35 +0900")
Message-ID: <xmqqbmlw64dr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	# Client requested to use protocol v1
>> +	grep "version=1" log &&
>> +	# Server responded using protocol v1
>> +	grep "clone< version 1" log
>
> This looked a bit strange to check "clone< version 1" for one
> direction, but did not check "$something> version 1" for the other
> direction.  Doesn't "version=1" end up producing 2 hits?
>
> Not a complaint, but wondering if we can write it in such a way that
> does not have to make readers wonder.

Ah, the check for "version=1" is a short-hand for

	grep "clone> git-upload-pack ...\\0\\0version=1\\0$" log

and the symmetry I sought is already there.  So ignore the above; if
we wanted to make the symmetry more explicit, it would not hurt to
spell the first one as

	grep "clone> .*\\0\\0version=1\\0$" log

though.

