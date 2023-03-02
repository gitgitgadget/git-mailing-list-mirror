Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24393C6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 20:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCBUu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 15:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCBUuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 15:50:11 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1925FE4
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 12:49:50 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id d10so224358pgt.12
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 12:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bHVdnoQRU7yO8hud1OKAnTHN1/W/txa+OPlWV9+Rfo=;
        b=SBSuIDKRR/m5XGGhvGsQvEQOaIgmXHzXDlTrTr5wywYmxQU8kRhzp1+Xs7nbyfFLN6
         CYpInR6OHyndYSn/yhJeoq+rNxs2lrRZ0rZVB4PCTJ84151XNe91+AmLH/ihyOOQmz7L
         364V86yaJE+daQoP7AqSIwqZsrTXvd+M4PSZKE4WnDT7F1AqEub0vpen7NsQ1h6gOe1V
         cM+rEY8OIR6de7kHTR/8Nl6HzYEero5zKHeqA8YFexTa8h8Uzy1euAfpJ0dpPsrmkF5Z
         AotypgDrDlKpv1BoOs2dteT3M4Z8uOPlrAEx2eMMlhR7QU2sKdPC3BdJ90qdA57obr8b
         4Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bHVdnoQRU7yO8hud1OKAnTHN1/W/txa+OPlWV9+Rfo=;
        b=RMubrjedIUnGQXNsNHD8bHqfocu35L5J3dfNgponJ/KJlQSQAGd2J5vqhWaeijkUWa
         iOLxPK2eoZ3yL1b/l0CrIt3e3wMCBSWrhl4mycahlrHGGtfTHT3op7SnLgSINRHCFRHU
         8gSr3SFESPzWKcI/lYC8U1edlhoGXb1HEph5aXhcyM2wJYmFp2Uq9zlIiT/flwg2efNr
         B1YYprfgTcdC5WspWMwf8ey6PLdajogQF5WEJEFoVlWXDIY3E6aFSs5x8pHITJH+MWiT
         +HudGdL39IAqNh639otscqdx4CLVXT28bDPmmMFaNTsIEih5tTjDAs3Vw2IO2ayXK4kA
         aV5w==
X-Gm-Message-State: AO0yUKUb50yZv/EapBI3UtAII9UzpB5tBybYGM/spLN+pggKEHuuGC8n
        r3cM3vq8/itKj7WjT8QQe50cGOvAtcM=
X-Google-Smtp-Source: AK7set9ICo6n6Qc5uJBCGX35MbzrFkwk8ZKeqoDUQ6qrndLQ8B1QiDiaL27JQVYolOa/Po9iE4s0Dw==
X-Received: by 2002:a05:6a00:a81:b0:5a8:aa5e:4bc3 with SMTP id b1-20020a056a000a8100b005a8aa5e4bc3mr4022812pfl.1.1677790190375;
        Thu, 02 Mar 2023 12:49:50 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id a25-20020aa780d9000000b005a8beb26794sm111470pfn.132.2023.03.02.12.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 12:49:49 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Git List'" <git@vger.kernel.org>
Subject: Re: [Failure] Re: git 2.40.0-rc1
References: <000001d94d26$1e52a910$5af7fb30$@nexbridge.com>
        <xmqqh6v3j8n1.fsf@gitster.g>
        <001a01d94d3f$04c2e460$0e48ad20$@nexbridge.com>
        <xmqq356mkjp1.fsf@gitster.g>
        <001e01d94d42$c5213b50$4f63b1f0$@nexbridge.com>
Date:   Thu, 02 Mar 2023 12:49:49 -0800
In-Reply-To: <001e01d94d42$c5213b50$4f63b1f0$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Thu, 2 Mar 2023 15:08:29 -0500")
Message-ID: <xmqqy1oej2tu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> On Thursday, March 2, 2023 3:00 PM, Junio C Hamano wrote:
>><rsbecker@nexbridge.com> writes:
>>
>>> On Thursday, March 2, 2023 1:44 PM, Junio C Hamano wrote:
>>>><rsbecker@nexbridge.com> writes:
>>>>
>>>>> Git 2.40.0-rc2 was a regression from rc1. The following new tests failed:
>>
>>I think you are reporting -rc1 relative to -rc0.
>>
>>>>> t3206 - virtually all subtests failed. An example of this failure is
>>>>> a results comparison in subtest 1 (seemingly relating to abbreviation):
>>>>> + test_cmp expect actual
>>>>> --- expect      2023-03-02 16:39:23 +0000
>>>>> +++ actual      2023-03-02 16:39:23 +0000
>>>>> @@ -1,4 +1,4 @@
>>>>> -1:  4de457d = 1:  35b9b25 s/5/A/
>>>>> -2:  fccce22 = 2:  de345ab s/4/A/
>>>>> -3:  147e64e = 3:  9af6654 s/11/B/
>>>>> -4:  a63e992 = 4:  2901f77 s/12/B/
>>>>> +1:  4de457d2c0d218f48d66f45f9b30f3aa62562105 = 1:
>>>>> 35b9b25f76d404d09a23e6c8efa96c3ce19e19aa s/5/A/
>>>>
>>>>Are any big endian machines involved?
>>>>
>>>>cf. https://lore.kernel.org/git/Y%2F+paI8WGSmEbv%2Fw@pobox.com/
>>>
>>> Oh yes. All NonStop variants are big-endian. That hasn't changed the
>>> SHA-1 signatures though.
>>
>>There is a stupid sequence that slipped through the review
>>
>>	char c = structPtr->intMember;
>>
>>	if (c < 0)
>>		... do something ...
>>
>>and where "char" is "unsigned char", the compiler thinks "do something" will never
>>trigger and from there everything goes haywire.
>>
>>The tip of 'master' already has a fix (and no other changes as of this writing), and
>>will be part of -rc2.
>
> Thank you for the really fast fix on this 😊.
> --Randall

Don't thank me.  It was René Scharfe who caught and fixed it first,
which happened a few days ago and the URL above was from yesterday.
