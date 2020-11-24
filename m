Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCC7C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F012076E
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hDC6wzm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgKXUxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 15:53:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57242 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgKXUxm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 15:53:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F9C4FA5A5;
        Tue, 24 Nov 2020 15:53:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1xGjBEjZK/NUCPlQNgYnE7PbLgs=; b=hDC6wz
        m8xDD17y60mbSIwPrVcOp9RKms12dFzaAx7SZGvk7uBVbibv4hy5kjhwlsy38N2b
        ieyB7B537le3PHLAt7dAIc5enizDC865WVSKzkVMfRCy6f5SCTzUF/+jQY22iUdw
        EN97sLVvnurs21lKKJSvRbPOiNReF5WAZJFWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cA2hO27fWLGvrO5Cv6op8ohXBdFkCz9X
        8LHZ5Q1xLdBHGWCykH96wY71SH+pn7ZOoIw/FEXZpM+SPAlaja4By6yksaACLWDo
        4fF6KU0niFjiA4tJjChpGmPcUHKVnki/yDj4r5HEIGtGvMDQVqa8XEaf/Y5z7RuI
        Jkwbc3XvAuc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 496FFFA5A4;
        Tue, 24 Nov 2020 15:53:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8C976FA5A3;
        Tue, 24 Nov 2020 15:53:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] init: provide useful advice about
 init.defaultBranch
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
        <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
        <bccef953913da629057b3e9b211bc54081fa4475.1606173607.git.gitgitgadget@gmail.com>
        <xmqq8sarljfn.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011240648160.56@tvgsbejvaqbjf.bet>
Date:   Tue, 24 Nov 2020 12:53:36 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011240648160.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 24 Nov 2020 06:57:16 +0100 (CET)")
Message-ID: <xmqq8saqjx2n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 208BC63A-2E97-11EB-980B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>     To configure the initial branch name to use in all of your new
>>     repositories and squelch this message, run:
>>
>> may be better---it makes it clear that the offered two choices are
>> (1) do nothing and see this message every time, or (2) commit to a
>> name and not see this message again.
>
> Well, I think I finally understand what you are saying: there is a
> legitimate need for a way to go with Git's preference but still suppress
> that message.

I am not saying it is a legitimate need.  I just wanted to make it
clear that we deliberately chose not to grant that wish in the
message.  An advice flag in this context means that the users can
choose to let their distro and sysadm to flip the default silently,
which is much worse than having to see the message every time they
start a new repository with "git init".


