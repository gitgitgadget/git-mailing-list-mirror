Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721F0C433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 16:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiF2QaH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 29 Jun 2022 12:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiF2QaH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 12:30:07 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564AC2ED73
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 09:30:05 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3137316bb69so153135867b3.10
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 09:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y10JV8IrbzuOH6RkskhCPyhGwFTMimvxq8s+TLHS2Z4=;
        b=4IblzfQLaPn83bEv7QpRK1uA+eQdgGdUY7cEnyeOxn+etUrQRRKfrbmx9LiLZEmW9u
         ITsJFBng6zIIk71rmsd5TRorMCnsTJkfRQQMRsMsOlEHKrgvibhgzk+TL5I0PxydFxsf
         JqPkWoaxBXXffEZtzpCEhqRdfcvZ0uDUehec04Y6Kiimc1pf0XSSkUAKaREwB/Jpiaju
         zlukv0bmSMIWeAotBOse4NZO6G0TenZJ5b1X0nN1Qs0Rl7SLSRGOGeW4nxlHaWocIY6Z
         tm7cFwBpTkghGzrb+o+q9AVxTJB0rQXHIB+9jC4PZ4/N+O//R8wGwLsOE57to5cdsch6
         7FQw==
X-Gm-Message-State: AJIora8lEQ1g3c4k2BeHvLpL2pp0l71Ffz0vVRMuFWxxkRnvhzVM26XV
        e5jAW76mtNkQD1ts0cEFSmLixhDpczu1koJRGTQdAJd26ZI=
X-Google-Smtp-Source: AGRyM1vhEt84zSdCHtr5Vockg/ZsrSklY7dCuyxrsqX98U9DnSMeLCEvtxC7XNQHA9UPF/JAYlz9AGvM6zHYae8V3kk=
X-Received: by 2002:a81:5857:0:b0:31b:8e8b:ded4 with SMTP id
 m84-20020a815857000000b0031b8e8bded4mr4927821ywb.70.1656520204493; Wed, 29
 Jun 2022 09:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <d2a7caa9-e2ba-457d-9fe9-92b29b5ee47a@www.fastmail.com>
In-Reply-To: <d2a7caa9-e2ba-457d-9fe9-92b29b5ee47a@www.fastmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Jun 2022 12:29:53 -0400
Message-ID: <CAPig+cSnhbruJE_WBpmmypE_vzEQForooOu8KqbJ=dbaUrKKcg@mail.gmail.com>
Subject: Re: Bug: "git-remote ls -h"
To:     Ian Whitlock <ian@theknown.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 11:39 AM Ian Whitlock <ian@theknown.net> wrote:
> I found a bug and couldn't find another way to report it. I hope this is okay.
> The help output for `git ls-remote` shows that `-h` should display remote HEADs, but instead the help output is displayed!

Thanks for the report.

>  ➜ git ls-remote -h
> usage: git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]
>                      [-q | --quiet] [--exit-code] [--get-url]
>                      [--symref] [<repository> [<refs>...]]

This is a known and documented behavior. The description of the `-h`
option in the `ls-remote` help page:

    Limit to only refs/heads and refs/tags, respectively. These
    options are not mutually exclusive; when given both, references
    stored in refs/heads and refs/tags are displayed. Note that git
    ls-remote -h used without anything else on the command line gives
    help, consistent with other git subcommands.
