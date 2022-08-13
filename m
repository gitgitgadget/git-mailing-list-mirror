Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AE8C00140
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 00:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbiHMAp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 20:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiHMAp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 20:45:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E9311457
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 17:45:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BB5E13F144;
        Fri, 12 Aug 2022 20:45:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VxTp2dqqHOKT
        xlnJEss7i+5Ru8PF4BT2JReSQZPDXmw=; b=DYdyuISfAaqqSRxyg5O4JU3NHTgM
        xd/bwintb1ujR2du7+2tq9oR13OkpaQy9w5IDODf8Hr7R2FOg0OlXVAEECbAjUnh
        enwD4/qfYpEKe8d1KMAP2sHtD/NhvYScLNS073qotK17gWZXihjwVP0xyV6tGtws
        gS5PV4r0VhHzu44=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 038E313F141;
        Fri, 12 Aug 2022 20:45:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5BC5E13F13E;
        Fri, 12 Aug 2022 20:45:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
Subject: Re: t7527 intermittent failure on macOS APFS and possible fix
References: <YvZbGAf+82WtNXcJ@danh.dev> <xmqqmtc9baht.fsf@gitster.g>
        <YvbtVoP01fHF2ka3@danh.dev>
Date:   Fri, 12 Aug 2022 17:45:51 -0700
In-Reply-To: <YvbtVoP01fHF2ka3@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Sat, 13 Aug 2022 07:16:22 +0700")
Message-ID: <xmqq1qtlas3k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4854E082-1AA1-11ED-BC37-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> Aren't these protocol drivers?
>
> The "answer" strbuf is the response from fsmonitor daemon, I think.
> The write_in_full to fd 1 is test-tool writes down the answer to
> stdout.

Ahh, then please scratch everything I said about this part.  Your
original implementation makes it more clear that we are "dumping"
what we got from the daemon, and then adding LF for our own
readability.  I somehow mistook the code to be preparing and sending
protocol message to the other end (iow, fd #1 was connected to
"them").

Sorry about the gotcha, and thanks for straightening me out.

