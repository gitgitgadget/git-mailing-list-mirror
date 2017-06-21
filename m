Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A749120401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdFUVqq (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:46:46 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35502 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdFUVqp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:46:45 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so30119558pgc.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ju0uIylD28a9WCaZpVXuhDTr03erK3XswDfVfxz2l1E=;
        b=I/fURhKWdaWGSosoN9EZ/kFsx8ezJsly2otPAihrZjTVp3xbOOdVLS0D2u7M0uWKYn
         58XShXslMqS8tYpVej427HXokA0gc6bJdnlH4K3A+XmdoPhPt4LoL/TGEwNP/t//p6Ko
         4dPBRNUz8IvH2kz76j3Gq7U/CE1TuV4nA4/mGbL776yBO3zerFqwMcmmOnVf1G3IPCF3
         /YU36ehr/BkQiLZYJiBR0TDt1QhxAU7wPRgGzooo/LPsFIVNvsl+JJt5XjEbE9CnXMjW
         viyPlCSY75sQrlDNhgg0aDK/j6RLUIlN+cTgvFK6Ke8BHY1qh8y3ji8tOAs+qPMYL8dK
         cpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ju0uIylD28a9WCaZpVXuhDTr03erK3XswDfVfxz2l1E=;
        b=syPFb7ANnZ6yFzfIPKko82k4Qppnwgj76Zv0ckJM1h4xnJzXwj5kvi0y0cv+4qseTP
         EFZdGbY8NOFumnpzTsbldcaeTg2jPn5oUToRCPEYWk7IGZRQ78bzCn7v1SnOaY0DV+oq
         7teqLgwzrqSSlmzh0PdiujNbaNRr34gdFC7TkuQ6PYivaGKZ9ajMDRWtJQRsT6/sb2uw
         tLmftmrHP0HNoZYt2X2rudseLGoCo+bvPpu6oE6aQc17IXS5o/hzIP/6bLqRsLmrEYOm
         zg0pmaHmSVQ/KUwywnliFzktekB8sQvoBhbNPkhaE4ffPXkWNS7ZEOZZvUKYKPHJRs5j
         6LZw==
X-Gm-Message-State: AKS2vOzGEFg8ZamhJxtxFlvSFeV8ugUIilzdhyMrLk9IaNob0jIdLVT3
        gfMpWotwXFqeMg==
X-Received: by 10.84.212.137 with SMTP id e9mr44746856pli.115.1498081604396;
        Wed, 21 Jun 2017 14:46:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id q6sm35674512pfi.129.2017.06.21.14.46.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 14:46:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Kyle Meyer <kyle@kyleam.com>
Subject: Re: Truncating HEAD reflog on branch move
References: <20170621213924.wh43i2h7v2zwihq3@genre.crustytoothpaste.net>
Date:   Wed, 21 Jun 2017 14:46:43 -0700
In-Reply-To: <20170621213924.wh43i2h7v2zwihq3@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Wed, 21 Jun 2017 21:40:51 +0000")
Message-ID: <xmqqpodxm2t8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I get the following on 2.11.0:
>
> 2cbfbd5 HEAD@{0}:
> 2cbfbd5 HEAD@{1}: checkout: moving from cPanel to master
> eaf8db2 HEAD@{2}: checkout: moving from master to cPanel
> 2cbfbd5 HEAD@{3}: clone: from https://bmc@git.crustytoothpaste.net/git/bmc/homedir.git
>
> and this on a recent next:
>
> 2cbfbd5 HEAD@{0}: Branch: renamed refs/heads/master to refs/heads/new
>
> For this test, any repo will work; I just picked this one because it had
> two branches I could use to generate dummy reflog entries.
>
> A colleague reported this to me as a bug.  I don't see anything in the
> release notes about this as a desired behavior change, and it does seem
> undesirable to truncate the reflog this way.  If this isn't intentional,
> I'm happy to work up a patch.

I do not think either behaviour is intentional (old one that gives a
meaningless empty entry probably is probably not what we want, the
new one that truncates is not what we want, either).

