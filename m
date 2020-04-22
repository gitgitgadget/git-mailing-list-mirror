Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061D1C5518B
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 15:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D753320776
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 15:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C7vpws86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDVPuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:50:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62508 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgDVPuL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 11:50:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE05ABF720;
        Wed, 22 Apr 2020 11:50:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GW9aIpm5lAwUkdJBBnP/XnYZIGA=; b=C7vpws
        86ajwI9OkvLhcz9/YaSFhMvwZDV4QxT86Sfaw3UpmexWWPrXqdIAP/zxLRZCq3vn
        0fGsqDNw2+rQjd4kz4lVvBjvCx3UL5OgULdG1+XVpq2hQI5SgTmXzlruAhUn6ulE
        Ea9FnumXlsh8qZUFTGqfYP3VER/8UfM0+9TXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T8RaYdmHKBvrajN/q5W/XnGLHqAB78U7
        WSKcw5dZzc/+otQ0eUeNu9uZQB+pUyeZl+GssKhsIwygWccuwUO6XTJtSHVp+iLx
        kq/LZZdCdexdbeisfAlWW3Xd3kqxN1n7m+mMrKPkyueT/Sdq46VVjEtOff5GxGNI
        yjoUVcHA8cU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E620DBF71F;
        Wed, 22 Apr 2020 11:50:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3D724BF718;
        Wed, 22 Apr 2020 11:50:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] t9164: don't use `test_must_fail test_cmp`
References: <cover.1587372771.git.liu.denton@gmail.com>
        <dfccb04e2d03656e18286bcca2c558e19d748ffd.1587372771.git.liu.denton@gmail.com>
        <CAPig+cQ6XS=ZDhAKGuDiGM4zcoxUhnghMY250qYLjuT8YZaoMg@mail.gmail.com>
        <xmqqr1whrkaa.fsf@gitster.c.googlers.com>
        <20200421201627.GA9357@generichostname>
        <xmqqa734muw7.fsf@gitster.c.googlers.com>
        <20200422085424.GA25366@generichostname>
Date:   Wed, 22 Apr 2020 08:50:04 -0700
In-Reply-To: <20200422085424.GA25366@generichostname> (Denton Liu's message of
        "Wed, 22 Apr 2020 04:54:24 -0400")
Message-ID: <xmqqsggvjz9v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFEE224C-84B0-11EA-8566-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hannes suggested that we should drop the tip commit of this series[1]
> and I tend to agree with him. Aside from that, though, the series is
> ready to go.
>
> (I could improve 3/8 as suggested here[2] but I'll throw it in the next
> series instead since I'm trying to get into the habit of not adding in
> unrelated patches.)
>
> [1]: https://lore.kernel.org/git/6cfa2c447e1196d6c4325aff9fac52434d10fda8.1587372771.git.liu.denton@gmail.com/
> [2]: https://lore.kernel.org/git/90faeb7a-1c6a-3fc6-6410-5e264c9340e8@kdbg.org/

I agree with you two that test_must_fail may make sense with these
__git_foo helpers used in the completion.  It is a bit of shame that
there is no opportunity to leave the reasoning behind the decision
for later developers, other than in the discussion thread.

I agree that 3/8 is good as-is in this series.

Thanks.
