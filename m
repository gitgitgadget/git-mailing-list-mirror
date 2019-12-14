Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7A0C43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 23:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4B120706
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 23:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hYSuCiZS";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="1EAM73wR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfLNXFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 18:05:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51722 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLNXFv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 18:05:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83D4DAFF06;
        Sat, 14 Dec 2019 18:05:50 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=GJ3zYWvmsLHC8j2dQj1Ic5VHfYw=; b=hYSuCi
        ZSjsQwUChnL2d7yNQ54nve0Qi+CNC1tpQKCYf1+qMtp1k93n6J9xM6AmFGOG1fxy
        HOHP7AaCJqUIK98wnxN1fstbXwZXmAy2ta5a1H4GhHr4MsjFQ+F2waEBoheGFU5j
        BArnB6ubOEqe88221ZkBbvm8TN5qzYH4fg60E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C0D9AFF05;
        Sat, 14 Dec 2019 18:05:50 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=/5HuswvCvnjAZXo2xkpCPrO7e9aMYrebMi1KeamzPHc=; b=1EAM73wRlY6sLnzvMlAHbzpMarJ4EPzzxl1AvadTUKuV1dbg7j2wo/lUR+dF8Bwpw6OaOLEzNZBNjYKH39iX5TVoClHSLKgK44X379fOZ5+6AL9eRmpIbWFLjLwXqCCVk8hr8Od1NvH5ESg2BELJhjpWiIJUtH4NykfJYbNyCyg=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C2B3DAFF03;
        Sat, 14 Dec 2019 18:05:47 -0500 (EST)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Chrissy Wainwright <chrissy@sixfeetup.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Stash does not save rename information
In-Reply-To: <87immizf55.fsf@kyleam.com>
References: <296B296B-EBA0-4F1E-AFEA-ADC232E84656@sixfeetup.com> <87immizf55.fsf@kyleam.com>
Date:   Sat, 14 Dec 2019 23:05:46 +0000
Message-ID: <87fthmzewl.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43CD6266-1EC6-11EA-A606-B0405B776F7B-24757444!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:
>
>     $ git init
>     $ touch foo && git add foo && git commit -mfoo

Sorry, I forgot to paste in the `git rm foo` step here.

>     $ git stash
>     $ git stash apply
>     Removing foo
>     On branch master
>     Changes not staged for commit:
>     	    deleted:    foo
>
>     no changes added to commit
