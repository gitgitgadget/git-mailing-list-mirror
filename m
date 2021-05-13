Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D68EC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 23:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A82A61354
	for <git@archiver.kernel.org>; Thu, 13 May 2021 23:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhEMXsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 19:48:20 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:39123 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230210AbhEMXsU (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 19:48:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D82741DC8;
        Thu, 13 May 2021 19:47:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 13 May 2021 19:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm3; bh=xPR
        3nv9RViuUI7Pm5HeyKP7a/yFpe94UvKTn3SkPqso=; b=Yfr6v8osFdkXpIu6Ear
        9+DUlf9fW5SiEe0h/LlJHAJi1mn52L/wGy7xFyZVTSkZ7Efp8la63FcQIR2ssjrT
        vjn1ngftnDjOBaWUCKekzZaPMIWuteuo6aNjrjzIri/lp3Vbn4JuPdn7+j8eptQm
        yoSknBYA6RHfO51+i3Jm9eq5N99tydDzjCWnLMiuUCwrmIqaQpqQHes5UuYPy1Uj
        AKoXnsODUCpY5C30w2QlEui/A4MQ82e3xGBPDiKjkz02TjMpaM/DXpCiQOyGRaO1
        yLr3wqrlDSEeqS2yrMzE2PV9+02A5vnp23lWAlux6VL55a1eI5pXP9u1El65GvGp
        9nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=xPR3nv
        9RViuUI7Pm5HeyKP7a/yFpe94UvKTn3SkPqso=; b=R+9K9fDVv8h1TJ1zlLVn8d
        lWqgbBSacX5nWWBQQ9BETzFOWe217NsAlOPNsth39rOxFnJZl7tUPY8JyemKLSfT
        tR+pYeq5vze2w42e7B6M/UmyzhKdEf+87PzE3Ag4hT3F/PU3aJIlusafVoPipfiY
        a83Gcdx5KYbP3tsooUSjKDv9UXV2Ml8UAmdBgsO8NYEcraXr+ujk07qKttcFbMNg
        qXnAAr4hR5Gq0zZE8xg38lr3ZOFV2PTCzz2dOzQU0ASYq7Eh+evdfbR/X1dZNyLi
        8tJ7UFF+l5KE3pe6B3nmBwZobV+iWtnyB6e253u3X1zhNfol03rRLsNuwB0pbzBw
        ==
X-ME-Sender: <xms:fLqdYE-vjIt4K8lZfyZp9hfwkpJ_YROE_KvuCP857Y9jmp1g49EctA>
    <xme:fLqdYMu6MTfI_XZZ11zcWWE-MQ-YyqFCXpgQlD4EnWOPAT_C5J1fjCsUWjOO6JlqP
    Od5e0rip6icC403>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehhedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttderjeenucfhrhhomhepugifhhes
    lhhinhhugihprhhoghhrrghmmhgvrhdrohhrghenucggtffrrghtthgvrhhnpeefjeevve
    dtveelgffhteeuleejhfeutdettefghedtleegieeuteekgfffieeileenucffohhmrghi
    nhepphihphhirdhorhhgnecukfhppedujeegrdehvddrudehrdefjeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegufihhsehlihhnuhigphhr
    ohhgrhgrmhhmvghrrdhorhhg
X-ME-Proxy: <xmx:fLqdYKBCg2LE3ABbur4y5T967V0Rd7fsjMLVWP304m5TTkdgasZOvQ>
    <xmx:fLqdYEeKIlAwEJxpJ3kri7dmUG1D4UU28uN9T1XIGSm3EGeWlTHHPA>
    <xmx:fLqdYJNuqG4lTzG_XquFhL4LiBO6n-LWWZ6WHACiHkfm8tBdtrGHbA>
    <xmx:fbqdYLUTumIMSroEw-SzeGETdUqzA2UdZgaXmAZ9LjW55igsXSktPg>
Received: from localhost (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 13 May 2021 19:47:08 -0400 (EDT)
Date:   Thu, 13 May 2021 16:47:06 -0700
From:   dwh@linuxprogrammer.org
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Is the sha256 object format experimental or not?
Message-ID: <20210513234706.GG11882@localhost>
References: <20210508022225.GH3986@localhost>
 <YJcqqYsOerijsxRQ@camp.crustytoothpaste.net>
 <87lf8mu642.fsf@evledraar.gmail.com>
 <YJm23HESQb1Z6h8y@camp.crustytoothpaste.net>
 <20210513202919.GE11882@localhost>
 <20210513204957.5g76czb5bk3thlep@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20210513204957.5g76czb5bk3thlep@meerkat.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.05.2021 16:49, Konstantin Ryabitsev wrote:
>Check out what we're doing as part of patatt and b4:
>https://pypi.org/project/patatt/
>
>It takes your keyring-in-git idea and runs with it -- it would be good to have
>your input while the project is still young and widely unknown. :)

Konstantin:

That's really clever. I especially love how you're using the list
archive as the provenance log of old keys developers used. That seems
like it would work although I have worries about the security of
X-Developer-Key and the lack of key history immediately available to
`git log` because it's in the list archive and not in the repo directly.
I guess the old keys would still be in your local keyring for `gpg` to
use but it would mark signatures created with old revoked keys as
invalid even though they are valid.

Old keys--even if revoked or compromised--matter in a world of digitally
signed data. As a matter of course, people should rotate their signing
keys on a regular basis. It's just good hygiene. That means that there
will always be old data signed with old keys and those old keys need to
be kept around to validate the old signatures.

My approach has been to move to cryptographically secure provenance logs
that contain key rotation events and commitments to future keys and also
cryptographically linking to arbitrary metadata (e.g. KYC proofs, etc).
The file format is documented using the Community Standard template from
the LF. I'm hoping to move Git to use external tools for all digest and
digital signature operations. Then I can start putting provenance logs
into a ".well-known" path in Git repos, maybe ".plogs" or something.
Then I can write/adapt a signing tool to understand provenance logs
of public keys in the repo instead of the GPG keyring stuff we have
today.

Provenance logs accumulate the full key history of a developer over
time. It represents a second axis of time such that the HEAD of a repo
will have the full key history, for every contributor available to
cryptographic tools for verifying signatures. This makes `git log
--show-signature` operations maximally efficient because we don't have
to check out old keyrings from history to recreate the state GPG was in
when the signature was created.

I still like your approach purely for the "it works right now" aspect of
the solution. Good job. I can't wait to see it in action.

Cheers!
Dave
