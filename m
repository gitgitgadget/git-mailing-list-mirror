Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62056C2D0C8
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 19:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9CE2072A
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 19:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jHyYHu2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfLYTNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 14:13:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63236 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfLYTNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 14:13:47 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 07897972A3;
        Wed, 25 Dec 2019 14:13:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+pj481hghZOEgW+01JAOZC3gSpg=; b=jHyYHu
        2zlKboDnVvdW500RrLkHS5T1Za2DdXW8ZvJDnaBiuDzrISOv2T/bS49C/k0aOtz1
        iZXyELCXNng1BW240uzvBHapsWCMHqkAzfn3ayvo7kyX8GrMP2FqsbmmEL8NrqIb
        1iBzCDWGdm8iGfLcq1WoettZRmH+Uo4ujVOTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uWgE3AzsCYL0PmcTcXxKRCWtbjYqJFDt
        i0B6+ji6SxjxsFzf7QFbUNf6LGqwkEKJElc6wkHX0+Rgxf5zlog4vp9EWn1MxDBS
        a9SqavV+nv4SB+kb1Rx7n7YaauZZdTEeFC2mFC7tYN95om/s+iP3UbjHyP0g7J5e
        ZfBDzXq++0w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F33D7972A2;
        Wed, 25 Dec 2019 14:13:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 273AF972A1;
        Wed, 25 Dec 2019 14:13:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>, Ben Keene <seraphire@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v5 0/4] git-p4: Usability enhancements
References: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
        <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com>
        <xmqq8sncj991.fsf@gitster-ct.c.googlers.com>
        <CAE5ih7-ptmmb2UurBw+k+2ZjZQuOkLJ3c-eBoOXKrPX0CJeErA@mail.gmail.com>
Date:   Wed, 25 Dec 2019 11:13:41 -0800
In-Reply-To: <CAE5ih7-ptmmb2UurBw+k+2ZjZQuOkLJ3c-eBoOXKrPX0CJeErA@mail.gmail.com>
        (Luke Diamand's message of "Sat, 21 Dec 2019 10:19:03 +0000")
Message-ID: <xmqqh81omd5m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB367D98-274A-11EA-A77C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> $ git log --reverse --oneline --abbrev-commit
> origin/maint..origin/bk/p4-misc-usability
> e2aed5fd5b git-p4: yes/no prompts should sanitize user text
>    - looks good to me
>
> 608e380502 git-p4: show detailed help when parsing options fail
>    - also looks good to me
>
> c4dc935311 git-p4: wrap patchRCSKeywords test to revert changes on failure
>    - why not just catch the exception, and then drop out of the "if-"
> condition and fall into the cleanup section at the bottom of that
> function (line 1976)? As it stands, this is duplicating the cleanup
> code now.
>
> 89c88c0ecf (origin/bk/p4-misc-usability) git-p4: failure because of
> RCS keywords should show help
>   - strictly speaking, the code does not actually check if there *are*
> any RCS keywords, it just checks if the filetype means that RCS kws
> *would* be expanded *if* they were present. The conflict might be just
> because....there's a conflict. As it stands this will be giving
> misleading advice. I would get it to check to see if there really are
> any RCS keywords in the file.

Thanks.  Ben, let's keep the first two and discard the rest for now,
which can later be replaced with updated ones.
