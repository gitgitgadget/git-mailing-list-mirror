Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0729C43464
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 22:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F522087D
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 22:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ebNGfKIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgIQWcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:32:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64623 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgIQWcD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 18:32:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA122F0E0A;
        Thu, 17 Sep 2020 18:32:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=srbfhtUz6xr3ODdov5KbcKur2V4=; b=ebNGfKIi8hmmnTv+sItL
        CBNsTWgh2egyMQ5x0YM4FfE/3Cp4A9PM/Lbkqq+Jy8nxfJBT5qKkccj3Hn+ZqsYZ
        KwguRlgRXd64Wk0doXvLldH7IoFc2Wsi1ABBfD6xsvohsQ7dXKokrcAIIDYD3fOl
        djK7spOb2gTmoPs7NLa5p+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=mMGWpOjyk+CffhJahd0s7eqi0ty59pgTFHN2wZu2gy65iP
        VtRWg++wtIWPnkjF1gT4uBnMEN78a9nhKavibXdLzGQk3z/6FYOmDOdPIa8YfZfs
        lGWVGfdqxjdAf7m/7ypWBL6WOBPHOhhlrG4gZlLXGOFGiFfU9yASMdnk02pCs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B26DCF0E09;
        Thu, 17 Sep 2020 18:32:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F0AF8F0E07;
        Thu, 17 Sep 2020 18:31:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
References: <20200915135428.GA28038@pflmari>
        <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
        <xmqqk0wtv204.fsf@gitster.c.googlers.com>
        <20200917140254.GA28281@pflmari>
Date:   Thu, 17 Sep 2020 15:31:58 -0700
Message-ID: <xmqqbli4ox0h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99F88A7C-F935-11EA-B67F-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Riesen <alexander.riesen@cetitec.com> writes:

> If the configuration variable is allowed to be set to that "lack of
> preference" value, we kind of have a command line option for it:
>
>     git -c transfer.protocolFamily=any fetch ...

Yes.

But we typically do not count that as being able to override from
the command line.  If "git fetch --ipv4" will defeat the configured
"transfer.protoclFamily=ipv6", the users will expect there is some
way to do the same and say they accept any protocol family to be
used.

Thanks.
