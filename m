Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F00D1FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 06:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbdJYGDL (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 02:03:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55432 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751937AbdJYGDK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 02:03:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A243AD668;
        Wed, 25 Oct 2017 02:03:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ezkaN23NTNV4u07vEztzt/oRw5M=; b=Gq9lXR
        pUYAenUvoF368cafo1PgGg7OTQ20luH5/8oO+kyLesPF5sllf+XWAxPKBmlfh8ID
        5AFm10NArtLlPxH995mQ1ufVtZME5wTyDBlBbyOYmiEv4a2vT+wRK/Wtec5BJEYm
        gGHg3gxv6h/qm1pZajcUFsijCdK4mB/dKYPGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EgX/gfK/B40jDn5HiuKr10/P2H6bGfgX
        JePipkAIYigvXL6xeBaEb66/pukY5GKnHnYXn2MZVmnvrP4W7Il69DV9SUoH8aeW
        jBFUqa4JGAV1CGOBxnis6mKREnzneTLTIdgKpOfdHAyd92rQJhimW26gweLlRbPg
        ieBpSpCi180=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 529A8AD667;
        Wed, 25 Oct 2017 02:03:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CDA1DAD666;
        Wed, 25 Oct 2017 02:03:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] completion: add remaining flags to checkout
References: <20171012122059.17242-1-thomas.braun@virtuell-zuhause.de>
        <20171024131931.18221-1-thomas.braun@virtuell-zuhause.de>
        <be2e0547-5ef7-c9d9-baad-44f5fa9d3c31@kdbg.org>
Date:   Wed, 25 Oct 2017 15:03:07 +0900
In-Reply-To: <be2e0547-5ef7-c9d9-baad-44f5fa9d3c31@kdbg.org> (Johannes Sixt's
        message of "Tue, 24 Oct 2017 18:45:05 +0200")
Message-ID: <xmqqefprix2c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CCEEC26-B94A-11E7-A8B2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> The flags --force and --ignore-other-worktrees are not added as they are
>> potentially dangerous.
>>
>> The flags --progress and --no-progress are only useful for scripting and are
>> therefore also not included.
>>
>> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
>> ---
>>   contrib/completion/git-completion.bash | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index d934417475..eb6ade6974 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1250,7 +1250,8 @@ _git_checkout ()
>>   	--*)
>>   		__gitcomp "
>>   			--quiet --ours --theirs --track --no-track --merge
>> -			--conflict= --orphan --patch
>> +			--conflict= --orphan --patch --detach --ignore-skip-worktree-bits
>> +			--recurse-submodules --no-recurse-submodules
>>   			"
>>   		;;
>>   	*)
>>
>
> Looks good to me. Thanks,
> -- Hannes

Doesn't quite.  This breaks t9902, doesn't it?
