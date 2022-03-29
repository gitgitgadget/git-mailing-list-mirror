Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837CAC433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 19:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbiC2THQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 15:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbiC2THP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 15:07:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D22122991
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 12:05:29 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77F3119BED2;
        Tue, 29 Mar 2022 15:05:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YO6wwDhKZYWs1kVFe03SON6/gaHjPsQcdil40p
        CTfCM=; b=ZqhXfW9qR/QCCxjbMhg+bpT2kAGaWLwac6ABh1hlRLHC1gu1QHGLfI
        GDozyKzUV03bcJx3HFDYENZJnJQeCvikSk4gAzzsmrdTLnVfU2K0Fpe0TwpXhdfx
        /dsS1D4BrZ9XlTIofAqBWfLrkXxuF1NP7CTr8C5xmCDNHIfgMYpzo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 726AA19BED1;
        Tue, 29 Mar 2022 15:05:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DAD9E19BECF;
        Tue, 29 Mar 2022 15:05:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, reichemn@icloud.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] mv: refresh stat info for moved entry
References: <pull.1187.git.1648173419533.gitgitgadget@gmail.com>
        <pull.1187.v2.git.1648516027925.gitgitgadget@gmail.com>
        <5ca04e86-6c61-3d4e-88a0-a3c827e19e13@github.com>
        <xmqqa6d8wvwt.fsf@gitster.g>
        <d017b0c6-c06b-e8cd-55a1-6972a9ae7c52@github.com>
Date:   Tue, 29 Mar 2022 12:05:25 -0700
In-Reply-To: <d017b0c6-c06b-e8cd-55a1-6972a9ae7c52@github.com> (Derrick
        Stolee's message of "Tue, 29 Mar 2022 14:54:57 -0400")
Message-ID: <xmqqee2ktw96.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 319D7E18-AF93-11EC-914B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> Does "test-tool chmtime" to tweak the filesystem timestamp help?  I
>> didn't look at the specific step that uses sleep to work around.
>
> The issue here is related to ctime, which is not modified by that
> helper. It also uses utime() which does not seem to have a way to
> modify ctime (which makes sense).

Ahh, silly me.  You're right.
