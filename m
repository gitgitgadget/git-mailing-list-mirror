Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFFF41F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 01:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKSB3S (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 20:29:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63312 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKSB3R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 20:29:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB0068B6D5;
        Mon, 18 Nov 2019 20:29:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DuScYb3zwmhit6s6ofUxGvriyOM=; b=PH9ZRU
        VV4yGrMCbL5oGAuS2f3oNOUf1TDbEwz19q2V1qFogBxQqtqddO++aJmWchfIV2wN
        5NvBVOGzXwL8YenBZRZvSjbf9Z1A1vewC5Dc8H4IDvuDOOGDOuTsGKKWWjRPMpw5
        GPVDvjK5x4EGVEfZuOCjpY7MnfUZjYdLb30Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kYh21N9tAkN/sobQkCkik5lyqVMGpaFs
        S7bYbmgRa07WfwmH3a9MErI2aThY2h++BE+UsFVcu0aSu6CtgXZVgqItR0QbXA/0
        sNrFN2ZiILxdbq5k0Wlp0IIMarwQ9Qjn5hM6vc6R4/s808NAVA53+0oCG35HEoRN
        tzJp3rB6ork=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A355B8B6D4;
        Mon, 18 Nov 2019 20:29:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CFB5A8B6D3;
        Mon, 18 Nov 2019 20:29:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] build-in add -i: implement all commands in the main loop
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
        <xmqqlfsd3omz.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911181940020.46@tvgsbejvaqbjf.bet>
Date:   Tue, 19 Nov 2019 10:29:10 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911181940020.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 18 Nov 2019 19:53:43 +0100 (CET)")
Message-ID: <xmqq36ek1wnt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE132B7A-0A6B-11EA-B229-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Preparing the "add -p" machinery in such a way that "add -i" merely
>> is one of the users would make a lot of sense from organizational
>> point of view.
>
> If I understand you correctly, you mean that e.g. `git checkout -p` will
> call the code from `add-patch.c` directly?...

Yup, and it is a good organization that the "add -p" machinery is
held not too intimate with the rest of "add -i" but treats "add -i"
as just one of its users from the beginning, which is what you did
here.

In case it wasn't clear, I am saying that I like the resulting
organization of these 8 patches.



