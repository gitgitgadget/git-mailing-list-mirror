Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BBFC432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC2F2465B
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vjqEEjZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfLBTEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:04:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58690 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbfLBTEl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 14:04:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9E4A1F43B;
        Mon,  2 Dec 2019 14:04:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZPLwqop15RI441gzCKASvGwHMo4=; b=vjqEEj
        Zx4EEsyBlP7+4dW8B7rrjUvC/mjB3HZ0NOwVRT0tn87fpzthz8mlZaGnZidgDYHY
        uy7htyMkOlYT0RFuGftcZ4XKAwSeAOcBqNNCvqXw+DnqtWW8wZaOhMe0P5qSvaw/
        uD7sJf0/AMoxIMV4HmuP4Bq3vDa2b568KzId4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b2RUBK7Y0VJz8ZnRQRJrPrpuopaIPt+N
        en+dy4dm7sA6qL4hwh5mMjBXdu/FILrTObqsHZKtWuxGx7GV2UAzeCDdmBS1BebD
        pHjVDk9jnmU2yqLlj1Vv33iaS3kq3JpyYTVagO46Zj0AkDwS5Y+jjbYHGHJj/Vca
        82uIkb0V9Nc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D88671F43A;
        Mon,  2 Dec 2019 14:04:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1CEE11F438;
        Mon,  2 Dec 2019 14:04:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/2] Brown-bag fix on top of js/mingw-inherit-only-std-handles
References: <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
        <pull.480.v3.git.1575286409.gitgitgadget@gmail.com>
        <a4ac4530-9b5c-3eb6-ada2-067c6ef73868@kdbg.org>
Date:   Mon, 02 Dec 2019 11:04:37 -0800
In-Reply-To: <a4ac4530-9b5c-3eb6-ada2-067c6ef73868@kdbg.org> (Johannes Sixt's
        message of "Mon, 2 Dec 2019 18:35:10 +0100")
Message-ID: <xmqqzhgawnui.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96D844A6-1536-11EA-A265-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 02.12.19 um 12:33 schrieb Johannes Schindelin via GitGitGadget:
>> Range-diff vs v2:
>> 
>>  1:  280b6d08a4 = 1:  280b6d08a4 mingw: do set `errno` correctly when trying to restrict handle inheritance
>>  2:  c3dea00fb1 ! 2:  e04e1269b3 mingw: translate ERROR_SUCCESS to errno = 0
>>      @@ -3,12 +3,15 @@
>>           mingw: translate ERROR_SUCCESS to errno = 0
>
> The subject line would have to be adjusted as well.
>
> 	mingw: forbid translating ERROR_SUCCESS to an errno value
>
> or something.

True.  Thanks for being careful.
