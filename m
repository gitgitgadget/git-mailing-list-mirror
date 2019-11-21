Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D85C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BAE20715
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XIiJgdOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKUAgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:36:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56933 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKUAgO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:36:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4299A060D;
        Wed, 20 Nov 2019 19:36:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LlMHP7HXcSNK/fBsrguzVZ7E9kc=; b=XIiJgd
        OpCnKpUBbQ0OWg73vDSw1vNNEK9jxBLggMvjvFRT0CfGZXfuMD6xuOF43L2lVBMp
        5I9cMQGtjdBpoNPIpHv/kafFx2UEkq20E8HCws+kz2Oxc6RT4n78FfadDK/sD5hV
        A8v1kjvfRwEyOVaRAnfIEEdat4hkOdGlTTW+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C76uLMna6/aqFeK9somXs1xvjOSY7q4H
        xXGo0tiH5doWsY/2jrNlWk81tZIHoFVOloW+tVkHI2w+Ex/B6nXlWU0D3D1jz6T/
        ISuBTKFfoKHMpG9ZlCKkoxzuo0Y5H2lFBxbbEOgGm8l4zlcgTDxxOapcb6drGwoJ
        wtWyriqOBkw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD196A060C;
        Wed, 20 Nov 2019 19:36:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E5B2AA0609;
        Wed, 20 Nov 2019 19:36:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2019, #03; Tue, 19)
References: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
        <20191119175850.GL23183@szeder.dev>
        <xmqqzhgrcksn.fsf@gitster-ct.c.googlers.com>
        <039f7668-53e3-9c6d-d813-ca412c4d1ed2@gmail.com>
Date:   Thu, 21 Nov 2019 09:36:07 +0900
In-Reply-To: <039f7668-53e3-9c6d-d813-ca412c4d1ed2@gmail.com> (Derrick
        Stolee's message of "Wed, 20 Nov 2019 08:58:25 -0500")
Message-ID: <xmqqy2wa9ibs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9BD309E-0BF6-11EA-A634-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> OK.  I had an impression that it was something relatively easily
>> patched to restore the plumbing behaviour without taking the
>> remainder of the series with a follow-on work.  If it is not the
>> case, perhaps I should revert the merge to 'next' and kick it back
>> to 'pu'.
>> 
>> Thanks for stopping me.
>
> That commit can be ejected from the series without affecting the
> correctness of any of the other commits. That will require reverting
> the merge at this point, though.

I've done the "reverting" part of everything, so that other patches
that need further work, if any, can be given a fresh start.

Thanks.
