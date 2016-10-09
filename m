Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5CBA1F4F8
	for <e@80x24.org>; Sun,  9 Oct 2016 00:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbcJIAaj (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 20:30:39 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:34688 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbcJIAai (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 20:30:38 -0400
Received: by mail-qt0-f175.google.com with SMTP id q7so35706118qtq.1
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 17:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gforgegroup-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Su4iqHFRlzQtPSAIkwBK9gCLFCBE6ZUBkUmtMiX6OLw=;
        b=oqMcCJa8MBkyZu7Md81tHqPaW0Qv63hzDGehm+quGGIyP+E5GLCwL/pE3reZREV4mv
         DDwgonVFESsbwOE1Sut3EF+0KUsRnMIGD9ubKWiJZ5WvVjaOGommqu1TSao3qkhf7GAh
         BsNWzZYqvavDhq7uKALksi/b4Rc1ABiXo0KbouHELCI7sXFJntNFzDycD1v3x82j4X6U
         we/4epyb0mMzGfuWeB6WD3R6v/2zwEyhtOCFJhHrLpldYNSXij9vkHdQYcZpy/QM5OOe
         Y7H0o9WQvB/c8iCbxa/15/ikKx/BYixRepzwFJ5nAwKgK+wJqDn/EJZ7lVaGIqx/VP6w
         mEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Su4iqHFRlzQtPSAIkwBK9gCLFCBE6ZUBkUmtMiX6OLw=;
        b=J6KQt7qNzulGI8hqfl+enDakzn+3O9zn7Kzg34oVxt3W4YwFBlqCidf767/dp8kN9s
         k0GQwDPOEfrGDnLnQ02TdT3SnO8S6Y/4gBqdcRmSvfMziuL0XSYtQsZhpmqQqZK2DZ9J
         EKNQ8dHy5xIoTiWcmRSiJu1qeRyAy1NSqJlB+efcl2z1zlUJPhqtQLBrl9YY8jSNZMop
         Ws9HevZSGfba/IrSwi0U0BwVhX1uqKFJCwlcL36brEK0ekKhGbjRbFomDjEI4nVYVNf/
         uPjjdypMEBDb2Shjl+p9Z8YcJTJbp/yh0dPcV1Fx3z+O+gFtrbiZ4W1hcWg0vdTOlqnr
         rGUg==
X-Gm-Message-State: AA6/9Rm3At322whNYplvZ2EStJu+qLnLyL3hyiLtC5NLn5F1HQzzkl2wKPX9wvN1xz+e/qy63IJuS3xtxr1q05gs
X-Received: by 10.237.34.212 with SMTP id q20mr26677183qtc.14.1475973037200;
 Sat, 08 Oct 2016 17:30:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.164.69 with HTTP; Sat, 8 Oct 2016 17:30:36 -0700 (PDT)
From:   Michael Tutty <mtutty@gforgegroup.com>
Date:   Sat, 8 Oct 2016 19:30:36 -0500
Message-ID: <CAOi_75+2SG2WYHBMQhfGj96eKsZ66niJzOevVGM5eJv-qqrVNg@mail.gmail.com>
Subject: Bug? git worktree fails with master on bare repo
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all,
I'm working on some server-side software to do a merge. By using git
worktree it's possible to check out a given branch for a bare repo and
merge another branch into it. It's very fast, even with large
repositories.

The only exception seems to be merging to master. When I do git
worktree add /tmp/path/to/worktree master I get an error:

[fatal: 'master' is already checked out at '/path/to/bare/repo']

But this is clearly not true, git worktree list gives:

[/path/to/bare/repo (bare)]

...and of course, there is no work tree at that path, just the bare
repo files you'd expect.
