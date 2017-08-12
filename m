Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4059320899
	for <e@80x24.org>; Sat, 12 Aug 2017 00:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdHLAmf (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 20:42:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57134 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751361AbdHLAme (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 20:42:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0E9F9ACCA;
        Fri, 11 Aug 2017 20:42:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MRIHOA9wiKj+
        JIUuYPChUajGFE0=; b=myYgOrRw8WHdk7e+DtjvOjtx6o2ntmHm7ij/VF4LS+v8
        M+OI5H7qtxmgPbp5dDjuKEaU9BBnau8vYDfQrL6cNXu6d7xJU8fswwcdFNcoQQjd
        TGOK8LbqYM3CQMnfQs7piqqQwSunQlhF1UKyCWJv0LcNIhHVtWbDjznjWrjGh1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YWPUMh
        AXltRc71Di4kKGwwgmlD81hVn32/K8K9fLncgojFdUgYphKKYgpOvZ4e8nCU6fWP
        z4sm5mFK9SlzEmzTYae5ulmCaAEA4x+SPMDHS3676ex79amYv/Br37eo1cBdzN+s
        2z78ert37b40MTsDxBSdjp0nCIBzCDULwjLtw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8F0E9ACC8;
        Fri, 11 Aug 2017 20:42:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2AAF59ACC2;
        Fri, 11 Aug 2017 20:42:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Takashi Iwai <tiwai@suse.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andreas Stieger <astieger@suse.com>
Subject: Re: [PATCH] hash: Allow building with the external sha1dc library
References: <s5hh8y19hyg.wl-tiwai@suse.de>
        <CACBZZX5yv-NzL7H-CH1yMeM9dWkz=PUhx=2wek_jBGpsz1=EAA@mail.gmail.com>
        <CACBZZX7M=H8tNkZXpHBvv0rbY58EJk4dkoUzGKMftWoKUqF8sA@mail.gmail.com>
Date:   Fri, 11 Aug 2017 17:42:25 -0700
In-Reply-To: <CACBZZX7M=H8tNkZXpHBvv0rbY58EJk4dkoUzGKMftWoKUqF8sA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 28 Jul
 2017 18:04:18
        +0200")
Message-ID: <xmqqfucxy5u6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1CB74E2E-7EF7-11E7-96C2-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Jul 28, 2017 at 5:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>
> I sent this last bit a tad too soon in a checkout of sha1collisiondetec=
tion.git:
>
>     $ make PREFIX=3D/tmp/local install >/dev/null 2>&1 && find /tmp/loc=
al/ -type f
>     /tmp/local/include/sha1dc/sha1.h
>     /tmp/local/bin/sha1dcsum
>     /tmp/local/bin/sha1dcsum_partialcoll
>     /tmp/local/lib/libsha1detectcoll.a
>     /tmp/local/lib/libsha1detectcoll.so.1.0.0
>     /tmp/local/lib/libsha1detectcoll.la
>
> So the upstream library expects you (and it's documented in their READM=
E) to do:
>
>     #include <sha1dc/sha1.h>
>
> But your patch is just doing:
>
>     #include <sha1.h>
>
> At best this seems like a trivial bug and at worst us encoding some
> Suse-specific packaging convention in git, since other distros would
> presumably want to package this in /usr/include/sha1dc/sha1.h as
> upstream suggests. I.e. using the ambiguous sha1.h name is not
> something upstream's doing by default, it's something you're doing in
> your package.

I do not think I saw any updates to this thread.  Should I consider
the topic ti/external-sha1dc now abandoned?

As we have finished Git 2.14 cycle, in preparation for the next one,
the 'next' branch will be rewound and rebuilt early next week.  I do
not mind tentatively ejecting some topics that needs fix-ups out of
'next' to give them a clean restart.  If there will be a reroll that
addresses the concerns raised during the discussion, please let me
know.

Thanks.

