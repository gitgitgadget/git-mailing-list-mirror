Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B26741F404
	for <e@80x24.org>; Thu, 22 Mar 2018 01:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbeCVBrR (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 21:47:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35933 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752752AbeCVBrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 21:47:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id x82so13149670wmg.1
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 18:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pGUqpqgz5YkRs56OWXJQIKCi0YYDaVhANzXkG/wDQEw=;
        b=OCDUac9YaNVYvz1tPAH9xqKUf5ox9pifvBVIFVM08twrqOsZQr87o+Lh4EAlKd+OUe
         M1Myt3S4u5mTFlrRCBFhltauL4jP/kzAjdLZfRiiUyqL2iSWbAP8SrshZHg2+QZAiCZw
         8Rvbq7dPhPebhesm+U8JwV9KzELuGIeN5Btonubm3xLWwtLzdTTZLxHcmno7vHcohPPG
         ZO6DrDJ1jc991bx/7ODnK30gQAEBUka14a1mlZXfmnRhdZoaNJb2kDY3I9WsnLGW2Dnd
         IbBaMmB3cEwpoW5rH+/b/VZSh8sR9ZSgvXQD4IAsFrT8sQxzw2lRErxqBNq0AFSCD96V
         xIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pGUqpqgz5YkRs56OWXJQIKCi0YYDaVhANzXkG/wDQEw=;
        b=swGMmmuy6quAPw9rGN94GXc2OkmGoqMvk8BSToQ3CDROCoO+B9v1Tars0lPpGiDbRm
         jS6da3cPpJrfXCPl3eeqa5r+3O0dVipJL962GZEPaKvgdMZDv9FPx6xhbMwlZrxqHEjq
         rllu1zD5W9VtnOMJEvB9lIE6pYzTnxURzAJJihBZkYGYfgU3upCln5dI/eMTwow7Crs+
         oWgmbrlJeGnpOAfixcvvGEThedHwlu5b9JAuKTEWZnqcUpQAexhNKqD/boKwt1NQ14qn
         nRN/mOY8jDRMQXi/29pFGDVYHVCcO+c2Y68I2mbNB0w+rLdqIjnSivujFEr237IdmosC
         YjNQ==
X-Gm-Message-State: AElRT7Gpf3hCCgUPuq/sP7LxIdTH9+9siwkGTYCgKRNOAQSk1sYNG6BA
        IkPtZQv0bo8+STdDOBybAZw=
X-Google-Smtp-Source: AG47ELuS81zWB6wob34+Y6781FtG9DF6ANFYckJ+5e2aEfF2OgBloIfcUh/N/h6BAaKpm5vlx142FQ==
X-Received: by 10.28.176.132 with SMTP id z126mr3840034wme.122.1521683234622;
        Wed, 21 Mar 2018 18:47:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r102sm1830391wrb.78.2018.03.21.18.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 18:47:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 40/44] packfile: allow prepare_packed_git to handle arbitrary repositories
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
        <20180303113637.26518-1-pclouds@gmail.com>
        <20180303113637.26518-41-pclouds@gmail.com>
        <20180321223923.GB202156@google.com>
Date:   Wed, 21 Mar 2018 18:47:10 -0700
In-Reply-To: <20180321223923.GB202156@google.com> (Brandon Williams's message
        of "Wed, 21 Mar 2018 15:39:23 -0700")
Message-ID: <xmqqr2ocnaox.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 03/03, Nguyễn Thái Ngọc Duy wrote:
>> From: Stefan Beller <sbeller@google.com>
>> 
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>
> This is an invalid conversion.
>
>>  packfile.c | 18 +++++++++---------
>>  packfile.h |  3 +--
>>  2 files changed, 10 insertions(+), 11 deletions(-)
>> 
>> diff --git a/packfile.c b/packfile.c
>> index 52febba932..2276e2ad26 100644
>> --- a/packfile.c
>> +++ b/packfile.c
>> @@ -882,19 +882,19 @@ static void prepare_packed_git_mru(struct repository *r)
>>  		list_add_tail(&p->mru, &r->objects.packed_git_mru);
>>  }
>>  
>> -void prepare_packed_git_the_repository(void)
>> +void prepare_packed_git(struct repository *r)
>>  {
>>  	struct alternate_object_database *alt;
>>  
>> -	if (the_repository->objects.packed_git_initialized)
>> +	if (r->objects.packed_git_initialized)
>>  		return;
>> -	prepare_packed_git_one(the_repository, get_object_directory(), 1);
>> -	prepare_alt_odb(the_repository);
>> -	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
>> -		prepare_packed_git_one(the_repository, alt->path, 0);
>> -	rearrange_packed_git(the_repository);
>> -	prepare_packed_git_mru(the_repository);
>> -	the_repository->objects.packed_git_initialized = 1;
>> +	prepare_packed_git_one(r, get_object_directory(), 1);
>
> Calling get_object_directory() returns the_repository's object dir,
> this needs to be replaced with r->objects.objectdir.

Nicely spotted.  I think this was inherited from the orginal,
e.g. the one from the end of last month

https://public-inbox.org/git/20180228010608.215505-9-sbeller@google.com/

also calls get_object_directory().

Thanks.
