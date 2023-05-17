Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F487C77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 07:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjEQHMd convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 17 May 2023 03:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjEQHMc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 03:12:32 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AC32683
        for <git@vger.kernel.org>; Wed, 17 May 2023 00:12:16 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-3f38c23b06eso3261691cf.3
        for <git@vger.kernel.org>; Wed, 17 May 2023 00:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684307535; x=1686899535;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxQKJgwI2kTkQi/QHV0Wt3yGiCEg/QyO4f2H4M2gSDQ=;
        b=HuZAb8kG7kaDUUtuIFuGAkj+0goNTgLE2/VkAhIjrYAXsfq9kCFU7VU0+9tsFXHB6w
         RrWReJt8oU+aZOpawwnVtnVl5g33rOvfWeqY+wYJ7HxcsAjEfXy8PeSsgUVroCSvG1c/
         H2dqrlogHblyW7virIoY7mTDE0jxUkcwRl3IVuF1gI2IWz26hxaHeR3An/eldnQKUwF/
         XUsAPobf61I5Q9yXxO+UgYkpx/QlyniOK6wCfvvt87JOk2D1HtOLvjVVANieNperhw2E
         +G5TH8c2xY4MT0BtLYx56KlQ8D6pAJirHg0O2vj6x1n/3y1vL0qcN7UrbF96MWQuJtgz
         2Xlw==
X-Gm-Message-State: AC+VfDzT2j/1utuSTGV5mH4ZCnKOnFPiXmDAfpg+/bBdBmllDbdrea9E
        cYFdxGjMZP9PFxqLjt3CQ4Jh3mPXRwHwZPVXH/Y2Fncre/w=
X-Google-Smtp-Source: ACHHUZ70zFRYZEoFyijTY18aL4MZRWU4nS0v8Pm/FxgVQWbCcWqdh4eLXEekFWikXT+lldQzM4yEflTD6OM65BBdSbM=
X-Received: by 2002:ac8:5a09:0:b0:3f3:8c42:cd76 with SMTP id
 n9-20020ac85a09000000b003f38c42cd76mr55649780qta.60.1684307535114; Wed, 17
 May 2023 00:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR14MB36544D63ECEAB9954C14407FA5799@BY5PR14MB3654.namprd14.prod.outlook.com>
 <ZGP2AzYJSLpI4kGN@tapette.crustytoothpaste.net> <BY5PR14MB36541924E1E6E5E912AFE0C2A5799@BY5PR14MB3654.namprd14.prod.outlook.com>
 <ZGQr03G/9swNcHt0@tapette.crustytoothpaste.net>
In-Reply-To: <ZGQr03G/9swNcHt0@tapette.crustytoothpaste.net>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 17 May 2023 09:11:39 +0200
Message-ID: <CA+JQ7M8CgqKxMRrR2TTKHLbBsiUbdQs=N_bN=Uv7d9OqbTbXLw@mail.gmail.com>
Subject: Re: git hangs with --separate-git-dir
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Tim Walter (Visual Concepts)" <twalter@vcentertainment.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 12:24 AM Tim Walter (Visual Concepts)
<twalter@vcentertainment.com> wrote:
>
> it's SSD, actually NVme, and the PC is 128GB ram 64 core very fast.
> Both drives are local SSD drives, the working directory on D: and the repo on F:.
> the 3 hour thing is not a problem as such  (it's a little frustrating that git is single threaded, but regardless, this is not the issue I am concerned with)
> it's only 3 hours once, on the very first git add when I create the repo
> I can live with that, I was just giving context.
>

I've worked on large repos (100k+ files) and 3 hours sounds unreasonable to me.
That's what, 27.7 mb/s?
My guess would probably also be anti-virus or some privilege
management type software.

Maybe try using procmon while you init and monitor all the processes
to get a better understanding of what could be the problem
https://learn.microsoft.com/en-us/sysinternals/downloads/procmon
I've used that successfully in the past to figure out the source of
unexplained performance problems (spoiler: it was privilege
management)
