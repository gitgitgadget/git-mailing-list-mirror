Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFB6C433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 07:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EAB4206C3
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 07:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btyOEFyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgFCH4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgFCH4a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 03:56:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCCEC05BD43
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 00:56:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y13so1155565eju.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2020 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=UbI1DFxS2/SaYOcqI8jWz/yK28ApSlFefVB8N4ctSuU=;
        b=btyOEFyKj+RG15DjY08E7EilscC0vCeLqor5eaRiinRaCzqnCGXFV+4uX5YqynKCij
         grR23X+LorwtJsgbjFwgqMr52KUcqBH80vxJ/MZYXWV3ZxvX8pJ6DRoEAJYp+IHRhgAb
         s+jKBHwpjkptqLNGSYIMPfFgJ1z1ZR8tJ5c3ei5JlinkcClcsmPUROt1fuTTO5D3UlQf
         lq/0dSH77yY7Op4/c6jQ/PQX8UF10A377vJVR1Txk/KcUGor6m4XQCrSp1Qmt+CBHEm5
         BoZ9Ri7Jn3RetJqaJZqhlPznM/swS1hDyY9kkc5R9CU9FxgWe/I1hPEApJ0BvPQGL2Ak
         pc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UbI1DFxS2/SaYOcqI8jWz/yK28ApSlFefVB8N4ctSuU=;
        b=SPv8o/4b8s66SCWZjuphCU3qGiNbBWFLuqrT84SVLXxWWmIPc/PblWU3IjinjrDif6
         mFDhPUd5oT7uNNwqIwRKSpI6vcR/JmY89zYhMqNMAv8kApqLhvXtJj0UxxBDpHt6ifIt
         I9VespGMJHFF+g8sK/41MVh3ntuThq2C6g+Ya/obQAgOpzSx5HDh15YG0jPk1XxQjxc9
         ttT4AtmltS5sdOtrXcDFeQXF2+DPuajt9Bn8Ouw0jmnqUg0xXh9YYgp6yDs8EkidSnXv
         QmymSQp2mpRznOFVpu6JuoyyH0GKl+mUPQog9t2Pl2jEVk1DBJz+H3bLb0kFFh37cafK
         7huw==
X-Gm-Message-State: AOAM533RL1bJhYfzu4wMTpV8cGXA0oU6FoOEqcKUNwxYV3D680xe6BBJ
        azWTLKsts5QAyaIAg8XmKm0C9CA8fO0t2OKtbqrcn8n7
X-Google-Smtp-Source: ABdhPJynR5sSAoeBAkI/JGW2cYZnhLCJ/k5Gb7GZYqZfnt0p5IZqqZTOmRygzLygLWhs3u2FeqBx5poJ+/WiXv4nFXo=
X-Received: by 2002:a17:906:689:: with SMTP id u9mr2352870ejb.13.1591170988575;
 Wed, 03 Jun 2020 00:56:28 -0700 (PDT)
MIME-Version: 1.0
From:   Edua Vioz <eltipejoloco@gmail.com>
Date:   Wed, 3 Jun 2020 02:56:14 -0500
Message-ID: <CAGiZ90kHSZEjw2ApU4kyGqCCH0KJS2Fe1mbvkJy4W2YKXs_-=w@mail.gmail.com>
Subject: Questions about Git-Gui Makefile and GNU File Name and Text Functions
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all,

Sorry to bother you for something that might turn out to be trivial,
but I'm curious as to something I experienced when building git-gui
with its current master branch's Makefile via Git Bash on Windows.

Essentially, the DEST value appeared to have suddenly changed
mid-installation: It omitted the word "Program" from "Program Files"
and failed to eliminate "libexec" from the target directory it ended
up writing to (judging from the files installed by Git for Windows'
installer, I assume it should be trying to place the share folder and
its contents in the mingw64 folder). I've been poring over the
Makefile trying to figure out the problem, and I have a few questions
(aside from wishing to see some sort of public Regex-like sandbox tool
sometime in the future that would let people preview the outcomes of
File Name and Text Functions fed to them):

Would the outcome of $(dir C:/Program
Files/Git/mingw64/libexec/git-core) be "C:/Program
Files/Git/mingw64/libexec/" or "C:/ Files/Git/mingw64/libexec/"? If
the latter, is there no way for the $(dir) File Name function to be
told to respect white-spaces in files' directories? The way the Git
Gui Makefile is set up, it's already passing the git --exec-path as a
defined variable, so I'm guessing doing that's a no go. Is there a
text function that can actually detect white spaces and substitute
them in and out for ?\s for the sake of other functions that need
them, for example?

Additionally, would $(notdir C:/Program
Files/Git/mingw64/libexec/git-core) result in "Program git-core"?
Which would then cause an ifeq against "git-core" to fail? Should I
have been more panicked if the above code had actually let files be
installed to "C:Program
Files/Git/mingw64/libexec/git-core/share/git-gui/lib"?

I'm not really asking for a solution for myself: I'm pretty sure I can
just change the Makefile so that I can successfully build Git Gui. I'm
just curious if it's just been this long since a Windows user decided
to take "you just need the dependencies installed and then you can
make install" on the README.md at face value, did so, and then
realized "oh, wait, I can't just do that."

Anyway, cheers all. I hope you're well, and I look forward to maybe
hearing from you.

~ ElTipejoLoco
