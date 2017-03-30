Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED5C20966
	for <e@80x24.org>; Thu, 30 Mar 2017 22:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933215AbdC3WjI (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 18:39:08 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36474 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932701AbdC3WjG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 18:39:06 -0400
Received: by mail-io0-f179.google.com with SMTP id l7so29229684ioe.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=retailnext.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=jPrIqCEkHq3QKa/+nroKZdXmofhnvMqRgyc4Lmz40Xg=;
        b=CGZS7MOpb9TAqfQ76ytF1l+PUr2NI3LkszQO8c8uTDJG801SFgnzi4jJvXCqiqPQom
         PXqcHJ05Pn2nIYfeO8CAwf+C7tPJhPEvGwjFWT3TTzurTF6zGJKwcVnsK7ClddkHw2aW
         OpgWxjaNfaJk6CQE0whVBNcEweC6RKSAcIYDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jPrIqCEkHq3QKa/+nroKZdXmofhnvMqRgyc4Lmz40Xg=;
        b=IaBkrjV8gMMA6KGeRTezMPx5Xp2jstiibRRmooWWZdDASqgkkdsjyknK++xtX/HHVn
         7HD+WtUMQcLmsbWD80pCg58VRkiblQI1sRtQtBp/K6m4PeNyaa+G1Nv+nyhFamf40NWX
         28S+xX8uwa9wka+pmTAfSKsBmpRY1jrg8gIxRhB6k206Ran9mCfl3EzeaO5092oGB7Yf
         /miDu3myapo1ocwPkYZ8dBbAZdmb/7mcGtVBOviIC/t6o63uckQYYIGoaRDxjOF+CheU
         mTLFgY1LhZvTft2UDyGpSbM21KSkehbrZIBBDAgxuz1ikr0RPbgr6HgUK9/cC7cR/EDc
         lvEA==
X-Gm-Message-State: AFeK/H1xrrA1ov9lNabUqlC3OY+9hzpCLNCzFXxG8rYavGqtW5wvjLPBwOQtUxC44Rm52yA6L2PQs+2aaUEmUIbm
X-Received: by 10.107.27.207 with SMTP id b198mr3448443iob.218.1490913544894;
 Thu, 30 Mar 2017 15:39:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.230 with HTTP; Thu, 30 Mar 2017 15:39:04 -0700 (PDT)
From:   Nate Mueller <nate@retailnext.net>
Date:   Thu, 30 Mar 2017 15:39:04 -0700
Message-ID: <CAJF7t-dqSa7tmQqNEWmg_VZ=+832nsZ-3JmSGA03qK6aY5eNTQ@mail.gmail.com>
Subject: Issue with 2.11.0 and GIT_EXEC_PATH with multiple entries
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I ran into this after upgrading to 2.11.0 through Xcode.  I assumed it
was a packaging issue but it looks like it's been in the mainline
since 1073094f30 (on October 29).

In 2.11.0, git-sh-setup switched it's call of git-sh-i18n from:

. git-sh-i18n

to:

. "$(git --exec-path)/git-sh-i18n"

This fails for me because my GIT_EXEC_PATH is set to
"/Library/Developer/CommandLineTools/usr/libexec/git-core:/Users/nate/.git-exec".
If I remove the second entry git-sh-setup works just fine.

Am I doing something wrong here?  I can't see what but I'm surprised
that I'm the first person to hit this.



-- 
Nate Mueller - Head of Engineering - RetailNext - 406-356-6283
