Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8944DC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 22:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59139613B0
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 22:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhGIWka (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 18:40:30 -0400
Received: from elephants.elehost.com ([216.66.27.132]:52678 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhGIWka (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 18:40:30 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 169Mbgtj016390
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 9 Jul 2021 18:37:42 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <003701d7741e$550b6510$ff222f30$@nexbridge.com> <xmqqk0m0brq1.fsf@gitster.g>
In-Reply-To: <xmqqk0m0brq1.fsf@gitster.g>
Subject: RE: [Question] worktree vs. gitdir in [includeIf]
Date:   Fri, 9 Jul 2021 18:37:36 -0400
Message-ID: <009d01d77513$07b638d0$1722aa70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQK3SQbvmkVoL9DL4YlGVMllr3mw1QEu7AHWqXIbUMA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 8, 2021 2:12 PM, Junio C Hamano wrote:
>To: Randall S. Becker <rsbecker@nexbridge.com>
>Cc: git@vger.kernel.org
>Subject: Re: [Question] worktree vs. gitdir in [includeIf]
>
>"Randall S. Becker" <rsbecker@nexbridge.com> writes:
>
>> I am wondering whether there is, or are plans for, something analogous
>> to [includeIf "worktree:path"] with a similar semantic to [includeIf
>> "gitdir:path"].
>
>I do not think there currently is an implementation, nor a plan, but I offhand do not see downsides in a feature to let you
conditionally
>enable some configuration based on the location of the worktree.

I'm scratching my head on this a bit. The [includeIf "onbranch:foo"] form is a bit confusing when dealing with a worktree. It looks
like the code either does not work if in a worktree or will get the branch of the main repo instead of the worktree ref. It looks
like include_by_branch() always returns 0 if in a worktree. Is there something being done in skip_prefix() or resolve_ref_unsafe()
that would deal with this?

Thanks,
Randall

