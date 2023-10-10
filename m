Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C787CD8CA9
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 17:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjJJRKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 13:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjJJRJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 13:09:59 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F9099
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 10:09:58 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 888A71AAEB8;
        Tue, 10 Oct 2023 13:09:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=dIwB842pyH2NwfyAl+0gFSUad0CuBpju3vt4G/
        dcM4M=; b=ZvyF1DWOW9y0tQfuDwsUXaGx1YTZQW3qThXAFlBoMePcX4IN955DRa
        F5tzyuf2cWZvAYHP6Cyz1TtxcwH4txC9IGBZwwfZt1J3lbdyG/azlPcMlbYwA6WX
        Sqf8zzVwkOWHIWDUkBMsqX9OM9iwFfEFXD4sJe+P2HPEyBNVSsIjc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EB301AAEB7;
        Tue, 10 Oct 2023 13:09:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A6AC31AAEB5;
        Tue, 10 Oct 2023 13:09:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] rev-list: add support for commits in `--missing`
In-Reply-To: <ZSTs3BUVtaI9QIoA@tanuki> (Patrick Steinhardt's message of "Tue,
        10 Oct 2023 08:19:08 +0200")
References: <20231009105528.17777-1-karthik.188@gmail.com>
        <ZSTs3BUVtaI9QIoA@tanuki>
Date:   Tue, 10 Oct 2023 10:09:55 -0700
Message-ID: <xmqqil7etndo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D637BB22-678F-11EE-97DC-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> I had already reviewed the patches internally at GitLab, so for what
> it's worth please feel free to add my Reviewed-by.

Great.  It seems that 'seen' with this series fails to pass the
tests, though.

https://github.com/git/git/actions/runs/6462854176/job/17545104753

Thanks.

>
> Patrick
>
>> Karthik Nayak (3):
>>   revision: rename bit to `do_not_die_on_missing_objects`
>>   rev-list: move `show_commit()` to the bottom
>>   rev-list: add commit object support in `--missing` option
>> 
>>  builtin/reflog.c            |  2 +-
>>  builtin/rev-list.c          | 93 +++++++++++++++++++------------------
>>  list-objects.c              |  2 +-
>>  object.h                    |  2 +-
>>  revision.c                  |  9 +++-
>>  revision.h                  | 20 ++++----
>>  t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++
>>  7 files changed, 145 insertions(+), 57 deletions(-)
>>  create mode 100755 t/t6022-rev-list-missing.sh
>> 
>> -- 
>> 2.41.0
>> 
