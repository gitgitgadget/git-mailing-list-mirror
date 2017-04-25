Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD0E207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 02:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980036AbdDYCbN (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 22:31:13 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:33588 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964919AbdDYCbK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 22:31:10 -0400
Received: by mail-it0-f45.google.com with SMTP id 70so17575588ita.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 19:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ScJtiC/JpwQULV3rIPu0iOieuDBomv6Obctxm57YFf8=;
        b=ibwkelu3HB8yKqoq3CFpOJE9MKjWlhBeEH7qCdLZQFRK5LdboRrdE7K55OKHc0Zs/6
         AUpN6AwIcM5ERFANaG67sHYOsWXOphdvAhqZncKw4QlZBhu5LaYVHVaK2IfZUqUZxvPp
         m6LG6ikJO48aQ+qT3eD49cnuI/fe7S2+EW62wEJzLoTEQjK/qhu8nbrZoQpq3us5it7R
         MqJivXNB4CEemMWIdStoeeZ893my6hdiGE1HORFWHKkzmXm5ehZ40ar5Q9reyf1OiJNr
         ATCkc0i3K/EvDUbq1fC5QEivPhQDYmdz0PdZiLX/lddeutD227Mf0/g3oqDPh7oYJyWd
         Y2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ScJtiC/JpwQULV3rIPu0iOieuDBomv6Obctxm57YFf8=;
        b=cvKdl1qZNeU/++3cZ6XaXJyR0HTJXz1p6pVUo9m3AiHD6vkocOG80EuNFHKFUX/mcw
         8ifLFbQCd/40fDTlYBTGd8WbXe0oRQiAIDxbmYAf/lV4Q/6EKLS08GCZkuI0vAnZeFsx
         Yyo75y9kvxIjyDWcPYSpbowQFpFLBeKPKppmgOwKGbPni843B69Q3rkKr4/8//oLIBiA
         rngB8/Xe1SBNFvFp24KzFbV/Ti1Wcok6P7T6po9hQHCjo3usI13JgeyAOfb6e/EunHFU
         EANwM3UDeb7s6gbWk4rE1vOoIGbFHh7AIdeSL7R9vA966ZU/VyR3/F2Wzt+6VBqYjKA1
         VWng==
X-Gm-Message-State: AN3rC/7w546RH3m72whCQsj4djN33k7nLKXIsqCtCGWpcjbsK25zADQS
        MGmjjkowgNnpmA==
X-Received: by 10.36.101.210 with SMTP id u201mr18630007itb.118.1493087469533;
        Mon, 24 Apr 2017 19:31:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id y127sm1289959iod.15.2017.04.24.19.31.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 19:31:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: abort when can't remove trash directory
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
        <20170420165230.5951-1-szeder.dev@gmail.com>
        <20170421201527.wdtxhox3p4g35gex@sigill.intra.peff.net>
        <xmqqk26a4q69.fsf@gitster.mtv.corp.google.com>
        <20170424014339.nuh7ixlqudfnftzp@sigill.intra.peff.net>
        <xmqqwpaa1pgb.fsf@gitster.mtv.corp.google.com>
        <xmqq60hu1mhq.fsf@gitster.mtv.corp.google.com>
        <20170424075241.ybbq2cpvbmwtdwz7@sigill.intra.peff.net>
        <18ee407c-db3b-16a2-4822-0ff302045b27@web.de>
Date:   Mon, 24 Apr 2017 19:31:07 -0700
In-Reply-To: <18ee407c-db3b-16a2-4822-0ff302045b27@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Mon, 24 Apr 2017 11:39:26
 +0200")
Message-ID: <xmqq4lxdxlp0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> []
>>>
>>> -		cd "$(dirname "$remove_trash")" &&
>>> -		rm -rf "$(basename "$remove_trash")" ||
>>> -		error "Tests passed but test cleanup failed; aborting"
>>> +			cd "$(dirname "$TRASH_DIRECTORY")" &&
>>> +			rm -fr "$TRASH_DIRECTORY" ||
>>> +			error "Tests passed but test cleanup failed; aborting"
>>> +		fi
>>
>> Yeah, that looks good to me.
>
> Does it ?
> Checking the error code of "rm -f" doesn't work as expected from the script:
> rm -rf DoesNotExist ; echo $?
> 0
>
> I think it should be
>
>>> +			cd "$(dirname "$TRASH_DIRECTORY")" &&
>>> +			rm -r "$TRASH_DIRECTORY" ||
>>> +			error "Tests passed but test cleanup failed; aborting"

What Peff told you in his response is all correct, but besides, you
can see the patch and realize that the original has been using "rm
-rf" for ages.

This change is about not using $remove_trash variable, as it felt
brittle and error prone than detecting $debug case and removing
$TRASH_DIRECTORY.  So in that sense, I shouldn't have even rolled
the removal of basename into it.

Having said that, because people care about the number of subprocess
invocations, I am tempted to suggest doing

	cd "$TRASH_DIRECTORY/.." &&
	rm -fr "$TRASH_DIRECTORY" ||
	error ...

which should reduce another process ;-)
