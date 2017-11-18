Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DF48202A0
	for <e@80x24.org>; Sat, 18 Nov 2017 11:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030739AbdKRLgg (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 06:36:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58607 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1030735AbdKRLge (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 06:36:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 328D7B5FB0;
        Sat, 18 Nov 2017 06:36:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0DSkk4lo1lDO
        cDg8JyjS1nRAOy8=; b=ROPLNrY+jjds2nbySHHZ/wX6cGGXD22UdoN8/9vL6ZR/
        yNAhKeecoFElSe+XrFFIHGdhPi7YoRnfRKc/BHjWg4r8CsNHEZIi7AfUpznmOnZp
        iJSOb9hwaQ5jwX6yG3sKYqYtV9PjRB8aHzUACoY3WNSIFE5F9nQ7lM+dB1O31ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=b9c1aj
        OVj4yYgJqJShzXkAwdl6Kbz9uZDXf5S8zzjD+JWn8ufcqDeBQnY1Qs5pJVsJFosQ
        L+AbiVRy2sAwBsxAJQMf3iEwqk3rhIn/cCivbJPOE6VrdEceyy7vHaVmF0Rt81im
        BgOreK3pdAMOvpWgfQJiG6nG4cGa3/PBcGpV8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A749B5FAF;
        Sat, 18 Nov 2017 06:36:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95BD9B5FAD;
        Sat, 18 Nov 2017 06:36:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Is it not bug git stash -- <pathspec> does not work at non-root directory?
References: <CAC2Jkr+brEKLy-z45WwP2iqssA14na9xpaCoKrNKbPcTvtUxJA@mail.gmail.com>
        <xmqqzi7kp7j2.fsf@gitster.mtv.corp.google.com>
        <CAC2JkrLWVEHvV7tf24bPmVEDpgnrKTFtHR5UHMh+kC8v_fWumA@mail.gmail.com>
        <xmqqmv3kow92.fsf@gitster.mtv.corp.google.com>
        <CAC2Jkr+TkqnZ+rZVxZNv80rpJHf-BBNZqXZqW+hBVZ8hRrPRSw@mail.gmail.com>
Date:   Sat, 18 Nov 2017 20:36:32 +0900
In-Reply-To: <CAC2Jkr+TkqnZ+rZVxZNv80rpJHf-BBNZqXZqW+hBVZ8hRrPRSw@mail.gmail.com>
        (=?utf-8?B?IuWwj+W3neaBreWPsiIncw==?= message of "Sat, 18 Nov 2017 18:08:37
 +0900")
Message-ID: <xmqqine7q0n3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BA7ED0F0-CC54-11E7-B10B-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E5=B0=8F=E5=B7=9D=E6=81=AD=E5=8F=B2 <aiueogawa217@gmail.com> writes:

> I upgraded the version of git from 2.13.1 to 2.15.0 on Mac and fixed my=
 issue.
> Thanks.

Ah, yes, that bug was fixed in the 2.14.0 timeframe but was
backported to 2.13.2 and onwards (it was a bug in 2.13.0, I think).

