Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C27C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 18:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJMSyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 14:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiJMSxX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 14:53:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF0E18C418
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 11:51:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 818111BBE18;
        Thu, 13 Oct 2022 14:50:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NPr5eFk5c1Bp
        x14kRuCH5AKhe5vQfSXMGoxIvmcPH38=; b=deHTNTDYchHCPpm6jI9CZWUaFxEw
        ZxiEhRny6yzjHAwgG35033yUPLzgfhUt6GFRDUqi7EpRyHG9jdynMl/yNfqWv+gP
        fQ9z99URUwZO6rqYeMz3M3dHLFGVwZT2nnXF1JHiZEUeee/ne8tzAe2dmzkpuvYS
        LEKbLxxrTok+KO8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A7E51BBE16;
        Thu, 13 Oct 2022 14:50:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AB5C71BBE15;
        Thu, 13 Oct 2022 14:50:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ignacio Taranto <ignacio.taranto@eclypsium.com>,
        git@vger.kernel.org
Subject: Re: About git reporting missing newline for symlinks
References: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
        <xmqq7d14k9uh.fsf@gitster.g>
        <221013.86o7uflvcv.gmgdl@evledraar.gmail.com>
        <xmqq35briuel.fsf@gitster.g>
        <221013.86k053lkvu.gmgdl@evledraar.gmail.com>
Date:   Thu, 13 Oct 2022 11:50:06 -0700
In-Reply-To: <221013.86k053lkvu.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 13 Oct 2022 18:57:44 +0200")
Message-ID: <xmqqtu47fti9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DB862152-4B27-11ED-BFCA-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> 	\ The filename pointed to by the symlink does not end in a newline
>>
>> While I do not think it would break anybody, I doubt it would give
>> us much value.  One line above that output is a line that any user,
>> who is vaguely familiar with the contents being compared, can
>> recognize as giving a pathname, the contents of the symbolic link.
>
> Clearly it confused the initial reporter upthread :)

But to such a user, I highly suspect that the rephased message above
still looks like a warning, and will result in the same reaction.

IOW, you want to explain why "does not end in a newline" is worth
expressing in the output.  Saying "does not end in a newline" alone
would tell the user what they already know (i.e. the symlink stores
the target filename without an extra LF at the end).

