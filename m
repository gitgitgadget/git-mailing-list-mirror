Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2C1C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD1A214AF
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C3TYjoBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgDXU0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:26:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63617 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbgDXU0O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 16:26:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5180F56B59;
        Fri, 24 Apr 2020 16:26:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Oc571frHC/FT
        QOdwIRR/8QKuZto=; b=C3TYjoBoJpB2GIsWBaafpkGrqo7djW+Cq115RCfpJ7YG
        PaRKG5xemcg1xypVFkLAHt65P7YRc/CbpoGS+x37RaaIuSjEaVIHG1EPgTfxt9tI
        6yEsbaxzZ16ri4PAEskY3soFw4h2ABHsJW8cVt4h1Lx7r3mVGIY2iyt8/8STHMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VfZ/7j
        YzEJ+U8H9qLQsJdAgXoror2p468fbPo5i9GkK6krdbJ1ZQMSGB+o8M1ZCQRney/Q
        xl7/368P8FXyRKMTWFaVketyrirM8MZtrvh4sDCwcon3FtbgtPaUZ73HUYbFCeMV
        J/BdhpywNVD2+aR39LtxjpzMC7tNPMOhIyfIA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4938856B58;
        Fri, 24 Apr 2020 16:26:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD76856B57;
        Fri, 24 Apr 2020 16:26:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH] credential: remove unnecessary forward declarations
References: <20200424112356.74165-1-carenas@gmail.com>
Date:   Fri, 24 Apr 2020 13:26:11 -0700
In-Reply-To: <20200424112356.74165-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 24 Apr 2020 04:23:56 -0700")
Message-ID: <xmqq7dy4d40s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D69E30B0-8669-11EA-AB61-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 46fd7b3900 (credential: allow wildcard patterns when matching config,
> 2020-02-20) introduced a forward declaration for credential_describe()
> that wasn't needed as well as a forward declaration for a similar
> function that was implemented a few lines below.
>
> remove the unnecessary forward declarations by moving the function
> to where it is needed instead.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  credential.c | 37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)

I would rather not to see this kind of code churn for "this way it
is cleaner" (as opposed to "this is broken and needs fixing") in the
area of code that were _very_ actively touched and across _wide_
range of versions.  Maybe long after the dust from 2.17.4 and
friends settles, but not now.

Thanks.
