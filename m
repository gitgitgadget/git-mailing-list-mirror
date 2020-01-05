Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4786C00523
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 04:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F73215A4
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 04:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQzYrFLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgAEEEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 23:04:39 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:36582 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgAEEEj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 23:04:39 -0500
Received: by mail-lj1-f175.google.com with SMTP id r19so47589011ljg.3
        for <git@vger.kernel.org>; Sat, 04 Jan 2020 20:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yORlr1mFm5QheVxcIFtcsQ4Rowxk09hM0uB8IAVPIIQ=;
        b=iQzYrFLPf6VUcZMcLondf4tq/f68vtVf/1BreHUyJ9XnOO8NhG6vAMfdi8mmOxSJ3H
         oiO50+tCc4tPYJKnmY0ksBoBkr4rDem79gNgpsfmf/OheZP8PZuscFHh/njjNl59QeoO
         taacUvHsplrwnM7H8X5Qsa+J85cRXcO5OInV3vlYI5A8oWjQKY+lUNgaVFfF5HO94PoJ
         h4sQH68tzwhAdZknW7Z78LNiSw9EZA5U4tVIfK+TUbOzWQCyuh9OhfDH5SQ72NVpfyVn
         Ja7PUAG9HgTP7R4MGeQ8/0tO01KB4YYOf6dZTXzLoCO12ilwfusQrRoSYlIX+gD2Xeih
         znLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yORlr1mFm5QheVxcIFtcsQ4Rowxk09hM0uB8IAVPIIQ=;
        b=LC4Jhnbr4DsQXqfM9j4aHU8mnCY4QhBv51Sa3T6AbKInwDnqhf42Kq/owYUEJvqUt1
         OCkK6CmfOlBm5msaw4vYhQ4QudPEeGGEEXXNAAH06Yg9TKhnm7e/77bzzZRcG5Qkefga
         H9PCEhcdt5pl9HJKMzEo+lcQ6NF8qJvlyiUCGu+vVSJkcBzMJyS/26658k+uynEZl/5H
         d6RCs8vJTkPcjPL+1wrE3Zupv/nP6fMi6dq6QKKXaQFlT9BWROJL5J2JZhm1FwBQcykH
         lzODzCJ96LwWaEjFDVuXn+ITr2Q0EXKgZEynbjMr7cFSBfholRcqGWHDm9sKwSg5p3ue
         Ppnw==
X-Gm-Message-State: APjAAAU7QRX7YVrU5H0Zi9Wto0pNdbPEh7rrSN/wI54Jveyj7E5xsQz4
        wxyzvaOfP/enFhar/yQgI6ok57bc0HIyN9Gj7N7Yv631yF0=
X-Google-Smtp-Source: APXvYqwHyqDXFqJwNe18uYja+5056f7ku7FJsjuWI6EB5U6mluDwc4MOdlT5JCDMgQkyrPFa9gK6mV8TA68+41fioGo=
X-Received: by 2002:a2e:9008:: with SMTP id h8mr57827056ljg.217.1578197077190;
 Sat, 04 Jan 2020 20:04:37 -0800 (PST)
MIME-Version: 1.0
From:   Wes Hurd <13hurdw@gmail.com>
Date:   Sat, 4 Jan 2020 23:04:26 -0500
Message-ID: <CAOAGZwEfMQ6F8t3a+jVDNrPd6ZWFfiHDU9z1srSHp575DmqcVQ@mail.gmail.com>
Subject: push --follow-tags not pushing tags ?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm experiencing an issue where git push --follow-tags is not actually
adding a new tag to the remote, as it's expected
https://git-scm.com/docs/git-push#Documentation/git-push.txt---follow-tags

I did the following sequence:
committed to master (new commit)

git tag v1.0.1
git push --follow-tags origin

The commit pushed to remote but the tag is not pushed.
plain `git push --follow-tags` has the same behaviour.

Output of git tag :
v1.0.0
v1.0.1

git 2.24.1 Ubuntu 18.04

Am I missing something for this to work ?
https://stackoverflow.com/a/3745250/4364036 also indicates it should
work based on the sequence I followed.

Thanks,
