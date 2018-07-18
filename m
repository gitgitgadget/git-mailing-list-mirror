Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0C771F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbeGRRp1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 13:45:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34722 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbeGRRp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 13:45:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id l2-v6so1873305wme.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VQPsVRfCKDB4g/RuieHX5TJtWC4bElCQMbnby+JfE+A=;
        b=HcnZ7cLFe1s3oVTI1lwt7voDMujo4irOowrd01O+uoMhfY56Ao1t6zNcGH1NgeiPFk
         GAZ500578R3RIuX5UoEI3fBcNKABveqKvEJ6k0+eJSGZQ1FCdgy7r39k5zXoL1Rl5dcR
         rMjlms8bqanyQ9cAodk3831c4ngH+H9GUT0RGKiQhKeoK1/9Z/fux9FLr8hqm2Yo7bzT
         ignNMjpiKOG5Rx3l+JXk0GLy3jDutCxWHIFXOHeNDs+kGzAmGNb3cy5afuOGdZi89joH
         e7KxnQtF0Ts/nQofUiVALjFaF4vUniOFqpd5oZ3vpcpadv4ZmZ6O+wj7k3E4A3M14ETP
         bcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VQPsVRfCKDB4g/RuieHX5TJtWC4bElCQMbnby+JfE+A=;
        b=Aul/QK677MTb2ev0JC5VSlYdOr4S0Yaufagy9EjIdTaFKQ5/n10EdS8cIcG48uIUlP
         mBupenwslOFzXbwq3zlRX+nv9cBYuvf+nc4V1QORC6qpAeYNnYcNhVRW4fU9pFQ2yE1A
         8F3K63h5XD4qwyUFKrPYcyLPM6v0fSY8Dsp+hAlcjnMDBOvFYDlo95yRjdmXcxq8OpxT
         zorgAYSES3C9fqpLYEavJvkSl4N8eYCeghCpIrFVR5+yfIQEh7KT5V93DciB0F2X/yI0
         waI7XkfiYgBBe+zMZck3XN0tGJaSRdOEkDV9crApfT+4wQp3U5dixpJa5pdda9ndbtlK
         eK/w==
X-Gm-Message-State: AOUpUlFFy0y8gmzOgcLTe9cChNTgTm5VR6IKY7+wzL2u/7IRWPIYetnE
        +SkuZKQ0b6EVl7dtvNowWxA=
X-Google-Smtp-Source: AAOMgpc65lN0ttZvNp4N3FPvbNVeop0nvnM6Eh9e6XeCbbHzHl7E/QiGcuMbLS5LUa3qDjcaCMox+w==
X-Received: by 2002:a1c:568a:: with SMTP id k132-v6mr2056429wmb.89.1531933595087;
        Wed, 18 Jul 2018 10:06:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u14-v6sm5504188wrs.57.2018.07.18.10.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:06:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 7/7] gpg-interface t: extend the existing GPG tests with GPGSM
References: <cover.1531831244.git.henning.schild@siemens.com>
        <cover.1531831244.git.henning.schild@siemens.com>
        <74d979ec0779b60d04e5dc7d2351783451e30eb4.1531831244.git.henning.schild@siemens.com>
        <xmqqefg1mtvr.fsf@gitster-ct.c.googlers.com>
        <20180718123617.55acfd3b@md1pvb1c.ad001.siemens.net>
Date:   Wed, 18 Jul 2018 10:06:34 -0700
In-Reply-To: <20180718123617.55acfd3b@md1pvb1c.ad001.siemens.net> (Henning
        Schild's message of "Wed, 18 Jul 2018 12:36:17 +0200")
Message-ID: <xmqqbmb4lbhh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

>> > +	unset GIT_COMMITTER_EMAIL &&
>> > +	git config user.email hasnokey@nowhere.com &&
>> > +	git config user.signingkey "" &&
>> > +	test_must_fail git push --signed dst noop ff +noff &&  
>> 
>> This is OK for a test that is known to be always at the end, but
>> also forbids others to further update this script to add more tests
>> at the end, as the standard setting of environment is blown away
>> (the config is probably OK, but test_config to arrange them to be
>> cleaned up would have been nicer), which is not very nice.  I think
>> it should be easy to fix it when it becomes necessary, but at the
>> same time if it is easy to fix, then probably we shouldn't introduce
>> a breakage in the first place, so I am on the fence.
>
> Switched to test_config, this is all coming from copying the previous
> tests, which i left as is.

I was specifically talking about the unsetting of GIT_COMMITTER_EMAIL,
not the configuration variables.

An easy way to try one step without the environment without
affecting later tests would be to run the above in a subshell,
perhaps like

	test_config user.email ... &&
	test_config user.signingkey "" &&
	(
		safe_unset GIT_COMMITTER_EMAIL &&
		test_must_fail git push --signed ...
	) &&

