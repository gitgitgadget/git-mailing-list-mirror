Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87239C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 15:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJTPig (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 11:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJTPie (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 11:38:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9EF1B7F36
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 08:38:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C3E7151843;
        Thu, 20 Oct 2022 11:38:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WWO1AMjR6iKQuzLYylurpLElMvNdOfo0cvcN4D
        Fbkwg=; b=WUirOemzbnux3M5B0AygoyksLLQPHoWNS85wfCspImrbrFgUoksPzO
        VzU0VUZY5RZRmWT2bh13ObNhea7KPss2xdvH9stQsoVAdjr1JoaShw8sRWu82FQR
        y9D37a8ipZipJGvQQ+Va1C9dwuM2PIc+lDFrTQMTijSO+z1PCy43A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9430F151842;
        Thu, 20 Oct 2022 11:38:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05EFC151841;
        Thu, 20 Oct 2022 11:38:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2022, #06; Wed, 19)
References: <xmqqa65rnuvv.fsf@gitster.g>
        <Y1DoHb1vRYpIyPzK@coredump.intra.peff.net>
Date:   Thu, 20 Oct 2022 08:38:32 -0700
In-Reply-To: <Y1DoHb1vRYpIyPzK@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 20 Oct 2022 02:18:05 -0400")
Message-ID: <xmqqmt9qmrnr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 410E0002-508D-11ED-8270-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Oct 19, 2022 at 06:31:16PM -0700, Junio C Hamano wrote:
>
>> * jk/use-o0-in-leak-sanitizer (2022-10-19) 1 commit
>>   (merged to 'next' on 2022-10-19 at 27c2546b98)
>>  + Makefile: force -O0 when compiling with SANITIZE=leak
>> 
>>  Avoid false-positive from LSan whose assumption may be broken with
>>  higher optimization levels.
>> 
>>  Will merge to 'master'.
>>  source: <Y08JZVDgJpJvrBiz@coredump.intra.peff.net>
>
> BTW, you should be able to see that "next" now passes the leaks CI job
> (because of this patch), but master doesn't yet.

Yup, thanks!

Unfortunately, without some CI/make updates, we cannot verify that
macOS builds are green again without Apple Crypto X-<.
