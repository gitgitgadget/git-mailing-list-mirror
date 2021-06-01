Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A28CC4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B8D6139A
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhFAOPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 10:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhFAOPM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 10:15:12 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9458C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 07:13:29 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id i29so7795694vsr.11
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 07:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jordi-vilar-cat.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OuBZQLLDao9hskC7sMNmwKKRNYg9najY0Ln7EiNoxb0=;
        b=R6xCfQ/vU5EiK0ki1BugJPi9rs8FNE5cgfGCm8Z/B5FbwpFXs0hgvFbfXmoJg2yUTn
         Q0NRaWxUAZ/1tjObzN07UVW9n5aHZFV/gOqFmXleEqgCCFtyfk98oCugMB6fzXTXqilG
         IAj7Ox2EgwvWvDvlFjHEcVih2mHRY8nkG3PCZHqq7I5jrJSB9CP8fkEU7PREA9DH4Yr6
         SX0dGXJqRnI3gHKN4xCdp3tLf1q+SvBMh6ZGE23ONWOs1rI145PVrPm4df3IFWr+0xcn
         4aFFyp1iR+4+Rc6Bp/3CRyZhHpmA3gj00gQ4AjjHvAjktNFT19NKFTFNZwBOPIh+FDgj
         FLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OuBZQLLDao9hskC7sMNmwKKRNYg9najY0Ln7EiNoxb0=;
        b=BxtO1ZUmz1ZtfWq1tZ+OQNR76gam9rzvnKW/RFffl5R1/S3rXvtkW1mut74I6puXie
         Gi6YnI0mV5ftxP/hu4rZMomyvRBi6Hv6MlaEZxJeBXR4L8c8aiMBEziYXo9N1OteTQ46
         OTZlkBWqkYsXb1u42pqnQH5vrc9oXiTJfZJy6HLx18jAZZ6yViiydD5bNRNvjJPPzkXH
         VCWEzsjR/bYl3yGz5RG2yVQeYVsb79z/cuQzr3wcvfqdse/V8Z/8oVT9mqBAbmQYTCc+
         vRq8WUgeS99sRW7qBb/SgHh8lxbbNeD1WMu92YUyC/gd1C71id0qZ0lK1X/ud8+PxT7q
         NG+g==
X-Gm-Message-State: AOAM531gJdKJkjBlb73wvPNAgp2ru99NbQe7YmFJRY1W/Xi2K5GwjLMV
        p/Y46tKff8nMwlnrhxwi/N0YuB77UVBhSgjXiyVpDqspNtAxBA==
X-Google-Smtp-Source: ABdhPJynl+2cllA31Dij5RrngJrzpHLshV8saRR/oNM/6hJSDjzUWWEJRj2w0BjBaebds6Z7u62CWRYKq5UkcLY4NlM=
X-Received: by 2002:a67:fbc5:: with SMTP id o5mr11110847vsr.28.1622556808796;
 Tue, 01 Jun 2021 07:13:28 -0700 (PDT)
MIME-Version: 1.0
References: CAE-zgtbm=pv=qfErdMeSckQD6Fqe=FdwfHko9G5iCgo7pPQyXQ@mail.gmail.com <20210601113554.52585C06174A@lindbergh.monkeyblade.net>
In-Reply-To: <20210601113554.52585C06174A@lindbergh.monkeyblade.net>
From:   Jordi Vilar <git.kernel.org@jordi.vilar.cat>
Date:   Tue, 1 Jun 2021 16:13:18 +0200
Message-ID: <CAE-zgtYTutLZWO63QtqZJztMPqi9eHYQfFu6sda8YDf_bVeE3Q@mail.gmail.com>
Subject: proposal for additional search path in config
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I would like to gather feedback about a feature I'm considering about.
Basically, I would like to propose a configuration setting with a path
(possibly relative to the working tree) to look for executables. In
that way, a local clone could setup additional tools/scripts private
for its work tree, maybe also under revision control.

For instance, we could have a setting like:
  git config core.extensions_path "./scripts"
so that whenever git has to resolve an external command also includes
that path in the search, resolving relative paths to the work tree, in
this case, the "/scripts" subdir.

A simple use case could be a custom tool integrated with git, but
local to the repository and thus versioned.

For instance, let's assume that we have some metadata required by a
custom build tool that is stored in commit comments or tags, so we
have a custom script git-project-metadata to handle it:
  git project-metadata query ...

Maybe the format for the metadata evolves, so the script must evolve
also. Having it integrated in this way would allow that each checkout
sees the correct script version, and that script is always invoked as
a regular git command, without having to tweak the environment
everytime.

It is not clear to me whether it's a good idea for this additional
path to have priority over the default search path, as in one hand it
could allow to override the default tools, but in the other hand this
may be a hole for bad things... For my, the conservative approach of
having this additional path as a fallback is ok, so that it only adds
more commands, but doesn't override commands.

Also, this setting could be set either globally or locally, and in
this case, in the conservative approach, the overloading rule is the
different to the normal one: the system search path in the environment
path variable has precedence over the global setting and this over the
local setting, but all apply.

Does it sound reasonable? Is there interest in such feature?

Thanks,

Jordi
