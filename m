Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F100E7735F
	for <git@archiver.kernel.org>; Sat, 30 Sep 2023 16:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjI3QfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Sep 2023 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjI3QfA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2023 12:35:00 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26442C6
        for <git@vger.kernel.org>; Sat, 30 Sep 2023 09:34:59 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d894b8b9b7cso2506655276.1
        for <git@vger.kernel.org>; Sat, 30 Sep 2023 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696091698; x=1696696498; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IEul2JNSzxKIOliLWZgWbuFsj5JoLIrgXYNv3PxTUTY=;
        b=ZylQWM82mjyL8w6QW2+ji3ipVC8BMLVfhONqOWvHzeeHg6SMOvOMprfsmfVGz8HWJG
         0OXLbEWkBXiSoSxqmsoV27+6uUocfNX0ISeWr05wighg32Com32f2bsgKUygz1dRKL7+
         GGJGjzpW+gbhZ1XN6NsN6DWD6omdP/Ug3WR1QnNbdmc8McZjbneJbbIrtgbUXPIVTNek
         vq6Bk1J8h/F+fnCO62P8cdpUMlxKHKl3Ded9k9cJ27t6DSyFgW4/LMeLOsimWPoIzDZr
         /tYjNhdX8uUB9qdycbQB9K9wbqPpmqffPep/9onHGVBLXP13cSQ8Ts726WFzhbHz1gg+
         FfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696091698; x=1696696498;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IEul2JNSzxKIOliLWZgWbuFsj5JoLIrgXYNv3PxTUTY=;
        b=YUoN0vyWSiI7hn/JidkI504NrFlbicRuNaw9mGPnlKG+v7S7exxUQ6Xe0qdz4ozsvf
         HkmdjbhdnhwOce9r+4ejiTAbrM+6nmzsl2/Zf1Nlb68lhyiB3zi2jJb0u48yykiEUD6p
         zttDGZsH6nZJGwPowSX3hXD/Dm9pWRFHBZ5qd76+m9XHdbeokAnf5COFI650BVpEt4Xc
         Xpv/sOZPed7yh3lB89DMppV1NpuXY7JRpgcz2j8aQIPxTMXT0SPTDJVC5BxTIbqLAMOM
         XOoGRu6sdUTTKXzLtXdBTwI/9L5a9qg+7Q2Hc/OCXmqnUVy9vbrKEgnyTP5zzWwYwoQX
         h4ag==
X-Gm-Message-State: AOJu0YzXehf+I8fRAC4A0qwg/36c0SEty0M7zyBW4PJgR2+ReHkyG3mz
        aHBSw3NpaOSPDFRrtxTwx2cU+rxlsxAqvzMVaxNVlhFlhl4=
X-Google-Smtp-Source: AGHT+IEvmsIBTZnYndHTLh7cQM9Whop2s2JmISfsdV8g1XpHKPOimf+pOOFcxs6Id76wsuYp0Hxt9byjKL3NBOZkshU=
X-Received: by 2002:a25:c094:0:b0:d89:f18c:94e with SMTP id
 c142-20020a25c094000000b00d89f18c094emr8628343ybf.18.1696091698152; Sat, 30
 Sep 2023 09:34:58 -0700 (PDT)
MIME-Version: 1.0
From:   Jesse Hopkins <jesse.hops@gmail.com>
Date:   Sat, 30 Sep 2023 10:34:41 -0600
Message-ID: <CAL3By--HowOL1ffKBPfmwnfUdJd4KXcnkpS2BgkbO=9E2WnHKw@mail.gmail.com>
Subject: Possible to update-ref remote repository?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello -

Wondering if it's possible to do the equivalent of the update-ref
command remotely.  Or I guess another way of putting it would be to
git-push to a remote repository without needing a local clone of the
repo.

Trying do something like:

git push <remote-repo-url>  <sha1>:refs/heads/mybranchtoupdate

where I know that <sha1> already exists on the remote.  I'd like to
avoid the need to clone a local copy of the repo.  Wondering if there
might be some plumbing command(s) that could accomplish this?

Regards,
Jesse

P.S. I think think a minimal way to do this using git push would be:

git init
git remote add origin <remote-repo-url>
git fetch origin <sha1>:refs/heads/mybranchtoupdate
git push origin refs/heads/mybranchtoupdate:refs/heads/mybranchtoupdate

Seems that if it's known that <sha1> already exists on the remote, the
fetch is unnecessary network overhead?
