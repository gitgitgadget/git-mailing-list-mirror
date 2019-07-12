Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6FCA1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 19:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfGLTaM (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 15:30:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63430 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfGLTaM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 15:30:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 977E37354F;
        Fri, 12 Jul 2019 15:30:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FiQxlB07m72xegaRHCrOI8LSfOQ=; b=h8PAYI
        y3v14vVc+K3+2KveEV1o+/kReaMZ3oRtFbHsM2sPQOnlW/GyII/OBkgg0aSVMhzA
        Ksp85u0vxardAFnPzQAgZBd8atHQA9JGUfJE9iDcWyuezByVwA+jXfUv36pwkk8G
        zIxv6JNqNij+m+tK+ySO4IJEyXyOEeoPE7UwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FTVvRYHS7y01xd+LvWNtDzNa5rIxNus1
        +wcPXpItP5+3vNmim8O7ZNl0PN+i54lRK6sf6gugj+PTrHxw12UMpiKxcz4rl5IC
        rydhipA2Q0jH8Qq2F20E/39rpxrMLDRF3VkNNayQecNc0eFFNJoZxpcNQu5zVilc
        GszbtCENQso=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 90D567354E;
        Fri, 12 Jul 2019 15:30:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3B9417354B;
        Fri, 12 Jul 2019 15:30:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] document deprecation of log.mailmap=false default
References: <20190712155901.19210-1-ariadne@dereferenced.org>
        <xmqqpnmfp2gs.fsf@gitster-ct.c.googlers.com>
        <CAAOiGNzcNhWmmr+COXhv2p9=KF5k4hHLEsNsfA1H+P0JQOTTqg@mail.gmail.com>
Date:   Fri, 12 Jul 2019 12:30:05 -0700
In-Reply-To: <CAAOiGNzcNhWmmr+COXhv2p9=KF5k4hHLEsNsfA1H+P0JQOTTqg@mail.gmail.com>
        (Ariadne Conill's message of "Fri, 12 Jul 2019 13:00:51 -0500")
Message-ID: <xmqqd0ifoxtu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 749AB6C4-A4DB-11E9-921C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ariadne Conill <ariadne@dereferenced.org> writes:

>> 4212.4 raises an interesting question.  It wants to see the output
>> of this command:
>>
>>         git log --format="%an+%ae+%ad" broken_email >actual.out 2>actual.err &&
>>
>> The question is, when the user explicitly asked for the "true"
>> identity values (not the mapped one via %aN, %aE and their friends),
>> if --use-mailmap should affect the outcome?
>
> I don't think it should.
>
>> A secondary question is if we should be issuing a warning against
>> this command line in the first place, if the answer to the above
>> question is "no" (i.e. --[no-]use-mailmap, and the future default
>> switch, do not affect the outcome).  There is no point issuing a
>> warning if the command line is already future-proofed.
>
> I will disable the warning if a custom format is specified.

I briefly thought that this is tricky enough that we should wait for
other people to chime in before casting the decision in stone.  But
we can continue with what we consider the better variant in the
meantime.

> A thought I had was to perhaps use isatty(STDERR_FILENO) to determine
> if stderr is attached to a terminal session and only issue the warning
> in that case.  What do you think?  It should fix all of these tests.

Some of them but it should not affect that one, which is run under
test_terminal, as the whole point of that test helper is to see how
we behave in a terminal ;-)

> Thanks wholeheartedly for all of your help so far, I know there are
> many git users who will be very happy once all of this work is done
> (basically anyone who has changed their name).

Thanks.
