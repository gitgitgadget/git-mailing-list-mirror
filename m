Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF39C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 07:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377642AbiDDHUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 03:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiDDHUd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 03:20:33 -0400
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FC1624F
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 00:18:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=Muz6ixxgZLwiP130AjprGmlzUr7HWj3ko343bqXIPZAbUUeypywKSaza0ZcN+k8OxdSmMgd/zZbi8Xq2aZEOERJARFyAGXHxtGc80u/neXjCRbSNc5FKZX6BZ1gw460i6pT0RtpuQaP6SJi51bSzZa/3peI1Ht0DJaXacKao2uIG19+Wzv8Ey4DKnmRZYng4pkQhF/6KHg5N/qnApfDZwYIlbAyqtfAF9ytcnkPv5685EKcOz2Muzkm1FUOiE/xsQPrCFUMv+PS7Ls58JOFQsQzQ7eXZTvrkotzDwgC5xwn/L3IYTneZ29c3X9ZTfBBycbZMi6FKC5gHA+eKfSP3Eg==; s=purelymail1; d=slashdev.space; v=1; bh=4wdzw25l3N9L67DHs6zJBNt+kFuPgmf8Ac5M0xV45M4=; h=Received:To:From;
DKIM-Signature: a=rsa-sha256; b=R33MbF0Ijb8LGyJSBjcYowJkYDdiH6FQzW5X3MvnyobxBt3p7OQDOdIJa610I1/TXaebwIQt0iOoeUU9TDbzzESzhuCnL1+I7UJX0kX2IHOeiAOZT5tSbw8BX7EvThr+I7PT9wnjHOSu5cK9qaXmSgM+/ThykO8fqqtNTrLO/u205p1hxY205xRtNmlCwkSRQzLGp2aZ2jHx7wNeZ3V/XgAwg8jt7VjSutqk0W1YEXfl0eKTYz0ENn6zo4o/w1ap1xgu8/YebqHbetgBROCUXuLCc4jhvMI5ilN14A/JfMioKaqxV6G6xL8o5xLoiEEDlskXeixGS8/7foJ0pPQ4mQ==; s=purelymail1; d=purelymail.com; v=1; bh=4wdzw25l3N9L67DHs6zJBNt+kFuPgmf8Ac5M0xV45M4=; h=Feedback-ID:Received:To:From;
Feedback-ID: 6471:1573:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 754608002;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 04 Apr 2022 07:18:19 +0000 (UTC)
Message-ID: <f39ae520-a370-a1c5-7dcc-1b7bba4306bf@slashdev.space>
Date:   Mon, 4 Apr 2022 09:18:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2] cli: add -v and -h shorthands
Content-Language: en-CA
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <ttaylorr@github.com>
References: <20220330190956.21447-1-garrit@slashdev.space>
 <xmqq5ynv6rb4.fsf@gitster.g>
 <fb915b91-ead2-ac35-4431-ad35674da463@slashdev.space>
 <220331.86tubfrngz.gmgdl@evledraar.gmail.com>
 <f3935840-e2a0-953e-0e7c-ac921d414ddc@slashdev.space>
 <xmqqsfqx28dv.fsf@gitster.g> <220401.86y20pnofb.gmgdl@evledraar.gmail.com>
 <xmqqtubcyeow.fsf@gitster.g>
From:   Garrit Franke <garrit@slashdev.space>
In-Reply-To: <xmqqtubcyeow.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01.04.22 18:02, Junio C Hamano wrote:

> I do not think one extra level of "unknown option", even with hint,
> is worth the trouble.  If we want to cater to those who expect "-h"
> to be more special than random "-<some single letter>", we should go
> all the way and make "-h" truly supported.  If we do not, they can
> read "git help git" just like those who wonder what "git -X" means.

 From what I gathered, we all agree that adding the "-h" shorthand is a 
good addition to the UI. Given that the "-v" option is understandably 
controversial, I could cut it from this patch.

Thoughts?

