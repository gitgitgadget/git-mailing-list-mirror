Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB82C433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 00:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEC8207BB
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 00:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E/+MqDY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHSAgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:36:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61835 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHSAgq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 20:36:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECB837CE99;
        Tue, 18 Aug 2020 20:36:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5ol7ddjaZZG4DT68Lmms0B8ygCE=; b=E/+MqD
        Y7jsKnX3ONwcVgKHVGaFQDjr/rQgVSydW/m/ZL2093RKaV4xcarLSPQdLa2dzxeP
        Xf0iiO/xgsdGA81ytmhM8Gb5wFei44mn9P2cXWEKwksV9nQ5jjJRjvmKfpbA1o7w
        6IQVpIQy64k7w/4XG9plm+ENADHIOPRDBFhhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QYfDWkEZRVZ97NNUzJltJco1AdWIRKaH
        vIBh+TIjzvum5Y5Pyp5IGKZguLGnkYUkIegRBiiw4dXiZNwQqIHqCRdp+dtql8+n
        phnhg/ha2NKjGfB0FnpFxdzOlQELhGvh0UTI4L5Mj5+iacxgvfIQGxZSoFwV5xN+
        uT/KFEyoB8I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E32067CE97;
        Tue, 18 Aug 2020 20:36:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EF9C7CE96;
        Tue, 18 Aug 2020 20:36:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, derrickstolee@github.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 06/11] maintenance: add --task option
References: <85268bd53ef7f4e7b3d97a8ae091290e8e74441d.1597760589.git.gitgitgadget@gmail.com>
        <20200819000015.2838345-1-jonathantanmy@google.com>
Date:   Tue, 18 Aug 2020 17:36:43 -0700
In-Reply-To: <20200819000015.2838345-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 18 Aug 2020 17:00:15 -0700")
Message-ID: <xmqq364jwjxg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EAC4AC8-E1B4-11EA-A7FE-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> @@ -66,6 +68,10 @@ OPTIONS
>>  --quiet::
>>  	Do not report progress or other information over `stderr`.
>>  
>> +--task=<task>::
>> +	If this option is specified one or more times, then only run the
>> +	specified tasks in the specified order.
>
> We should list the accepted tasks somewhere but maybe this can wait
> until after part 2.
>
>> @@ -791,7 +791,9 @@ typedef int maintenance_task_fn(struct maintenance_opts *opts);
>>  struct maintenance_task {
>>  	const char *name;
>>  	maintenance_task_fn *fn;
>> -	unsigned enabled:1;
>> +	unsigned enabled:1,
>> +		 selected:1;
>> +	int selected_order;
>>  };
>
> "selected" and "selected_order" are redundant in some cases - I think
> this would be better if selected_order is negative if this task is not
> selected, and non-negative otherwise.

It is good to get rid of redundancies.

> Apart from that, maybe this should be documented. It is unusual (to me)
> that a selection can override something being enabled, but that is the
> case here.

I had the same reaction as "(to me)" above during an earlier review
round, IIRC.  This definitely deserves documentation.
