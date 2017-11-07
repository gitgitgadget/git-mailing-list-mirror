Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED8120A10
	for <e@80x24.org>; Tue,  7 Nov 2017 00:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbdKGAUN (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 19:20:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62330 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933642AbdKGAS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 19:18:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC51BA4738;
        Mon,  6 Nov 2017 19:18:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=t57XNU41RFxq
        nLHNQvrLFDrogig=; b=mpW9D4pG8ekRvwY9BmroaNDSUEJzpRX/ZpZK8djzDbY7
        qcvfF+EDrNIcMjH4VEMl9FmGxxSBieX7K+GyP6lhUzqXCcSIpGXI2j2q6qgRkQyj
        8gqubvAPlMeNzbLAMmGUqGhz6TePZu8dm41u/DtO7dX8aNVVzRt0bw7YTi6gO3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=M9XVMa
        mlp+dFRVq/P7ZC/zxxgCWi8uHVfsPniQM8dnDJ8YqDwa0CtgU+sOaqvwSLav5yaX
        2mhBfVtY3aFBNIlPns6/uK4V7r60Raj/ynIyEBaKMCn+n9rFzitrA4GHMu18BxH1
        fia3RalC/NE/ODYJwSmOxK93H523Y8Cav7nQk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D3C7BA4737;
        Mon,  6 Nov 2017 19:18:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 331E3A4736;
        Mon,  6 Nov 2017 19:18:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        git@vger.kernel.org, me@ikke.info, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi
Subject: Re: [PATCH v1 2/2] log: add option to choose which refs to decorate
References: <20171104004144.5975-1-rafa.almas@gmail.com>
        <20171104004144.5975-3-rafa.almas@gmail.com>
        <xmqq60aqn1ok.fsf@gitster.mtv.corp.google.com>
        <B24042DB-BB27-41DE-82B7-5F3ED502D7D0@gmail.com>
Date:   Tue, 07 Nov 2017 09:18:56 +0900
In-Reply-To: <B24042DB-BB27-41DE-82B7-5F3ED502D7D0@gmail.com> (Jacob Keller's
        message of "Mon, 06 Nov 2017 12:10:40 -0800")
Message-ID: <xmqqbmkfhrf3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F7BE0FC-C351-11E7-A2FE-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On November 3, 2017 8:49:15 PM PDT, Junio C Hamano <gitster@pobox.com> =
wrote:
>>Rafael Ascens=C3=A3o <rafa.almas@gmail.com> writes:
>>
>>Why should this be a special case that burdens users to remember one
>>more rule?  Wouldn't users find "--decorate-refs=3Drefs/tags" useful
>>and it woulld be shorter and nicer than having to say "refs/tags/*"?
>
> Actually, I would expect these to behave more like git describes
> match and exclude which don't have an extra /*. It seems natural
> to me that glob would always add an extra glob, but.. I don't
> recall if match and exlude do so.

I would have to say that the describe's one is wrong if it does not
match what for_each_glob_ref() does for the log family of commands'
"--branches=3D<pattern>" etc.  describe.c::get_name() uses positive
and negative patterns, just like log-tree.c::add_ref_decoration()
would with the patch we are discussing, so perhaps the items in
these lists should get the same "normalize" treatment the patch 1/2
of this series brings in to make things consistent?

> That being said, if we think the extra glob would not cause
> problems and generally do what people mean... I guess consistent
> with --glob would be good... But it's definitely not what I'd
> expect at first glance.

FWIW, what describe --match/--exclude do is not what I'd have
expected ;-)  In any case, we spotted an existing inconsistency that
we would want to resolve (the resolution could be "leave it as-is";
I do not think we have thought this through enough yet), which is
good.

Thanks.

