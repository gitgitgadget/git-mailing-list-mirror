Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1945203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 17:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932952AbcLMRvN (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 12:51:13 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34329 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932409AbcLMRvM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 12:51:12 -0500
Received: by mail-qt0-f177.google.com with SMTP id n6so114209775qtd.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 09:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=1Tk+QkTT2xlXaWcWkrCVX4g3OIfFQsmCD/QL6uMDMtw=;
        b=iiN5YONBAnmoPWvOjVI8LP6bnEiOcrkgWxWYNDXrkiaX0P01f2JcqAu5MdEFlsupeZ
         35fexJNbnPn8aWD4N9wSqmVCRudcn3oYpETurWuWp524nKittfpy6GlP8/b0ZRk3f84s
         onbKlRteweS/CG1j7//9FWrN++jSW+CgP+V8Zqg/yQyDoOFwqFCtvbm4wSEDoJVbgOSl
         61WxuLJ+0xsOQ/orNFtr9LPmC8SA3MIm9QE2jauLqpJJ4ADdRkAY5yGcFkmPYMCtHQQ6
         oH8xeKjhLANey7d62Xe0geAXLeh63WjqiosPPcHR/N/nQWM+UJVJZIrXAuS0oIBne1mB
         0H2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=1Tk+QkTT2xlXaWcWkrCVX4g3OIfFQsmCD/QL6uMDMtw=;
        b=EsYFcENkWjyCBgXQ7nAVD0Wt/qMu2IgJjE6QnsxAs/SeXb3PeOihkFziK0uvotoh/X
         MZZvi8MAF8spoP0P6osS3Rr1jDUSl6pHmrmVMyatS9Z+9fZOTMs29JKvLi+7ocCDrB6o
         r7FQ0nHODqgvQ370EshtfzTDbucuXFvyypdKVZFz88Xv1bceXMJlXYV1J5WdN0hZcyEh
         lCG3ifYlPPsx20Eyrdl44vYMmZ23vlFZfRWMfqO4iSQs6XdcpBYX51LAfxXNWXAtAKpo
         Xtr/LdG12UY+PXngclQN5OHAhtPBxcMRq4epPt0SjOHs9WW4z90o4VXON5XrRAVVkjr7
         zPnQ==
X-Gm-Message-State: AKaTC02KSbOY0uJljLtgDur9PuxMhTbYklAobUwSmh4QsZmPyK4K0jOw/rfqDVZyANIqQQIfRVX2VgtNfJ0PYIxc
X-Received: by 10.200.50.53 with SMTP id x50mr85016196qta.207.1481651471549;
 Tue, 13 Dec 2016 09:51:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 13 Dec 2016 09:51:11 -0800 (PST)
In-Reply-To: <20161213032848.4ps42jinix6fdgdc@genre.crustytoothpaste.net>
References: <20161213014055.14268-1-sbeller@google.com> <20161213014055.14268-7-sbeller@google.com>
 <20161213032848.4ps42jinix6fdgdc@genre.crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Dec 2016 09:51:11 -0800
Message-ID: <CAGZ79kYg0kdRt1K_m+ocMeeJz=-18+jZFktt5ic+7T_55Gfh3w@mail.gmail.com>
Subject: Re: [PATCH 6/6] rm: add absorb a submodules git dir before deletion
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <David.Turner@twosigma.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 7:28 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Dec 12, 2016 at 05:40:55PM -0800, Stefan Beller wrote:
>> When deleting a submodule we need to keep the actual git directory around,
>> such that we do not lose local changes in there and at a later checkout
>> of the submodule we don't need to clone it again.
>>
>> Implement `depopulate_submodule`, that migrates the git directory before
>> deletion of a submodule and afterwards the equivalent of "rm -rf", which
>> is already found in entry.c, so expose that and for clarity add a suffix
>> "_or_dir" to it.
>
> I think you might have meant "_or_die" here.

indeed, will fix in a reroll. Thanks for the review!
