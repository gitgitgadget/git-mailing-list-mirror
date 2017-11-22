Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2BEA202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 07:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdKVHuR (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 02:50:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65372 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751411AbdKVHuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 02:50:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D28B5B4006;
        Wed, 22 Nov 2017 02:50:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nSQrToG5avYAXl8M1hLkPWhz8UE=; b=XFnXA5
        KTcIWB6UNiiQlfeglbHQlfQUQHOhLtIlkkVcZCTt0/w6ubiC5WrZTjZ5jQ5JjMG9
        wZAeAtMEZ8xh1+6u1Hom6TeT/+I0t3zuMV+1qq1jy7ej0UqKVIz/hEI7fhdopf8V
        rwVi8PS0hyaPjTkTKbBa3wkdK4syKq8nXF3DM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z4Nxz5Sb+8panCbTzMEuNI8bd/eMuLx/
        05CaoDqFzZeNaYgt+TS6/A+jaOQlUfMwVFm883+ycc/4+pFDPKMAaMffbHd+ai5s
        9YcaSZjAYrfqDAXM/I70XTC6aR+g36ym3B39NdPxPEPkIyqWzAbaCSgevDOKAcmP
        lVncBD9Fv7w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA0F0B4004;
        Wed, 22 Nov 2017 02:50:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43F30B4002;
        Wed, 22 Nov 2017 02:50:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/4] Hash abstraction
References: <20171112212854.791179-1-sandals@crustytoothpaste.net>
        <xmqq4lpyajra.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 22 Nov 2017 16:50:14 +0900
In-Reply-To: <xmqq4lpyajra.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 13 Nov 2017 13:24:25 +0900")
Message-ID: <xmqqbmjuu4zt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6DD9E64-CF59-11E7-95DE-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> This is a series proposing a basic abstraction for hash functions.
>>
>> The full description of the series can be found here:
>> https://public-inbox.org/git/20171028181239.59458-1-sandals@crustytoothpaste.net/
>>
>> At the bottom of this message is the output of git tbdiff between v2 and
>> v3.
>>
>> Changes from v2:
>> * Remove inline.
>> * Add dummy functions that call die for unknown hash implementation.
>> * Move structure definitions to hash.h and include git-compat-util.h in
>>   hash.h.
>> * Rename current_hash to the_hash_algo.
>> * Use repo_set_hash_algo everywhere we set the hash algorithm for a
>>   struct repository.
>
> Change for all of the above in this series looked sensible to me.
> Thank, will queue.

So... is everybody happy enough with this version that nobody minds
more codebase to be adjusted on the infrastructure this series lays
out?  I think this is ready for 'next', but just in case I missed
some discussions...

