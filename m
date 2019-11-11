Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DB7F1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 15:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKKP22 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 10:28:28 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43959 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKP22 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 10:28:28 -0500
Received: by mail-wr1-f46.google.com with SMTP id n1so15057117wra.10
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucar-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=3erC98Q1xg9IfuVUiiRw+FMEMxGzf/Nc1MhD+WecNDQ=;
        b=XinJhHGDHhmV26Oh0YvYYVZvBdlx92CygiooDOs67/QlJi/j9ZU4r5vcGdhrGLbMM1
         n13WcybCJNljrHX1kbI6EuNuFFLU7iRNzwGSKljeyDgvPFgeHKrFZmpQ+7kdtRrbzjAG
         6zTs1H7TRYzr3ZPN1sVlHuzQUIVCKaT1XlyJGCY2CGFwGYXtk8ie/YZPnAAvX6tr3pIi
         O1n81zRyl1bvyFaGMewDE1ADSvtVrbjg9p4kim4FaVPhfFKv8BWOfiCfzLLZ3dINItuf
         ALn1JGTMyTJIDCsX1s0/OIstFizdRNGrFZLNY6TtCOb/68VHtht32nEZEOzlR3JUhcRR
         nozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3erC98Q1xg9IfuVUiiRw+FMEMxGzf/Nc1MhD+WecNDQ=;
        b=RpbONzfOHh3x3HaKDBEtcIKo4Fqv+T/0kmZmQp764KtC3AFxk9GSDvXgD7f6LfnYVZ
         txcTP5Jo0kipoMsEp5HtCVV+C0vFcMlqEOJD5SP1sbaH22NrNbX4CKmGsNa7+I/uuJzo
         Pj7m3x0m/X6ZUQiocL50NnTHC2UZVvLiFMDSAXUAgxrk76F2T0tjCO31FNMK9sA7cTZi
         /VjHyGvIUxQISGfUXV88viOM0jM4yZsGpqEzDQkp/YU6NIfXaJiJYtV5HuSoP110g3SN
         Ex3pc1bcFo3a3bMNhk5mmpdo9JL0yzdyc8FCs8JRO7ljlm/rFgpcThvzgHCd/e5UONAo
         WHoA==
X-Gm-Message-State: APjAAAWpaFRHgHx64bS1kPuXQSiagXX5K/j1HIqIgNidwmUIIdyPHNL4
        bEyZa9NcfFEL88cglR7ZXXZQ3zx0fm3VXw5mZZPA5Nu7FfM=
X-Google-Smtp-Source: APXvYqy2aQT1rH0TdbUYY8bqDYXEjpaGFcwdLuoSBSg9xSqtIo8zjNbpXdYZ/dcDhQoOXbGoNtLc/uyxudYMo+BiNsU=
X-Received: by 2002:adf:e387:: with SMTP id e7mr15611640wrm.180.1573486105660;
 Mon, 11 Nov 2019 07:28:25 -0800 (PST)
MIME-Version: 1.0
From:   Jim Edwards <jedwards@ucar.edu>
Date:   Mon, 11 Nov 2019 08:28:15 -0700
Message-ID: <CAPuR+ZhwnHCp8j76PscuBqG2rCLkgG0+6Y3WwLgNRhaoj4OR9A@mail.gmail.com>
Subject: tying files to git repository
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am a developer of scientific software, as science software we expect
and encourage users to modify source code in order to customize their
experiments.   The mechanism which has been developed to do this
predates having source code in git and we are trying to figure out a
way to minimize changes to the scientists workflow, while leveraging
the power of git to improve the process.  In the workflow the
scientist creates a 'case' using script in the repository to create a
directory structure from which they will conduct their experiment.
Part of that directory structure is a SourceMods directory where the
user can drop modified source files that will be compiled in place of
a file of the same name in the source tree.  These files are sometimes
long lived and passed from case to case and even user to user and it
is not hard to have the files get out of sync with the source tree.
We have discussed at length removing the SourceMods capability and
requiring scientists to create branches in git, but there is a lot of
resistance to this in the community.   What I would like to explore is
allowing scientists to keep the method that they are used to but at
the same time tying these modified files to their history in git.   Is
there a way to get the git metadata associated with an individual file
so that we can treat that file as if it were in the repo?

-- 
Jim Edwards

CESM Software Engineer
National Center for Atmospheric Research
Boulder, CO
