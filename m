Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C36C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 18:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD6D64DFF
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 18:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhBQSNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 13:13:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55652 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbhBQSNF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 13:13:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE04D11F99A;
        Wed, 17 Feb 2021 13:12:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WzuyBxTRdYjQ
        mwrwDztiQLMUP90=; b=b9A3AqnILaXaxtEEzFyGe6dFGPlenaa8B5BoHKI81cWC
        nZh0iH3spfUXQbHb+2b4NIX8DNcTWbi0WhT2O/uzXZ89tS9rJGGlBrD0mmeX+ON9
        iuXb4ALr4ubSwND+BlwbY2VebCkcim0k1UWS5rsu5+DKgINK3Af1vy3Ntizbqig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OzEvva
        1evgSk9Z7AYGWdn8sjCsoT82LHgKB+aB1rgXjIuL7A4COPJJXVttAoW3syoE5Rsw
        j6EwpzE0i85bWt/d9gywXrXPJTK9xm4nYgkxhjgGpF4vnftVU+HnzH5w/3UfMpej
        n7s5J6LaLPe1G1dw7+TcHv9RkOqExhgaqP2+A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E690811F999;
        Wed, 17 Feb 2021 13:12:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3E98B11F998;
        Wed, 17 Feb 2021 13:12:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pretty: add %(describe)
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
        <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
        <87k0r7a4sr.fsf@evledraar.gmail.com>
Date:   Wed, 17 Feb 2021 10:12:17 -0800
In-Reply-To: <87k0r7a4sr.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 17 Feb 2021 01:58:28 +0100")
Message-ID: <xmqqwnv6lg1q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AC550FF4-714B-11EB-B1CF-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Feb 14 2021, Ren=C3=A9 Scharfe wrote:
>
>> +'%(describe)':: human-readable name, like linkgit:git-describe[1];
>> +		empty string for undescribable commits
>
> In the case of undescribable we've got the subcommand exiting non-zero
> and we ignore it. The right thing in this case given how the rest of
> format arguments work, but maybe something to explicitly test for?
>>
>> +	if (skip_prefix(placeholder, "(describe)", &arg)) {
>> +		struct child_process cmd =3D CHILD_PROCESS_INIT;
>> +		struct strbuf out =3D STRBUF_INIT;
>> +		struct strbuf err =3D STRBUF_INIT;
>> +
>> +		cmd.git_cmd =3D 1;
>> +		strvec_push(&cmd.args, "describe");
>> +		strvec_push(&cmd.args, oid_to_hex(&commit->object.oid));
>> +		pipe_command(&cmd, NULL, 0, &out, 0, &err, 0);
>> +		strbuf_rtrim(&out);
>> +		strbuf_addbuf(sb, &out);
>> +		strbuf_release(&out);
>> +		strbuf_release(&err);
>> +		return arg - placeholder;
>> +	}
>
> There's another edge case in this: if you do "%(describe)%(describe)"
> it'll be run twice for the rev, 3 times if you add another "%(describe)=
"
> etc. I don't know if pretty.c has an easy way to cache/avoid that.

Just like for-each-ref that has the "atom" system to lazily parse
and cache a computed result so that multiple invocations of the same
placeholder will have to prepare a string only once, the pretty side
has the "format_commit_context" structure that can be used to cache
values that are expensive to compute in case it is used more than
once, so we could use it.

I however suspect that we may already be leaking some cacheed values
in the current code.  For example, there is "signature_check"
instance that is used to handle %G and we do use it to call
check_signature(), but a call to signature_check_clear() to release
resources is nowhere to be seen as far as I can tell.




