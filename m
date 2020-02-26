Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DF9C4BA15
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 16:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8041B2084E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 16:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mMAmJzrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgBZQ3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:29:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65387 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgBZQ3j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 11:29:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61AC7B7811;
        Wed, 26 Feb 2020 11:29:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dveuu+WWIGIwCx9Tq0vM+Fh5rrY=; b=mMAmJz
        rIIujxPfL1aXU9QJJeXRvo0BPWw4dlxSi4h7GEE0EzmeOZfQo/Gg+Cl9SGoxh1U6
        RHxvxa+Bo/nBb/fTRlneV/8TVp4Z2dIxaaFARfdVlIl0ku8KOQvHo9rtUJQToPot
        WBdOv8epK20AB6EyuH1z3AS9QYAmfC2Bd+83o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZJTLqmSpGvLVniK9Odk6gCkvLjyIti3s
        0v+wPm6QpYWDXpqNUJF0wLbvyb5Z7qQq9h/CEXclJTviZJYlwub3U0g83/o8HRR7
        4RdF0rHGFzHsgEuUS5TnM+dfnTa3IZS8MvO1516F+v0GljbE1tVi4fB1SnhhRpjm
        gH9WHkrQZh8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A8CBB7810;
        Wed, 26 Feb 2020 11:29:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 87D38B780A;
        Wed, 26 Feb 2020 11:29:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2020, #05; Tue, 25)
References: <xmqqo8tml1lv.fsf@gitster-ct.c.googlers.com>
        <CAPig+cR3H2qvCddWuWPNex=K-x0FyzKehpbOiv7W-s_4EAW1bQ@mail.gmail.com>
Date:   Wed, 26 Feb 2020 08:29:32 -0800
In-Reply-To: <CAPig+cR3H2qvCddWuWPNex=K-x0FyzKehpbOiv7W-s_4EAW1bQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 26 Feb 2020 01:54:01 -0500")
Message-ID: <xmqqzhd5jor7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C6A6712-58B5-11EA-9AF6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Feb 25, 2020 at 5:54 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * es/worktree-avoid-duplication-fix (2020-02-24) 3 commits
>>  (merged to 'next' on 2020-02-25 at 74c612837a)
>> + worktree: don't allow "add" validation to be fooled by suffix matching
>> + worktree: add utility to find worktree by pathname
>> + worktree: improve find_worktree() documentation
>> ...
> The description of the patch series could perhaps be a bit clearer.
> How about this instead?
>
>     In rare cases "git worktree add <path>" could think that <path>
>     was already a registered worktree even when it wasn't and refuse
>     to add the new worktree. This has been corrected.

Perfect.  Thanks.  I wish there were more contributors/topic owners
like you ;-)
