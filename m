Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF3CC4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 15:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909CD20722
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 15:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jReH46a8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCVPua (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:50:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50816 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgCVPua (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 11:50:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93F80BEB33;
        Sun, 22 Mar 2020 11:50:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LTAp8BYBXXkmpkPj0BTIkTHY1lc=; b=jReH46
        a8BPONnYU9u+KDRfgIdtm7yok2lPFKOuqvcpWgOwTeDtNQFny7Z/JkCNo+2A0k4Z
        3ZpmSsvQt41i2vsXk5jm/1Y+hJvlkDV4HCuFnwuNvydjOhja7v7bL0pTKs+9fPs3
        GDJukYbJXIzk4XqWLtedcAdi8/razs20sF4Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DsPI4vBuw9Iwx+VqmK3BZf8CzIJZUJY7
        eUBmcJY437baPLhxWZ5PAOSWo1QfyVvqINnMRP0PSclkX6RcGGscCzlICf4+1+un
        /FSmAxTTTMyjsHuOJ03o2zvlAS2JKfykQJ0MEFwbdgY3Oj1HsVktKaogQK+qOcds
        yVTF2T1rIEI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B223BEB32;
        Sun, 22 Mar 2020 11:50:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D8A7EBEB2C;
        Sun, 22 Mar 2020 11:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: git stash push/save/create all return exit code 0, even if no object was created
References: <CAHMHMxW=muHe5qqndtdzR_md6KFQqwEonko-2gXC_q973JgB5w@mail.gmail.com>
Date:   Sun, 22 Mar 2020 08:50:23 -0700
In-Reply-To: <CAHMHMxW=muHe5qqndtdzR_md6KFQqwEonko-2gXC_q973JgB5w@mail.gmail.com>
        (=?utf-8?B?Is6jz4TOsc+Nz4HOv8+CIM6dz4TOrc69z4TOv8+CIidz?= message of "Sun,
 22 Mar 2020 17:09:57
        +0200")
Message-ID: <xmqq8sjs8k3k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D83AD678-6C54-11EA-A929-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This has been asked and answered recently at least twice, I think.

https://lore.kernel.org/git/01020169a7ad6af3-ad50e2d1-19fb-46eb-b397-759f8d579e8b-000000@eu-west-1.amazonses.com/

https://lore.kernel.org/git/CADZUK1cjvifbFYk9w6+vE95jgEBuwjoOi_1QfZHoPFBXuXHCCg@mail.gmail.com/

I think these previous ones wanted something more relevant to "git
stash", in the sense that they wanted to be able to

	git stash
	do some other things
	do many other things
	if earlier "git stash" produced an entry
		git stash pop

and the answer to that may be "use stash create upfront, save it
away yourself in a variable or something, then use that to restore"

But to me your use case does not look like it has much to "git
stash".  If a user wants to ask "is my working tree and the index
dirty (iow, have I made any changes)?", wouldn't "git status" be the
right tool for the job?  It even has an option to produce output
designed to be machine readable.
