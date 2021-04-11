Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD85C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 19:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45EF6105A
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 19:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhDKTIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 15:08:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64377 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbhDKTIq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 15:08:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63D4ECAE7E;
        Sun, 11 Apr 2021 15:08:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XhQKg1VHdaed
        86Iu9V/sBxhfBA0=; b=OYLCMNLxo0X8sbj7CAghtDa/oMgKD+CQXOyyS26eBZoh
        j4bEAIt6tgJlVqL42GGf6yMpvH1XZcncHTVtJYGyBPXcugb238ke0DptnPxuCR/r
        shNvIdsxPERnFzWb0l2HSj331dyV0nMH7Bmax1aFA5PT/aWiIkwqrao2zcIroZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JC7nU8
        PIJQ5aH53E25+TQNvQQ0ahT/t2eMovu7DDVlKevxyHwa00A0DOhVfcNfAK1YSXUr
        6I6JdO5fOjOJaGLBju0khLY83j6uuW06gS6b+ktwJM7dyW8BIMKsaY44snz9403A
        NSNGs6l+J5SIKPxTBYW1uYeyoYhKZa7zhbn2M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 487E8CAE7D;
        Sun, 11 Apr 2021 15:08:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B73C8CAE7C;
        Sun, 11 Apr 2021 15:08:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Drew DeVault <sir@cmpwn.com>
Subject: Re: [PATCH 1/2] send-email: remove non-working support for
 "sendemail.smtpssl"
References: <20210411125431.28971-1-sir@cmpwn.com>
        <cover-0.2-00000000000-20210411T144128Z-avarab@gmail.com>
        <patch-1.2-ee041188e55-20210411T144128Z-avarab@gmail.com>
Date:   Sun, 11 Apr 2021 12:08:28 -0700
In-Reply-To: <patch-1.2-ee041188e55-20210411T144128Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 11 Apr
 2021 16:43:19 +0200")
Message-ID: <xmqqk0p8hc5v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4C9AB078-9AF9-11EB-9AD9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> So let's just remove it instead of fixing the bug, clearly nobody's
> cared enough to complain.

Hmph, is that a safe assumption?  They may have just assumed that
you did not break it and kept using plaintext without knowing?  If
we do not give a warning when sending over an unencrypted channel in
red flashing letters, that is more likely explanation than nobody
caring that we saw no breakage reports, no?
