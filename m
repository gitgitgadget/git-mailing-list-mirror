Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FE7C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 18:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74992082E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 18:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CvKDtPhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBDSUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 13:20:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62772 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgBDSUX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 13:20:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59DB851A00;
        Tue,  4 Feb 2020 13:20:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AgsX2H5VjlEGyXSJZXzJvuG8lCc=; b=CvKDtP
        hpUqu/GNXVi/jvyvSSrXIHz81tXVvMDaCrw+48GrjNoF9BfniObCmyHtP+zRrTRa
        KyTzKY7CUP8vDBfavCWyT8lEpHI1pftlFPppWViML7d0t5NC8fRHST1Qhr9mGxBh
        PdWnHXUK+v3hieSdFPkGVt+bEIwf3O9C2RbmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VjQ9XksVSVcv+EOhCyM6N0NyzsPoz2Ko
        MPzyg2qAmTc3Mt0Pmx/3zRaXtXlW2Tgsj8gWY+8O00bq7n8JJcCQ2pFbb9K/H+xO
        Nl9Q1fZOfQa93GWJSgqj/ZkC2ciSU2LV1XkYc6Ig7N16ZDL+Fw8lrMd+cWBDrZ7V
        WxsGmNwZAho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A4E6519FF;
        Tue,  4 Feb 2020 13:20:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F867519FE;
        Tue,  4 Feb 2020 13:20:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] doc: describe Git bundle format
References: <20200130225818.193825-1-masayasuzuki@google.com>
        <xmqqk1579xa4.fsf@gitster-ct.c.googlers.com>
        <CAJB1erXnNe0yGvL+wgU9RXAA6Vyx7T2dwM9NgCmUChOtL102NQ@mail.gmail.com>
        <xmqqy2tn8c3w.fsf@gitster-ct.c.googlers.com>
        <CAJB1erXqK-a2uDPPQDLpdLYnPC8Mcxjo2ER0qSAsD9DOVHSmGQ@mail.gmail.com>
Date:   Tue, 04 Feb 2020 10:20:16 -0800
In-Reply-To: <CAJB1erXqK-a2uDPPQDLpdLYnPC8Mcxjo2ER0qSAsD9DOVHSmGQ@mail.gmail.com>
        (Masaya Suzuki's message of "Fri, 31 Jan 2020 15:57:55 -0800")
Message-ID: <xmqqpneu8ba7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF4F9B26-477A-11EA-8647-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

> * Delta complete: If an object in a packfile is deltified, the delta
> base exists in the same packfile.

Yes, even though "thin" packs delierately violate this to save size,
normal packs, and more importantly, on-disk packs, are complete in
this sense.

> * Object complete: If an object in a packfile contains a reference to
> another object, that object exists in the same packfile.

A single packfile that would result from a full clone at some time
in the project's history would be "complete" in this sense.  Such a
packfile may contain all objects that are needed to reproduce the
history up to v1.0.1, or another larger "object complete" packfile
may contain everything needed for the history up to v3.0.0.  So as a
concept, this can be defined sensibly.  In the original packfile
design, however, this concept was not useful (iow, there was nowhere
that cared if a packfile is "object complete" or not), so I do not
think there is no explicit "support" to ensure or validate this
trait in the system.

Obviously, a bundle that stores object incomplete pack must have
been created with the bottom boundary.

> The reader of a bundle SHOULD have all objects reachable from prereqs.

Perhaps.  

It _might_ be possible to teach "git clone" to produce a shallow
clone whose shallow cut-off points match the prerequisites of the
bundle, so it depends on what the reader wants to do with the data,
though.

Thanks.

