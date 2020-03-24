Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6635DC10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 23:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF4E20724
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 23:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZegvsBU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCXXk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:40:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64298 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgCXXk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 19:40:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D2BF4D274;
        Tue, 24 Mar 2020 19:40:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=NQckaZ1s54amD6UWeOS+7oqOix4=; b=ZegvsB
        U/8A2cWxDes6u6rklGDwIsB7ooOfxCsCH/P3rFp9KQlVWU3sGrEiSYRlxeR0dUaH
        SauOf+WiPNou+M3qsx6+WM4lj0ecu140YxVc9+xn+fkGLxHtO23eUjnBejzkFc+T
        WRU4wVghlm6WZLpISXwXoHGaXAlg2A0pQKXp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Szr+7m1paV15NOYjoUuUkpjxWGRcr0kB
        AJuqycfybV5dpWpvCL/7Usjo0K5xgz2JSMF2J6SaNEjd+oNm1RGY+RFPUicifthT
        U8OW59lzenP7/WtU9KmGCTsIeXxzkcI5HuMtBwbhqa2S0j6vEyRqDRB2V1/BRycz
        yflrn9fVGDM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3592F4D273;
        Tue, 24 Mar 2020 19:40:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B028C4D271;
        Tue, 24 Mar 2020 19:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] tests(gpg): allow the gpg-agent to start on Windows
In-Reply-To: <nycvar.QRO.7.76.6.2003242326190.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 24 Mar 2020 23:26:36 +0100 (CET)")
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <287a21f1033b2a74420029c529ad4db956051a85.1584968990.git.gitgitgadget@gmail.com>
        <xmqqd09355h7.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2003242043050.46@tvgsbejvaqbjf.bet>
        <xmqqh7yd1nbh.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2003242326190.46@tvgsbejvaqbjf.bet>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Tue, 24 Mar 2020 16:40:26 -0700
Message-ID: <xmqqo8slz5hx.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6A8C6D2-6E28-11EA-8BF9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 24 Mar 2020, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > I fear that this distinction really is lost on anybody who does not have
>> > to deal with MSYS2 on Windows.
>> > ...
>> > In short: I am convinced that this is a subtlety in our test suite that we
>> > cannot reasonably expect any contributors other than Windows-based ones to
>> > get right, and I am fairly certain that we will just have to keep
>> > monitoring the CI/PR builds for similar issues and then help the
>> > contributors by suggesting the appropriate fixes.
>>
>> IOW, this cannot be made an engineering problem and has to stay a
>> black art? ;-)
>>
>> That's somewhat sad, but I guess we have to live with it.
>
> I am afraid so.

As long as there are our users on Windows, we can trust that we'd
have some folks who are as familiar as you are with these
subtleties, even if you may get bored working on it yourself,
leaving us with the right bus factor, right?  ;-)

Thanks.
