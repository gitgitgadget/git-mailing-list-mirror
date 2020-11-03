Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5BDC55178
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 17:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA112236F
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 17:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iWxVr9n3";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="Kg6k6O5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgKCRyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 12:54:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56632 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgKCRyE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 12:54:04 -0500
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2020 12:54:03 EST
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7BFBEC545;
        Tue,  3 Nov 2020 12:44:27 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Y2Bbpioi/CNGoEy6uIP3kjS2r2A=; b=iWxVr9
        n3rrqr6rQJ+8j/Nhks4hERhw1a7M8rdiA68BPVZOQHqMg9tC9+RP5exys8b8NwVx
        LCHUnffu4ltCekmurqFSK1zFMN5QdVkpoj7qyP+JHWitDOUhw3eko0KiWgfGu5ej
        QrnK5tkSpCrhZlN6Q4J01oOKyByOMrrfTPdzM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C0E5EEC544;
        Tue,  3 Nov 2020 12:44:27 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=kGIQ72q138cxjuB/2BaJ61RuKeZQg9md0DNrj2rC4BM=; b=Kg6k6O5kd4Hh46ju1Ed2/ZjOGPVFMVyVLqowozHvyVTvLrhAlEt02Qpz0yGE4n0AhkSiciL0RqJVsLIhwf55gUZjen+RmAQLqbx1S/vo9E2VK1umtJCl3T6i6p6CK1iKPCPaiA+jXliQpB/+inV1DcWHSiHx0wmmOsE37yrxV8w=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38D2FEC543;
        Tue,  3 Nov 2020 12:44:25 -0500 (EST)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Simon Richter <Simon.Richter@hogyros.de>
Cc:     git@vger.kernel.org
Subject: Re: Regression: cannot edit after intent-to-add
In-Reply-To: <20201103171618.GA28810@psi5.com>
References: <20201103171618.GA28810@psi5.com>
Date:   Tue, 03 Nov 2020 12:44:23 -0500
Message-ID: <87eelamj2g.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36C0186C-1DFC-11EB-9EEC-D609E328BF65-24757444!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon Richter writes:

> git-add -p now shows me both lines as added, but does not allow me to edit.
> If I want to create an intermediate commit adding just one of the lines, I
> have to edit the actual file.
>
> This used to work in older versions, as I remember using this technique for
> a while and recommending it to others.
>
> Before I do a deep-dive into a codebase I haven't looked at in years: can
> this be re-added easily?

Which version of git are you using?  I think this was already fixed by
75a009dc29 (add -p: fix editing of intent-to-add paths, 2020-09-09),
which was included in v2.29.0.

https://lore.kernel.org/git/pull.731.git.1599659932391.gitgitgadget@gmail.com/
