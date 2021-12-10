Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BA9C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 21:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhLJVhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 16:37:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62774 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344445AbhLJVho (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 16:37:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92816103FB6;
        Fri, 10 Dec 2021 16:34:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GDSaD2oU8cn7
        HkQD2eYBZd3P3iQZL1ESBuav7X+O+to=; b=yXgRmbjsSu26Xz21UzdvHWTwdK7Q
        OZsTSOKhVIurdBX3F51pfplETdFAy9dNBioBfcp0QxsdiiBzkvmpOnRgS3SvP4oT
        mWXqKcevnhBa5vElBUP++f4esHCGJIDDaE5fK9RwkWz0Xg/bxuVAf5XAQxiWJsZc
        0d/rfzoyt+Xb4+8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8797B103FB5;
        Fri, 10 Dec 2021 16:34:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2F50103FB4;
        Fri, 10 Dec 2021 16:34:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/6] Transition git-p4.py to support Python 3 only
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
        <211210.86r1ale0o0.gmgdl@evledraar.gmail.com>
Date:   Fri, 10 Dec 2021 13:34:06 -0800
In-Reply-To: <211210.86r1ale0o0.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 10 Dec 2021 01:48:23 +0100")
Message-ID: <xmqqsfv0m9f5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E7DCF584-5A00-11EC-B577-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Dec 09 2021, Joel Holdsworth wrote:
>
>> Python 2 was discontinued in 2020, and there is no longer any official=
ly
>> supported interpreter. Further development of git-p4.py will require
>> would-be developers to test their changes with all supported dialects =
of
>> the language. However, if there is no longer any supported runtime
>> environment available, this places an unreasonable burden on the Git
>> project to maintain support for an obselete dialect of the language.
>
> Does it? I can still install Python 2.7 on Debian, presumably other OS'=
s
> have similar ways to easily test it.

Yes, that is a good point to make against "we cannot maintain the
half meant to cater to Python2 of the script".  Developers should be
able to keep and test Python2 support, if it is necessary.

So the more important question is if there are end-users that have
no choice but sticking to Python2.  Is there distributions and
systems that do not offer Python3, on which end-users have happily
been using Python2?  If some users with vendor supported Python2 do
not have access to Python3, cutting them off may be premature.

As the general direction, I do not mind deprecating support for
Python2, and then eventually removing it.  I just do not know if 2
years is long enough for the latter (IIRC, the sunset happened at
the beginning of 2020, and we are about to end 2021).

Thanks.
