Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DF81F859
	for <e@80x24.org>; Wed, 31 Aug 2016 18:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbcHaSpP (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 14:45:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54523 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754031AbcHaSpO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 14:45:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E2B13B0E7;
        Wed, 31 Aug 2016 14:44:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OoIFJBbkA4LzjHR4rVvdRNkigcM=; b=W+ZFYI
        2GrUt0XqsUBeN8JM1sCyFO+WRuSsNIk1L5BiG+Z9QXXv5t8phBVcc7Yr+wtdEx7D
        bPKTwmtQhT1T88g2omuuF2JJuHS3sNwLsDmbS+8nWsFwIx9Bz7JL3XhXLlRZtwxr
        nk6naThdKAomMDmDv38igW6rr2Z3O0LnI+HaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E5frVLVQxVkwWkzFqfsi5QAG6qj2jS5X
        D5+jCSTXot2JEpcVP2V9MTI/g4VuuweX9ZqDeMeP9L1qedIBerqRbhf4EavuXxyb
        NY9PM8hx7NezyHSCgWHKEtBwmo0KBacCcthoVCZjgIZNa2t8wgFZW3FGCgA1S+L3
        ZMJPBhQJq/8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0666D3B0E6;
        Wed, 31 Aug 2016 14:44:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 814923B0E5;
        Wed, 31 Aug 2016 14:44:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Uma Srinivasan <usrinivasan@twitter.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: git submodules implementation question
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
        <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com>
        <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
        <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
        <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
        <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
        <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
        <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
        <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
        <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
        <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
        <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com>
        <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
        <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com>
        <CAN5XQfvK7M5eSkMfz5iRTnE_va9VGjONAPO5hmF+iQg-i3XEpQ@mail.gmail.com>
Date:   Wed, 31 Aug 2016 11:44:46 -0700
In-Reply-To: <CAN5XQfvK7M5eSkMfz5iRTnE_va9VGjONAPO5hmF+iQg-i3XEpQ@mail.gmail.com>
        (Uma Srinivasan's message of "Wed, 31 Aug 2016 11:40:03 -0700")
Message-ID: <xmqqh9a022xt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE7C0B54-6FAA-11E6-9F4D-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uma Srinivasan <usrinivasan@twitter.com> writes:

> diff --git a/submodule.c b/submodule.c
> index 5a62aa2..23443a7 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -960,6 +960,9 @@ unsigned is_submodule_modified(const char *path,
> int ignore_untracked)
>                 return 0;
>
>         }
> +       /* stuff submodule git dir into env var */
> +       set_git_dir(git_dir);

We want to affect only the process we are going to spawn to work
inside the submodule, not ourselves, which is what this call does;
this does not sound like a good idea.

