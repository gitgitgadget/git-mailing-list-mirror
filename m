Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2438DC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 21:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E944861222
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 21:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhDMVkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:40:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63735 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhDMVkI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 17:40:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F668123DB7;
        Tue, 13 Apr 2021 17:39:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gfF9oKla7cAQ
        1Zc1KrYe8QWuYbQ=; b=U5lbDxp0JAZQ1S+VULlDLbSZBQAKhca9ERPSswpxh+ag
        v+3LumnptddF6xXqh5ByYs54mC6YRwT6UJO5256ImbZIeuchbcjSIsuh1rsjpZfv
        Jdz7dDCDzF/YMKktYC+yWbcPOAeNyRs0UziUTpSCcqWZ+TMHMi1S6Cjolk2m8U0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qpq76j
        4U6830/itqBPoBDQHTTZup4GLvRJXJiQnvx+n6wt8ccusgSm/AtuGm5/rXPh3huc
        GuEumsQrxiNYwssqGE+IqoZHirSkdOjro2XMlTGi0gKa92gHehX7C2T3jRp0yyoK
        MIoLQfBwXue3Vh2cyF0pT60TdtrZ+ZkfGJxbc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08A41123DB6;
        Tue, 13 Apr 2021 17:39:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4EDE9123DB5;
        Tue, 13 Apr 2021 17:39:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] git-send-email: die on invalid smtp_encryption
References: <20210411125431.28971-1-sir@cmpwn.com>
        <20210411125431.28971-3-sir@cmpwn.com>
        <87blakgaxr.fsf@evledraar.gmail.com>
        <CAKYMAEJQOA3.25YK6UYSYFHXQ@taiga>
        <878s5ogagz.fsf@evledraar.gmail.com>
        <875z0sg8t9.fsf@evledraar.gmail.com>
        <CAKZTYI6U0WY.36DC3N1E4R7D2@taiga>
        <87zgy4egtp.fsf@evledraar.gmail.com>
        <CALQY92B6OVL.2Z59Y6W51BU4Y@taiga>
        <87o8ejej8m.fsf@evledraar.gmail.com> <CAML4RYHKQ6U.35902JHAIZYY@taiga>
Date:   Tue, 13 Apr 2021 14:39:43 -0700
In-Reply-To: <CAML4RYHKQ6U.35902JHAIZYY@taiga> (Drew DeVault's message of
        "Tue, 13 Apr 2021 08:12:47 -0400")
Message-ID: <xmqqtuo9kgo0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C37CCF5C-9CA0-11EB-8535-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:

> Can I get one of the maintainers to chime in on this thread and explain=
,
> in their opinion, what this patchset needs before it is acceptable? I'm
> not sure where I should go from this discussion.

What you called "compromise" in the upthread didn't even smelled
like a compromise but the safest way forward.  My reasoning goes
(thinking aloud, so that you and =C3=86var can correct me if I am talking
nonsense and discount my input based on it):

 - If we were designing this from scratch, we would have called the
   smtps:// tunnelled transport SSL/TLS and in-place upgrade
   transport STARTTLS, like e-mail providers and client programs do,
   but unfortunately we didn't.  We ended up with 'ssl' vs 'tls'.

 - We could introduce and advertise STARTTLS as a synonym to 'tls',
   but then those whose send-email does not understand STARTTLS but
   read about the new way of spelling would end up having no
   encryption due to another earlier mistake we made, i.e. an
   unrecognised option value silently turns into no encryption.

 - To avoid the above problem, the first phase is not to change the
   status quo that 'ssl' vs 'tls' are the only two choices.  What we
   do is to make the program error out if we see an unrecognised
   value given to the option.  We release this to the wild, and wait
   for the current versions of send-email that turns unrecognised
   words into no-encryption die out.  It may take several years,
   though.

 - After waiting, we add 'starttls' as a synonym to 'tls'.  We may
   also add 'ssl/tls' as a synonym to 'ssl'.  Unfortunately 'tls'
   alone cannot be repurposed as a synonym for smtps:// without
   another deprecation dance, and it is not in scope of the
   transtion.

Am I on the same page as you two? =20
