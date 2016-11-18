Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6101FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 18:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbcKRSSp (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 13:18:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62363 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752367AbcKRSSn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 13:18:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 427074E248;
        Fri, 18 Nov 2016 13:18:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B4oPjoZ6WS0l1NvpDPrX9ScsUeY=; b=jtvKo4
        HzuqC9ccjy+Ke941wRGsPY8LCPaeklgu/StQwA05WoQ9/rbAeX+H4AwG5gZH/wvd
        WSQY1+It/iI3GYE48I3be7sX2Tg6GqQa4xIKg4YK6IOCa3n9ppYUp0VaWXnJTQxK
        nicMaw+FjzR7lycyJp5cXIMFomBiVzJLKNpc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mYxBXXYFxXerQYdoR/Uv7ddqIGi17UYz
        y6TCGs2hgcm5b/J79T9ojq80SBn17b2lXrt1Y9Wn6pV+ZeFo5ZPszADv/wSMrmpH
        7Sy5ypzsis11qI78+ujzowJTqiDUuJorhOrdYQ4djNur3zU8CTYYprPcpZ9VrOQ7
        TcqHgcgtFqc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38FF34E247;
        Fri, 18 Nov 2016 13:18:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A002D4E246;
        Fri, 18 Nov 2016 13:18:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for ref printing atoms
References: <20161108201211.25213-1-Karthik.188@gmail.com>
        <20161108201211.25213-14-Karthik.188@gmail.com>
        <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
        <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
        <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com>
        <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
        <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com>
        <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
        <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com>
        <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com>
        <CAOLa=ZSaTdACC60g6D6k5frjKkChbkBL8+kLJjNgoutLSe8mOQ@mail.gmail.com>
        <xmqqmvgynee4.fsf@gitster.mtv.corp.google.com>
        <CAOLa=ZTVTZ+1dXpcp=kdoGbT1Feq=vOfFpNpBiZepajMucraPQ@mail.gmail.com>
        <CA+P7+xo847HRkm1Kur0mdB15OgwVMOckuK5fXNMkPxDGkK1XGA@mail.gmail.com>
Date:   Fri, 18 Nov 2016 10:18:39 -0800
In-Reply-To: <CA+P7+xo847HRkm1Kur0mdB15OgwVMOckuK5fXNMkPxDGkK1XGA@mail.gmail.com>
        (Jacob Keller's message of "Fri, 18 Nov 2016 00:19:42 -0800")
Message-ID: <xmqqpolsmz28.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F273614-ADBB-11E6-B82D-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>>>> to get remotes from /refs/foo/abc/xyz we'd need to do
>>>> strip=1,strip=-1, which could be
>>>> done but ...
>>>
>>> ... would be unnecessary if this is the only use case:
>>>
>>>> strbuf_addf(&fmt,
>>>> "%%(if:notequals=remotes)%%(refname:base)%%(then)%s%%(else)%s%%(end)",
>>>> local.buf, remote.buf);
>>>
>>> You can "strip to leave only 2 components" and compare the result
>>> with refs/remotes instead, no?
>>>
>>
>> Of course, my only objective was that someone would find it useful to
>> have these two additional
>> atoms. So if you think it's unnecessary we could drop it entirely :D
>>
>> --
>> Regards,
>> Karthik Nayak
>
> I think having strip and rstrip make sense, (along with support for
> negative numbers) I don't think we need to make them work together
> unless someone is interested, since we can use strip=-2 to get the
> behavior we need today.

I am OK with multiple strips Karthik suggests, e.g.

    %(refname:strip=1,rstrip=-1)

if it is cleanly implemented.

I have a bit of trouble with these names, though.  If we call one
strip and the other rstrip, to only those who know about rstrip it
would be clear that strip is about stripping from the left.  Perhaps
we should call it lstrip for symmetry and ease-of-remembering?

    refs/heads/master:lstrip=-1 => master (strip all but one level
    from the left)

    refs/heads/master:rstrip=-2 => refs/heads (strip all but two
    levels from the right)

    refs/heads/master:lstrip=1,rstrip=-1 => heads (strip one level
    from the left and then strip all but one level from the right)

I dunno.
