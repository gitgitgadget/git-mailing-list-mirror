Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1079820969
	for <e@80x24.org>; Wed, 29 Mar 2017 21:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753916AbdC2VfF (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 17:35:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55924 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932658AbdC2Vd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 17:33:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFA7783D80;
        Wed, 29 Mar 2017 17:33:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aM7iDx3uaBoAI9T8tfSCQbcNXsw=; b=kxPoS0
        Wk0vgCwTr/7Ek6dyY4ql7QStTgEnOXJWjmdKWjvfV0ll4gvcL3SZy91wRyBzjvfn
        GV3DJQHhsOyYAi0wfS9RqyJBjTJoIalSIryBYPpmcsRucVjgjGr3+JGPqHxSMXxr
        XSnUUXCPKlJAndWP51WabUPmRv123qRQ556jw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dsAELNbsJwQbUy1PzxZ4Y+SdrpT9relm
        aGl2RIrpFhBDqO6MTlgD13txUaYfycwWS9cxvMDbvTTAZY2coIimuLlHd0fQqaNy
        Gx0YZXOHIzQ33DRrPu6SrLoywsQFA2f+b/Iv5V8bgPDus0ijHqCFzU4hBSexjzSa
        /6d2AoiyQOA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E775683D7F;
        Wed, 29 Mar 2017 17:33:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4567C83D7E;
        Wed, 29 Mar 2017 17:33:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] unpack-trees.c: align submodule error message to the other error messages
References: <20170329183743.27506-1-sbeller@google.com>
        <20170329183743.27506-2-sbeller@google.com>
        <20170329184833.GX31294@aiede.mtv.corp.google.com>
Date:   Wed, 29 Mar 2017 14:33:18 -0700
In-Reply-To: <20170329184833.GX31294@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 29 Mar 2017 11:48:33 -0700")
Message-ID: <xmqqy3vn93a9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53ACF6BC-14C7-11E7-A01A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>
>> As the place holder in the error message is for multiple submodules,
>> we don't want to encapsulate the string place holder in single quotes.
>
> Makes sense.
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  unpack-trees.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 8333da2cc9..9f386cc174 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -167,7 +167,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>>  	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
>>  		_("The following working tree files would be removed by sparse checkout update:\n%s");
>>  	msgs[ERROR_WOULD_LOSE_SUBMODULE] =
>> -		_("Submodule '%s' cannot checkout new HEAD");
>> +		_("The following submodules cannot checkout a new HEAD:\n%s");
>
> Nitpicking about wording: unless the user has adopted a strongly
> object-oriented point of view, it is Git that cannot checkout a new
> HEAD, not the submodule.
>
> How about:
>
> 		_("Cannot update submodule:\n%s")
>
> That's vague, but if I understand correctly the way this error gets
> used is equally vague --- i.e., a clearer message would involve
> finer-grained error codes.

Makes sense to me.

Thanks for helping.
