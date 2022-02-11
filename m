Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A70C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 19:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352387AbiBKTU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 14:20:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245721AbiBKTUz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 14:20:55 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F252ECEC
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 11:20:53 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92549187491;
        Fri, 11 Feb 2022 14:20:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ud+M35Ulu2ugc2gDGDChplTC5pRZHJSSHBFVTt
        FKtmI=; b=a9w+JD2HBxRkiqxlaIQxjidOqLLZH+EBtVw7pmbaYqkcHEp6JlDuvH
        enGbh0u+iarEghI7z4c2fn89nFVh7xyRptb9HxFFeBjT1hgu3bDdqIpRBLC1EhJC
        yjDYs/Fjg5kYt88rbKUjuCJo6S/n5DV7vjJwA4pDLdoXwUktjqFSI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B14718748F;
        Fri, 11 Feb 2022 14:20:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E2F9218748B;
        Fri, 11 Feb 2022 14:20:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, paulus@ozlabs.org
Subject: Re: [PATCH v3 4/4] gitk: pass --no-graph to `git log`
References: <20220211163627.598166-1-alexhenrie24@gmail.com>
        <20220211163627.598166-4-alexhenrie24@gmail.com>
        <xmqq1r09clxl.fsf@gitster.g>
        <CAMMLpeTBstt8qo2q6r=YCEi-h-G-EkjY=d7kHKeepzTvz1gmJg@mail.gmail.com>
Date:   Fri, 11 Feb 2022 11:20:49 -0800
In-Reply-To: <CAMMLpeTBstt8qo2q6r=YCEi-h-G-EkjY=d7kHKeepzTvz1gmJg@mail.gmail.com>
        (Alex Henrie's message of "Fri, 11 Feb 2022 12:05:17 -0700")
Message-ID: <xmqq5yplb46m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B96196CE-8B6F-11EC-830E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> What if we make log.graph=true also require feature.experimental=true?

No.  feature.experimental is to give people an opt-in opportunity
for features that we are considering to enable by default.

> The log.graph option would really be a useful feature for people who
> use Git exclusively from the CLI without any external tools. It seems
> that the main challenge is how to give others time to adjust.

Those who want to see log by default must need to twaek their
configuration.  Instead of doing "git config log.graph true" and
breaking tools, they can do "git config alias.mylog 'log --graph'"
with the same ease, without breaking anything.

So...

