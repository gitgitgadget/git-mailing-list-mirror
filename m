Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD53DC2D0E3
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 20:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F4320897
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 20:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W3lMi+WK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgICUCd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:02:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54988 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgICUCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 16:02:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E96F4ECB6C;
        Thu,  3 Sep 2020 16:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OzEizvSsAr0FBnEMJ7wMtNYupCM=; b=W3lMi+
        WK1MJYjyKUz4eCI3O6J0F2QiKTxw7luDJlRpL2Mb0CzrR31yG0TUu6xWz6Yb2lK4
        jQyKmWmQ9Db+rx+mgcfIvDR8Eg7XXK93xs1IkTvi2v3ihqUsM3GmErIkrcqWr5SB
        MDuPmZgEo0prshUNhUYcnb2awHjF15ngTd0cg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=omwiDhjfRg+2O9eWmZhGubseSVxjkaRA
        rHAjChOBDOXf19WmztJMj6qt51103LhCGl+o1cBbF7zv3Qo2MXdBS+TCFrdyqb55
        mAIsazyz6Sy0/mUJR/8NDdtvCQqGONJKDKmtgffC3U7m4dvR9lUmGgQf3hCsutrH
        dmbUMgxvi1Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E1A3AECB6B;
        Thu,  3 Sep 2020 16:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A62B8ECB6A;
        Thu,  3 Sep 2020 16:02:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victor Toni <victor.toni@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Aborting git rebase --edit-todo
References: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com>
        <xmqqa6y6ah8h.fsf@gitster.c.googlers.com>
        <CAPUEspjKcQgLvVrJ2GroqYydNPksEziMgyceN-CFBFVgtngMuA@mail.gmail.com>
        <CAG0OSgf9FsOpfOH+ErRTzMT333yDyZNthM8+7X3eRp=apRwJZg@mail.gmail.com>
Date:   Thu, 03 Sep 2020 13:02:03 -0700
In-Reply-To: <CAG0OSgf9FsOpfOH+ErRTzMT333yDyZNthM8+7X3eRp=apRwJZg@mail.gmail.com>
        (Victor Toni's message of "Thu, 3 Sep 2020 21:22:06 +0200")
Message-ID: <xmqq5z8uaatg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5729FAE8-EE20-11EA-8A76-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victor Toni <victor.toni@gmail.com> writes:

> Even when using Linux I never needed to make my editor exit with a non
> zero code. From a coding perspective this might work, from a usability
> perspective I really don't like it.

I do not use --edit-todo myself so personally I do not care that
deeply either way, but I have to agree that it is not the most
natural UI to make your editor to exit with non-zero status to
signal something to the program that opened the editor.
