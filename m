Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601591F404
	for <e@80x24.org>; Fri, 23 Feb 2018 04:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeBWEUv (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 23:20:51 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46832 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeBWEUv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 23:20:51 -0500
Received: by mail-qt0-f195.google.com with SMTP id m13so4401324qtg.13
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 20:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1BwDVSECVWQ1I5Daw9g73PG/sJSuLzrObrCTV5t4uG8=;
        b=bjB+ZxUwu8npRYsqMfot8LBoIU5kib3Rb6fbnI8B92repbsezJSf+lWMLsIIiWwJz5
         7f42elJQqTFoHCLHx89gLRHKmfJrQNl0QgSJRN7dIlqMD0k3ZJLd1ZQJZk0SDJnhZfDO
         lya4hYHPoHV3GOZm8VocxbHSIhNaiutznjdajzonnEQ08ZT0RjHW6gcRTAOnY1iyFaHg
         NQYS7/DP36O9LXLMx8XmTa/0KUv+TQ8r9ZOn44Bs9++cDuAtEFzBOU8yscj99CpLHmyh
         yDdzl0dAvfKqXwEHkoau7Ze6e24k+YCx8OfGVLXTdUMC+hf0h7YhlTTUiB7RPYhaSLli
         dGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1BwDVSECVWQ1I5Daw9g73PG/sJSuLzrObrCTV5t4uG8=;
        b=arMmcm0dd4ZwsC7/yQ1q890FK15K9mwrsdbVrl7GAiF3so5qlS5Lc9qKxbAs+ZFH1E
         5YsI/3zzISjxUYxh/SoO6VJtCseJF1JaOIRiIiCAqDbMmLocmlnyHwDhc35RL2dN0mec
         cZogd+HuHUAU0h24iaSkW/1Xmpl8y537aqH8NLx5NIQRLtU4FEoWyErIW+b/hG3FT7RG
         VHl0/NrlRU/vvpI3ltIIjavDBSAPQ2ZAsgyMLlv4bNVcIWnUiS0uGCzG1Xz5Qv1j0UfN
         mBjxVRFy4vNf9YrnhrZqxPJ7Dk4DGw9WI6bhIS6HcrVuwO/+9MyWuc4LwIsnL25jX1lh
         0/6Q==
X-Gm-Message-State: APf1xPAPwRuL4zveOBP1jwubkk4SZBeqnXmfX0Z+2NIyA/0waE03p1eV
        ntO8lZkTAXxgx+SCMpfJb1pt5y8aBcbN7Cn6N8zUlg==
X-Google-Smtp-Source: AG47ELsn7sDQ4rGNT+d1h3DXQZ80kBfp7trILEg29+hGqmXIahmjuMkjk5R+4u4vIbkuobrLCt76CTBV9geG/p6nJtQ=
X-Received: by 10.200.35.113 with SMTP id b46mr512102qtb.262.1519359650239;
 Thu, 22 Feb 2018 20:20:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.173.54 with HTTP; Thu, 22 Feb 2018 20:20:49 -0800 (PST)
From:   Duane Knesek <duane.knesek@gmail.com>
Date:   Thu, 22 Feb 2018 22:20:49 -0600
Message-ID: <CACzbczZNAxN94wfNhFX2=Xbob6sO1wUrY2M+ZNE4rDet_tapRQ@mail.gmail.com>
Subject: FUSE with git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Disclaimer:  I am not a git developer, nor have I ever written
anything FUSE. So I apologize if the following is idiotic:

I've been looking for a virtual file system (in Linux) that works with
git to make huge working directories fast.  I have found that
Microsoft has written GVFS in Windows for this purpose.  I read in a
forum a discussion where they said using a FUSE implementation was too
slow and that they had to write a full file system at the kernel level
to be fast enough.  Their web page also boasts that a checkout takes
30 seconds rather than 3 hours.  My question is why?

If a FUSE was implemented in a way where a git checkout would do
nothing more than copy the snapshot manifest file locally, wouldn't
that basically be instantaneous?  The file system could then fetch
files by the hashes within that manifest whenever one needed to be
read.  Files would only need to be stored locally if it they were
modified.  Since the file system would know exactly what files were
modified, then it seems that git status and commit would be fast as
well.

Perhaps MS implemented GVFS that way because building a big tree from
scratch would be slow if it had to go into user space over and over
again?  If so, then what if a build system like Bazel (from Google)
was used to always build everything incrementally? It too could be
modified (maybe via plugin) to interact with the file system to know
exactly what files changed without reading everything.  The file
system could also use Google's hashes and remote caching to provide
unmodified binary content just like it would use git's SHA1 to provide
unmodified source content from git.  So when a user did a checkout, it
would appear that all the binaries were committed along the source
code.  Bazel would build new binaries from the source that was
modified, and only those new binaries would be written locally. To
execute those binaries, most of them would be read from the cache
while new ones would be read locally.

Perhaps that runtime part is the issue?  Executing the resulting code
was too slow due to the slower file access?  I would think that hit
would not be too bad, and only be during init, but perhaps I'm wrong.


Microsoft is full of really smart guys.  So clearly I am missing
something.  What is it?


(Sorry if I'm wasting your time)
