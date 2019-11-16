Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389F61F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 03:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfKPDLm (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 22:11:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54133 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfKPDLm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 22:11:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6C1021A91;
        Fri, 15 Nov 2019 22:11:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JjSMZ7jP/1AlGn61O6ngNBoHW4s=; b=Bx3x+6
        6aYP6W838BQoD7DOwvi61B7JWVmbSdmxBFPo1UMNfspZ4mNcFuDaEyUBYlCPttDB
        vCVMXVwmlKsnr4mhAQE0VsDrrPRKu6zFBPvg3+FtkqnYF2nSglnbkJsps7ZNNsRa
        HT8wYhPt42CdUx9Ulk6U8aBAS7O4zBR/2tGpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t1hQaBMeX8KIU2+81bo9reUGWWNa0M9y
        4dB0sk2M4U6uQzHRMhkFHHsvu14OX074ZTdgdUblwj7DQDgjUC2aHoorrshNYD0U
        ERAmX+tBqQtOCTdGBkHEYe2hZdOxdO9214QMhGoBzuUOUdnOAyNASlr+AQNV2VLi
        EHiniShe8dI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF1C921A90;
        Fri, 15 Nov 2019 22:11:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18C2221A8F;
        Fri, 15 Nov 2019 22:11:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/9] bugreport: add tool to generate debugging info
References: <20191025025129.250049-1-emilyshaffer@google.com>
        <20191025025129.250049-2-emilyshaffer@google.com>
Date:   Sat, 16 Nov 2019 12:11:38 +0900
In-Reply-To: <20191025025129.250049-2-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 24 Oct 2019 19:51:21 -0700")
Message-ID: <xmqqr2284is5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE4943D8-081E-11EA-BCF6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Teach Git how to prompt the user for a good bug report: reproduction
> steps, expected behavior, and actual behavior. Later, Git can learn how
> to collect some diagnostic information from the repository.

It makes sense, but I do not think of any good reason why this
should be implemented as a builtin.  I'd expect it would probably
need to collect more info on the running environment than otherwise
necessary for the regular Git operation, and perhaps you'd want to
even link with libraries that are not needed for the regular Git
operation to achieve that.

Can you make it a standalone binary instead to avoid bloat of the
main "git" binary?

Thanks.


