Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C226CC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A270760E78
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhGZWqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 18:46:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52456 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbhGZWqY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 18:46:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB35E155515;
        Mon, 26 Jul 2021 19:26:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MSjCmAeNexqm
        bpjnzWz0a5RSVRCGg5fpjPJOqwzyIyE=; b=FTP+4KUX/eOaN33oKlJbJjBm5bhL
        H8qCCT4M0GRuO4yg3LxepYiY8JP6pXFoU70ebfv8SMhBI2RIx4bbtpUKzasWfpya
        Ra0PXY4XoOgAEC9vMznrX812BSJ8aaLDl6Ots3Qs2yy7CjCI+bORrKWVWCif2Jq4
        SWOerZAFytf8uvU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A21A9155514;
        Mon, 26 Jul 2021 19:26:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E711D155512;
        Mon, 26 Jul 2021 19:26:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 12/34] fsmonitor-fs-listen-macos: stub in backend for
 MacOS
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
        <587580489473a7a2ad665bdf3c482ea5d2c54f61.1625150864.git.gitgitgadget@gmail.com>
        <87sg0xbq9v.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2107161748050.59@tvgsbejvaqbjf.bet>
        <871r7yxkq8.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2107262338320.55@tvgsbejvaqbjf.bet>
Date:   Mon, 26 Jul 2021 16:26:48 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2107262338320.55@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 26 Jul 2021 23:40:18 +0200 (CEST)")
Message-ID: <xmqqr1fkfyh3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F3D312D2-EE68-11EB-A2D9-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi =C3=86var,
>
> On Fri, 16 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Fri, Jul 16 2021, Johannes Schindelin wrote:
>>
>> > So you suggest that we name the new stuff after an `uname` that
>> > reflects a name that is no longer relevant? I haven't seen a real
>> > Darwin system in quite a long time, have you?
>>
>> It's not current? On an Mac Mini M1 which got released this year:
>>
>>     % uname -s
>>     Darwin
>>
>> We then have the same in config.mak.uname, it seemed the most obvious
>> and consistent to carry that through to file inclusion.
>
> Sorry. I assumed that you knew that Darwin was the name for an open sou=
rce
> Operating System. See
> https://en.wikipedia.org/wiki/Darwin_%28operating_system%29 for more
> details.
>
> Ciao,
> Johannes

Sorry, but I do not see that you are being more constructive than
the other party, whom you blame to be not constructive, in this
exchange.

The part of the file that the patch applies to uses $(uname_S) to
implement platform specific special cases, and we are looking at

	ifeq ($(uname_S),Darwin)
		...
		FSMONITOR_DAEMON_BACKEND =3D macos
		...
	endif

I find it a fair question why the name used there has to be
different from the one we can automatically and mechanically
get out of "uname -s".

Then you respond that uname output is no longer relevant because
Darwin is a name that is no longer relevant?  And when asked why the
name is no longer relevant, you make a sniding comment implying that
the other party does not know the name is an operating system?

What is going on here?

It does not really matter how "Darwin" is described in an
encyclopedia in the context of this discussion.  What matters is
that it is what the system's "uname -s" currently uses to identify
itself, and what we guard the section of makefile snippet with,
isn't it?

ci/lib.sh seems to have an attempt to unify/translate among these
names, and

 * on azure-pipelines, it wants to translate darwin to osx
 * on github-actions, it wants to translate macos to osx

Presumably that is because these two systems call the platform with
these two different names, and you want to pick a middle ground that
nobody uses to be neutral, or something?

Also, in contrib/vscode/init.sh, I see Darwin obtained from "uname -s"
gets translated to "macOS".

In any case, if your argument was "we picked macos because we use
the same token elsewhere, while trying to translate away from Darwin
as much as possible for such and such reasons", I would have found
it a productive exchange, but unfortunately that is not what I am
seeing here.
