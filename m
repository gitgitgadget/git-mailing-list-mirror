Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3537FC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 12:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017022067D
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 12:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVpEZCqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgAHMmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:42:18 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:45965 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAHMmR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 07:42:17 -0500
Received: by mail-wr1-f44.google.com with SMTP id j42so3154649wrj.12
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 04:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f2guXfbkyVIq34MSJnqz4cAtDwYGmqn0MyEoLlORh1A=;
        b=JVpEZCqcqFYtZlm60+9uce3Sw4pFp/avrGgKa+7VYyHhTrGS2fW7v9Vd/W3IH8oqKu
         kM8fw9Lu/ana9IShpmlOUoG8oY2xjWaBt3zaTbltRNYg/H/+MNNIX0jzmCEB5wRohUUl
         bTb7hCoPO6VhixRcgu466Ggh1lWHVi/fSHy3Zipuz0FR7A0XnQnfGUU3fD/SpA9C2PZx
         WtjNBc82N7LRsqd64ysSjjhz38JnFJGmTuvOOt8Gg3XylpRnvSooIAR18obA3ukuKH5N
         X4IBQqxxo1x7zxd6FDvbLDzZkcyGkG93XuD6NdQK9jgLoPQnsrGH8vio2JeUOJiHHBR3
         uLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=f2guXfbkyVIq34MSJnqz4cAtDwYGmqn0MyEoLlORh1A=;
        b=RVOcBBOccRY0UVFVpLD3cbkzRT+qrPaPLaZNYeBv28i+P4P781W14sI8j5rvHH7BcG
         XPKjyAFFUUQ+RO/j2z2DJYf6//yGXp3k8uMdNxceEqf0vh7wCzdWxxbgiOGM6W0wWS4u
         k14GMupgH0XvA4gOzvPQHeFcA6MYUF9EbZTwHuG2ylII63+WnbgGMZNFFIXynp2LB0nX
         xAvY0IYASgCgSNzaAdWAXCk9hhTSefXybUbBPvG3/reJ9IGC3evAnHry1qr08JDFhPNT
         n9JL1Z6JrS7rhEr1dC+JI9ZPZeArATk5d6ytaTSCFl+tH/p2NwQvduM2N/0Cr0Jdn/6n
         tWLA==
X-Gm-Message-State: APjAAAXRpT+FWJN5HIOHr4zKp4+22yw+Rtrt/TLcjvVnOFOld5VHjeZD
        keup73dNFI/pmwyCUuBYRu0TNdtlTc8=
X-Google-Smtp-Source: APXvYqwqJzARTB29uyqX5BLOe3AhFz/F/nBoqNtLUmSaH17XiuO5eRTAyZNbZfZhdwC0F1Ywgd8LyQ==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr4218664wrp.238.1578487335943;
        Wed, 08 Jan 2020 04:42:15 -0800 (PST)
Received: from torstenknbl.mgm-edv.de ([185.40.248.10])
        by smtp.googlemail.com with ESMTPSA id f207sm4098581wme.9.2020.01.08.04.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 04:42:15 -0800 (PST)
Message-ID: <654cc7a58cf6947f91478411dd6a3f7f3473bc67.camel@gmail.com>
Subject: Re: Broken branch after git commit - tracked files in staging area
 can't be removed with restore --staged, or commit or stash
From:   Torsten Krah <krah.tm@gmail.com>
Reply-To: krah.tm@gmail.com
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Wed, 08 Jan 2020 13:42:14 +0100
In-Reply-To: <20200108104008.GA2207365@coredump.intra.peff.net>
References: <07c84224bb0b093ab3770be9b5ab2ec23ce2d31a.camel@gmail.com>
         <234df85965f8a685be5e563fe795ed477f359d7c.camel@gmail.com>
         <f0638fc0d09c213b661d2b244d3457f362daebe0.camel@gmail.com>
         <20200108091119.GB87523@coredump.intra.peff.net>
         <2423f8c0b91578c0faf7527b7d97b0e1e9666261.camel@gmail.com>
         <20200108104008.GA2207365@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Mittwoch, den 08.01.2020, 05:40 -0500 schrieb Jeff King:
> So there seem to be at least two bugs:
> 
>  - git-restore doesn't properly invalidate the cache-tree
> 
>  - the index-reading code is not careful enough about bogus cache-
> trees,
>    and may segfault
> 
> -Peff
-- 

Hi Peff,

thanks for confirming those bugs and taking a look at my report itself
even before I've put the small reproducer recipe.
I don't need to take any other actions or create tickets somewhere else
now to get those fixed, you're driving this from here, right?

Another question - how can I fix my broken original branch where this
bug did hit me which is in that "bogus" state now to get back to the
"original" commit made so I can remove my unwanted files with "git
reset HEAD <files>" instead of git-restore in the meantime (tried your
rm .git/index variant but after that I had files which were already in
the branch shown as unversioned after that, so that did not work very
well for me)?

kind regards

Torsten


