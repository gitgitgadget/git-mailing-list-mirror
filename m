Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6F8C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F30C23A00
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgLSROZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 12:14:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64265 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgLSROZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 12:14:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE9EBA6810;
        Sat, 19 Dec 2020 12:13:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2LfBalARPW3xLAf82g3lk/pMrwc=; b=BhmnPA
        9Jr9ond0a4ESgxEYlmIo/lB+ulgS9B/427jDyklMgN+EdTA4Q9vJBBn3pMwzdLHY
        1DDo26ozLCC0kLp0WE+5u6/oL4C51UV55Vk4WQfchQwVDMIegZRduhePuatYHDok
        9HJ5cDJ4V/5i6LU/hAUuDC8aL4o0jlNFNeBbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bJw+R92pQjqgn2+GdPb53xrnAbZdJHdM
        0QKrEWqZh9rbq7XpSTWYsbgPTvUuGYaI9XAmbXxT8itbyxtQZO0nxxzkiLi93RVB
        v5fZ2TrvuBNsBSvA6WkhkmZfFSlEL/XPSS0d4Kl/VLLW10SefDy0KkzJOv11/ajK
        m5QkEegWEuU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E76BAA680F;
        Sat, 19 Dec 2020 12:13:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37C76A680E;
        Sat, 19 Dec 2020 12:13:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2020, #03; Fri, 18)
References: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com>
        <CAPig+cRycw=JnYOxCspJiLWbX10FK_QJhHx3A98oJBSG_MBaoQ@mail.gmail.com>
Date:   Sat, 19 Dec 2020 09:13:42 -0800
In-Reply-To: <CAPig+cRycw=JnYOxCspJiLWbX10FK_QJhHx3A98oJBSG_MBaoQ@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 19 Dec 2020 01:44:17 -0500")
Message-ID: <xmqqo8ippvll.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BD541AC-421D-11EB-A9B0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Dec 19, 2020 at 12:36 AM Junio C Hamano <gitster@pobox.com> wrote:
>> * ds/maintenance-part-4 (2020-12-09) 6 commits
>>  - t7900: make macOS-specific test work on Windows
>>  - t7900: fix test failures when invoked individually via --run
>>  - maintenance: use Windows scheduled tasks
>>  - maintenance: use launchctl on macOS
>>  - maintenance: include 'cron' details in docs
>>  - maintenance: extract platform-specific scheduling
>>
>>  Follow-up on the "maintenance part-3" which introduced scheduled
>>  maintenance tasks to support platforms whose native scheduling
>>  methods are not 'cron'.
>
> I've read this series in its entirety at each re-roll, and am
> satisfied that the comments from my reviews have been addressed.
> (There may be one or two remaining subjective nits but nothing worth
> holding up the series.)

Thanks.
