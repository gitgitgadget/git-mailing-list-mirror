Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55C61F462
	for <e@80x24.org>; Tue, 28 May 2019 01:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfE1Bnz (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 21:43:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44812 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfE1Bnz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 21:43:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so3282976edm.11
        for <git@vger.kernel.org>; Mon, 27 May 2019 18:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=79JLntXBxI5rcJznIuYI3wmslCr8VASIlZWiLEVbmvc=;
        b=CJlVqCXSI3dJDDO9XHqYMKgdJdNMDKS70kQn7FNfKmAaNQ/1m84eafRJb43d4QHAKR
         PBw9JVyAZe3WwzRUVx0uds2K0JR+eWHOMvKVQrXk1gR/rGKiWfG6XXggAVvFTJoEbJ2V
         icYce521ahYqYfogE29gQ4zDxWR7i3hawQ7vKUeIyOEa4yHssnI/+cJWedg7K5dRysXX
         4tMxW8m+V5eJNWoYevRW3tohB0N6Shx6Af8QVYectb+pVaE1cNsIqIfxwz1vw92SrTtQ
         qAYvACDIZFgFMxgvYLAMwzFdmrl04U6vKEkTKQIqunWalsTzOsQPMPPVIK7GudpryZho
         cQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=79JLntXBxI5rcJznIuYI3wmslCr8VASIlZWiLEVbmvc=;
        b=MVoslacsCMYZAmbleWk062Y3S5Tyi6/5iu5eYVgklWgi8VDM7LkjmuXZjjui9Tj87m
         6ra0mwB8ZPC2XBIEsrcqVqhqCyw4MRXMjxKYbWxhcTA0Hw/YmlbgSIJ8b/P5x9EOwpir
         qZeuDb66gIHmj3R/Wmp6XxfTLZKnxd1JRlohvQpAzRjDMehiiFcW9u92DCsBBa8XmElE
         U9HqUrcsgHQBxsA97Lv0XNZe6425xMER1UsSrvdihnMTmNL6WK+u1cm4dw8ITMsInFhc
         +jb2M7jH4Ay04NSIVOaXhZRAlvouoM0gnN4ni1ccn6Lv+P6cYJlvUvzF8/GQWEG0W908
         rhvA==
X-Gm-Message-State: APjAAAXfEyk0PhgkFYy3xMgNO6WytPtFLUiZWNSp+KTaGtv7LCxwPigZ
        3Gc9t5+od9RgjaAMHwBj2gE=
X-Google-Smtp-Source: APXvYqyaPhjls0aprZQYcUaGjdbbL4h9Wkb5RwoXN3x+vRsJ//qc1z4/21jpBQZHUNQCzD7GTBuLDQ==
X-Received: by 2002:a17:906:3586:: with SMTP id o6mr81158665ejb.253.1559007833595;
        Mon, 27 May 2019 18:43:53 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id e35sm3828826eda.2.2019.05.27.18.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 18:43:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Todd Zullinger <tmz@pobox.com>, Chris Mayo <aklhfex@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] send-email: remove documented requirement for Net::SMTP::SSL
References: <20190526172242.13000-1-aklhfex@gmail.com> <20190527193517.GA22013@dcvr> <20190528000544.GX3654@pobox.com> <20190528013128.ynvvci4ul2exiyef@dcvr>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190528013128.ynvvci4ul2exiyef@dcvr>
Date:   Tue, 28 May 2019 03:43:51 +0200
Message-ID: <87h89fmjzc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 28 2019, Eric Wong wrote:

> Todd Zullinger <tmz@pobox.com> wrote:
>> I wonder if it's (separately from this change) worth
>> adjusting the conditional which sets $use_net_smtp_ssl to
>> use "Net::SMTP->can('starttls')" rather than a strict
>> version check?  (It might not be if using 'can' is too
>> fragile or would only benefit the Red Hat 7 packages which
>> likely won't officially be updated to a newer git with such
>> a change.)
>>
>> Something like:
>>
>> diff --git i/git-send-email.perl w/git-send-email.perl
>> index 24859a7bc3..84ac03994d 100755
>> --- i/git-send-email.perl
>> +++ w/git-send-email.perl
>> @@ -1465,7 +1465,7 @@ sub send_message {
>>  		}
>>
>>  		require Net::SMTP;
>> -		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("2.34");
>> +		my $use_net_smtp_ssl = Net::SMTP->can('starttls') ? 0 : 1;
>>  		$smtp_domain ||= maildomain();
>>
>>  		if ($smtp_encryption eq 'ssl') {
>
> Looks much better to me.

Same, but to bikeshed a bit, at this point we can just do:
    
    diff --git a/git-send-email.perl b/git-send-email.perl
    index 24859a7bc3..4ad2091a49 100755
    --- a/git-send-email.perl
    +++ b/git-send-email.perl
    @@ -1468 +1467,0 @@ sub send_message {
    -               my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("2.34");
    @@ -1485 +1484 @@ sub send_message {
    -                       if ($use_net_smtp_ssl) {
    +                       if (Net::SMTP->can('starttls')) {
    @@ -1507 +1506 @@ sub send_message {
    -                               if ($use_net_smtp_ssl) {
    +                               if (Net::SMTP->can('starttls')) {
