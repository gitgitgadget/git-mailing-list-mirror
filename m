Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCD4CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 17:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379544AbjJLRDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379526AbjJLRDW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 13:03:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2B1B7
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 10:03:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CE6B19D3A5;
        Thu, 12 Oct 2023 13:03:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=ibX1WAT74i4pjDzT4t1vML3Kt4kjQ6dLxa8dho
        2TcpI=; b=HmTwbar+yxo6RgqyHKKaYFBDB1969I90bOqSJJO4msedFiMCOz8NDs
        NY6qVhqmNBU1QLHNwvx4jof5J8u3Moo6w8crjSIp+8N2jh4TZJN0DXRV7OeG9B8I
        gL+FZOn+4HFh0DpmRvjZZNdafkUfib/8/MDmPR9LcVWDyJkCwgo+k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 235FD19D3A4;
        Thu, 12 Oct 2023 13:03:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 764BC19D3A3;
        Thu, 12 Oct 2023 13:03:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How to combine multiple commit diffs?
In-Reply-To: <CAOLTT8RzcENBx9NKffHReVKJAho89TCO7W2SPBX8sb2tEU84Gw@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 12 Oct 2023 20:00:25 +0800")
References: <CAOLTT8RzcENBx9NKffHReVKJAho89TCO7W2SPBX8sb2tEU84Gw@mail.gmail.com>
Date:   Thu, 12 Oct 2023 10:03:19 -0700
Message-ID: <xmqqpm1jg4dk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EE3A8A6-6921-11EE-B022-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> This may seem similar to cherry-picking a few commits from a pile of
> commits, but in fact, we do not expect to actually perform
> cherry-picking.

If you said "We do not want to", I may be sympathetic, but it is
curious that you said "We do not expect to", which hints that you
already have some implementation in mind.

Whether you use a checkout of the history to a working tree and
perform a series of "git cherry-pick" to implement it, or use the
"git replay" machinery to perform them in-core, at the conceptual
level, you would need to pick a base commit and apply the effect of
those commits you would want to look at on top of that base in
sequence, before you can see the combined change, no?

Puzzled.
