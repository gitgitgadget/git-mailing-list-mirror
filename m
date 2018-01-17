Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75BC61F404
	for <e@80x24.org>; Wed, 17 Jan 2018 01:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750861AbeAQBc4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 20:32:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52495 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeAQBcz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 20:32:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9891B90D6;
        Tue, 16 Jan 2018 20:32:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XWW57orc9gYv
        DwkFXPTvOaa4nSA=; b=Hr0KoStLihmu/mclCii5qOvFBlytaY/dDqt/AJoaFl6s
        kkvsZ9v4rOy4Ilb+oiQsJsk1aYQx2ZBrG4auGFQESW+4PF5XVW1XXbEUm3N+Wgez
        A3IELxCa0saIn5MSK+G3Yiv8JmE5CWq5AQeOiqM76AOew4hbxSeIN3dIo3pgo3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PUeIL8
        oTNUGDRzaWVotgrpoLsL9Sb5+DaDNpXh0W6RiocczqVD+1VS1pYaJY856xG3j48e
        wv/wUe0SDINcpvMSvKk3+zkux8F3bDNxI+BNWRbQ9uwGO1AnhbeBfYNYyNOp+DNf
        zwHDZovoRYmFF06ohah1O5LasKCS7dDMOlGR0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1D6DB90D5;
        Tue, 16 Jan 2018 20:32:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23251B90D4;
        Tue, 16 Jan 2018 20:32:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 6/7] trace.c: print env vars in trace_run_command()
References: <20180112095607.18293-1-pclouds@gmail.com>
        <20180113064949.6043-1-pclouds@gmail.com>
        <20180113064949.6043-7-pclouds@gmail.com>
        <xmqqmv1dtptj.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbWvxoBtcU9iKPHSy_Agz-ko_KSE_M9budrtCOq7-Swdw@mail.gmail.com>
Date:   Tue, 16 Jan 2018 17:32:53 -0800
In-Reply-To: <CAGZ79kbWvxoBtcU9iKPHSy_Agz-ko_KSE_M9budrtCOq7-Swdw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 16 Jan 2018 14:20:53 -0800")
Message-ID: <xmqqwp0hs20q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 56D568D8-FB26-11E7-A3FA-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Jan 16, 2018 at 2:13 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>>
>>> +test_trace() {
>>> +     local expected=3D"$1"
>>
>> Style: "test_trace () {" is how we start a shell function.
>> Portability: we do not use "local".
>>
>>> +     shift
>>> +     GIT_TRACE=3D1 test-run-command "$@" run-command true 2>&1 >/dev=
/null | \
>>> +             sed 's/.* run_command: //' >actual &&
>>> +     echo "$expected true" >expected &&
>>> +     test_cmp expected actual
>>
>> Consistency: everybody else in the test script contrasts "actual" vs
>> "expect" (they happen to be of the same length ;-); don't say
>> expectED just to be different.
>
> 3491 entries in the t/ directory disagree with your imagination of
> consistency. ;)

Heh.  I thought it was clear enough from the context that I was
talking about matching the remainder of the same test script; I do
not have time time to count 'test_cmp expected' in all others in t/
;-)

> But I agree that we want to go for consistency, and most likely it's
> best to go for 'expect'.

It is unclear if you are volunteering, but do not change things for
the sake of making them consistent.  Not adding new ones and fixing
existing ones when they need to change anyway for some other reason
is the way to do this without unnecessary code churn.

