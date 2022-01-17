Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A1C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 22:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbiAQWp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 17:45:27 -0500
Received: from smtp.zlima12.com ([107.172.191.159]:57482 "EHLO
        smtp.zlima12.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbiAQWp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 17:45:27 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 17:45:26 EST
Date:   Mon, 17 Jan 2022 17:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zlima12.com; s=dkim;
        t=1642459155; bh=2fU4opPFEtjutCeXnCZgNZjdJb6eRpi9VFmo2Qqwqos=;
        h=Date:From:To:Subject;
        b=Ar25ZmLCovHrlEw/RykC3z4z1SinFwhZzs0xpEfjl+T/AElgDo87SxOUHxnhyk8WE
         qFSokn/HOy08h3AQhloZacbn986BOcB1Sa95mcirfsBiWDi9hBGMVSzTnXo0MOivKr
         eDdlcL1t8kxZCwZIlc9/bjtb96qj+her2PM1UMQ/Pw3DJWaljMiyc15ayC2CV26e5E
         OxkNm+Ki4kOsJKEGPNlU8gGR5n5WxdUASAyNkaOXVm2ema436Lb8WUwM5z9cB0lWJI
         EP/B5+YGPyj8qxOV115bqoJMx3ziinPc3vwQ5oTRVhVNwDKLHAKxURtrSPFadtySJz
         iBGAsq2vW1KNg==
From:   "John A. Leuenhagen" <john@zlima12.com>
To:     git@vger.kernel.org
Subject: Behavior of core.sharedRepository on non-bare Repositories
Message-ID: <20220117223912.fwsydwpkwfbcdlcq@Zulu-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been trying to work with the core.sharedRepository option today.

Based on the wording in the man page, I was under the impression that
this would affect all files in any type of repository (bare or not), but
it seems as though this is not the case. It affects bare repositories as
one would expect, but it only affects the .git directory on non-bare
repositories. The working tree is not affected by the option at all.

I doubt that I'm the first person to encounter this issue, and I'm not
sure why this behavior would be desirable. If for some reason it is
discouraged to share a working tree between users in a group, I don't
believe this option should affect non-bare repositories at all; there
should be a warning about any dangers associated with this kind of
setup instead.

However, if we'd like to support this kind of thing, I believe that
simply applying the same permissions to files and directories in the
working tree would suit the language already used to describe the
feature. I could make a patch for this if people agree that it makes
sense.
