Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DFBC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3BA207FF
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TyxNDtlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgDJVo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 17:44:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60761 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDJVo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 17:44:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EBE23CA8B7;
        Fri, 10 Apr 2020 17:44:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sR6x8Hk/r+sOWWRhHiDW1WXfeh4=; b=TyxNDt
        lS5PkzC9Jh+k4g6daxUAY8fsUF3gj9BC4pE1knwJOdJtIX4XpfelRy9JAjVJyZJg
        xm8K53be5PIT399OufP/wBagWuEWg7VxwhGQ13L0THA9aOlsSeD8okgf7VRr9l/O
        QTT7ZEJcVTpsYsIry81PcXcHI4zgT2vjD59tg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lZwBBAVGXRCkrIZgeDeh/0JBCXqUYWGj
        nNtWzv6E1YgPAibmne+8tnR6YAOZzGgbSChOD7RR7mHf0S8c5C+Xzreuo5KHasPd
        Fzgrq+mAOSfCEgJLfargIOdokxatHTn1EiplbGJE9HtePuASb+rEelYTaWflIK+q
        gk98SiHEiNc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4774CA8B6;
        Fri, 10 Apr 2020 17:44:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 40ABBCA8B4;
        Fri, 10 Apr 2020 17:44:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] remote: drop auto-strlen behavior of make_branch() and make_rewrite()
References: <20200410194211.GA1363484@coredump.intra.peff.net>
        <20200410194341.GA1363756@coredump.intra.peff.net>
Date:   Fri, 10 Apr 2020 14:44:23 -0700
In-Reply-To: <20200410194341.GA1363756@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 10 Apr 2020 15:43:41 -0400")
Message-ID: <xmqq8sj3hv7s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72548C1C-7B74-11EA-9F8B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Let's instead just drop this feature and have the callers (of which
> there are only two total) use strlen() themselves. This simplifies the
> code, and lets us move to using size_t.

Makes sense.

Thanks.
