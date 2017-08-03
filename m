Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343AD1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 20:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbdHCUJa (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 16:09:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57554 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751236AbdHCUJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 16:09:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AF59A739D;
        Thu,  3 Aug 2017 16:09:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Pp9962GacoWHUE6GuM7Lbh3cwwk=; b=oKcUm7
        EORDluVikimwoyAZNmkYktq1pcWjgVExNPGDI08kty17/xmGRgtfgSe0WMkcis+g
        zjtk2mFWnQM7WlwT7nWVGJYSrEyQN9MarCWRLcbzdK3a6Y2unBqVvOq2qyOt+ggf
        0nxnewIO7nXuzY+8DphBJCtmdcxKzXcZI9q5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gPLbcvVWSpHzGxnpiK99CMueTDAU5kEH
        +y2A3jiY5G0WDwuogRfyna/PmcMB7VrX5ohymdwD9Y4KjY2HtspweJg/CFSSTxb/
        H7sLIqLRHTEhBgSQ2522rIT3CeqpJDh2GqVn+6NorRv/yLeJajeQ28lPwYwihFxl
        WTTMll/xWGA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01AC6A739B;
        Thu,  3 Aug 2017 16:09:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 500B7A739A;
        Thu,  3 Aug 2017 16:09:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de
Subject: Re: [PATCH v2 00/15] submodule-config cleanup
References: <20170725213928.125998-1-bmwill@google.com>
        <20170803182000.179328-1-bmwill@google.com>
Date:   Thu, 03 Aug 2017 13:09:20 -0700
In-Reply-To: <20170803182000.179328-1-bmwill@google.com> (Brandon Williams's
        message of "Thu, 3 Aug 2017 11:19:45 -0700")
Message-ID: <xmqqy3r0wgzz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3529BEE-7887-11E7-B982-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Changes in v2:
>  * Rebased on latest 'bw/grep-recurse-submodules' branch (Still also requires
>    the 'bc/object-id' series).
>  * Changed unpack-trees.c (checkout command) so that it no longer respects the
>    'submodule.<name>.update' config since it really didn't make much sense for
>    it to respect it.
>  * The above point also enabled me to fix some issues that coverity found with
>    how I was overlaying the repo config with the submodule update strategy.
>    Instead the update strategy parsing logic is separated into two functions so
>    that just the enum can be determined from a string (which is all
>    update-clone needed).

Thanks.  I was wondering what the status of this series was when I
accepted the updated "grep --recurse-submodules" the other day.
