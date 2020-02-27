Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B47C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 17:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726292469B
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 17:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BHrbk8cD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgB0RNJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:13:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55261 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgB0RNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 12:13:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23DEB42FF4;
        Thu, 27 Feb 2020 12:13:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CQtuvTdDPworrWl9uAT5ppZ91w8=; b=BHrbk8
        cDfP9uVcEn5kzcRCaIUv8YV7IZtRyJ3Be5y0s85lC6cc86ERWtBCDyTkulIQnmMW
        Co4GeC7Uw1sI/McmjXaUsHTYJ8M+JAFxw2SdLIe1Gis0n4G8OGrj5FnGlylvWTEK
        n7iA/13gifpqcBZjn9JD3cG6B6URg5c9YTM1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DIMx0U0h+F+/V12r1upyKV9B43hZdtfS
        4+9DP4z+dsXjldoNQEmHPwkilOw0nUdc8OT+c+qxz3P2I0qvjeUyp8TnSo/BaDho
        GYFndaAeJ8EkV+/ts7fw1EEfvYERv1RN8X7FLa5BxJnVwjLQvyemH2qwD18vCTOk
        nFswA4XZ4UQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0588C42FF3;
        Thu, 27 Feb 2020 12:13:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0774642FF2;
        Thu, 27 Feb 2020 12:13:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     <git@vger.kernel.org>
Subject: Re: Q: submodules and detached HEAD
References: <5E578F2A020000A1000373EF@gwsmtp.uni-regensburg.de>
Date:   Thu, 27 Feb 2020 09:13:03 -0800
In-Reply-To: <5E578F2A020000A1000373EF@gwsmtp.uni-regensburg.de> (Ulrich
        Windl's message of "Thu, 27 Feb 2020 10:43:06 +0100")
Message-ID: <xmqqsgiweyxs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BFC8D40-5984-11EA-8C06-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:

> I'm rather new to submodules, and I have a question on something I don't understand (git-2.12.3 from SLES12):
> I had checked out tag v0.0.1 of my submodule.
> When checking the status, I see:
>
> iptables> git status
> HEAD detached at v0.0.1
> nothing to commit, working tree clean
> iptables> git checkout v0.0.1
> HEAD is now at b23fbdc... .version: 0.0.1

I do not see anything special about "submodule" in the above.
Assuming that v0.0.1 is a tag (i.e. refs/tags/v0.0.1 points at a
commit whose object name is b23fbdc...), what we see in the above
is quite expected.

> iptables> git checkout v0.0.2
> Previous HEAD position was b23fbdc... .version: 0.0.1
> HEAD is now at 5af0df5... v0.0.2: Fix issue with "xtables lock"
> /iptables> git status
> HEAD detached at v0.0.2
> nothing to commit, working tree clean
> iptables> git branch
> * (HEAD detached at v0.0.2)
>   master

So is the above, under the assumption that v0.0.2 is a tag and not a
branch.  When you give a commit to "git checkout <what-to-checkout>"
instead of giving it a branch name, the HEAD points directly at the
given commit and the state is called "detached HEAD".

I do not quite get what the question is.  What was the end-user
expectation and how is the actual behaviour different from it?


> git reflog says:
> 5af0df5 HEAD@{0}: checkout: moving from b23fbdc0e18e570a4d9ec4cb8826afc82e2e0b64 to v0.0.2
> b23fbdc HEAD@{1}: checkout: moving from ec7dd70b59e039b49bb478a3134b713a2b0a279c to v0.0.1
> ec7dd70 HEAD@{2}: checkout: moving from master to v0.0
>
> Config submodule.iptables.branch is not set.
>
> Who can explain?

Not me, especially without  knowing what to explain.  Everything I
saw so far is expected.

