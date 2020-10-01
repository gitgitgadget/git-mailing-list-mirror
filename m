Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ED2C4363D
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 00:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B082D2184D
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 00:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jaZk/r7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgJAAfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 20:35:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51906 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbgJAAfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 20:35:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61B8B89DD7;
        Wed, 30 Sep 2020 20:35:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n27vfSZLgm3yCuIWrJsrDuDU6ck=; b=jaZk/r
        7zZZm0CU0uVdIseHPCUkr/1QuFqGxqko5c8wbuRMJzDxc1kRLd561lpQGwQn23k3
        UbJAMnjjha1vNsW5erXVC9KomnYBmSskhyofgvQ5VRUIV8QU/WsP1Gs3roo0/Qsa
        +WjU2Pkj03shXSS+ZWtYf4C8U8NHGKMEgBQtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X+N3D9+xfExZgRJMmQ9G02+AVLbM1zFD
        k4oBE3j5J9TQKM6YnIoH1Q9io2YqlmKGZtM1ngKrW/ex34nk9hf+9UOsjh8Qak2l
        GTgEJC2m2Qs4jtskSMu4qrHuciIlu7mH8u/xHDFkQmId55TrncGvGLQ7ckS8fwTN
        F41VFNibo9Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4806089DD6;
        Wed, 30 Sep 2020 20:35:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA66989DD5;
        Wed, 30 Sep 2020 20:35:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        <20200930232138.3656304-1-shengfa@google.com>
        <20200930232138.3656304-2-shengfa@google.com>
        <xmqqpn62essa.fsf@gitster.c.googlers.com>
        <xmqq7dsaeqij.fsf@gitster.c.googlers.com>
Date:   Wed, 30 Sep 2020 17:35:07 -0700
In-Reply-To: <xmqq7dsaeqij.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 30 Sep 2020 17:31:00 -0700")
Message-ID: <xmqq362yeqbo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4C36E3E-037D-11EB-80CE-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> 	test_config user.hideTimeZone true &&
> 	(
> 		export GIT_AUTHOR_DATE=@1600000000 TZ=UTC-09 &&
> 		git commit ... &&
> 		git show -s --format='%aI' >output &&
> 		echo 2020-09-13T15:26:40+03:00 >expect &&

Oops.  The sample date and zone must be adjusted for the values
exported above.  I expect that we'd need to do

		...
		echo 2020-09-13T12:26:40+00:00 >expect &&
		test_cmp expect output

