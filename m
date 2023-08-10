Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC24C001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 10:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjHJKDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 06:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjHJKCx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 06:02:53 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC58E46AE
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 03:00:56 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 724C423FA5;
        Thu, 10 Aug 2023 06:00:55 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qU2TP-0fC-00; Thu, 10 Aug 2023 12:00:55 +0200
Date:   Thu, 10 Aug 2023 12:00:55 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4] send-email: prompt-dependent exit codes
Message-ID: <ZNS1VyGgtk9JmMe0@ugly>
References: <xmqqmsz1a547.fsf@gitster.g>
 <20230809171531.2564739-1-oswald.buddenhagen@gmx.de>
 <xmqqo7jgm3hd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqo7jgm3hd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2023 at 12:15:42PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> From the perspective of a scripted caller, failure to send (some) mails
>> is an error even if it was interactively requested, so it should be
>> indicated by a non-zero exit code.
>
>I would agree that there should be a way to ask the command to
>indicate if some messages were not sent due to end-user request, but
>I have to say "From the perspective of a scripted caller" is a gross
>over generalization that I would not want to see in a commit log
>message of the project I run.
>
this gross error can be fixed by adding "likely" to the sentence.

>It should not be hard to make this opt-in,
>
that doesn't matter.

>and I still think it should be opt-in.
>
and i still think this would significantly reduce the value of the 
change.

the very idea of having to explicitly request that the obviously right 
thing is done is intuitively silly, and shouldn't be seriously 
entertained unless changing existing behavior can plausibly lead to 
serious adverse consequences. the minor nuisance of having to adjust 
wrappers to explicitly accept the most likely unexpected case does not 
qualify as such.

fwiw, other users who noticed this problem most probably preempted it by 
adding appropriate --confirm=* and --suppress-* options. but this 
doesn't fit my use case of a "light" wrapper.

regards
