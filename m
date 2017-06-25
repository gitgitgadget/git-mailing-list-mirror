Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0BCB2082E
	for <e@80x24.org>; Sun, 25 Jun 2017 14:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbdFYOGo (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 10:06:44 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35736 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbdFYOGn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 10:06:43 -0400
Received: by mail-wr0-f172.google.com with SMTP id k67so120428853wrc.2
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3B0HBEiAaY+q2cJ9IL+oCrJgc/4k7DUCz2419Q3gzo4=;
        b=I2GE9zI9HljwcTa/MNNossvTUpXdzskZkUl12XfDmo8uOGyGMmRrjvViVv8TASVOci
         hhlVAI7vlb9+cTB36MFsZlCkNnh+X1ba6x9VAXnpYqRP6i9pSm/owsuxdUCK/lKn1POu
         3C1YRuBNV7JUBozJdgb00BGbIr4I8J1cXfA3BEasRIH0ms5k/Xn+X9hi8TPLhc+cDZW2
         +9fctrHcoSsw2xsEJ1UrfJZFhODwhAx+aEF50/gbvlFVA+g23R3abHwpgudWsSOQAXvu
         umue6B6gTNPc931N+023hXKQhECwBNoOHBZu7jDSti9p7qPs6nCxcIom0rvGhGnFnUg6
         Q28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3B0HBEiAaY+q2cJ9IL+oCrJgc/4k7DUCz2419Q3gzo4=;
        b=R08HfkeB/tGDBcTAFbllw2An43ty5yiSyCIVOWWLsPRx8lrRMlgTM+H8Ps49AbjjT/
         cxsxAuv2NrzpoHmds5R91zPCj7kibExnhyV8oRRVMJWrw6JJxOT2x9cX0K43E61jXPW1
         uz4UfrnyIF8j5/exJ5JY2OcOI8gcU7m+4A2BNODIkc8hReYAxtodeq71FruzWsoQ3OLn
         LLispwTHLlQBfYqUvS0syrk6Rvh7jktJxpIDeHZeu49cFQek+CP5ASLh8T0tiaX1zixb
         VfYNY+SvfJWfMlq9TqWQz7FIsuZ60UNpkjbFb5ChfXj9z1TCVOTyErOxvYkxw4NAbbrl
         W2xg==
X-Gm-Message-State: AKS2vOyk0jxtJgtBSGwXtWL3bZ0WvkxEc3fmDmK55MtPkE98M8m1HKJh
        wXKbsR137GNqgVT3GAjzobf9HeSxgpmx
X-Received: by 10.80.129.4 with SMTP id 4mr5587903edc.120.1498399601500; Sun,
 25 Jun 2017 07:06:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.179.145 with HTTP; Sun, 25 Jun 2017 07:06:41 -0700 (PDT)
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Sun, 25 Jun 2017 17:06:41 +0300
Message-ID: <CAGHpTBLP9MiYr2ZoUOaGjGMC+aO_EKYO6SwNLfAu6QFSRnPatQ@mail.gmail.com>
Subject: Getting first tag per branch for a commit
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git describe --tags <commit> gives me the first tag that includes this commit.

git tag --contains <commit> shows all the tags that contain the commit.

git branch -a --contains <commit> shows the branches that include this commit.

What I'd like to have is a way to tell the first tag per branch (or
per merge) that the commit appeared on.

I'll use an example from the Git repository. Let's pick commit
32b8c581ec which was first introduced in v2.9.3.

git describe --tags will only show v2.9.3

git tag --contains shows the following list:
v2.10.0
v2.10.0-rc0
v2.10.0-rc1
v2.10.0-rc2
v2.10.1
v2.10.2
v2.10.3
v2.11.0
v2.11.0-rc0
v2.11.0-rc1
v2.11.0-rc2
v2.11.0-rc3
v2.11.1
v2.11.2
v2.12.0
v2.12.0-rc0
v2.12.0-rc1
v2.12.0-rc2
v2.12.1
v2.12.2
v2.12.3
v2.13.0
v2.13.0-rc0
v2.13.0-rc1
v2.13.0-rc2
v2.13.1
v2.13.2
v2.9.3
v2.9.4

What really interests me as a user is the "first in the series" tag
for each version. What I'd expect is:
v2.10.0-rc0
v2.9.3

and I can conclude that if it appeared in 2.9.3 then 2.9.4 also has
it, and if it's in 2.10.0-rc0 then all the following versions (2.10.x
and up) include it.

I think that this can be done by filtering out tags that are connected
to already listed tags by first-parent link.

Is there a way to achieve this kind of "simplified contained in" list?

Related: https://bugs.chromium.org/p/gerrit/issues/detail?id=4331

- Orgad
