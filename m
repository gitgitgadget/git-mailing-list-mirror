Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A17C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 19:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606A420870
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 19:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xm1EGR+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgGATyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:54:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65277 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGATyo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 15:54:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 765CCC08C5;
        Wed,  1 Jul 2020 15:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kn2IGTdP4r8h/N83t8n9lkneAJk=; b=Xm1EGR
        +a/7q7GWJXT+MfqCRqS1lVqJastzmVPFy7aSCteTiRELbRtDhSqpur40rYqF4Hmz
        kGUjoxDENmDB5HLzvqL6XR3ouv02FpO/eaPu1TKhGQkl1gQOnVxWUq8hnXoeDOvA
        cB0GnpaV+Jn2auUhEsN2JGhw2fxw3sl95DqCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lMdgRICpGkNQXgoaxRr4j8SEvh6dHHB+
        TJmotkttaBDYoJUnyYo82JsUdE/VFRjyrlOakePryS1kqhxdULNqGYDb5g7ucHY5
        1AMqS91VieUebmGWZXUCDrSh86I2Bxo5NIam7GOiuAbnj7mjNiTa2nBTRXKKdPOt
        jF4sa9Lz1i4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C698C08C4;
        Wed,  1 Jul 2020 15:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B41ABC08C2;
        Wed,  1 Jul 2020 15:54:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4 1/9] fmt-merge-msg: stop treating `master` specially
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
        <fffdb9944fc2672ccb7eac776cdd18855a1f99dc.1593009996.git.gitgitgadget@gmail.com>
        <20200629162003.GD20303@danh.dev>
        <nycvar.QRO.7.76.6.2006291520220.56@tvgsbejvaqbjf.bet>
        <20200630150533.GF20303@danh.dev>
        <nycvar.QRO.7.76.6.2007011237330.56@tvgsbejvaqbjf.bet>
Date:   Wed, 01 Jul 2020 12:54:38 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2007011237330.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 1 Jul 2020 12:39:07 +0200 (CEST)")
Message-ID: <xmqq366bdn9d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2ED27A2-BBD4-11EA-A17A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> In _my very opinion_, I don't think it's that critical.
>> We allow git merge --edit and git fmt-merge-msg -m.
>> ...
>
> True.
>
>> If there're a consensus on changing those documentation,
>> I won't mind to do that manual work ;)
>
> I actually agree that it is not _really_ necessary.
>
>> The test is a different story, since some (or most?) distro enable
>> check (or test) phase for their build infrastructure.
>> And, we shouldn't break their infrastructures.
>
> Actually, the hit in t7606 is in the initial _comment_. So I highly doubt
> that it would break any build infrastructure to leave it alone.

I guess it's settled, then.

Thank you to all for being extra careful.

