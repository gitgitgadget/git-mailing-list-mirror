Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357EAC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 18:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103D361050
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 18:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhJLSDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:03:19 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:60307 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229495AbhJLSDS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Oct 2021 14:03:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E35BF32010F5;
        Tue, 12 Oct 2021 14:01:15 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute6.internal (MEProxy); Tue, 12 Oct 2021 14:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waite.eu; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=Wu97IYdv4WqMSypRUjhw2Di8MpB3sLp
        acSlaYL6wYkk=; b=VTwfZHcgk5BsqMmT3IHVbn3qPq/GIQ3hDyaneOVOYCa3Nhi
        7UK1/61yJdo98VSYu6qzeDZdCwc8qa3JFs/N60vGw7KLm4tg0mrI9IAraPZuTbpR
        2RoQ1BngH1oZVtQvMoGY2w+3tpj+miNHvqQlaIivKZNNAK8Cg5+AEdb+syiO7O4j
        6GOxMAKBm1nw0N9dgv81N4s/mWJuWu8ozGc/fnlJQklENjQnib68tchyeVwyCVez
        GgP/1kH84OYk+d65rGE3vJ/Pjm3+kAkyhfZZ/fhTC34VxZz7I72fXhzGLQOEsDPU
        chMkwBQvBSAGRAT5NTh9mBF/84F8BAOOV/H5QjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Wu97IY
        dv4WqMSypRUjhw2Di8MpB3sLpacSlaYL6wYkk=; b=jjEoo7zBAKdCiy4Ip7qPNE
        FEQoSw7ykvD3DkqYUvf9Ng5R+Gcm/wVQV3MZjqgDbuAVueCtZD3InK2WTDbwrlca
        jdr/Mu/cqER6aVkIkTg72bLayS0Y6cqc4caTqZjBZHsEqfvDSvmpQTq7xS3sIhKm
        8ARuRLWHJA3b7P3bXbD97cgxvXiEFUWbf8nqd/T+2dZmX9vfnKe9MNWMIOOwmJxF
        pdVu33OpZPii02fTKSlA25FAPi5AC5WT5Cvk30lzSYkVt8DlGu4Pr0CPL/kPkqDc
        g9cj/E0UNPuK9mfkgbwRWsYjAUWhUcd3E7Y9o42vlfMZBCpEbXdI+nHHypc6qisg
        ==
X-ME-Sender: <xms:a81lYdQgWGFhCDftWEjK-JHjQb9qL-h0qILNuS16K7UtoyF619TQdQ>
    <xme:a81lYWyOagMqVY5T9zeA0fah1MBM4vZKAtz8m2UrnEwfG0V9oWeaPIg9N6ldZi9qh
    y1mGAwMzbQtbFOEKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtkedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesth
    dtredtreertdenucfhrhhomhepfdetlhgvgicuhggrihhtvgdfuceorghlvgigseifrghi
    thgvrdgvuheqnecuggftrfgrthhtvghrnhepledtheeugfffgfeufffhfeelgfffheelie
    elheehhfelgfejiedtvdefjeduffdvnecuffhomhgrihhnpegvgigrmhhplhgvrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvg
    igseifrghithgvrdgvuh
X-ME-Proxy: <xmx:a81lYS0ERBvsnYQ30nGrqJDL9bKv7XocWj6-LKYDEbHSJffPSWLnSw>
    <xmx:a81lYVChFdxwqN-7JJ97sf994B8o1rwX4rrEDH7qzcsGDaqEymvYbA>
    <xmx:a81lYWhTJ3Z5itkCNQPc9Scptv1A7bRvF0TEXxsNvE2Hw5AUBDk2YQ>
    <xmx:a81lYceikbjnYTUR6OYtniBdVwtrIaJ2IXvIOZVUwqrY7WHzBcQZUQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5E4AE2180075; Tue, 12 Oct 2021 14:01:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1345-g8441cd7852-fm-20211006.001-g8441cd78
Mime-Version: 1.0
Message-Id: <2883c3a9-a44f-4b24-acac-5ed573319d27@www.fastmail.com>
In-Reply-To: <xmqqk0ii3zl6.fsf@gitster.g>
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
 <xmqqk0ii3zl6.fsf@gitster.g>
Date:   Tue, 12 Oct 2021 20:00:55 +0200
From:   "Alex Waite" <alex@waite.eu>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] credential wildcard does not match hostnames containing an
 underscore
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the response. :-)

> Hmph, given that hostnames cannot have '_' (cf. RFC1123 2.1 "Host
> Names and Numbers", for example), the third URL seems invalid.  Is
> this even a bug?

That is a fair question, and I do acknowledge that later on in my bug report (where I provide some additional information).

The core issue, IMO, is that git is not consistent with itself. I can write a static rule that will match ("https://test_c.example.com") but cannot write a pattern that will do so.

From a user perspective, a URL containing an underscore in the hostname works for everything else (including all other git operations), but not with pattern matching. It took me a couple hours to figure out /why/, as GIT_TRACE does not provide debugging for how git config rules do (or don't) match patterns.

Specifying in the docs which characters are matched would have helped understand why it was behaving so.

In any case, I felt it was opaque, and was worth sharing.

---Alex
