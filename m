Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81161C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 19:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8B424672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 19:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G7o0SRfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfLSTpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:45:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63854 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfLSTpK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 14:45:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 518DD30CC3;
        Thu, 19 Dec 2019 14:45:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jNIvSpUudsoiqGIi89xEajePPqw=; b=G7o0SR
        fRw1H0tRj88Xpfft4vH/lDdvUK18Rt0yQYw9vEiE38rrIcsvbo0YONBAC/H5WGM3
        NirZQ//fUG4MdiXgVqD0c6fvqWaLN8VdnPNCKwyMl+x2hDCoJo5aoQm/qMQoQntY
        zMHxTP/pi82cNJfNnULgHd2Sq1EAekYtGO/pY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xtJZCJ4gaSyMS6R3bo8+sOAl9IkXHbAR
        w4xbTamWmu9LQU6J4V+Ib56SOfMcJIMHUsSVsiN/DGCeEs+jDn2N3GVCK+v7/AM6
        EGN4KFiYmG4daJnFeEkSjX2WYO5UOWCCdcFCRHrXxj/2YH/d8bIF2SLCNsgsw5LT
        qFpMiHd251g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F95530CBF;
        Thu, 19 Dec 2019 14:45:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3AD0A30CBE;
        Thu, 19 Dec 2019 14:45:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 0/1] [Outreachy] commit: display advice hints when commit fails
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
        <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
        <xmqqlfr8b28v.fsf@gitster-ct.c.googlers.com>
        <20191219185427.GA227872@google.com>
        <xmqq7e2sazlh.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 19 Dec 2019 11:45:01 -0800
In-Reply-To: <xmqq7e2sazlh.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 19 Dec 2019 11:23:54 -0800")
Message-ID: <xmqq36dgayma.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CD73C70-2298-11EA-897A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
>> On Thu, Dec 19, 2019 at 10:26:40AM -0800, Junio C Hamano wrote:
>>> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> 
>>> >      @@ -19,16 +19,16 @@
>>> >             #   (use "git add <file>..." to update what will be committed)
>>> >             #   (use "git checkout -- <file>..." to discard changes in working directory)
>>> >             #
>>> >      -      #   modified:   ../builtin/commit.c
>>> >      +      #   modified:   /builtin/commit.c
>>> 
>>> Really?
>>
>> It's hard to know what this cryptic comment means.. :)
>>
>> This was a recommended change:
>> https://lore.kernel.org/git/20191218031338.203382-1-jonathantanmy@google.com
>>
>> Since other changes were being made at the same time, I personally don't
>> mind a little nit fix in the commit message.
>>
>> Or, do you mean that "now it looks like the file is at the filesystem
>> root, which is wrong"? It is indeed wrong now when it wasn't before. But
>> I, for one, can't tell what you mean by just the one word.
>
> That is exactly the point.  I am not in the business of spoon
> feeding answers.  I want my contributors to *think*.

And I am not being unnecessarily cryptic.  If anybody thought a bit
about what the topic was about, looking at it it would immediately
be obvious that the sample output shown there is totally bogus, due
to the leading slash.

Any contributor working on this topic should be competent enough to
realize/notice it once it is pointed out---even though lack of
proof-reading before sending may cause such a mistake by
carelessness.  And that is what I wanted to convey by deliberately
a short response.


