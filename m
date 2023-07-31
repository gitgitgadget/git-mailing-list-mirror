Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EB2C001DC
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 15:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjGaP4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 11:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjGaP4P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 11:56:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC441BB
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 08:56:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D29151A476D;
        Mon, 31 Jul 2023 11:56:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yUoSFlIpUbbs5FcJ9F2btcq4xhNWbBWN+nTCJG
        hobV0=; b=BZfMe+lumgjq7iNyvkF4yAzXBM0G/MiG5a8v+VAaEUCwG3vriUa09w
        Q1crqUnjpmcL4uWn4R31W0kPV0+F4obKWZoyNU/GKpRDON0/3d+5p61TsvNrD51g
        qGIWiTrH3atkTA8Yl3/7Rtq2NdzZ5+xzlE4OWaT9+q/Z9G/34BiRg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9F521A476C;
        Mon, 31 Jul 2023 11:56:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 284491A476B;
        Mon, 31 Jul 2023 11:56:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Thomas J. Faughnan Jr." <thomas@faughnan.net>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Daniel P." <danpltile@gmail.com>, <git@vger.kernel.org>
Subject: Re: Git is removing . from the last part of user.name
References: <CAL-s8C7makcRT_ufsv4THSrKeDkXfhFoAXSBKSiK5w0anMvZag@mail.gmail.com>
        <YSJuS1OoYsqgpF3j@camp.crustytoothpaste.net>
        <YSKleNynVrWWyyML@coredump.intra.peff.net>
        <CUFTY8BW9NHM.132KSE56BDE8Q@badwolf>
Date:   Mon, 31 Jul 2023 08:56:09 -0700
In-Reply-To: <CUFTY8BW9NHM.132KSE56BDE8Q@badwolf> (Thomas J. Faughnan, Jr.'s
        message of "Sun, 30 Jul 2023 17:38:13 -0400")
Message-ID: <xmqq351413dy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C47A650E-2FBA-11EE-AC3F-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Thomas J. Faughnan Jr." <thomas@faughnan.net> writes:

>> On a somewhat lesser note, I'm tempted to say that "." probably was
>> never that useful (compared to say, comma, which is the gecos
>> separator), and we could probably just drop it from the crud list.
>
> Would this change still be considered? Or alternatively a git config
> option to ignore "." when checking if a character is crud?

That is certainly a blast from the past ;-)

I actually was wondering the opposite should be done, i.e. be
consistent and remove '.'  just like '<' and '>' even from the
middle of names.  '.' in the human-readable name part anywhere on
To: and Cc: lines, not just at the end, causes mailers to barf,
unless such name is quoted.

And from the consistency point of view, I think that a configuration
variable that tells Git to include/exclude "." from the "crud()"
letter should make us drop/keep "." from anywhere in the name, not
just at the tail end.  If we decide that adding such a configuration
variable is a good idea, that is.


