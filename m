Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D36AE2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 05:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbdKVFOf (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 00:14:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64033 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751050AbdKVFOe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 00:14:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31723B23E9;
        Wed, 22 Nov 2017 00:14:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vtRjdu6wIianrCDwX0e53maIgfs=; b=pjRlTi
        aoxdhGfutc81Rtx+/cmkNNWZoG/9H9kKVj4PC/nBlL6KVNjaRAka9kjL7/M4aSRx
        NZdRCIA/f+859IROqD+/wDGGfF4Q+nn1konN5lxXKqsPUMlhWCz3i7BAxl/B5b3v
        C2KNHxSYl32zjgOAuFue8u4lX1zhXd2I2Ej3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EaIjC7aYnljeI7AXSuATA50Ie+cM/WLA
        ZJrU8vJYTtPZA6cRe/wzCyTuv6p25xIsy2zF1wiFoOyJb7YwIrA7J4DIjvxGm3f5
        TK1yWCziBrTNeg0TMMjdymdSRokDzkCsDs5Rd6O4G+s7DP5AFJtF+wwBmINO3fZZ
        bw8Vhz6FJis=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 292C7B23E7;
        Wed, 22 Nov 2017 00:14:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1748B23E6;
        Wed, 22 Nov 2017 00:14:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        peff@peff.net, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 0/6] Partial clone part 1: object filtering
References: <20171121205852.15731-1-git@jeffhostetler.com>
        <20171121173754.12ae87e8bfdd773efada98e3@google.com>
Date:   Wed, 22 Nov 2017 14:14:32 +0900
In-Reply-To: <20171121173754.12ae87e8bfdd773efada98e3@google.com> (Jonathan
        Tan's message of "Tue, 21 Nov 2017 17:37:54 -0800")
Message-ID: <xmqq3756vqrr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06CB19C2-CF44-11E7-A9AB-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Jeff Hostetler (6):
>>   dir: allow exclusions from blob in addition to file
>>   oidmap: add oidmap iterator methods
>>   oidset: add iterator methods to oidset
>>   list-objects: filter objects in traverse_commit_list
>>   rev-list: add list-objects filtering support
>>   pack-objects: add list-objects filtering
>
> I checked the diff against v4 and this looks good.
>
> I'm still unsure if pre-parsing the --filter argument into a struct
> list_objects_filter_options is the best approach API-wise in the case
> that we plan to send it to the server, but it does have the benefit of
> failing (and informing the user) early if the filter is in the wrong
> format, so I'm fine with this patch set as-is.

Thanks.  I share the same suspicion but as long as we keep the raw
version in addition to the parsed-out value, we could pass it around
without having to reconstruct it (and risking an incorrect
reconstruction), so it should be OK.

Will queue with your reviewed-by: unless you object ;-)

Thanks, both.

