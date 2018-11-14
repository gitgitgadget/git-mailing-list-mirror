Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D14E61F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 01:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbeKNLhx (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 06:37:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56747 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeKNLhx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 06:37:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 96C4728085;
        Tue, 13 Nov 2018 20:36:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=16RUERB364SZvgawqqL4Hbh3Lwk=; b=TN60PU
        qABeOJq6SEJ6Dw9eunwE+4tfEblsyEZ+1VlGkwmb5lUKgOhMKEpim1+Nvksw562Y
        e4FJ4R5Zmv97+U4kIQEoJOMsPpDHn/CxGxg25K7KAuwx7pHxTsbjHRxLMnwS0871
        5rDYGHBFeuzDlqZIaUxDwHqKUo0GGt6ZrAqGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HbIKdfpkdgjUialKm4KVG/EsWbXVIH5c
        bAKVTXHugQTkOwpHLbK3bfcEObEVkdNTGSe2egC0nQeizO2vQrV0MPJWQflrw0H6
        MviiOvqKwLVldZRJL2eSdWage9hF2qBNJMpxRhUDjxVUNobD8+ULIeTMTg2BnEwk
        6NVtTPo6b+U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8FDD428084;
        Tue, 13 Nov 2018 20:36:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A189D28083;
        Tue, 13 Nov 2018 20:36:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 1/3] eoie: default to not writing EOIE section
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20181010155938.20996-1-peartben@gmail.com>
        <20181113003817.GA170017@google.com>
        <20181113003911.GB170017@google.com>
        <xmqqtvklzszv.fsf@gitster-ct.c.googlers.com>
        <5fae19dc-2e77-1211-0086-e7aa9d30562f@gmail.com>
        <20181113182502.GC68106@google.com>
Date:   Wed, 14 Nov 2018 10:36:49 +0900
In-Reply-To: <20181113182502.GC68106@google.com> (Jonathan Nieder's message of
        "Tue, 13 Nov 2018 10:25:02 -0800")
Message-ID: <xmqqzhuctp72.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2B44528-E7AD-11E8-B189-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>  1. Using multiple versions of Git on a single machine.  For example,
>     some IDEs bundle a particular version of Git, which can be a
>     different version from the system copy, or on a Mac, /usr/bin/git
>     quickly goes out of sync with the Homebrew git in
>     /usr/local/bin/git.

Exactly this, especially the latter, is the answer to your 
question in an earlier message:

>> Am I understanding correclty?  Can you give an example of when a user
>> would *want* to see this message and what they would do in response?

The user may not be even aware of using another version of Git that
does not know how to take advantage of the version of Git you have
used in the repository, and it can be a mistake the user may want to
fix (e.g. by futzing with PATH).  The message would help the user
notice the situation and take corrective action.  Users of IDEs that
bundle stale version of Git cannot even bug the supplier of the IDE
to make them more up-to-date if they aren't aware of it.
