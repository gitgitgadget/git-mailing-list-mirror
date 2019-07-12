Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4811A1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 18:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfGLSdM (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 14:33:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51223 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLSdM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 14:33:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F188570D12;
        Fri, 12 Jul 2019 14:33:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lVFiQv9pcUpo+O9GYKcnrQyzqXI=; b=lfv0Dn
        /dh+n2qKF0PSgy3EFL1TuaS2lQoWoaKoKFh0zDsTwgnwQcZcb3LG2sZCHux9BL8Y
        m/oFO0u6H53MPfGA/bO9TTv8hHkkhwkcKj2Q0a8hRZA7+GcfZuwDvJ3lb1mDEeFP
        z+nzn+nAtiFIJ7SNe/V4IKgKjZcQxFtONk+lI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YIwzk5MlMfJHcmRHB6OfLb4mBWh9/2C7
        UAxaeF43hSvPfJPyqZkq6GHd6qfy9XMHTFEZScsD6av5uz50UefsD3w+dK2XNk6u
        KCi4r/mb4vxbNjiOXmvPgmjKvTghXeqv47waI6q6hiKAzrVViIgf/Aky4fIsq6OW
        j+rf0SlYo60=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8EE570D11;
        Fri, 12 Jul 2019 14:33:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 83AE970D0F;
        Fri, 12 Jul 2019 14:33:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Elijah Newren <newren@gmail.com>, usbuser@mailbox.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
References: <423596682.8516.1562665372094@office.mailbox.org>
        <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com>
        <1152121968.7459.1562688927235@office.mailbox.org>
        <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
        <275487563.12198.1562691633735@office.mailbox.org>
        <CABPp-BGPLxR7NgXRHppLy_W0c=Odhhns2RjcQ4iWKKQMz+SpDQ@mail.gmail.com>
        <CAGyf7-FW-_4AbWE735-=7WjZAaTLHOT_QuWOoHKAjOzZCbWhFA@mail.gmail.com>
        <xmqqtvbtu9uo.fsf@gitster-ct.c.googlers.com>
        <87sgrdf91j.fsf@osv.gnss.ru>
        <xmqqftncsdv4.fsf@gitster-ct.c.googlers.com>
        <87blxz9xbh.fsf@osv.gnss.ru>
Date:   Fri, 12 Jul 2019 11:33:01 -0700
In-Reply-To: <87blxz9xbh.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        12 Jul 2019 16:50:10 +0300")
Message-ID: <xmqqh87rp0gy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BEAF36A-A4D3-11E9-87BB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> If we have a project like this:
>>
>>         A               topic that is slightly stale
>>        /
>>   o---F---o---o---X     mainline
>>
>> M, A', and N should end up with identical trees:
>>
>>
>>         A-----------M   topic that is slightly stale, merged into mainline
>>        /           /
>>   o---F---o---o---X---N mainline with A' merged
>>                    \ /
>>                     A'  mainline with A rebased on top as A'
>>
>> And by forcing to rebase A to A' before merging into the mainline as
>> N, compared to advancing mainline from X to M, one major difference
>> the workflow is making is to _lose_ the information that the topic
>> was cooked in the context of an older mainline and did not take what
>> happened since F until X into account....
>
> However, committing untested M still doesn't taste as the best possible
> way of handling things in general. It'd be best to actually test M or N
> before publishing.

Oh, no question about it.  I am not advocating (and I do not do
personally) publishing an untested tip.  

But the point is, if M and N are equally well tested before
publication, they may still have bugs resulting from subtle
interactions between A and F..X that is not discovered during that
testing.  And N loses the information that would help diagnosing
what went wrong, which does not happen if you published M.

About the docs easily getting misinterpreted, I think Elijah covered
it pretty well.

Thanks.
