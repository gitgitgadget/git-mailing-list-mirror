Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45E1F1F462
	for <e@80x24.org>; Mon, 27 May 2019 15:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfE0PoK (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 11:44:10 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:35865 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfE0PoK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 11:44:10 -0400
Received: by mail-wr1-f43.google.com with SMTP id s17so17311766wru.3
        for <git@vger.kernel.org>; Mon, 27 May 2019 08:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2A4/Dy7CeUNWJQHbbLk0HO1r8qYMXPrMtWyOg+ikpyk=;
        b=EH2z9mVd1rQDD7pGoqcmQYuf2V3S3BRxvb9u1fIF+t787j7GXynwJnEpzCHgYXCAfC
         RTslgBG7jWnXFzM1LRB3CN1OcJ83SjnUNP6R484qsIE1vroTTsunL4vj6tv70zOFnA/2
         2F8Q/wSsEW8wuZPZvHpYh1E85rrChC/gAXZcte3TFL/T5JrJ1EwPCJyykr49kr2uqhkQ
         0fGlv+J/xaVV4SH2py8N3FfFaVX/jTyBi8CjQsVL1Yxpuqj6sSDxQ9vS1VuaRxtgKPn8
         S0nFIzN6Liyb8wNuspDTngK5plN1kh3LH2Fx/xOTEKT+nx7z1i1uRLnKNAiWB5WCE+8e
         64Dw==
X-Gm-Message-State: APjAAAUgnsm0lK0x/20jx9roeXDDjJAAAXWRqYIZuOAs31WLQEi+h6N7
        5/kUUC/H7OzH35B2pLpklaukPA==
X-Google-Smtp-Source: APXvYqxek10K/dO9NSTEttg+mnORuKnxwc7jyGofKaHXmyE/ma/6TRaCxUAv7G+DGuJ8bDopIl1MFQ==
X-Received: by 2002:adf:ef8d:: with SMTP id d13mr6429556wro.60.1558971848967;
        Mon, 27 May 2019 08:44:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c92d:f9e8:f150:3553? ([2001:b07:6468:f312:c92d:f9e8:f150:3553])
        by smtp.gmail.com with ESMTPSA id s62sm22814951wmf.24.2019.05.27.08.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 08:44:08 -0700 (PDT)
Subject: Re: [RFC/PATCH] refs: tone down the dwimmery in refname_match() for
 {heads,tags,remotes}/*
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <CAHk-=wgzKzAwS=_ySikL1f=Gr62YXL_WXGh82wZKMOvzJ9+2VA@mail.gmail.com>
 <20190526225445.21618-1-avarab@gmail.com>
 <5c9ce55c-2c3a-fce0-d6e3-dfe5f8fc9b01@redhat.com>
 <874l5gezsn.fsf@evledraar.gmail.com>
 <xmqqef4jewj6.fsf@gitster-ct.c.googlers.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a40c5388-4274-6bfa-4213-6013601c8fae@redhat.com>
Date:   Mon, 27 May 2019 17:44:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqef4jewj6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/05/19 17:39, Junio C Hamano wrote:
> I do not think lightweight vs annotated should be the issue.  The
> tag that the requestor asks to be pulled (from repository ../b)
> should be what the requestor has locally when writing the request
> (in repository .).  Even if both tags at remote and local are
> annotated, we should still warn if they are different objects, no?

Right, lightweight vs annotated then is the obvious special case where
one of the two is a commit and the other is a tag, hence they ought not
to have the same SHA1.  I'll take a look.

Paolo
