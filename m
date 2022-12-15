Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A5FC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 11:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLOLos convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 15 Dec 2022 06:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOLor (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 06:44:47 -0500
X-Greylist: delayed 345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Dec 2022 03:44:44 PST
Received: from mx3.uni-regensburg.de (mx3.uni-regensburg.de [194.94.157.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFC02C11C
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 03:44:44 -0800 (PST)
Received: from mx3.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 06A076000052
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 12:38:55 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx3.uni-regensburg.de (Postfix) with ESMTP id DFFC2600004D
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 12:38:53 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Thu, 15 Dec 2022 12:38:53 +0100
Message-Id: <639B074B020000A100050792@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.4.2 
Date:   Thu, 15 Dec 2022 12:38:51 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Strange "git stash pop" conflict (one chunk out of many)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

This is for a somewhat older git-2.26.2:
I had added interactively some changes  using edit of a few junks (I tried to structure my big hacking into logical junks when committing).
To test whether the partial commit would be consistent, I did a "git stash -k" before committing, and after committing I did a "git stash pop" to continue hacking.

Unfortunately I had a "Merge conflict". Looking at it, it is rather "interesting", however (meaning: I don't understand it).
Here is how the conflict looks (to me both variants seem identical):

        # pre-allocate translations and accesskeys
<<<<<<< Updated upstream
        foreach my $attr (LD_SEARCH_ATTR) {
            $attr{$attr} = [translate_attr($attr), undef];
            $attr{$attr}->[1] = add_access_key($aks, 0, $attr{$attr}->[0]);
        }
        foreach my $attr (LD_SEARCH_ATTR) {
=======
        foreach my $attr (LD_SEARCH_ATTR) {
            $attr{$attr} = [translate_attr($attr), undef];
            $attr{$attr}->[1] = add_access_key($aks, 0, $attr{$attr}->[0]);
        }
        foreach my $attr (LD_SEARCH_ATTR) {
>>>>>>> Stashed changes
            @n = (P_P_SRCH_ATTR . $attr, @{$attr{$attr}});

(the other conflict junks look reasonable)

Regards,
Ulrich




