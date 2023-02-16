Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B398C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 16:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBPQPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 11:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBPQPO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 11:15:14 -0500
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D0E4C13
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 08:15:12 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 31GGEgVS2541985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 16:14:43 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>
Cc:     "'Git List'" <git@vger.kernel.org>
References: <000001d94165$3d1cf2f0$b756d8d0$@nexbridge.com>     <Y+0eIlsIxRr+1RYp@coredump.intra.peff.net>      <000801d9416e$4bf844b0$e3e8ce10$@nexbridge.com> <xmqqwn4iycbt.fsf@gitster.g>    <Y+05tTHdj2Jzenge@coredump.intra.peff.net>      <xmqqwn4itmb1.fsf@gitster.g> <xmqqo7putj1t.fsf_-_@gitster.g>    <Y+2ycMAkVd8rh50q@coredump.intra.peff.net> <xmqq8rgxtwvm.fsf@gitster.g>
In-Reply-To: <xmqq8rgxtwvm.fsf@gitster.g>
Subject: RE: [PATCH] test-genzeros: avoid raw write(2)
Date:   Thu, 16 Feb 2023 11:14:55 -0500
Organization: Nexbridge Inc.
Message-ID: <002e01d94221$d2127800$76376800$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFlBHy1D1yynoWJMXR7ix1CE7kV4gGiJvNtAetN2VwCaLwQ1wJ9R7EbAVy6mb0Cv5xKswJGWfwoAate09ivNi4FAA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, February 16, 2023 11:10 AM, Junio C Hamano wrote:
>Jeff King <peff@peff.net> writes:
>
>>>     I ended up avoiding write_or_die() primarily because there is
>>>     nothing "Git" about this helper, which is a poor-man's emulation
>>>     of "dd if=/dev/zero".  It felt a bit too much to pull cache.h in
>>>     as dependency for it.
>>
>> I don't find it any more "Git" than xwrite() or die_errno(), really,
>> but I am quite happy with what you have here.
>
>True.  I view "git-compat-util.h" as "projects, not limited to Git, would
benefit by its
>help to use POSIX api more sensibly", while "cache.h" is "things that are
about Git".
>write_or_die() is certainly in the former category, but is not available
without
>"cache.h" X-<.

I remember by first time in there, and thought why can't we use gnulib or
libc and then realized that those dependencies don't port well either (no
gcc on box). I am grateful for the existence of git-compat-util.

