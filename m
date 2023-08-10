Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87D7C04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 16:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbjHJQAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbjHJQAp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 12:00:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7285E53
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:00:44 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3703119A256;
        Thu, 10 Aug 2023 12:00:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FpmcC1i2mLqbejCgejUMxqORH/FokShQDy6n4V
        I3f0w=; b=gg4biB2JOUVHwopfF8txY58YqIHsmEoXt26tN2PPa8JECIy+SmsxBL
        Lbf3G6SIU7L8LR/vS15046CaKWxuZ+X3/mvkkbjrG7Dz8YQpvF8djQ73LYjAEH2K
        3dZU9BNgGga8UnECPNxHSgbIzEXvhmsuDIlPZirBwzUabFJBSqPVg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E39519A255;
        Thu, 10 Aug 2023 12:00:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 970D919A251;
        Thu, 10 Aug 2023 12:00:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/1] t/lib-rebase: (mostly) cosmetic improvements to
 set_fake_editor()
References: <8ce40f48-f36f-9e81-1a3f-9d8b170c4a0f@gmail.com>
        <20230809171531.2564785-1-oswald.buddenhagen@gmx.de>
        <xmqqh6p7lxxx.fsf@gitster.g> <ZNS/JteS1nhzk58P@ugly>
Date:   Thu, 10 Aug 2023 09:00:41 -0700
In-Reply-To: <ZNS/JteS1nhzk58P@ugly> (Oswald Buddenhagen's message of "Thu, 10
        Aug 2023 12:42:46 +0200")
Message-ID: <xmqqpm3uhopi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F001450-3797-11EE-8AAA-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Wed, Aug 09, 2023 at 02:15:22PM -0700, Junio C Hamano wrote:
>>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>>
>>> An update to the documentation, and two minor functional changes that don't
>>> actually change anything given current use cases, and are therefore basically
>>> documentation updates as well.
>>>
>>> Oswald Buddenhagen (1):
>>>   t/lib-rebase: improve documentation of set_fake_editor()
>>>
>>>  t/lib-rebase.sh | 21 ++++++++++++---------
>>>  1 file changed, 12 insertions(+), 9 deletions(-)
>>
>>Now I lost track.  This is slightly different from one of the steps
>>in the three-patch series.  Were the other two steps retracted?
>>
> no, this cover letter was a messup on my side, caused by a lack of
> attention and still suboptimal tooling. this was meant to be an update
> to just this one commit, while keeping the other two intact.

I see.  It is a bit too late for today's integration cycle to
resurrect the other two I have discarded, because I have other
things to do including the -rc1 release engineering, but I can
easily go back to the list archive.

For future reference, in this project, we do not generally replace
only a single patch in a three-patch series [*].  We do not want to
deal with a mixture of [PATCH v1 1/3], [PATCH v3 2/3], [PATCH v2
3/3], especially since during the evolution of a series, new patches
may become needed, a patch may become split into two, etc.  Instead
everything gets the new iteration number, i.e. v1 and v2 of patches
1/3 and 3/3 may be identical and only 2/3 may have differences
between its v1 and v2.  And that is perfectly expected around here.

Thanks.


[Footnote]

 * Of course there are execeptions.  When it is obvious to everybody
   that the series is more or less done and all things that need to
   be discussed have been discussed during the review, and the
   review conclusion is that everything in v4 patch is good except
   for this minor change necessary in one patch, it would be a good
   approach to send just a single message, saying "here is to
   replace step 2 of the 7 patches" under the three-dash line and
   marking it as [PATCH v5 2/7] (or "v4bis" or any other marking
   that makes it clear it is the "latest").

