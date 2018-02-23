Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1B031F404
	for <e@80x24.org>; Fri, 23 Feb 2018 22:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeBWWWQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 17:22:16 -0500
Received: from mail-yb0-f195.google.com ([209.85.213.195]:46680 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbeBWWWP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 17:22:15 -0500
Received: by mail-yb0-f195.google.com with SMTP id e142-v6so1248262ybc.13
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 14:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tHS0L/Rw7RCJXR5QYZ0888oNfFLPcS3QzKslBMMDu6M=;
        b=G80n/Olwc+w+hJ3otr6SlkvGGqlCClfIvf/oFRXp3Z/fDH2mKtLrgeIsm2AFmiBF57
         MaKPC2JFuaOINqS1YjU33cnNNfmKL3lz3DJl1QQoZIrABhRwbdLeeSMxW2yDMoA3y1Bf
         6WSvY8+0V3KG99Xq22GApGmgvwVPkeNtR9hsOMkpxbjso8gYbPS/oFKLDJ+tC7j3a34f
         /vMP2PSV62+iK54l4PvPe8dHNd+DkZfAkMJjKPVbUnDZzHFEZgg6XVdO9g4Eyo3FaDyH
         QpPvSfSweQ8PKFI+l8PbdY9FDELwtuUDwu/CGyvWyzk6pmYQtl/LyFERLT9CTmfhfTvH
         jBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tHS0L/Rw7RCJXR5QYZ0888oNfFLPcS3QzKslBMMDu6M=;
        b=fkdSa/C/T5dBMfEfubPmwLHDbrhBxtFtSBzO88WQIZd6+EP3yA2H/IwTYN110Ro73E
         b9BTGmME0D89Y/Any4ZtX0Sez3a1QfDMXwCPL+AWq1hcWv1Z5j4PwdHZpUipfjIVA6FX
         r6kVLsTYkMAb41N8pThob8W/Kjr0Y/PghAFyLRN2wi6QAladtlv8zGIW5mZF3eMi1EZN
         dHdmtxl1z2vzddNYBW6cZPqzcPT6Tfcn+6FsbgDM7AakuQ0kSMeVYkJ+XrMC1Wc2ql+y
         rS8xJmOu6NpDXUGcCbnnlxlBE942gx57sYUyq2kO6ySxQ8jRHr74qJhDnb/TOE+5i6PK
         DOqw==
X-Gm-Message-State: APf1xPDpr+5EzZMcOyjRsVJtygSlHugC4AfY2tI1RnskMf+tg1dtaa4R
        1f8xevzQ+bA0J6bi9gDS26C1uWIrrhALH7wfNB+eSA==
X-Google-Smtp-Source: AG47ELttpO6lkZctizK9Z573HZI2a2UbjfBelj8D2W3GCX2o8Xrky6Y70Y11JNkL0YZuMDfmSLnneg8hYvtH8SU5Ayg=
X-Received: by 2002:a25:6b0e:: with SMTP id g14-v6mr2281503ybc.292.1519424534822;
 Fri, 23 Feb 2018 14:22:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Fri, 23 Feb 2018 14:22:14
 -0800 (PST)
In-Reply-To: <20180222004710.GF127348@google.com>
References: <20180216174626.24677-1-sbeller@google.com> <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-9-sbeller@google.com> <20180222004710.GF127348@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Feb 2018 14:22:14 -0800
Message-ID: <CAGZ79kahS_mk8gFONUAxBjw7iV=5q1ff-ZgjLnQ7rMw=kBKThw@mail.gmail.com>
Subject: Re: [PATCH 08/27] pack: move approximate object count to object store
To:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 4:47 PM, Brandon Williams <bmwill@google.com> wrote:
> On 02/20, Stefan Beller wrote:
>> The approximate_object_count() function maintains a rough count of
>> objects in a repository to estimate how long object name abbreviates
>> should be.  Object names are scoped to a repository and the
>> appropriate length may differ by repository, so the object count
>> should not be global.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>>  object-store.h | 10 +++++++++-
>>  packfile.c     | 11 +++++------
>>  2 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/object-store.h b/object-store.h
>> index 6cecba3951..bd1e4fcd8b 100644
>> --- a/object-store.h
>> +++ b/object-store.h
>> @@ -93,6 +93,14 @@ struct raw_object_store {
>>       struct alternate_object_database *alt_odb_list;
>>       struct alternate_object_database **alt_odb_tail;
>>
>> +     /*
>> +      * A fast, rough count of the number of objects in the repository.
>> +      * These two fields are not meant for direct access. Use
>> +      * approximate_object_count() instead.
>> +      */
>> +     unsigned long approximate_object_count;
>> +     unsigned approximate_object_count_valid : 1;
>
> Patch looks fine and is effectively a no-op, though what is the need for
> both of these variables?  Maybe it can be simplified down to just use
> one?  Just musing as its out of the scope of this patch and we probably
> shouldn't try to change that in this series.

I agree we should. It was introduced in e323de4ad7f (sha1_file:
allow sha1_loose_object_info to handle arbitrary repositories, 2017-08-30)
and I think it was seen as a clever optimization trick back then?
