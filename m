Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B3C91F463
	for <e@80x24.org>; Sat, 28 Sep 2019 23:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfI1Xbk (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 19:31:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62549 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfI1Xbk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 19:31:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 982D6844D4;
        Sat, 28 Sep 2019 19:31:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EJS1b95RPFNq
        s/uoSOzIsLierfs=; b=X691SoP87KyIAWCfaP50by9UQQZ55SA5U9rnzs8x+GgW
        CLSOUnpZgXRWTt9ZXSpZ3+B75dLWgmT+ZdJ1SL7epXIatAtMCa1+1xpqKlykCMz3
        +V3N3kA9n9akPzjfxMNajHwJN0VKRe7v76ofY69bC1vYP8CPNMnls4CbuN1PwgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rSJJ+6
        naKssSHU+/39IFKLxcIZAnw3ywUvdQeVymIzIZShWSFcTsAKz3XM0Yw/gHiVZzaP
        G05z+ms2R9WFuEHVIwY8f30NqCBk1qJNJaQoF5PcDp7ASFdQ4u2FNOCuBuTxy6U1
        ryfljQMdgCv7B3pFLKJZGOVqmYqDyTx/RMb74=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91FB1844D3;
        Sat, 28 Sep 2019 19:31:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C5841844D0;
        Sat, 28 Sep 2019 19:31:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2019, #01; Sat, 7)
References: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
        <20190909234715.GO11334@genre.crustytoothpaste.net>
Date:   Sun, 29 Sep 2019 08:31:33 +0900
In-Reply-To: <20190909234715.GO11334@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 9 Sep 2019 23:47:16 +0000")
Message-ID: <xmqq36ggj8ve.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1CAE65A0-E248-11E9-9D16-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2019-09-07 at 17:26:53, Junio C Hamano wrote:
>> * bc/object-id-part17 (2019-08-19) 26 commits
>> ...
>>  - builtin/replace: make hash size independent
>>=20
>>  Preparation for SHA-256 upgrade continues.
>>=20
>>  Looked mostly OK, with a possible update.
>>  cf. <20190820223606.GJ365197@genre.crustytoothpaste.net>
>
> Just to update on the status of this, I wasn't planning on a reroll,
> although I'm happy to do so if folks have feedback.  Opinions for or
> against the current state are welcome.

I've already said that this looked mostly OK, and I think you and
RR=C3=A9ne's "maybe adopt the use of oid_to_hex()s without using our own
buffer" can come after the dust settles, so let's move this forward
as-is.

That is, unless I hear otherwise in the next few days.

Thanks.
