Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F41C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C170C21531
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVG4/RHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504148AbgJUSd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439123AbgJUSd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 14:33:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1294C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 11:33:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id bc23so952921edb.5
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fknKL3upUR02ZoVxV+UvFHZtHqYkfamqEZxCdRkJNF0=;
        b=BVG4/RHDuhB3gpc95AZfxiYhtsHO1h71ewXejogeiec/vu9feKGRtN8Y1JUv286ODR
         JHXhSNiSOwb5q6ygV8qTYVYarBbdJwgeP9HwznZVu71yzoV609KTf2PkVtmi2w5kF9lE
         KxSK9e1E0CODBiPd8qnYhFo+wQUh5ircUETs3m+D9U4Yc+X69KgbmMMJsd0EbXEarkmK
         8JyLvewN+XqJIyOEr1vapU7WAnQUUiOgsaMc1CtZXJst7KH1zMRPj1L0Xh10AnSzbS/E
         yacrW8MPaSX1LVZo5FBwrgLTtvfh6f4Vx6zsCLkiIn3mBJKLJH2ZmYpZ/jJKyWKUY9vV
         3N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fknKL3upUR02ZoVxV+UvFHZtHqYkfamqEZxCdRkJNF0=;
        b=iGbLRpvyoJT7s3We5Rf+JkhN+urSVK/cSfcgqdQS2RnJ3xsCgJVdMdB0vLSQ+rCw6O
         zQibq7gUP6GYfV4u8UWB5kIP5lkco2VIdS2F1dhT7iwA6Qk7BYE2/VHQz1/U7HrE1RIC
         tDoKkCmRpXioXIXJ/0I/CqLgBMEONGGtK4Mm5BkRKyNNfD27eHEods5rA6lt/5Ew5+DO
         FZp7U6k3T+qHkX+4aDTn0nSIqHHaZF1DWw8BLll7g5cuK+UB0ewrD0MHf4n/NWAfljMa
         inROV26ixHLz+rHRpYZf1Q+e7L0hauaUHEiwioHRU5kMs/2Y3PjYRgLpub0rtTTYKzUu
         vqyA==
X-Gm-Message-State: AOAM531aRBnuHaQDlojHxa568Nr41Ga/9eaClc5klV0YlMlGQgaj6mx0
        6k9GNRGHd4/4zxZJHxhIpcFxF3ESkcg7Kjc0ndah3JI4U9xrUg==
X-Google-Smtp-Source: ABdhPJyvQeia7MzzNHVq6HkoNrwcWBQyidVzyME+s4lkfQStWDMrEVbKbeacMeaCzemIB0PULfJDucIziHds2+Aj4/c=
X-Received: by 2002:a50:c40c:: with SMTP id v12mr4080970edf.233.1603305234013;
 Wed, 21 Oct 2020 11:33:54 -0700 (PDT)
MIME-Version: 1.0
From:   Flurin Feuerstein <flufeu@gmail.com>
Date:   Wed, 21 Oct 2020 20:33:41 +0200
Message-ID: <CADVShLvZ9Nwbix97g6OXGu6XwXxzbxNAa=VcpXqOzqTJoQp2+Q@mail.gmail.com>
Subject: [Bug] git svn reports an error when a temp file is too large
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git svn reports an error when a temp file is too large

The issue happens when (for an unknown reason) a temp file is
generated that is too large.
The exception is thrown in Git.pm on line 1344 in the function
File::Temp::tempfile().
The method breaks when a string with more than about 260 characters is inserted.
This is a limitation of the Perl File::Temp::tempfile() function
itself (tested on both linux and windows computers).

I have managed to work around the issue by changing the way the method
is invoked.
I have forked the git repository on github and made a quick fix there:
https://github.com/fxredeemer/git

Since I am completely inexperienced in Perl I am not sure whether this
fix represents clean code.

There is also another workaround in that repository for a follow up
issue (not part of this bug report).

Unfortunately I am unable to provide the repository since it is
company internal and not open source.

Used version: 2.28
Used OS: Win 10 2004 (also happening on Ubuntu 18.04)

Regards
Flurin
