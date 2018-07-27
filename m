Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044CE1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 21:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbeG0XDZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 19:03:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34991 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389583AbeG0XDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 19:03:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so6372727wrt.2
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KuQKBG/lprvf0uqBkiXKNiMCnZDX9ZB4gc2psHA5zGY=;
        b=QBTedpa/cGE1lZiaOpVlbJFcXCf3/A2yAB3JIJ50qVmj8LbbTBSzwBeITynRgN3Wwv
         Gq8r6Ij9h4X7DnQjAJLau/xGx92QhZ9CvB5ATV9m3rs00AP26TwVwjg0sSBKwX9FIAgk
         SQyBMgwvbp+qTjhMT2k7GdjMFkXFsv+3FE/phHVq6pxIkDsc7tE+jqy8skUAUeXq8L0l
         rethDNXj7PrEiD7b5UKMXR0Ir5FZdG1KCgSilxWDCRMZ0AThRHPo9sVI3akb/RzUJYps
         ISVc9bSjWuExUJCloj70XmCobSzsVEq1b54WknOIo+1EPPYx54O6WFaDbcI2XN+PJp98
         +avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KuQKBG/lprvf0uqBkiXKNiMCnZDX9ZB4gc2psHA5zGY=;
        b=Ugz0FUSXf7856RqVhYqTBWExgiNS0uhwsel446+GQoqBzmKLuT6pW3id87lLldTvuN
         RvW4xhKpPBOdfOB8Ww0fCgSinMSmlubtllbgY8Wx0d9Uq3t0xQXE5GJSpCMI7kpt6YkH
         aWwYc4Rc46+E3tkk24q303tdZ27n5uvxlzlF7JtneykkAN3+uYxIXBy1Zuu3AOm9hNaP
         ygiwCscJ2WBg/FExeZ3XaY/P6SGl52PdzIWOD926Rn6khtT/Gsw0TUfN/LlrTcfNkHRs
         qyLRD5KwJOs2+cqexB6lrae2gbyxm7dPNSd3ZZZh7E/xIlcvt+oChdmAm3YpJ8I9VxYO
         qZeQ==
X-Gm-Message-State: AOUpUlFzhAB7+DHM87FvhzeQsvDCeZSk50lqaQTAtcH1vlfns7Y43mma
        eQW2I7JujKAHAJT/vvtAokfMMs0A
X-Google-Smtp-Source: AAOMgpenXpw+ALg/MamaSrcDu5fPOkT6IOAHGxdE+SX/992sPfSs3k8RAHPQfcwr+LNOFjdoN/m50w==
X-Received: by 2002:a5d:6a03:: with SMTP id m3-v6mr6315166wru.192.1532727576801;
        Fri, 27 Jul 2018 14:39:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j131-v6sm6075306wmb.35.2018.07.27.14.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 14:39:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] config: fix case sensitive subsection names on writing
References: <20180727205117.243770-1-sbeller@google.com>
        <20180727212140.GA54208@google.com>
Date:   Fri, 27 Jul 2018 14:39:35 -0700
In-Reply-To: <20180727212140.GA54208@google.com> (Brandon Williams's message
        of "Fri, 27 Jul 2018 14:21:40 -0700")
Message-ID: <xmqqfu04l5ns.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Either way you're probably going to need to be careful about how you do
> string comparison against the different parts.

Good suggestion.

>> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
>> index 03c223708eb..8325d4495f4 100755
>> --- a/t/t1300-config.sh
>> +++ b/t/t1300-config.sh
>> @@ -1218,6 +1218,24 @@ test_expect_success 'last one wins: three level vars' '
>>  	test_cmp expect actual
>>  '
>>  
>> +test_expect_success 'setting different case subsections ' '
>> +	test_when_finished "rm -f caseSens caseSens_actual caseSens_expect" &&
>> +
>> +	# v.a.r and v.A.r are not the same variable, as the middle
>> +	# level of a three-level configuration variable name is
>> +	# case sensitive.

In other words, perhaps add

	# "V.a.r" and "v.a.R" are the same variable, though

and corresponding test here?

>> +	git config -f caseSens v."A".r VAL &&
>> +	git config -f caseSens v."a".r val &&
>> +
>> +	echo VAL >caseSens_expect &&
>> +	git config -f caseSens v."A".r >caseSens_actual &&
>> +	test_cmp caseSens_expect caseSens_actual &&
>> +
>> +	echo val >caseSens_expect &&
>> +	git config -f caseSens v."a".r >caseSens_actual &&
>> +	test_cmp caseSens_expect caseSens_actual
>> +'
>> +
>>  for VAR in a .a a. a.0b a."b c". a."b c".0d
>>  do
>>  	test_expect_success "git -c $VAR=VAL rejects invalid '$VAR'" '
>> -- 
>> 2.18.0.345.g5c9ce644c3-goog
>> 
