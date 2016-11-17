Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E31CD1FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 18:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754405AbcKQSfU (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 13:35:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57215 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751335AbcKQSfT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 13:35:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAC7050DFE;
        Thu, 17 Nov 2016 13:35:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fxuz3rf7il+clKvpEtOC7GD29m4=; b=IfUNFs
        Pv4towPh3UezWCPg15VL6UkNCt0GbD3Dc30W90+WhVo+Eb2vruf/+xubDDv8LWl0
        ziCCloa1wRIEN7oxMsc+InXuR26QTJQ/q7q+3aDbZH1xaxuR/sVKG507ZOv1wnzE
        nPvOuFFKfJYKFoR+rg2SNdS3WxE2bZ1U70eoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XY1VPhssUiQLuzkQLhj9XJ1HCFj/nRUa
        ca2hMR+ll0vAryJ+QKOgbmkDAIUyFAo7WaySfCVCenwViewSk7b55O7zCpkyw5WG
        eKReAtSWKeAl2R1mWApZe8j6nbw8cbGIWmwF+hcJn8kA+pjkUmtQlTTOBenrmksl
        v8SBnFH4FuI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2A7950DFD;
        Thu, 17 Nov 2016 13:35:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D1E650DFC;
        Thu, 17 Nov 2016 13:35:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
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
Date:   Thu, 17 Nov 2016 10:35:15 -0800
In-Reply-To: <CAOLa=ZSaTdACC60g6D6k5frjKkChbkBL8+kLJjNgoutLSe8mOQ@mail.gmail.com>
        (Karthik Nayak's message of "Wed, 16 Nov 2016 13:28:35 +0530")
Message-ID: <xmqqmvgynee4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 960BC5AA-ACF4-11E6-9D5D-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> On Tue, Nov 15, 2016 at 11:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jacob Keller <jacob.keller@gmail.com> writes:
>> ...
>> I think you are going in the right direction.  I had a similar
>> thought but built around a different axis.  I.e. if strip=1 strips
>> one from the left, perhaps we want to have rstrip=1 that strips one
>> from the right, and also strip=-1 to mean strip everything except
>> one from the left and so on?
> ...

> If we do implement strip with negative numbers, it definitely
> would be neat, but to get the desired feature which I've mentioned
> below, we'd need to call strip twice, i.e
> to get remotes from /refs/foo/abc/xyz we'd need to do
> strip=1,strip=-1, which could be
> done but ...

... would be unnecessary if this is the only use case:

> strbuf_addf(&fmt,
> "%%(if:notequals=remotes)%%(refname:base)%%(then)%s%%(else)%s%%(end)",
> local.buf, remote.buf);

You can "strip to leave only 2 components" and compare the result
with refs/remotes instead, no?

