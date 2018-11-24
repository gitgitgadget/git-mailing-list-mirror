Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2211F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 04:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbeKXPKM (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 10:10:12 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57648 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbeKXPKM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 10:10:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E4E223AC5;
        Fri, 23 Nov 2018 23:23:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n7NdQKtl9Fjhcjjp59i2dKK35MQ=; b=gCQTuI
        /JqYyhH1dOeuI72drUU6u8RiXFFsNBQmUJjN0NoODeGxAWmrzVBhOW5eveylQe8W
        EVeLkx1BaQrwFjQo35EDf0nYFkOohNDJpT+D2sRNOd55mFo4h0EHZcNQnNJMyLR6
        jX1FzKz3VsS+CZ3y32elHcWvUG2QVnhWa3bMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aodtDYhArIP+5IcQdHKc3qZZQ1+l0GDY
        P3e3GmWcSfSOzvve9W8eTApFTMK2bcL3FAIf56xiiNhEqLf1bU4Fbalt0hq1rBD5
        cLNmTNjQc4sTBYBMsZYpTKivHnWa5bjbQUM6OIHVVKRFnpBrVJRVK6y61M+Cs5Iv
        O+LML97On/w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8767C23AC4;
        Fri, 23 Nov 2018 23:23:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EED3223AC1;
        Fri, 23 Nov 2018 23:22:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Mandelberg <david@mandelberg.org>
Cc:     git@vger.kernel.org
Subject: Re: git overwriting local ignored files?
References: <a852c0e9-f278-8e2a-406c-bb6099b2440c@mandelberg.org>
Date:   Sat, 24 Nov 2018 13:22:51 +0900
In-Reply-To: <a852c0e9-f278-8e2a-406c-bb6099b2440c@mandelberg.org> (David
        Mandelberg's message of "Fri, 23 Nov 2018 21:35:05 -0500")
Message-ID: <xmqqftvr2jfo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CD69F4A-EFA0-11E8-81A6-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Mandelberg <david@mandelberg.org> writes:

> It seems that git is overwriting my local files on merge if they're in
> .gitignore. See command transcript below. I searched `git help config`
> and Google, but I couldn't find any way to prevent it. Am I missing
> something? (The reason I care about ignored files is that I'm using
> git with a working directory of $HOME to manage my dotfiles, and most
> files in my $HOME are not tracked by git but are still important.)

The .gitignore file is to list "ignored and expendable" class of
files; there is no "ignored but precious class" in Git.
