Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44A0E2018D
	for <e@80x24.org>; Thu, 11 May 2017 14:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935799AbdEKOib (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 10:38:31 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35547 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932441AbdEKOi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 10:38:28 -0400
Received: by mail-it0-f48.google.com with SMTP id c15so44937672ith.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Efx2jOx6DN08Br0gkwyWA2whPvaJkLt3wcLYIYS6kxU=;
        b=PqmbV5/z4YAEAmrx3rUT8Lvv/Yw+WTxIF1qxDJn/5APKzKIj9xZXvUtbJ9noq6D9UB
         vQ/8zHGYZHPXF3QPZVeMpPUm04SZmjDM3osq8K0aCEllRui0O31MZ8lIJZzazCwX6No5
         oLCdQ6DOgCSiYQU/xeztNwVDzYkDhSkqdRmwuI8CMCfd9RSoXiXkVrQmkSNwuyWqaSYb
         u/wbxym5AYFdLOhPWbCoHbphAhCfMlCPJXYrvFszD6mYRw5HI+17v0MkzMIAuhd1OkJ3
         3MmX39feln0w3IWn9AGwa7bttLds3HP7GWh2I02S67be8VkWpXrLIJu0pgX6tJQU9VGp
         Q0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Efx2jOx6DN08Br0gkwyWA2whPvaJkLt3wcLYIYS6kxU=;
        b=eLlEV8PiIblXq7WkyyqysjWoBB9QseVEyzDFhq2YMqDjcbpRXVcNGLPMQG2UQBRwS6
         dxeJYaJVA6+bU3/IdkMFkgrmzRi8/Lpn4YG8DQJM36RfPor4PaFaLV+IBj6m7MED8TAg
         53rVEfsWqvbZnE/9Lk6wwwZcLGw8nys0caAY1PGqjcFnCsBXbjYJ3pEeBk0e+Xm6AUOt
         fhNn57PHpUZyMpZZXMotw2+fhG1TWeMy5MozgD1c28r2g64akXk+EGXzKj45Ntf+MupC
         SWQTFVAjpiJZnNpSLy/1QgtpciORyRpjJbfUTtCzTrTN7uBe7g1XflmxwJIRDJRZR7K1
         NPZA==
X-Gm-Message-State: AODbwcDNYUENlnRHtQqRX831ebko2gVgFli0mdsv+PGtuBfeDxZXJviE
        u6UM4BWZE9urdNJMELzaWQuYDZ7F3zPt0Zg=
X-Received: by 10.36.101.130 with SMTP id u124mr6611774itb.109.1494513497855;
 Thu, 11 May 2017 07:38:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.104.194 with HTTP; Thu, 11 May 2017 07:38:17 -0700 (PDT)
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Thu, 11 May 2017 16:38:17 +0200
Message-ID: <CAHGBnuOzWSCR9wr=TSGoJSnimZDx2Gr-eR3+LFXmpc9m0cv4qw@mail.gmail.com>
Subject: [BUG] fast-export --anonymize does not maintain fixup! commits
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just tried to created an anonymized repo to allow the list to
reproduce a bug in "rebase -i" I discovered in Git 2.13 for Linux
(Windows is not affected). However, in order to reproduce the bug it's
important to keep the "fixup!" prefixes as part of the commit
messages. Unfortunately, "fast-export --anonymize" does not maintain
these (or any other command prefixes in commit messages). Given that
the --anonymize option is explicitly designed to help reproducing
bugs, I consider this to be a bug in the --anonymize option itself.

-- 
Sebastian Schuberth
