Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFC1C433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 03:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B4C207A5
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 03:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbhAADwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 22:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbhAADwK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 22:52:10 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AAAC061573
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 19:51:30 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id j20so19406771otq.5
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 19:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=kkba1g8btPDSOkokf13I6J/gW6WCf/z9GoiR4xCYaIQ=;
        b=Q+Uu8UsuMdWpjZZc9wqmkblpRFLfGprnh25veccehlJgBkI5u4U3dRKmYGbzz3kCww
         bTSYwSE/3jwkWpjgm4XebJ/Q71DtW5XNtxllGFsKCqBy8MA3uvnQck3pUmQ3PsOI6JzK
         /ecaKcd0Blu9OJk52K4EBt8YNX/Zuw9fLLtTGZvN+caz81tdpx4AY8McauRwUXL9VRHn
         g5bBS6VteH7ySr6EfvC8V9/kChz5DQendaBS8+veiNcdtwe/DqSoOreMn8fhcOGxDYnP
         ZXxxNQGn6bd9VdGpMKZ2YWkv/vkCa9LA6iqgoBGhA9lHca5e4M/9/4P8aOR2N48Us+op
         2DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=kkba1g8btPDSOkokf13I6J/gW6WCf/z9GoiR4xCYaIQ=;
        b=FhC6Btmgr7r4eRARJLJjGk7ZiZ7UzgATOdpgq1gkZOKwG7wbO5V7ZmGHcR7lB1JkFK
         upye06L9fODaZD0mubxkJ51Z4PHFzI9BIaF6loNIjXC3b1efnULH4EX0ZT+dxIe1mF++
         /pa08sFJ/vluW1r9ch2gXkgsDQGWXuWZAhUp5OOpYkJLS3piE3a7vGpM+uD1b6oXOrQ2
         seI6lY/1QHEZn5sSquJCErbmxE3EDLALeIB35nWglsBfvZXXL4w4BOxyTPmYcYyw6nUk
         pZ2w30M8pMw5dMWwDVxvKbFR8pqJijtYDYkxbydapFqrn5h9qD56HS71p/nRV6IuvJmQ
         v3Kw==
X-Gm-Message-State: AOAM530DY5en1/ghqZFVuatghmyzEZn/jz8XHRET7s1tCLIyEpG8SErr
        +JTtM6GHAtjzUFY+/9paSMtlyN19momdwQ==
X-Google-Smtp-Source: ABdhPJxgxv6lQeUtCtpwKSldLzsypx2oQxhZjZfLPyY/YDgt4G0v/gBFZHHPvAZzyd8CjKCP5lg4rQ==
X-Received: by 2002:a9d:5d02:: with SMTP id b2mr43415766oti.148.1609473089481;
        Thu, 31 Dec 2020 19:51:29 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t19sm12502363otp.36.2020.12.31.19.51.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 19:51:28 -0800 (PST)
Date:   Thu, 31 Dec 2020 21:51:27 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Message-ID: <5fee9c3f91cb5_988208fb@natae.notmuch>
Subject: [ANN] git-send-series 1.0
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have a bunch of patch series flying around, and it gets tedious to
keep track of the state of each one of them. That's why I created
`git send-series`; a tool to keep track of multiple patch series.

The idea is simple; a patch series contains certain metadata (version,
cc list, subject, body) that should be easy to edit, and other metadata
such as the previous version's range (branch@{u}..branch), can be be
automatically tracked.

`git send-series` does all that for you.

The format of the metadata file is straightforward:

------------
version: 2
cc:
  - Felipe Contreras <felipe.contreras@gmail.com>
  - Don Draper <don@draper.me>
  - William G. Connolly <william@connolly.me>

README: bunch of fixes

There was a bunch of typos and grammatical errors.

I've separated the fixes in multiple patches.
------------

The first part is a YAML document with all optional fields, such as 'version',
'cc', 'to'. The second part--delimited by a blank line--is the cover
letter. The first like will be used as the subject of the cover letter
email, and the rest as the content of the email.

Then standard tools will be used to send the emails: `git format-patch` and
`git send-email`, which you must have configured before using this helper.

In the end, a custom ref will be created to save the current state of the
branch. For example, if you want to see what was the status of your series of
the branch 'feature-a' in version 2, you can use 'sent/feature-a/v2', for
example to create an interdiff to see what changed between one version and the
other.

By default `git send-email` will attach a range-diff to the cover-letter
using the previous version of the series.

The last version (0.1) was a very crude attempt (although it did work),
now it's a much more mature tool I've been constantly testing and
improving over the past few months.

Changes since the last version:

 * Add range-diff with the last range sent
 * Add safety to make sure the same version isn't sent twice
 * Add --dry-run option
 * Add --show option (to show the cover-letter before sending)
 * Add --range-diff option (to show the range-diff that will be sent)
 * Add --delete option (to remove all the branch metadata)
 * Add safety that the upstream tracking branch is configured
 * Add manpage documentation
 * Add vim syntax
 * Improve installation (make install works now)
 * Allow arrays in the YAML header (cleaner Cc list)
 * Check exit status of the editor (e.g. :cq in vim)
 * Chomp the last newlines of the body
 * Clean the patches directory properly
 * Fix in the check for the current branch

A screenshot of how it looks on the wild (with the vim syntax) [1]:

Enjoy and Happy New Year!

https://github.com/felipec/git-send-series

[1] https://snipboard.io/ExfbWo.jpg

-- 
Felipe Contreras
