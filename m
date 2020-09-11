Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C34DC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE4722208
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="matNG7/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgIKTID (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:08:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51148 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgIKTIA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 15:08:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C751EC452;
        Fri, 11 Sep 2020 15:07:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LZMBPiq/dGnQ
        5jl/0e8dqG65h4g=; b=matNG7/WbZlQNyao//Me5BRRomh0WgLbvYfozvzA9FY+
        dzOwUgWUtAn0oCK6IYYB+7DFXqc5ZLLpROxJdoTMpTyPlnbo6WAk1Sxh02edb8EN
        JJMly/DQU1qLFy9mWbmZ0YGoQ8PMJ/eBwFKJuKB4EgEAHqJ6P/nZJn7oWCW5HRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=evoBz/
        hWs6U9B9oujUk9DMIZ4+EVfqSMxBUnoFcIJf+l29dTsC0PZQmzgtmQ2xtKRhB4Zl
        4HkPyiSRNIHI36wp0ov2avuLWwXp3aJCeRqUpTMJpMmjclS6d5Cit+Yqa8awGzxJ
        SXliwdqq+ysEjHfzibHIyhBiKFA7GlTW8oCtE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03633EC451;
        Fri, 11 Sep 2020 15:07:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8388DEC44E;
        Fri, 11 Sep 2020 15:07:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?Q?J=C4=99drzej?= Dudkiewicz 
        <jedrzej.dudkiewicz@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Cannot run `git submodule init` on Cygwin from script with strict error checking
References: <CABJqhQNh2Qc2Btp==bGUbT-AaSjGdGEmhtphQQyX=nqjWOis0A@mail.gmail.com>
        <CA+kUOan0N32W22xkoYsGYqM7rJDnc=tjQe_2Hnh2H47=19bbeQ@mail.gmail.com>
        <CABJqhQMST-n6-uEDpFCUSsYueF_=7ZLPCtj_mQnu679oY99ZVg@mail.gmail.com>
        <20200911131943.GA23146@szeder.dev>
Date:   Fri, 11 Sep 2020 12:07:51 -0700
In-Reply-To: <20200911131943.GA23146@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 11 Sep 2020 15:19:43 +0200")
Message-ID: <xmqqsgbonnco.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 18A346B0-F462-11EA-89D6-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Having said that, unlike 'git submodule', 'git-sh-setup' is meant to
> be dot-sourced into users' shell scripts, and, therefore, should work
> with the shell options set in users' scripts, including even 'set -u'.

Is it and should it?

git-sh-setup was meant to be an implementation detail for our own
scripts and we know don't use "-u -e".  We never cared about
backward compatibility for such use by end-users when we made any
update to the git-sh-setup scriptlet.  We freely changed existing
features and squatted on good names for variables and functions we
used in it, because it is designed as a private helper library.

Having said that, we do protect from end-user misconfiguration like
exporting CDPATH, and protecting ourselves from exporting SHELLOPTS
is not something I would oppose.

Thanks.
