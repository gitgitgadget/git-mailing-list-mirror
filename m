Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64B8C433E2
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 21:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8DF2193E
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 21:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vMbb/Y4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgINVNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 17:13:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64518 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgINVNb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 17:13:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77B091035A7;
        Mon, 14 Sep 2020 17:13:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nryndLxY/euGCInPukHL8CTocZc=; b=vMbb/Y
        4Bguh53XFxxdt6gPpayppO2IGGh/OeKn7ah3itoBwe/zpf1AcRZa2MLrIqmAYPUM
        mmwU1ckjcSKjfSmq8s3+Wj0sZ4IiodruY6GU0L8qi9Wq2SqlNqVoi2+fiZ2eyMxp
        9hZ6W5xM3AYFKMerq03AijKd0AGR7YMoSI9/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=st2NQXCzkIsLgOMVmPJEHe0LkDc6apUV
        Kkt1icXb/ONKDBevj6xdiJ4EAaPZbg2KCM/l6raw6oGNa6hkXm0EsneRCdCDBBTf
        ZIb5Ul3UvTsN9KYG4ZR+Q74CNDIHWTU+mb2v9E9S6vGNSnA05kIUBR/0JScmo677
        2B9tyIq5GJw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 701781035A6;
        Mon, 14 Sep 2020 17:13:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 88B9F1035A3;
        Mon, 14 Sep 2020 17:13:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/7] remote: add reflog check for "force-if-includes"
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
        <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
        <20200913145413.18351-2-shrinidhi.kaushik@gmail.com>
Date:   Mon, 14 Sep 2020 14:13:24 -0700
In-Reply-To: <20200913145413.18351-2-shrinidhi.kaushik@gmail.com> (Srinidhi
        Kaushik's message of "Sun, 13 Sep 2020 20:24:07 +0530")
Message-ID: <xmqqsgbk12q3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 214F73BE-F6CF-11EA-A915-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> +/*
> + * Check for reachability of a remote-tracking
> + * ref in the reflog entries of its local ref.
> + */
> +void check_reflog_for_ref(struct ref *r_ref)

Make it file-scope static.
