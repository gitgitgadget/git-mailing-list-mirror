Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D60AC433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 22:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiBAWUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 17:20:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51648 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238746AbiBAWUz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 17:20:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41996FBA6E;
        Tue,  1 Feb 2022 17:20:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SGYRx8hS5eG+f4X6CoI6jR8388YR2RmWkA0OA5
        um0LQ=; b=Zbl0yKTdxtpczQxSnOuGFldE2FSbuV6rx0wmht0njy9FRLYYnD6KxG
        HzSqu/XadaCu1X3S02tgVtK13JK36PRU5CKp+EGyl+8HIz7Wmd0RcyERd1cTSOm8
        Wi2R4q9nAGY/TlClZH83JQSI8K8ZEZUgzCucnI4x/m5Pw0R6T2jYA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3816DFBA6D;
        Tue,  1 Feb 2022 17:20:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 760F8FBA67;
        Tue,  1 Feb 2022 17:20:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v8 2/6] branch: make create_branch() always create a branch
References: <20220124204442.39353-1-chooglen@google.com>
        <20220129000446.99261-1-chooglen@google.com>
        <20220129000446.99261-3-chooglen@google.com>
Date:   Tue, 01 Feb 2022 14:20:52 -0800
In-Reply-To: <20220129000446.99261-3-chooglen@google.com> (Glen Choo's message
        of "Fri, 28 Jan 2022 16:04:42 -0800")
Message-ID: <xmqqmtjab54r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3813FE78-83AD-11EC-A0DC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> With the previous commit, there are no more invocations of
> create_branch() that do not create a branch because:
>
> * BRANCH_TRACK_OVERRIDE is no longer passed
> * clobber_head_ok = true and force = false is never passed
>
> Assert these situations, delete dead code and ensure that we're handling
> clobber_head_ok and force correctly by introducing tests for `git branch
> --force`. As a result, create_branch() now always creates a branch.

A very nice simplifiation of semantics.

