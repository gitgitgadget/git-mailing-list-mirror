Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC750C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 16:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbiCAQxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 11:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbiCAQw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 11:52:58 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3066551
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 08:52:17 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BABB10EC97;
        Tue,  1 Mar 2022 11:52:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HcRJbrqNYpxt6VmXyzaNe7xaHJZBlUL7b6y4PB
        Te72k=; b=ICFAO4mFKdPB3ZT3FdnkxBJ0MFIxEujeJ4Cd3emelOTupX+i5SQg+6
        DhY22tbwVrdxaBDrB+cFeohvxijMwfVNMxcjJ8TjOOYpLei1XMIheIEzYYI5HRqm
        buQD6YVMKoL3td5s4gnsjHS+rrJBMDdEGx/Ue1zGeKfl//fHKUd2M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93AB710EC96;
        Tue,  1 Mar 2022 11:52:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED66B10EC95;
        Tue,  1 Mar 2022 11:52:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
        <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
        <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
        <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
        <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
        <xmqqv8x2dd7j.fsf@gitster.g> <xmqqzgmd5uzu.fsf@gitster.g>
        <xmqqee3mwf7k.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2203011111150.11118@tvgsbejvaqbjf.bet>
Date:   Tue, 01 Mar 2022 08:52:12 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2203011111150.11118@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 1 Mar 2022 11:18:07 +0100
        (CET)")
Message-ID: <xmqqilsxsjib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1E5803C-997F-11EC-AF22-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Let me again state my goal clearly, because some readers seem to be
> confused and believe that I want to improve the developer experience of
> veterans of the Git mailing list who are more than capable of finding
> their way through the build failures.
>
> My goal is instead to make new contributors' lives easier.

I understand who your primary target audiences are, and making them
happy without robbing too much from others is a good thing to do.
Instead of "Nah, this is not targetted for me" and ignoring the
topic, I have been reporting my dogfood experience exactly to help
that process---to notice if this variant worsens end-user experience
and see if that is within the reasonable pros-and-cons tolerance,
especially because they will start noticing the same hiccup as new
contributors stay longer and gain experiences.

> In any case, thank you for integrating the patches into `seen` so that the
> impact of the patches can be "seen".

No, do not thank me.  Thank yourself for writing it, and thank
others to try it and tell you their experiences to help you make it
better.

Thanks.
