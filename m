Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C89C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 18:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C601D221E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 18:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vstt9bB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgHFSeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:34:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65280 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgHFSeE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 14:34:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 143E9EDAA3;
        Thu,  6 Aug 2020 14:17:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gx/xI/6MfkfasWwOocWJaiJ7RmI=; b=vstt9b
        B16hwaLEKhQ6mBZVIaCyiecGtrHMMZ5DC6+c+Buco9+NvYJQYl2jOPP6aO2b1HG6
        LDFK70tx5c19sbGIelU1pZ8ZAkdiLf6bHuMoPRLHy+uM5p63/HpAPaYnkM7ZBOiv
        N4VWLgQX9mX1NmSjYbyr8Y+3amFU2CYz2eUR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yLeQD/PoEJLN0Gk74uga8kGphvl9tDtD
        E7iJxhnWxxUn2pGP/Ndu1xyn3UangCnovP0r4eoF68yVlvIPsrvfj1i+Iw0MZg7G
        ChrcvsuBiE6SZSR6sVS6mejPxOBPrd+E2vUi/slFB4lL4F9UZ9nFvct7se3EsoM1
        +t29zGBM+eQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0C7B9EDAA2;
        Thu,  6 Aug 2020 14:17:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 06B05EDA9F;
        Thu,  6 Aug 2020 14:17:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     =?utf-8?B?16DXotedINeh15XXnNeV15HXmdemJ9eZ16c=?= 
        <inoamsol@gmail.com>, <git@vger.kernel.org>
Subject: Re: Why is AuthorDate displayed on git-blame?
References: <C4PPV24G8ZNK.3IYI2MQ3A262Y@ziyou>
Date:   Thu, 06 Aug 2020 11:17:31 -0700
In-Reply-To: <C4PPV24G8ZNK.3IYI2MQ3A262Y@ziyou> (Raymond E. Pasco's message of
        "Thu, 06 Aug 2020 02:57:20 -0400")
Message-ID: <xmqq1rkjljus.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18CD84BA-D811-11EA-AFB7-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> Perhaps the following
> adaptation:
>
> --first-parent::
> 	Follow only the first parent commit upon seeing a merge
> 	commit. This option can be used to determine when a line
> 	was introduced to a particular integration branch, rather
> 	than when it was introduced to the history overall.

Yup.  We somehow forgot to document it when we did 95a4fb0e (blame:
handle --first-parent, 2015-09-15).  The text reads well.

Care to make it into a patch?

Thanks.

