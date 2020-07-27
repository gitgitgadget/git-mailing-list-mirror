Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9E2C433E1
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 16:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B55420719
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 16:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JmXu7NcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgG0QVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:21:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50700 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgG0QVi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 12:21:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 023AA6CA24;
        Mon, 27 Jul 2020 12:21:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vHHdOoNLLo5dWdE+adIpbkleSNc=; b=JmXu7N
        cKgyAkf5aRr1zP1tKj2v3xibeKUgojAi5z61KcMswMIGlFKnXRNeLlptFccwfpmE
        S7moVsq/h4/PA1H3Ye5wz7oGn7JEJNul2ohLaYpjD7a0NnjB5oHE2s6l1ZxMRESj
        xFJtDN1PXhvPvZ1uv/NA7B4UzMlRp9cSIALMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eJ87Ywdzy4Ire+EJTc0lwLUnHuXhObVm
        dCMsEl7d/2++dSOMDYjZNVndKj/3H4nYRfwKKrM3QePwzH4l4/0SB7D0zQqgEjPJ
        xCd8NdOt4QNe+jmIYPa8FOYKyDfqMGJGCSFE4cd9RD+6Fb5Kh0t0ABmRJl9xqzER
        Cr6H3ThY63c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDD3A6CA23;
        Mon, 27 Jul 2020 12:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B1546CA22;
        Mon, 27 Jul 2020 12:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, mirucam@gmail.com,
        chriscool@tuxfamily.org, git@vger.kernel.org
Subject: Re: [PATCH v5 02/13] bisect--helper: use '-res' in 'cmd_bisect__helper' return
References: <20200717105406.82226-3-mirucam@gmail.com>
        <20200725173118.GA614724@konoha>
        <20200727054215.4nfke6byi6m63txf@yadavpratyush.com>
        <20200727064605.xhgtuxh46kukpisv@yadavpratyush.com>
Date:   Mon, 27 Jul 2020 09:21:34 -0700
In-Reply-To: <20200727064605.xhgtuxh46kukpisv@yadavpratyush.com> (Pratyush
        Yadav's message of "Mon, 27 Jul 2020 12:16:05 +0530")
Message-ID: <xmqqlfj5gc8h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DAB5DFA-D025-11EA-9D3A-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> My MUA didn't download Junio's reply earlier for some reason. Sorry for 
> the redundant message.

Mails cross all the time---you do not have to apologize.

