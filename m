Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C55C4320A
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 21:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C967B60D07
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 21:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbhHNVVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 17:21:01 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:32899 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236602AbhHNVUN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Aug 2021 17:20:13 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 799FF320091B;
        Sat, 14 Aug 2021 17:19:43 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute2.internal (MEProxy); Sat, 14 Aug 2021 17:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawned.biz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=hSKl/G2LFyMCeOcpicfAAiOE/+xWiYH
        1AAmOBTjJnw8=; b=Uu9XM/rFl1S5lq+ebOP59sFP/xB0Ro2mZ+MP/wx0KaUjk4x
        R5LLVonnfsfhwUevLXSkyD8/SJK/29WXBWfHQWemKfSxnS+Kjd6XzZI1QIRUCReO
        hP3tHWldTURlRZBV51j7y9ylzYutJx66/LDNiRAfwl+T2VcAVt6as06l1tLVMpSY
        ug/YxPs67aI2jRrMb0bV1vTRyqWGpNHkSzzAN1SycTPVi686Am4hH6fhSFQ2h06S
        DKJGZQssN4yOq1PMJ5Qm2mg8Ei+ct3WBT+DKbxgX/e5uFaTknIvpNgniNGyYeI3I
        A0dclMQInt3ye6YNJ6NzHX4xYEHsInCPfLk2fwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hSKl/G
        2LFyMCeOcpicfAAiOE/+xWiYH1AAmOBTjJnw8=; b=jEnPb3t7qQDYyW/sLs32Nb
        O0ArvGfh5UyQnF97uJfHIQdAuzIlrAGVzvsrv6KY2SF4kjaCLxaEYHypHlVRYs+V
        SWFL8MkSsfQL/JyQLO1NHAwr3VAKkv78BInqu6w19/4Tzc779bWMsPIbjjpf2+wO
        ETw9ihGD5hK1ByH0c23uiZqyk3BDd+YhzZq3wr9hxonbWhOCQVPkVwHh3HKwHJbE
        I/nQYc86fUN+hH6OxZYqVsItrHVZTOlz2QVn8C9sfW6Q25gmZckumG9VGdeGOVGg
        swg7uFm+yq6qJ3+kG2rT6vGc+I5K+CtNMpxYkFhP5E46wS2ZBp5Ays8xh3nT9KAQ
        ==
X-ME-Sender: <xms:bjMYYSn5z28Yy5f2FWkkAdB4ZDwkEQqo8TJfQZ_PZ5IZVcixQ1_9wg>
    <xme:bjMYYZ0IKv3OioIhHJDtb9rEdxt4qEQau_ogABBFvtxL_Rl1yMZ8a-0Y5fk9ix94F
    3p4beFp9PzruKb_1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeejgdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdflohgv
    lhcumfhlihhnghhhvggufdcuoehthhgvpghjkhesshhprgifnhgvugdrsghiiieqnecugg
    ftrfgrthhtvghrnheptdekgfdukedujeeijefgheelkeekgfduvdeugfduleeffefftdev
    ueeuhefhieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepthhhvggpjhhksehsphgrfihnvggurdgsihii
X-ME-Proxy: <xmx:bjMYYQoRv5wKT4wB9rD9XKi3xJn1MKlHoRUYXkVFTEFV9ssdDRERrg>
    <xmx:bjMYYWmpxAzD7Fi25g0meNtMEtTj_TsSqSPdZpRGoY0uHcmE7f-iRw>
    <xmx:bjMYYQ08AJdJvK2BnplVkxGOOLUjN5PKxhNwAYzH9tGvSkZaa8L8AQ>
    <xmx:bzMYYdzBx8wGo4dIT7mpbHdDtqSYptGzvwELTBH3S5yGxHpbLB86Qg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8874CA038A7; Sat, 14 Aug 2021 17:19:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-554-g53a5f93b7d-fm-20210809.002-g53a5f93b
Mime-Version: 1.0
Message-Id: <d268b6ef-89c7-4649-828e-759ed269e9c6@www.fastmail.com>
In-Reply-To: <ec5f6698-46e9-c8c8-057d-b04851cb9265@gmail.com>
References: <pull.1014.v2.git.1628725421868.gitgitgadget@gmail.com>
 <pull.1014.v3.git.1628755346354.gitgitgadget@gmail.com>
 <e3a24819-9953-0245-7f64-472def4d180a@gmail.com>
 <0576a44a-c726-4550-ad29-52f09982de98@www.fastmail.com>
 <0151003c-d544-1fab-18e9-34eb84842555@gmail.com>
 <1fc066c5-a085-4865-9eb9-853dfcbe33c2@www.fastmail.com>
 <ec5f6698-46e9-c8c8-057d-b04851cb9265@gmail.com>
Date:   Sat, 14 Aug 2021 23:19:22 +0200
From:   "Joel Klinghed" <the_jk@spawned.biz>
To:     phillip.wood@dunelm.org.uk,
        "Joel Klinghed via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     "Jeff King" <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v3] commit: restore --edit when combined with --fixup
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 14, 2021, at 17:20, Phillip Wood wrote:
> On 13/08/2021 16:35, Joel Klinghed wrote:
> > 
> > With the above change use_editor no longer defaults to 0 for --fixup as
> > it used to do.
> > My expected behavior (based on old versions):
> > git commit --fixup <hash>  /// No editor
> > git commit --fixup <hash> --edit  /// Editor
> > As far as I can see your change would display an editor in both cases.
> 
> I've just tested it and it works as expected. However moving the
> 'if (logfile...)' breaks the test "commit --squash works with -c" so we
> need to just move the second if clause. This is what I have on top of
> master (i.e. without your patch so a plain fixup is still setting
> use_editor=0)
> 

Ah, my bad. I misunderstood and thought your first patch was to
be applied without my fixes. This way is cleaner, no doubt.

> diff --git a/t/t7500-commit-template-squash-signoff.sh 
> b/t/t7500-commit-template-squash-signoff.sh
> index 54c2082acb..3fa674e52d 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -270,7 +270,7 @@ EOF
>   
>   test_expect_success 'commit --fixup provides correct one-line commit 
> message' '
>          commit_for_rebase_autosquash_setup &&
> -       git commit --fixup HEAD~1 &&
> +       EDITOR="printf \"something\nextra\" >>" git commit --fixup 
> HEAD~1 &&
>          commit_msg_is "fixup! target message subject line"
>   '

Good idea to make --fixup without edit behavior verification explicit.

/JK
