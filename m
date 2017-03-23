Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E85920958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753977AbdCWVjE (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:39:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54896 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754211AbdCWVjC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:39:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A62968FCC;
        Thu, 23 Mar 2017 17:39:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gH2mUPwz08E6
        If7TeqIXm8QsB9M=; b=X6UR7G0mVtnhmBdukjE+Qgm+XWxSgVOEy2dvtVGnQl1L
        tnaGEE4EKL0H9Mc7UE/WOPXCU57HbTrrPHuuIMkt/5ZOx4XFQdGeTj5RcCLbgSSL
        tdcegXxXIJyEC8WYOx8gbCa75jrcX6JzyYNaAJrMaEgCGfgCYmHlwPrkA3yPoSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Tan2JT
        lVltlHhVaQ59k2JeMfEMfdij0vq3jMu9esk6/rvX/PsVJzZf9XEhYWsvqrL+DnrS
        UltwaHzIptm189Tdjlc3FnNW4I7APX//uDjfOjftBdmlPTGfUwkZfNKnZjuN8NlX
        OBK3UxkZzeqp2ZjDdMmRU+cHyryrDdYmIwQx8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71BB168FC9;
        Thu, 23 Mar 2017 17:38:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2FE268FC8;
        Thu, 23 Mar 2017 17:38:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ulrik Sverdrup <ulrik.sverdrup@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug: Revert with -m 0 says no -m was given
References: <12e6fae3-a341-3dcd-0920-c3df2d54d0a8@gmail.com>
        <xmqq4lyjeu5m.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5e-p4gKSWxehhVnnSgApC9H2v_ud+1Drz-vu_OAZwCgg@mail.gmail.com>
Date:   Thu, 23 Mar 2017 14:38:57 -0700
In-Reply-To: <CACBZZX5e-p4gKSWxehhVnnSgApC9H2v_ud+1Drz-vu_OAZwCgg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 23 Mar
 2017 21:39:41
        +0100")
Message-ID: <xmqqmvcbad1q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1FA45514-1011-11E7-B33E-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Mar 23, 2017 at 7:15 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Ulrik Sverdrup <ulrik.sverdrup@gmail.com> writes:
>>
>>> Git produces a misleading error when you tell it `git revert -m 0`.
>>
>> Thanks.
>>
>> I think this is the same issue as the one with 'cherry-pick' that
>> was reported earlier.  We have a fix in the 'master' branch already;
>> please try it out.
>
> Specifically, in master:
>
> $ ./git revert afd6726309
> error: commit afd6726309f57f532b4b989a75c1392359c611cc is a merge but
> no -m option was given.
> fatal: revert failed
> $ ./git revert -m 0 afd6726309
> error: option `mainline' expects a number greater than zero

Yes, exactly.

Thanks.
