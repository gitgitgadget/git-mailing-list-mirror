Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194F4C4361A
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE37320684
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbhAZWEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:04:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50661 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732632AbhAZUNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 15:13:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91344AC065;
        Tue, 26 Jan 2021 15:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=loZeegEUgZTbJq1iQNzLKjYdfls=; b=A3XJNH
        QqKiMRSp5ELdfZNrm3TImF0Z1C29YdlQ+ZbyPaYslu2KUP7m1PWiahrnhHYkXuvD
        67q2y9Ybpv/IDIQrbo771iaoQ8AH2llnN+DqtvUNAwbzRNfW21JYZZBBfv7D1k8w
        Efa30sGeQQZPAmboMhpNAAjunCIJ7slqy2NH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qGAV3dLdGG2+f5uRGAP1wR+sdgJRfz3r
        ARjtTmE0VIzmdjrVDihj4D6TPJBrKXkH2nRjr1S+xpT+ndQy9/lMCzJ+Q//eDPTN
        j+hFFRGQ4XW+ztgOsu6VJZZiTlqoBbGddpIg60Sb2Xt7UXuivMDltM4r27EhQxWn
        JBtCtnsJz9w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88DD5AC063;
        Tue, 26 Jan 2021 15:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 167F2AC062;
        Tue, 26 Jan 2021 15:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] doc/reftable: document how to handle windows
References: <pull.951.git.git.1611589125365.gitgitgadget@gmail.com>
        <xmqq35yo459k.fsf@gitster.c.googlers.com>
        <CAFQ2z_PCh2RfWALhAUXm01Xq0o+ibuEGJ2p9sCtvTASQ0FLUag@mail.gmail.com>
        <xmqqtur338bg.fsf@gitster.c.googlers.com>
        <CAFQ2z_PN8K6sKq=Rdw=maVhd67GhCtxWgGSUb5KhZ85EYV6jOw@mail.gmail.com>
Date:   Tue, 26 Jan 2021 12:12:41 -0800
In-Reply-To: <CAFQ2z_PN8K6sKq=Rdw=maVhd67GhCtxWgGSUb5KhZ85EYV6jOw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 26 Jan 2021 19:11:50 +0100")
Message-ID: <xmqqk0rz1mpy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8646828-6012-11EB-BE19-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> The first two parts of the file name (${min}-${max}) already provide
> visibility into what is going on, and the file system timestamp
> already indicates which file is newer. I picked a random name as
> suffix, as it gets the job done and is simple.

OK, as long as two paths of the same ${min}-${max} part would not
confuse people, I am perfectly fine.

> Or, we could rename to ${min}-${max}-0 and if that fails try
> ${min}-${max}-1, and if that fails ${min}-${max}-2 etc. I think that
> is somewhat nicer than parsing back a counter from the existing
> filenames, but it could have the effect that 1-1-0 could be newer than
> 1-1-2.

I agree that such an approach that can get fooled by an existing gap
would not achieve anything over the ${random} approach.

Thanks.

