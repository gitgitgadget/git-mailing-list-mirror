Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E2C433E1
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 22:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A626420768
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 22:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="en/n0VdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgGWWSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:18:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55056 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgGWWSY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 18:18:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32C3A7FD29;
        Thu, 23 Jul 2020 18:18:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=erQmsbbk6Dpkcc9UGbSq6DRiI4w=; b=en/n0V
        dAXyUOy+uaJVBO3UPx8B+gSU+Qev2Flt4a8u1FAzLeLZZxkFK9kQQrV7EHlbBofM
        aFmPtN/OBVMwBbYPi5TsAY3ORfUDnd2Q9+RBM1i25ueD0GhpFDVnhfdiBJnLCi68
        zbRmMnwjZmE7IVaqU9oSC2ey7QmkNFLPqrpyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QFlhXS8LhPuXR4dUSdH3DiHm3/h7fqxG
        Xt838FEHEBYyItlyVnHg37mA0tz5HNpAcOfrEsloUqXBJenuKVXtqI0x6hsGEROh
        8IdxiJ3W4rK4D4DtbW8vIcj2UUqfrAHZKQFprkZByVxqiRteqLYKk4Jbbd96RHh5
        MVZKVxOeJLY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27A377FD28;
        Thu, 23 Jul 2020 18:18:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE4257FD27;
        Thu, 23 Jul 2020 18:18:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 06/18] maintenance: add --task option
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <a09b1c16874c0fad6dd0df3ace573a2ffe34519e.1595527000.git.gitgitgadget@gmail.com>
        <xmqqimeeq8x4.fsf@gitster.c.googlers.com>
Date:   Thu, 23 Jul 2020 15:18:20 -0700
In-Reply-To: <xmqqimeeq8x4.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 23 Jul 2020 13:21:43 -0700")
Message-ID: <xmqq5zadq3ir.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B1D6292-CD32-11EA-9282-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  	for (i = 0; !result && i < num_tasks; i++) {
>> -		if (!tasks[i]->enabled)
>> +		if (opts.tasks_selected && !tasks[i]->selected)
>> +			continue;
>> +
>> +		if (!opts.tasks_selected && !tasks[i]->enabled)
>>  			continue;
>
> I am not sure about this.  Even if the task <x> is disabled, if the
> user says --task=<x>, it is run anyway?  Doesn't make an immediate
> sense to me.

OK, after seeing the title of 12/18, it does make sense.  Even if it
is disabled by default, you could still choose to run, which makes
sense.

