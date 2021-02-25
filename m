Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFE4C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A698864ED3
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhBYUBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 15:01:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53597 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhBYUB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 15:01:27 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A3BF311BDE3;
        Thu, 25 Feb 2021 15:00:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VmQNApKTHS3P
        /LSnbHN2fddwQkI=; b=G0lLkDlTBVW3i0wpYrDnSoFwd8H/5cgHt5eAO9URDSqR
        04QQ1hihc08GpoYfi7/A8mOSAfRrlS9Y8XwmFyGntdugGib/eJHY5cya6Qiz6JXj
        JitGz+421C969egBA2qvI4eF1hObpnAOTGODzIURAzp9jDG52e4EhfHBXxfRVXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MwBfkB
        FhRm3d2/q3tZOz+i7rg4yFzhmgGy437dn5IRAeO1md8UxtVS3KE5f1f8oTtIqCDp
        TqYHAbGKxSUlPaU4GP+Qy0b0JpMLkTQz1BePoG77zch0PomG5ykdNDFifFFBJF/a
        oh0clUFAxRSIeycK1mkUq0KpuYoMx2KKn3ryo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C88F11BDE2;
        Thu, 25 Feb 2021 15:00:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DA94C11BDE1;
        Thu, 25 Feb 2021 15:00:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/2] remote: add camel-cased *.tagOpt key, like clone
References: <20210225012117.17331-1-avarab@gmail.com>
        <xmqqwnuwx2ea.fsf@gitster.g> <87wnuw6iaw.fsf@evledraar.gmail.com>
Date:   Thu, 25 Feb 2021 12:00:40 -0800
In-Reply-To: <87wnuw6iaw.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 25 Feb 2021 20:47:35 +0100")
Message-ID: <xmqqzgzrudcn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 241CA476-77A4-11EB-BC23-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'm not quite sure what to make of this feedback in general. That you'd
> like the bugfix but we shouldn't bother with a regression test, or that
> we shouldn't bother with the fix at all?

I like the style update to make the callers use the canonical case
(even though they do not have to), but the test that inspects the
cases in the resulting configuration file may be too strict.

> But I don't agree that we should feel free to munge user config files
> within the bound of valid config syntax when we edit these files for
> users.

I agree with your sentiment in principle.  I just wanted to make
sure that future test writers agree with the principle, and also
that they understand there are cases where end-user input may not
match the output (e.g. when running "git config Vari.Able value" to
an existing configuration file that has "[vari] ous =3D true", it may
be less desirable to add "[Vari] Able =3D value" than to add to the
existing "[Vari] section a new line "Able =3D value").


