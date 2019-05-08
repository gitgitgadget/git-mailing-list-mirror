Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3156D1F45F
	for <e@80x24.org>; Wed,  8 May 2019 02:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfEHC4r (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 22:56:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50374 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfEHC4r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 22:56:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 066F714EA9F;
        Tue,  7 May 2019 22:56:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0BKbXoBwOkLBTxNSQYdHF/Vrink=; b=mP0tlT
        PNnnGG7/8bQ8tqFNzI9Cs6bBAeQ2BiCwSDbBviJv+hsvqsFPHaLYDgsl1KotdVXk
        d1NhOGOg2JbLSPYcMkrcOGIfOdhuRrNRAHAfby+XkT/tlLDrq27LcOUEglCs2gOV
        vu1ytGtCGUxqJuOGuPJVZr2eZX1eZQLyK3sak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rqB6w/WYDRx+ce6kNY5ICcBO2lMkMn8I
        FjZPiL3NI3i0jAcS7kn1jg0TjetzBxI3vk+gC752pxNZin73M05cG5CylpY/92Tx
        dbujz+EtAulZvRhAzft90poCmOVjOzLDOBiwVoaYSmJ7RshoE5jjyKuMFrudm6ci
        lYESLE/v5Yc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0A4D14EA9D;
        Tue,  7 May 2019 22:56:44 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C30C14EA9C;
        Tue,  7 May 2019 22:56:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     git@vger.kernel.org, Xiaolong Ye <xiaolong.ye@intel.com>
Subject: Re: [PATCH 2/2] format-patch: Make --base patch-id output stable
References: <20190426235157.106350-1-sboyd@kernel.org>
        <20190426235157.106350-2-sboyd@kernel.org>
        <xmqqpnounakf.fsf@gitster-ct.c.googlers.com>
        <155725118838.14659.6891235578536334187@swboyd.mtv.corp.google.com>
Date:   Wed, 08 May 2019 11:56:43 +0900
In-Reply-To: <155725118838.14659.6891235578536334187@swboyd.mtv.corp.google.com>
        (Stephen Boyd's message of "Tue, 07 May 2019 10:46:28 -0700")
Message-ID: <xmqq1s19k61g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9B6E716-713C-11E9-8F22-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen Boyd <sboyd@kernel.org> writes:

> Quoting Junio C Hamano (2019-05-06 21:38:24)
>> Stephen Boyd <sboyd@kernel.org> writes:
>> 
>> > I wonder if we need to make some other sort of form of
>> > "prerequisite-patch-id:" here and let that be a legacy form of the
>> > patch-id so that users know that they have a fixed version of this code?
>> > Maybe "prerequisite-stable-patch-id:"? Or we don't have to care because
>> > it's been broken for anything besides the most trivial type of patches
>> > and presumably users aren't able to use it with 'patch-id --stable'?
>> 
>> Do projects actively use -O<orderfile> when generating the patches?
>> I had an impression that not many do, and without -O<orderfile> in
>> the picture, --unstable/--stable would not matter, no?
>> 
>> So, I am not sure if this matters very much in practice.
>> 
>
> I'm not really concerned with projects using -O<orderfile> for patch
> generation. 

I think I misunderstood, then.  I have been assuming that the order
of target file paths was the primary thing that contributes to the
differences between --[un]stable modes, but apparently I forgot
about that 30e12b92 ("patch-id: make it stable against hunk
reordering", 2014-04-27) affects even a patch that touches a single
path.

If we advise "--stable" in the documentation to those who wants to
interpret "--base", then I agree with the goal of this series to
make sure that is what actually is happening.

Thanks for working on this.
