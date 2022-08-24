Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBDAC00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 16:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbiHXQGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 12:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiHXQGw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 12:06:52 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A781276478
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 09:06:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A227C145800;
        Wed, 24 Aug 2022 12:06:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=El/pJUkzAlIcfyZ3iirVKonU5LnOm8K9ES7LSG
        laeJc=; b=RhlXLPmxDB4hiC9AU4xQo2Mkfwl2gSvUjaJRjk4JlsYHpD2oDiUv/G
        C/8SsLrBbFOxj0qVLBN2QC9mj9DK2Er4KhlsicH2lPT+d3HRjCSPc+wr6DqQGEMU
        H4I+LjAwB+0hS3yrf+R5t3mVu4Y1RD3prV7VOfqk2Oz+aeuTGTfKU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98BD11457FD;
        Wed, 24 Aug 2022 12:06:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 045691457FC;
        Wed, 24 Aug 2022 12:06:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Renato Botelho <garga@freebsd.org>,
        Todd Zullinger <tmz@pobox.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] gc: use temporary file for editing crontab
References: <1dd29f43-1a8e-eb69-3320-7f5140a0e18e@github.com>
        <20220823010120.25388-1-sandals@crustytoothpaste.net>
        <6428252p-ssrn-7qs7-9p26-5so10r96s3os@tzk.qr>
        <9e737b4b-4a17-09d5-6452-4ca5eef3d9da@github.com>
        <YwVDcO/V+zx2iy4I@tapette.crustytoothpaste.net>
Date:   Wed, 24 Aug 2022 09:06:46 -0700
In-Reply-To: <YwVDcO/V+zx2iy4I@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 23 Aug 2022 21:15:28 +0000")
Message-ID: <xmqqpmgp8w2x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1CE3660-23C6-11ED-97FD-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> There is something wrong with this patch: it needs to update
>> t/helper/test-crontab.c in order to pass t7900-maintenance.sh.
>
> Will fix.
>
>> While the memory release is nice, I also think it would be good to use
>> delete_tempfile() so the temporary file is deleted within this method,
>> not waiting until the end of the process to do that cleanup.
>
> Sounds good.  I'll include that in a v2.

Thanks for following through the idea fell out of earlier
discussion.  I almost forgot about it, and it is very good to see it
written and reviewed quickly like this.

Thanks, all.
