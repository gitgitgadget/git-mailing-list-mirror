Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EE4C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31CA206D9
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xK4yQmTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgD2UjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:39:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53707 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD2UjG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 16:39:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B504473C2;
        Wed, 29 Apr 2020 16:39:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z8AP8blT6WfSaghIf4xF0kMabu0=; b=xK4yQm
        TdDlssQkSJgLu3zOAFs6Ls4WMg1b/JbuCP9SySMpBvucEcDHu5eYPKF1b383PU2L
        gaglEgZUcBMVhaWmhhgZ1+nzHhMElWa2RLABGT3STdjMa/Lr00Wq4cn0TCuKkIE5
        Nx/DqfJxOQ13JiLN+ECHA4AH6F7D1FdQ/mRII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=totRC3HjUVDIo+SPpkQm6vnS4RPnQHrP
        R5gY9UyoOstjEa9yx+HAtcANTSfSdy4UMcYHY5zEhfBy7lldp5/PYNutaWTJ3bHA
        BaMuiqcorSdOwG/i20vRwJZsZVFlMw/K67oDaY+bqbj4AOaFNJnM5ImxwW/ym2/I
        uJPRYLMriQc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3360E473C1;
        Wed, 29 Apr 2020 16:39:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3DF1473BF;
        Wed, 29 Apr 2020 16:39:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Ivan Tham <pickfire@riseup.net>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
References: <20200429130133.520981-1-pickfire@riseup.net>
        <877dxyo1k8.fsf@osv.gnss.ru> <20200429190013.GG83442@syl.local>
        <87v9likr5a.fsf@osv.gnss.ru> <20200429195745.GC3920@syl.local>
        <xmqqa72uvy7n.fsf@gitster.c.googlers.com>
        <20200429203508.GA7899@syl.local>
Date:   Wed, 29 Apr 2020 13:39:04 -0700
In-Reply-To: <20200429203508.GA7899@syl.local> (Taylor Blau's message of "Wed,
        29 Apr 2020 14:35:08 -0600")
Message-ID: <xmqq1ro6vxg7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7755E596-8A59-11EA-AFDA-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> OK, I could sympathize with that as well. I still think that my
> suggestion from earlier about documenting the fact that 'git branch -D'
> already understands '@{-N}' as a separate first patch is valid.

No question about that ;-)

> If I were the author, I'd cut that as a first patch, and discard the
> remainder if it sounds like we don't want to go with 'git branch -D -',
> which is fine by me. (I don't really care either way, and I can
> understand the arguments in both directions).

Yup, that would be what I would do, too, whether I wanted "-d -" or not.
