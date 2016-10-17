Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48501F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 19:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935559AbcJQTQT (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 15:16:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58577 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935062AbcJQTQR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 15:16:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FD7947BC4;
        Mon, 17 Oct 2016 15:16:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xr77kNneYtXeAaEt+mVqueLEfGA=; b=ABG9sH
        igaFxuyF+4/yoob+Kp2euKBGcgl/syFZwjRlqM5fqczbxpQxsX8Xq2lfRqGNqCzI
        vwCgIhpqrnZIAdaqCIliowLI/mrUM2v37WxVOWDpHyhSDxmvicDzsr/AIyAMYBh/
        FffQxABnOflcv2lTsH7pC8oU/H6NA21aONxA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZC6qbULIDV8m82dgGq+HVTRyfyR4gbnL
        0cptfP1e+E+YvQcOis/lCghPWgjeHNGq44nFF846own5IGY2AquKloWsFjNLo6e4
        9CjiHrM1+6/yrXIS92vXXkGo+vgA1gcF6vQJiSvZTeuZXULwSKn1/U6oOehAjWoy
        JkdzNI5RYM0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1764047BC3;
        Mon, 17 Oct 2016 15:16:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 63B4947BC1;
        Mon, 17 Oct 2016 15:16:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 1/2] submodule: ignore trailing slash on superproject URL
References: <20161010175611.1058-1-sbeller@google.com>
        <alpine.DEB.2.20.1610121501390.3492@virtualbox>
        <CAGZ79kYDpth7YDbN0VRD0dcpp7aeQ-y4HSEhsmd_c46ggZoXsg@mail.gmail.com>
        <alpine.DEB.2.20.1610131255001.197091@virtualbox>
        <xmqqfunvxxgu.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYW2qK1GKxoKy_mkVkjjqEUzkh5aPSzDEfRd6U=PYDdzw@mail.gmail.com>
        <xmqqh98avnhh.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZvRf0gHA7tBh1veS9YzAWZ0j0SMGL3c9QQOrERMjmuyQ@mail.gmail.com>
Date:   Mon, 17 Oct 2016 12:16:08 -0700
In-Reply-To: <CAGZ79kZvRf0gHA7tBh1veS9YzAWZ0j0SMGL3c9QQOrERMjmuyQ@mail.gmail.com>
        (Stefan Beller's message of "Mon, 17 Oct 2016 11:58:52 -0700")
Message-ID: <xmqqvawqu6pz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2996EE36-949E-11E6-8793-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Where at the end-user facing level does this trailing "/." surface
>> and how does the difference appear to them?  I think that is the
>> crucial question.
>>
>> Unless there is some convincing argument why "." is not special
>> (i.e. counter-argument to the above "bus vs sub" and ". vs sub"
>> example), I would think "existing users with /." does not matter.
>> If they are "relying" on the behaviour, I would think it is not
>> because they find that behaviour intuitive, but only because they
>> learned to live with it.  IOW, treating all of A/B/C the same way
>> would appear to them a strict bugfix, I would think.
>
> I see, so we should adapt the windows style and chop off '/.'
> to make A,B,C all the same, because internally we never produced
> C AFAICT.
>
> These came in via hand edited .gitmodules files.

Can you elaborate a bit more on this?  

Without seeing "The user added X/. instead of the usual X because
s/he wanted to see Y happen.  If s/he had X there, Z would have
happened instead of Y" and why being able to expect Y to happen is a
good thing (compared to Z), we may fail to notice why the more
"intuitive" (at least to me) "these three must result in the same
outcome: path/to/dir, path/to/dir/, or path/to/dir/." does not serve
a legitimate use case.
