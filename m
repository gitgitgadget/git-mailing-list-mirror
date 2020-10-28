Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9250AC55179
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F1620684
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCh4P3qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390296AbgJ1XyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390081AbgJ1Xxw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:53:52 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880B4C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:53:52 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id j7so1402532oie.12
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KYOiDsxm0R36v5Dec+5BPo4TuwIvPu8SD6WluEmDwIo=;
        b=pCh4P3qbDDGScO41pqtcbWo+N/ShzyFAS/vS+T3n0QFIRGdUX/SilpzBQ11UgKB4yx
         ygvfLe7pHWB6kOV4FpHVTEG/yxw55V3R+4xVn8m4DjwuxtbcHrnTR/B0d9qzZXcHEbDc
         yXkBsWDNE6J+QozY4Jw/qINLkMNFvQwvWTnR4E100Ev215HMM0GqVicg5tc7BsClA5S7
         mDWmf6ERJNLSnJzFNpimZzaa8wVY0PZFxsBBlUaKgEUNenJsKl6XdNowa2eZeivZ1zmy
         /V2t1ax+/6f5QVjdmI1ciTksTxWVAvKV7We9h7IY0EtIfcnwCVwsFvllPtSoxabQ+J+v
         0l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KYOiDsxm0R36v5Dec+5BPo4TuwIvPu8SD6WluEmDwIo=;
        b=adclVOC6FyG6q6ZioL4MQ5dEHx+t0lH7xBLSmJ6PWIriM2HYfn7YYlTDPcUuau1IJb
         cxyLj65F09npcOEQITeNXsee+F9zIwh6NZL4GpBE5bNrxqjj3ZOBBygf2z5Oy6F8fDnE
         CxnrvIzDDUv/3u+ePThQMnRxWuH8QzHNKyz7djGC0mzNwVH8vzelaUnc9/3AKepLT7oT
         aCT1qur4TA0paSJw3OAjabmRi2O2JgSN4QqKS7oqOQD64GvHxiM9Uu50bFuKJFF8ykaV
         kaEuKCp+zyNny2v8OiWK4QmJNBSm+1v4l8U/bvR9FCJK5C/A2KUoL8zJa1wvW6Fme2HA
         lBiQ==
X-Gm-Message-State: AOAM531Czj0UO0g4Rd1YqKGwXI4hD5sxYw8nx0nCn/66TGwqxdmG8aS0
        PKNUr2Za1nYbMMAJERbymp7mNGDfbc4=
X-Google-Smtp-Source: ABdhPJzKfzX4+o+YEi5MPt/G4V9LiwiZi8ki+hUXxkBIM2HOrYbvVfLcHbnDEn5/YAvbpx5mLuaSeg==
X-Received: by 2002:a17:90a:fa02:: with SMTP id cm2mr3328300pjb.236.1603844348497;
        Tue, 27 Oct 2020 17:19:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id e184sm1234190pfe.146.2020.10.27.17.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 17:19:07 -0700 (PDT)
Date:   Tue, 27 Oct 2020 17:19:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Joey Salazar <jgsal@protonmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in
 test script
Message-ID: <20201028001905.GA1500644@google.com>
References: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com>
 <20201026205028.GC2645313@google.com>
 <xmqqwnzcd6jf.fsf@gitster.c.googlers.com>
 <Bgt8H4Cev0hu-OKtYHazhsRRIFO_6bAoBqdc4tep09T98tL426R9WXIAMjm7aO4b0uPrZGldPhZ1mV3f9pbS3PDN4bOlb9JkUvvXKtnUFHA=@protonmail.com>
 <20201026220228.GD2645313@google.com>
 <AwF-WVCPGK9qyy3lWQ-aYXuvw7HTPjjGuvT4rbPjgoWZE0czToIU-aACj2oyRnkOevGWLQbDgtndt9dkMSGF-SFkNanPgao9yLuVYU1VURI=@protonmail.com>
 <XDwhHkxbkjL46BTp1WCJ5gJ3UbrMxRGwR2VgeRxehZh0-G07JlxCHrBGCpruqk-OegVspO6LJ0Y3yW9izl97pufYDwOhGaS885_xaVK63vs=@protonmail.com>
 <20201027001427.GG2645313@google.com>
 <bixxjcjnQYoZ6CIUQUXdBTaGE7vawm33kqmy3csw7hsPqGQpQNyEhUqBYkvoDgHb8sb3vjLr1KOR3I71-4a4wDKQqTrFocv-eVtGlyE8S84=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bixxjcjnQYoZ6CIUQUXdBTaGE7vawm33kqmy3csw7hsPqGQpQNyEhUqBYkvoDgHb8sb3vjLr1KOR3I71-4a4wDKQqTrFocv-eVtGlyE8S84=@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joey Salazar wrote:

> I see, thank you. I'm now thinking of a paragraph like this (thank
> you Emily Shaffer for your guidance in the IRC channel);
>
> Messages from checks to `${if_local_config}` are also printed when the
> result is false, which can be confusing. Improve readability by
> removing `${if_local_config}` checks and print messages only when a
> pager is wanted.

I think that's on the right track, though I'm having trouble
understanding the details of it.  If this goes as part of the same
patch, we'd want to focus on why we're making this change in the
context of this commit.  Using an example can make the idea clearer:

	A subtlety: one advantage of helpers such as test_path_is_missing is
	that they print a diagnostic if and only if the condition fails, which
	can make the output from a failing test easier to read.  Unfortunately,
	some helpers in this test communicate whether a configured pager is
	expected to run using a shell constract that doesn't have that property:

		my_generic_helper () {
			...
			${if_local_config}test -e core.pager_used
		}

		...
		if_local_config='! '
		my_generic_helper

	Rewriting this to "${if_local_config}test_path_is_file core.pager_used"
	would print a diagnostic when the file is absent, which is the opposite
	of what we want.  Make the logic more explicit instead, using "test" to
	check a variable core_pager_wanted that is nonempty when core.pager is
	expected to be used.

That said, it looks like js/t7006-cleanup is in "next", indicating
that it has finished being reviewed and is now safe to build on (see
https://git-scm.com/docs/SubmittingPatches for more on this subject),
so it would be even better to make this a patch on top of the existing
v2 patch after all.

Thanks,
Jonathan
