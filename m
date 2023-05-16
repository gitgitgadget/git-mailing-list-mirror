Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EFCC77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjEPRdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjEPRdp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:33:45 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B979FC
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:33:43 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 34GHWQHG2476529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 17:32:26 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Taylor Blau'" <me@ttaylorr.com>
Cc:     <git@vger.kernel.org>, "'Elijah Newren'" <newren@gmail.com>
References: <009501d98817$9eb44560$dc1cd020$@nexbridge.com>     <ZGO4LesPe4A2ftdm@nand.local> <xmqqlehourbf.fsf@gitster.g> <xmqqh6scur3r.fsf_-_@gitster.g>
In-Reply-To: <xmqqh6scur3r.fsf_-_@gitster.g>
Subject: RE: [PATCH] run-command.c: need alloc.h for our own at-exit handler emulation
Date:   Tue, 16 May 2023 13:33:34 -0400
Organization: Nexbridge Inc.
Message-ID: <009a01d9881c$8dc57490$a9505db0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQISB4+gSnh328toY6kthhDPMMbUlAHsJJn1AcWymX0B18m2jK6/3MHQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, May 16, 2023 1:24 PM, Junio C Hamano wrote:
>Recent header file shuffling missed this old user of ALLOC_GROW() that was
inside
>"#ifdef NO_PTHREADS' section and forgot to include the new file, alloc.h,
that defines
>the macro.
>
>Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
>---
> run-command.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git c/run-command.c w/run-command.c index d4247d5fcc..1affea48af
100644
>--- c/run-command.c
>+++ w/run-command.c
>@@ -1073,6 +1073,7 @@ static void NORETURN async_exit(int code)  }
>
> #else
>+#include <alloc.h>
>
> static struct {
> 	void (**handlers)(void);

Thanks gents.

Regards,
Randall

