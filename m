Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B13720899
	for <e@80x24.org>; Sat,  5 Aug 2017 23:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdHEXbp (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Aug 2017 19:31:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51977 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751214AbdHEXbo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2017 19:31:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC6509FF80;
        Sat,  5 Aug 2017 19:31:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4uecgQ3i2t0ugvuB4p7K2ZEovhQ=; b=vm+PWb
        ez2+ajZecdmSmPs0Jt1kzXQY6MDnTUw7JcjY2SjrV0Uz03g7MwSNZHe9xkd1TDVb
        seNtJcvwsY0aVuqsUe5huRmfHA8pwoqtDpqEvBU+yPhyV1QM/oQYvIXdtTaVRd1p
        AhRB9IwcQv562NZkO4xbwgxJ+NOr1dnTRS0bE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iSSt7yayO7b/ZcC++x9s8DMcko7W87/K
        XQ4GunaFelzhkxe42LAZ4ps+dU6uzJuC/4/Jo6G+kYiE9QJjIb1lsaHPPLeD8dEL
        v+bpH9IyxyJjONWcBIalJsipwO7JwYdX3C3P0m4ruFYUHcoUay56ezisWzPKrAn0
        odS+0Qx1VCo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C27FB9FF7F;
        Sat,  5 Aug 2017 19:31:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EE699FF7C;
        Sat,  5 Aug 2017 19:31:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Forney <mforney@mforney.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
References: <20170805064905.5948-1-mforney@mforney.org>
        <xmqqlgmxskm6.fsf@gitster.mtv.corp.google.com>
        <CAGw6cBtKF-Xt4z3m4gBDQvaSnurbtHURe737s8XMX78ca_RTcA@mail.gmail.com>
Date:   Sat, 05 Aug 2017 16:31:41 -0700
In-Reply-To: <CAGw6cBtKF-Xt4z3m4gBDQvaSnurbtHURe737s8XMX78ca_RTcA@mail.gmail.com>
        (Michael Forney's message of "Sat, 5 Aug 2017 15:54:32 -0700")
Message-ID: <xmqqh8xlsiaq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D2EFA00-7A36-11E7-BD91-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Forney <mforney@mforney.org> writes:

> On 8/5/17, Junio C Hamano <gitster@pobox.com> wrote:
>> Have you made sure that all of these scripts, before calling
>> 'git-foo' in the current code, update their PATH so that these found
>> in the bog standard place (i.e. GIT_EXEC_PATH)?
>>
>> The reason I ask is because we can rest assured these changes will
>> be a no-regression improvement if you did so.  I do not offhand
>> think of a reason why these scripts wouldn't be doing so, but it
>> never hurts to make sure.
>
> I just checked and all the scripts make some other call to a built-in
> with `git foo`, so I think it should be safe.

As long as they are the same "foo"'s, then the check you did is
perfectly fine.  The (unlikely I would think) case that can lead to
a regression is if these script deliberately used `git-foo` to find
them on $PATH, which can be different from 'git foo' that is found
by 'git' in its own binary (as all of them are built-ins), and that
is why I asked.

Thanks.
