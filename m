Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173D9C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 19:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbjHJTJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 15:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjHJTJs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 15:09:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7257A2713
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 12:09:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0DE661DAD0;
        Thu, 10 Aug 2023 15:09:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mx4DNvl5154baq/LTk9IUh8QwABigGp+rYSVDl
        NJMDw=; b=N6vlur5pvro3Goh/KVadJZariwaSrKDoGM3vRPB6gX8jYPZTR+ayJG
        s9q+SOeTZlfmI/0zRX0IiIRIx/f7Z+gM0R+nY5Z1uckuxremHkRndDHM72FuHsnT
        4VoDhU2z51EkouBzO+cYVveksosEWsUx9DhMo4TsbAj9pDr8pthN4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0654E1DACF;
        Thu, 10 Aug 2023 15:09:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD4B71DACE;
        Thu, 10 Aug 2023 15:09:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t9001: fix/unify indentation regarding pipes somewhat
References: <20230809171531.2564769-1-oswald.buddenhagen@gmx.de>
        <xmqq350sm21v.fsf@gitster.g> <ZNS7PJ0oyOQLeaZ7@ugly>
Date:   Thu, 10 Aug 2023 12:09:43 -0700
In-Reply-To: <ZNS7PJ0oyOQLeaZ7@ugly> (Oswald Buddenhagen's message of "Thu, 10
        Aug 2023 12:26:04 +0200")
Message-ID: <xmqqa5uysoi0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7769BB1C-37B1-11EE-83C3-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

>>but more like
>>
>>	A |
>>	B |
>>	C
>>
> i'd argue that this should be written as
>
> 	A |
> 		B |
> 		C
>
> like other continued lines (no trailing backslashes are needed here,
> but it would be ok to add them, and there is in fact a commit that
> does just that in other places, and one might do the same here in a
> followup).

You are entitled to your own opinion, and you are welcome to stick
to it in projects you run.  But please refrain from wasting time of
this project on something that is subjective preference and has no
absolute yardstick to tell which is _right_ or _wrong_.  Difference
between the above two falls into "once it is written in one way, it
is not worth the patch noise to turn it into the other way", and I
already told you which is the preferred way for new code.

As to trailing backslashes _after_ pipe, we have preference that is
a bit stronger than "once it is written, it is not worth fixing".
The shell knows, when you end a line with a vertical bar, you
haven't finished your pipeline, and we do want to omit such an
unnecessary backslash if we accidentally added one.  b8403129
(t/t0015-hash.sh: remove unnecessary '\' at line end, 2022-02-08)
is an example of such a style fix, and that is why I said the
preference is a bit stronger than "once it is written...".



