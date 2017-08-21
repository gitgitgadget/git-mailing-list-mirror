Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7F6208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 22:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbdHUWwM (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 18:52:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62105 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753600AbdHUWwL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 18:52:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 141339F0C2;
        Mon, 21 Aug 2017 18:52:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wFgk7uJwnDaO9YoeW3s4NVekbBg=; b=ktFC7q
        nfJwwTDHIjZ3ykiFrPiZ2vIrBQ2N2L41kHOCVtyTSQ4Rrqc0lMDEHfXoPB16/Xgk
        g4tfn32/rdCdnYYEKqb0JTyXMF7oImH4eh8H5tsHRwnanrx7oKCmpZUxYiEJWyaJ
        cctTVmQUlVmLKLpVLPGj3CkYQC5plx08ewQ74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FW6nLq/S0W5BTfO64xoqMHFvuDrCIvxX
        AhRnCPizuacxuiOivMqgEarOWhcd/BCCV36OfkPtYvGvQ0Z8XZfneWHZdss7s40S
        O3eCb8or9KfnSfXwuzzF9UPerNUTVQHLHJd1UXG9gLcxNoMpVKnsVTRsEt6RaJbh
        FS9BKc4Vc/s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D7A39F0C1;
        Mon, 21 Aug 2017 18:52:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66AB09F0C0;
        Mon, 21 Aug 2017 18:52:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] pull: respect submodule update configuration
References: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com>
        <20170818220431.22157-1-sbeller@google.com>
        <xmqqvalk9is0.fsf@gitster.mtv.corp.google.com>
        <20170821162056.GB1618@book.hvoigt.net>
        <CAGZ79ka1jyxmATQbrjPHAv3227UJNcN0nw9AY-RZXnNahepoGQ@mail.gmail.com>
        <85ED93BC-1E27-4B8D-856D-090C6860BAB0@gmail.com>
        <CAGZ79kZMjGNOn0FnJGtO5gRY3rF0Eiow8n0uppTZsCUAHY+m3A@mail.gmail.com>
        <20170821182110.GA156514@google.com>
Date:   Mon, 21 Aug 2017 15:52:09 -0700
In-Reply-To: <20170821182110.GA156514@google.com> (Brandon Williams's message
        of "Mon, 21 Aug 2017 11:21:10 -0700")
Message-ID: <xmqqa82s5yau.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D8D7792-86C3-11E7-8476-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> > I tried to make it work here:
>> > https://public-inbox.org/git/89AB8AA3-8E19-46BA-B169-D1EA4CF4ABE7@gmail.com/
>> 
>> (A) you need to set expect there as well, to have sub{2,4,5} be expected
>> there as well.
>> 
>> (B) That may hint at another (UX) bug.
>> 
>> The test case there uses "git submodule update --init".
>> The init flag will set all submodules to active.
>> 
>> Maybe you want
>> 
>>     git config submodule.active ":(exclude)sub0"
>>     git config --add submodule.active ":(exclude)sub2"
>>     git config --add submodule.active "."
>>     # Read: anything except sub0 and sub2 are interesting
>> 
>>     git submodule update
>>     # no init flag, needed even for new submodules IIUC

Sounds like a good solution.  I do think what Stefan said about
"reset --hard --recurse-submodules" makes tons of sense, and we
should do a hard reset in submodules as long as they are marked
as active, regardless of what the .update option says.  I have
not thought deeply enough about other operations like "pull" in
his message to be able to comment, though.

Thanks.
