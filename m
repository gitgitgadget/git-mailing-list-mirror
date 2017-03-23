Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3149820958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756819AbdCWVdy (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:33:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56920 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751336AbdCWVdx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:33:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE4CE68E63;
        Thu, 23 Mar 2017 17:33:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nh97LTvwtYRx
        vg6rPr+W8MN/tIo=; b=oT0QPMwPxhnUj7hY0w7MxObjfuyLUefXXG3uCkzXbqBm
        zydDBynxrrKscqvQA960MqrlZIIGWt13zpf8YKONbsrZeASuEcjS1HMqNZkF2ioX
        GWNtv4EuKVQj0IuatRtpqm5VZFaWXKuLFTpiKKiB9ZP5KWk70OLyHQtoG31ymbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=chDCiS
        BwDCD2lC0NJtycxkFmXRE6UaOniwaZRIHxFp2rMrMtJimw3dQBet0T3ci8QyV5pm
        7+fJw3R0OxFKb5zA7JSAJmKgrI8kxUZrMCSNYZgcmWkdB58vIiwCHGZaEs6EVuET
        xNSfS63cD+KnYOWrY1fqPbq3fQdHfost59RsE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E64BC68E62;
        Thu, 23 Mar 2017 17:33:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A88068E60;
        Thu, 23 Mar 2017 17:33:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 12/16] tag: implicitly supply --list given another list-like option
References: <20170323130529.11361-1-avarab@gmail.com>
        <20170323130529.11361-13-avarab@gmail.com>
        <xmqqlgrvewak.fsf@gitster.mtv.corp.google.com>
        <CACBZZX6HnUZSV49c2uRqW3u-+Tc-5LtaaEG=Yype1155qR0ifw@mail.gmail.com>
Date:   Thu, 23 Mar 2017 14:33:50 -0700
In-Reply-To: <CACBZZX6HnUZSV49c2uRqW3u-+Tc-5LtaaEG=Yype1155qR0ifw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 23 Mar
 2017 21:32:40
        +0100")
Message-ID: <xmqqy3vvada9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 685281E2-1010-11E7-8BED-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Hmph, wouldn't we want to instead replace it with
>>
>>         ... something to set expectation ... >expect &&
>>         git tag -n 100 >actual &&
>>         test_cmp expect actual &&
>>
>> here?
>
> Nope, we already have detailed tests for "tag -n 100" and the like and
> what that output should actually return earlier in the patch,...

Then what you did is the right thing to do.  Thanks.
