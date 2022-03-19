Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CF3C433EF
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 12:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242924AbiCSMuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Mar 2022 08:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCSMuO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Mar 2022 08:50:14 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBA96E8E4
        for <git@vger.kernel.org>; Sat, 19 Mar 2022 05:48:53 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 77BC020391
        for <git@vger.kernel.org>; Sat, 19 Mar 2022 08:48:51 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1nVYVn-C1J-00
        for <git@vger.kernel.org>; Sat, 19 Mar 2022 13:48:51 +0100
Date:   Sat, 19 Mar 2022 13:48:51 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: using oldest date when squashing commits
Message-ID: <YjXRM5HiRizZ035p@ugly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

moin,

during interactive rebasing, i sometimes find it necessary to move a 
hunk from one commit to a later one in the branch. now, if that hunk 
cannot be re-ordered with the later commit due to conflicting with it, 
it becomes necessary to squash the later commit onto a temporary commit 
created from the extracted hunk, not the other way around (or using a 
stash). unfortunately, this causes the author date of the later commit 
to be reset, which can rather seriously falsify the date if the branch 
is long-lived.

i know how to manually work around that, but that's not exactly user 
friendly.

my first thought was to create an --oldest-date option (essentially 
complementary to --ignore-date).

but i wonder whether it even needs to be an option? why would anyone not 
want that behavior, unless they are explicitly resetting the date 
anyway?

thanks
