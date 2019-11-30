Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E4CC432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 20:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFA02075A
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 20:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yfYA4SX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfK3UV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 15:21:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52785 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3UV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 15:21:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77B5A8B543;
        Sat, 30 Nov 2019 15:21:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VbuZwK0orLSRv38iDSQacatT2Zc=; b=yfYA4S
        X4LPftw4S01BmsxcKl/YUVMIy7YSgRA05hnOmt5eafSHiqDAmrGBQpys3tduesnC
        tgOuvSwObdS/56bSO1uMyAqU19U/9kNDLLMsKEmE0ETq34G1FGIx13JE8YXdB3Wb
        nA0U7yyIIIaOsxqtPUMH6IPL6rB+3eRwSFkik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O8Hu9Mczu4lJjmlw6MtVeAxtQCpesU98
        GzfCMhvE4kXlQp54AFkCIxLvcQZ6+ydFst5jbdcigfAp5eyE7DcZ1R/fVtoquSi5
        pYRsvJd+Q/QeM4HOXppmAGpGl2STRgB68/DNdy1rbl6cilZa7+iqD+VfEvs+e4xB
        87+F4o/dNU0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D1F18B542;
        Sat, 30 Nov 2019 15:21:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 559578B53A;
        Sat, 30 Nov 2019 15:21:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Brown-bag fix on top of js/mingw-inherit-only-std-handles
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>
        <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
        <xmqq5zj12qc2.fsf@gitster-ct.c.googlers.com>
        <6beaf25f-1369-3e77-fd54-fdb5a1e63707@kdbg.org>
Date:   Sat, 30 Nov 2019 12:21:18 -0800
In-Reply-To: <6beaf25f-1369-3e77-fd54-fdb5a1e63707@kdbg.org> (Johannes Sixt's
        message of "Sat, 30 Nov 2019 20:13:56 +0100")
Message-ID: <xmqq1rtp2k01.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F890051E-13AE-11EA-80B8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Just like on POSIX the value of errno is indeterminate after a
> successful system call, the value of GetLastError() indeterminate after
> a successful Windows API call. Therefore, the err_win_to_posix() would
> not be able to point at a bogus caller reliably. For this reason, let's
> consider the function as a simple error code translator, and then
> translating ERROR_SUCCESS to 0 (or is there ESUCCESS?) makes total sense.

OK, that makes sense.

Thanks.
