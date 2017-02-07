Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89CEA1FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 20:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754977AbdBGUGv (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 15:06:51 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36022 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbdBGUGu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 15:06:50 -0500
Received: by mail-pg0-f66.google.com with SMTP id 75so12945182pgf.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 12:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8Cygk7yGXC1rq/WzzIGiZoU25YbOKdVbbFQZzrvMfCE=;
        b=d57+YIdsdoRVKpXWE6DfUnJjq4mpw3LxZLqOXPAOzfovcxgHtRVgxGa0lfw0+lneB4
         r0QEn3ZUEp2jDCTkd8mk6XUqZ7X7GUFFQ7oyvz2mNxy2IKTBaO92GtHgZ4mVutYR34YS
         cGzZei5YAGH0cUHpaGy/rBuEF1DsxjMZVhcwSZ2c10clSvEvewHBEaSw1fagtmDBhaYM
         TfuK5f9YAZpwNGKy+U9h4L2dMsbpEs7VRdHh4DhYmT8sXLhka2lg0st/STtRMWEhTECY
         m16BdnRdq/56NO0Y6Mvu2rXkk3L9YGChRd1tUvgOMIyC47lsq17mxc/i72AmnCqXAbGX
         OMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8Cygk7yGXC1rq/WzzIGiZoU25YbOKdVbbFQZzrvMfCE=;
        b=YMr65OF41Se87qpZ3RWCmV5+SISjLFBuXsTUJfZmI+ljGrQ6x6YbgcmNwHkdQKLp4j
         jDgQVkIVeSLEZunDYmUqtYEPoKNP+CLddpW436FN1gqCXWZad9bx06mBMF+wOqTUmf7d
         B9ztrlDiTLr3vz2ZPW001RS1ruweBV+h9Pyl4zTdFVMf8wpnO3AMdz5JMBrTdx7mf4Lj
         a2mLKXMM2nKGvmT1nc3ByxL22ni/6qOTfbQelklP84sEgm1J0h4kaJ+niDwBGbp5Zngz
         780Ponasss17MJwqHI0Z23TnhmXDE6TosRDy22wbdyD6DiTERpkaB1d719SHuLDdFXco
         rZHQ==
X-Gm-Message-State: AIkVDXKhp85CfCyuWwinWYQoI77xe4KT7dIPc7px2IHZj5iEhUKnMTRu1oaogmjbJBhXbA==
X-Received: by 10.98.56.196 with SMTP id f187mr21956795pfa.131.1486498009722;
        Tue, 07 Feb 2017 12:06:49 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:1564:f4f3:f1b4:c9b2])
        by smtp.gmail.com with ESMTPSA id o12sm13707268pfg.15.2017.02.07.12.06.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Feb 2017 12:06:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     David Aguilar <davvid@gmail.com>, Git ML <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] difftool: fix bug when printing usage
References: <20170205201751.z4rfmy5xxaqg472l@gmail.com>
        <20170205212338.17667-1-davvid@gmail.com>
        <alpine.DEB.2.20.1702061716120.3496@virtualbox>
        <xmqqinon2nnt.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702071220290.3496@virtualbox>
        <xmqqh945zs3c.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 07 Feb 2017 12:06:48 -0800
In-Reply-To: <xmqqh945zs3c.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 07 Feb 2017 12:03:19 -0800")
Message-ID: <xmqqd1etzrxj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> > Likewise, this would become
>>> >
>>> > 	GIT_CEILING_DIRECTORIES="$PWD/not" \
>>> > 	test_expect_code 129 git -C not/repo difftool -h >output &&
>>> > 	grep ^usage: output
>>> 
>>> I agree with the intent, but the execution here is "Not quite".
>>> test_expect_code being a shell function, it does not take the
>>> "one-shot environment assignment for this single invocation," like
>>> external commands do.
>>
>> So now that we know what is wrong, can you please enlighten me about what
>> is right?
>
> David's original is just fine, isn't it?

I've also seen people use "env VAR=VAL git command" as the command
to be tested in t/ scripts.  You can run that under test_expect_code,
methinks.
