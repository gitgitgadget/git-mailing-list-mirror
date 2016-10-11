Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A161F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 20:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbcJKUTd (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 16:19:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59001 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752047AbcJKUTd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 16:19:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CC0045893;
        Tue, 11 Oct 2016 16:19:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3vFh/hJ2msTR
        j14fxvHJ1sKZYRI=; b=JEx9+aYu5jxShztkAf8YGRnWGSNymjbPCalin7fH58r5
        UgZIhFPY2K9ETtOSGZC5uQSfqFZPHKJBqOBvv0kEfhBhsoAjtT3dmavB/2Fq8U+k
        QZJLTzcDK8EIIeXWFnlkIzL/Oo6I18RcsRjDdnCfrx6aWFpDOzrbTxXyxhGrbS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=US78Ey
        ckhaosbtnSYGbq+TovvNl8pq2OGSMGewKY5HvSmQ+QHye7ZpUw0Ju54atbHs/GKY
        tFduhvH+5jDje73VoLetmZnpYDJZd2TezzHVjoVa8w0Sf5JrSwuOf/kpKpo0oj/E
        CXv+zc/+eA4OMjM3DUWuiXMEqd8YUp6TwtREI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82CEA45892;
        Tue, 11 Oct 2016 16:19:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E99834588D;
        Tue, 11 Oct 2016 16:19:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] contrib: add credential helper for libsecret
References: <20161009123417.147239-1-grawity@gmail.com>
        <1476198080.3876.8.camel@kaarsemaker.net>
        <xmqqoa2q8ypl.fsf@gitster.mtv.corp.google.com>
        <c87e4dd4-7253-d7c2-010b-6d8c7f587093@gmail.com>
        <1476216585.3876.10.camel@kaarsemaker.net>
        <xmqqa8ea8wzy.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 11 Oct 2016 13:19:28 -0700
In-Reply-To: <xmqqa8ea8wzy.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 11 Oct 2016 13:13:37 -0700")
Message-ID: <xmqq60oy8wq7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0460AEF2-8FF0-11E6-AF7E-F99D12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>
>> On Tue, 2016-10-11 at 22:48 +0300, Mantas Mikul=C4=97nas wrote:
>>> On 2016-10-11 22:36, Junio C Hamano wrote:
>>> > Thanks for a review.  I'll wait until one of (1) a squashable patch
>>> > to address the "we do not want unconditional overwrite" issue, (2) =
a
>>> > reroll from Mantas to do the same, or (3) a counter-argument from
>>> > somebody to explain why unconditional overwrite is a good idea here
>>> > (but not in the original) appears.
>>>=20
>>>=20
>>> I overlooked that. I can write a patch, but it shouldn't make any
>>> difference in practice =E2=80=93 if c->username *was* set, then it wo=
uld also
>>> get added to the search attribute list, therefore the search couldn't
>>> possibly return any results with a different username anyway.
>>
>> Makes sense, so a (3) it is.
>
> So... does it mean the gnome-keyring one needs a bugfix?

Just so there is no misunderstanding, updating (or not)
gnome-keyring code is an unrelated issue. =20

I'll queue the patch under discussion in this thread, and if an
update to gnome-keyring appears, that will be queued separately.

Thanks again, both of you.
