Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30BCC001DB
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 12:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjHKMME (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 08:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjHKMME (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 08:12:04 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869BA125
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 05:11:59 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 79366241A6;
        Fri, 11 Aug 2023 08:11:57 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qUQzl-WDz-00; Fri, 11 Aug 2023 14:11:57 +0200
Date:   Fri, 11 Aug 2023 14:11:57 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4] send-email: prompt-dependent exit codes
Message-ID: <ZNYljcYTKHZ6hAyR@ugly>
References: <xmqqmsz1a547.fsf@gitster.g>
 <20230809171531.2564739-1-oswald.buddenhagen@gmx.de>
 <xmqqo7jgm3hd.fsf@gitster.g>
 <ZNS1VyGgtk9JmMe0@ugly>
 <xmqq5y5msmc0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq5y5msmc0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2023 at 12:56:31PM -0700, Junio C Hamano wrote:
>I have no problem with giving the command an option to allow it to
>report if one or more messages were held back via its exit status.
>
that doesn't give credit to the observation that there is an opportunity 
cost to not doing it automatically. it is much easier to imagine that a 
scripting user simply didn't consider the possibility of an interactive 
cancellation than that they really meant to ignore it. therefore, the 
status quo is very likely more harmful than the fallout of starting to 
more aggressively report the situation.

>Others may even want to know which ones among many messages weren't
>sent, not just "there were some that weren't sent", to make it
>easier to identify which ones to be resent after touching them up.
>
yeah, i've considered that as well.
i think that on the exit status side my solution is adequate - it 
reports in a sufficiently distinctive way that something didn't go quite 
as probably expected.

going further, i'm considering producing a mapping from sha1s to 
message-ids (which i'd persist for automatic chaining of re-rolls). this 
would provide the fine-grained reporting as a side effect.

regards
