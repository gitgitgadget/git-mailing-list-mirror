Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7CAC43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 20:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359072AbiFGUID (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 16:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359079AbiFGUGc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 16:06:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF051C4245
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 11:25:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BFFB124E9E;
        Tue,  7 Jun 2022 14:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eBgsQ+Bk/fcU
        YVulFUlWhAcjWBmcBXD9ROvECjCqgjc=; b=Zq0XONENb5dM02nCy6IGT6hpZIZ4
        dffyBx8DO6Mr0GY8z0UKbS/cKk3aZ5cKnprvD1Um+kJ83Bnq1OQFUQChPbUY72K7
        4Lhl8pPgg+ie7Qbt14o9NeUuR7vO/GLbwj05tuww9Kp3IvyZb7/rUmuMKLByG6V6
        tJf7nWM2TAzKJqE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DDB0124E9C;
        Tue,  7 Jun 2022 14:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B242124E9B;
        Tue,  7 Jun 2022 14:25:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        congdanhqx@gmail.com, dyroneteng@gmail.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: js/ci-github-workflow-markup output regression
References: <xmqqee28spni.fsf@gitster.g>
        <patch-1.1-0fdfec624eb-20220531T171908Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2206021703110.349@tvgsbejvaqbjf.bet>
        <220603.86fskmxd43.gmgdl@evledraar.gmail.com>
        <xmqqpmjpeedq.fsf@gitster.g>
        <220604.86y1ydwcq1.gmgdl@evledraar.gmail.com>
Date:   Tue, 07 Jun 2022 11:25:51 -0700
In-Reply-To: <220604.86y1ydwcq1.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 04 Jun 2022 01:13:08 +0200")
Message-ID: <xmqqo7z4wcsw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 433F22C4-E68F-11EC-BA64-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Jun 03 2022, Junio C Hamano wrote:
>
>> Indeed it makes it impossible to figure it out things like this
>> case.  But ...
>>
>>> But this does look easy to "solve" with a quicker fix, just bringing
>>> back the "ci/print-test-failures.sh" step so you can at least expand =
it,
>>> and not have to go to the "summary" and download the *.zip of the log
>>> itself. As that shows we still have the raw log there, it just didn't
>>> make it to the new GitHub Markdown formatting mechanism.
>>
>> ... it seems a solution is possible?  Care to send in a patch (or
>> perhaps Dscho already has a counter-proposal)?
>
> The only thing I have at the moment is:
>
>     1. git revert -m 1 bd37e9e41f5
>     2. merge: https://lore.kernel.org/git/cover-v6-00.29-00000000000-20=
220525T094123Z-avarab@gmail.com/
>     3. merge: https://lore.kernel.org/git/cover-v6-00.14-00000000000-20=
220525T100743Z-avarab@gmail.com/
>
> I.e. to pick this in the sequence I'd proposed doing & have tested
> thoroughly.

I know you two have difference in opinions, but throwing away
everything the other party did and forcing your stuff in is not a
very effective way to work together.

> It also addresses other noted some other regressions in "next", but as
> noted e.g. in [A] there's other issues in "next", e.g. that even the
> "raw" trace logs are altered as a side-effect of running with
> --github-workflow-markup, and of course the major UX slowdowns.

Dscho?  I know you do not care about the UX slowdown as much as
others, but I am sure you do not consider what is in 'next' is
perfect. It seems to need further work to go back to the feature
parity with what it replaced.

