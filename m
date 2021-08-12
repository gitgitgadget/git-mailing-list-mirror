Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348BCC04FE3
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 07:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB41610FA
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 07:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhHLHnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 03:43:18 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:35205 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234879AbhHLHnP (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Aug 2021 03:43:15 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 5EE6A3200938;
        Thu, 12 Aug 2021 03:42:50 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute2.internal (MEProxy); Thu, 12 Aug 2021 03:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawned.biz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=5lyDF5k5xjnHopRKzwqSbJD71XqoAW5
        3TQricWtlanM=; b=D98Aqguj9pOsNypw1gCE5U/IAGw/0gwSTQS6ZeoP+P5DrDz
        iUgQSmv7DOPWQ6+5+MKlmZCTYZIiESKkIWp2QsvI5X5Hmgs9IdTIxYKQ9zasoDFv
        41t6tgIdBys0hc7RhprV2X73Dg8GvPXhJu6xlYQcGpFk7DA3b6Irxl+d7mXgpl48
        tUNrCiCR/UeaK5SaLcdImdphSmcCzIu/S9AYRUJ/5Y57xuz+dWCdzqoxVEwZ7p5M
        7zKaCUNAb9hQiIJ8U7/yYKXsq187cH7ouCHgOFgj74c5P5LUlVF9njhpi05Q7dG0
        45XNagbYSuCi6x/rUb6w91yCwZT+p2kBYvFNHQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5lyDF5
        k5xjnHopRKzwqSbJD71XqoAW53TQricWtlanM=; b=LmkRKC2r0ZmV3tzT4JkQKU
        FEjeYgjvetLHvllJTdVVwUPe8ibACHh3AHYp43NCC8yjZsnwe+IRpCnDBSClFtjU
        MuX3pZFp6gLUHHhyX6BZCNap9s0z7q1iIhaAAcwG9UozUt+XGRlfzYCcEx0tWMUn
        +qbJfWTcOrDXvSfVNWjTmDMRGZjos47UTxCvL3HEdW1Df1kTXTVba2j32Vvu7Yah
        UIPaUcKpnqa7EQq4RZ9MIel+0TGmvuzY6N5MU4lNXpI6gAFNB3E5C5hwUo6z8Vmz
        89aG3iFUQRwn36krWGrQcJ9jeDJIC/KmyLHsKaI5287g2my1F3nybuJm5sMnIaYg
        ==
X-ME-Sender: <xms:-dAUYchII2F6ppldpMaNnsOBNcUUNsnKiljZMDV-hR9cD2J037AHIA>
    <xme:-dAUYVDJv9_4C_5IW6Wc5Zl3gdUdlduofwXxkk5f3yv97YZFKwOqYgxGIK6rrkUIt
    1Gzpi0YzzpOOOL6_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedvgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdflohgv
    lhcumfhlihhnghhhvggufdcuoehthhgvpghjkhesshhprgifnhgvugdrsghiiieqnecugg
    ftrfgrthhtvghrnheptdekgfdukedujeeijefgheelkeekgfduvdeugfduleeffefftdev
    ueeuhefhieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepthhhvggpjhhksehsphgrfihnvggurdgsihii
X-ME-Proxy: <xmx:-dAUYUHvpoDQOb4PtEzyaawl7TBS5iS5QqTbqtQ0gtvXX-7Y-APgjg>
    <xmx:-dAUYdSw1_R9MEJds1JGH0uMmaXbmq3aoXKYwsFWfnAyLkqZie0W6A>
    <xmx:-dAUYZyGaCAhIQSh6C8vkhtVYVmRnPcycoLg5cuqIj8JxpGFDLk2qg>
    <xmx:-tAUYU9Lay7ONjL1sIHKrObkQ3FO1B_uNWuVqRZ-dsI6dlvgIa3EpQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A3A71A038A7; Thu, 12 Aug 2021 03:42:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-554-g53a5f93b7d-fm-20210809.002-g53a5f93b
Mime-Version: 1.0
Message-Id: <873ec1ab-c062-4306-b3fb-09d32c70cc7f@www.fastmail.com>
In-Reply-To: <xmqq1r6z6xwf.fsf@gitster.g>
References: <pull.1014.git.1628689758413.gitgitgadget@gmail.com>
 <pull.1014.v2.git.1628725421868.gitgitgadget@gmail.com>
 <xmqq1r6z6xwf.fsf@gitster.g>
Date:   Thu, 12 Aug 2021 09:42:06 +0200
From:   "Joel Klinghed" <the_jk@spawned.biz>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Joel Klinghed via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Jeff King" <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] commit: restore --edit when combined with --fixup
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021, at 07:21, Junio C Hamano wrote:
> "Joel Klinghed via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 190d215d43b..4c5286840c5 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -1333,7 +1333,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
> >  		} else {
> >  			fixup_commit = fixup_message;
> >  			fixup_prefix = "fixup";
> > -			use_editor = 0;
> > +			if (0 > edit_flag)
> 
> Writing this as
> 
> 			if (edit_flag < 0)
> 
> makes it far easier to immediately see that we are talking about a
> nagetive edit_flag.
> 

Agree, I'll change it.
I was unsure of the style and copied from the earlier condition:
	if (0 <= edit_flag)
		use_editor = edit_flag;

> > +				use_editor = 0;
> >  		}
> >  	}
> >  

> 
> Use write_script helper from test-lib-functions.sh here and lose the
> hardcoded reference to /bin/sh.
> 

Ah, missed that one.

Thanks.

/JK
