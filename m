Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1ACC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 19:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DC1239ED
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 19:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgLQTnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 14:43:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52663 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQTnV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 14:43:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03D2110677A;
        Thu, 17 Dec 2020 14:42:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WMw6L/fWNRFb
        zA1ttJ/3CXMOgBo=; b=JRn8UYXbRla+lNFF2z7XcBMv7CGzQGDlpIG4Wtk1Rtc9
        0BGf3AozTtpQNXVwLfRUhobld1lm2vyF/bGLwit0uTmdZ3m35ySznJT5KC24wOjx
        LJq0hWda6avhfxlTQIehb3lXtWxOoIYe1VuER3y08yYtUAd4m1q6E7xuFDMzqL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EVmdE3
        oEUbNUSt5gpc05yD0bTEkXMWFYvc7e12efU3Jje2BiSURNsyd1UWGj084SRDb3B1
        IiUk+v0wncZrZ3ptbIPKi0lUHlRdsD3ymoCVH4RCwxzfpi4fgbvNyg8S1rVqx4w4
        PQtBZYqtQQSP/Q81K/PBFL7eVMwElYrprin3c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EFECD106778;
        Thu, 17 Dec 2020 14:42:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 42714106776;
        Thu, 17 Dec 2020 14:42:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Fwd: Bug in `git add -N xyz ; git stash` command
References: <CAHMHMxW-LwjLWF9PPuSJmbAafw37d_18j+HmOd4+8MKbajb_8A@mail.gmail.com>
        <CAHMHMxW_zwq_xK3Mh5QjC4dM1muVotESZdGQkRAx8xeKYmHzbw@mail.gmail.com>
        <xmqq1rfp4l35.fsf@gitster.c.googlers.com>
        <CAHMHMxUdt1cxE1UkjbjUxpL=4fcjrE64udR6YJidbzLJS0ca2w@mail.gmail.com>
Date:   Thu, 17 Dec 2020 11:42:36 -0800
In-Reply-To: <CAHMHMxUdt1cxE1UkjbjUxpL=4fcjrE64udR6YJidbzLJS0ca2w@mail.gmail.com>
        (=?utf-8?B?Is6jz4TOsc+Nz4HOv8+CIM6dz4TOrc69z4TOv8+CIidz?= message of "Thu,
 17 Dec 2020 10:43:20
        +0200")
Message-ID: <xmqq1rfoz0b7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 04B53E80-40A0-11EB-953E-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 =CE=9D=CF=84=CE=AD=CE=BD=CF=84=
=CE=BF=CF=82  <stdedos@gmail.com> writes:

> Not deciding to fix that (or not agreeing on how to fix it), should be
> orthogonal from the "what does the error message says" about it.
> I would expect something like "'xyz' is marked with intent-to-add;
> either stage (git add xyz) or remove the file (git ... xyz); refusing
> to stage."

"refusing to stash", you mean?

I think that your wording may be an improvement.  Care to whip up a
patch?

Thanks.
