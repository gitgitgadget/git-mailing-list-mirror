Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2CFC3524E
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DAD207FD
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFRqcL87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgBSVFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:05:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59157 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726875AbgBSVFr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 16:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582146345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DKRqWR9mJH4C0dQ3kK7SeGlg/BHIRvss5H06oeeFD84=;
        b=AFRqcL87YteiDb6ZrkG/vOsno56+wyjM0i2njyjTq3RHzSl8xzWIViqIP4LA6g0YIRowU2
        S5LBIPGM779oOB+ShmM8mSTuXOYSAzqe1GA3Bre/NtKLwhxu/6sK55jK93ZBWCvJuAanxL
        RSztUJGrg30UPf2oOasSmCz9cZBWCzQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-BdIwWYnCMkWJnaoAUlWbLQ-1; Wed, 19 Feb 2020 16:05:43 -0500
X-MC-Unique: BdIwWYnCMkWJnaoAUlWbLQ-1
Received: by mail-wr1-f70.google.com with SMTP id p8so713370wrw.5
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 13:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DKRqWR9mJH4C0dQ3kK7SeGlg/BHIRvss5H06oeeFD84=;
        b=X1Hg6fx2APbFhFlrcGwoFgpWt3pHUZEg6DTaPzxPsKHzEnBWZ+QxF2ja9n7Gl77h34
         k68Y77g9odcMw9K3umn7u3Ejy78yQsAJMkAjim8RLh6EHXgEm3wnlDQD8vBeHjW0pNmU
         eXnqXY38DnE6z/Bj2dN/Uu6so/sY5+6JM8yyL/Uavu1syjpbwEJ8fh5IrDpsCgKz0/9W
         BfktyjmVAfq8FH/P/hjjma3uA47rGDamisKelfTgy9O3h+RjNXZ3hXKKGuKH7bQutrrY
         7SPrAI6GecKqJin9Z9ujAt0hfzfSKQhQVjFT5oKUSildiUZjIGY4aqIEDiJfAWljpluU
         JV9Q==
X-Gm-Message-State: APjAAAU7qJ2pvOOHP8pYnXtikuhxOQATHX6e/wxdOKHKaQG3rC9Rrzp+
        CNoioI1+mTUY34Mvj8my/JbI67+eT4Qju7BDcuLPy8/Ye1PpsJQYyRSFQPjMj3O2CSPyoq27bWn
        +Nd24EQm5rrb6
X-Received: by 2002:a1c:9602:: with SMTP id y2mr11826756wmd.23.1582146342553;
        Wed, 19 Feb 2020 13:05:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMaUHuDDsa8C51hnq1eAi5AJWp4MHyj0+3kddgv7qwrTFaKSxxE6mzQYYJEb3YbKV4uvh3Jg==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr11826742wmd.23.1582146342297;
        Wed, 19 Feb 2020 13:05:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ec41:5e57:ff4d:8e51? ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
        by smtp.gmail.com with ESMTPSA id v131sm1375142wme.23.2020.02.19.13.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 13:05:41 -0800 (PST)
Subject: Re: [PATCH 1/4] parse-options: convert "command mode" to a flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bfields@redhat.com
References: <20200219161352.13562-1-pbonzini@redhat.com>
 <20200219161352.13562-2-pbonzini@redhat.com>
 <xmqqzhdee6c6.fsf@gitster-ct.c.googlers.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea9395db-b39a-358f-df8e-b28907193415@redhat.com>
Date:   Wed, 19 Feb 2020 22:05:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqzhdee6c6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/02/20 20:15, Junio C Hamano wrote:
>> OPTION_CMDMODE is essentially OPTION_SET_INT plus the extra check
>> that the variable had not set before.  In order to allow custom
>> processing, change it to OPTION_SET_INT plus a new flag that takes
>> care of the check.  This works as long as the option value points
>> to an int.
> It is unclear but I am guessing that the purpose of this change is
> to make "only one of these" orthgonal to "the value of this option
> is an int", in preparation to allow options other than SET_INT to
> also be combined with "only one of these"?
> 
> If my reading is not correct, that would be an indication that the
> above paragraph does not tell what it wants to to readers.  

Your reading and your conclusion are both correct.  I'll reword the
commit message.

Paolo

> It is unclear at this step what other kind of option the flag wants
> to be combined, though.
> 

