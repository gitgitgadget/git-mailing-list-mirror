Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DDEC32772
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 15:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344137AbiHRPut (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 11:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344410AbiHRPuV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 11:50:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BA2C0E7C
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:50:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n4so2188258wrp.10
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=WLgsOQQjZN3aBSh149SXQbs8lasK+1eMfJACeSGB/NE=;
        b=nryfXaqGxrEFw/BUE0fUeyxLoI/RVxFJIqX5cecjTPMj27eDGQzZDImPUnN9zu6pnA
         7hIoS107t6RX+WbGTA0zEbro4qL1m1kjrHOKBRqtMOokB6wDuiAmPESxWmrwtQ5w0DWp
         NLplzx6jth3lDKsWBYcEqN17OeL5FMT5Gt4yMRpWLszrpWL4VC3QgiUNrvK6q+WphgU5
         UYbFp3h2rGzc/MsOskVNUMVIi3UXzGEFminitn9H7k/KCGqiFHK20v95VQ1gZ7Embgvr
         srd42GMkh3k1t0y89otKEu40DQGLIsXEcKzA/Jqg8GmoMAx3ehUDBtcCePbE9oeaSbTZ
         gLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WLgsOQQjZN3aBSh149SXQbs8lasK+1eMfJACeSGB/NE=;
        b=Cn42hO9qc5yDU9J0/AO2LoY2I22DoZ3j2XdtTdIXitvpBk98rYSnoS18t87om+eJCw
         cSzksNlcTFMKU4lwR7qYAl/VwuggYrcdePwrQPbXyvxLidS6VeJugprBw/BHS4LuLfyM
         Qm9EJtLhpalpMYcPpOIquAiPV9hd2y4N0YB7LYLvh4iyCJXbygfc31LfQtvTFGY9IEuh
         X09FtGFiA2KMz3oBeWBFg3P4uy7tlYoswl3Wtphbj1rzv80FxAXUbNBGJWrblxOBHjra
         e08HXUjNdDaIi/BlKB2EfICsOlXYUR57JVgEjGsz2gRqYroBjE3Ahzgx50TLj/3LOpjN
         tUBw==
X-Gm-Message-State: ACgBeo2p8eK4xwaxd/TC4iT4DK7H5XZ40DsfwjdiJZUIvg3wF1NaCrsy
        C6c9U55XepW5CAkNpFox5cI=
X-Google-Smtp-Source: AA6agR7fCOd0c4YvZRNX0Qxno92chEIhVVz0ZTVpmxvm8vBOmss3rHM9yElK2Uy0YwxecixPAugdiw==
X-Received: by 2002:a5d:47ca:0:b0:220:5cbc:1c59 with SMTP id o10-20020a5d47ca000000b002205cbc1c59mr1962001wrc.662.1660837809803;
        Thu, 18 Aug 2022 08:50:09 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id bg24-20020a05600c3c9800b003a38606385esm174779wmb.3.2022.08.18.08.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:50:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oOhmY-000IdR-1B;
        Thu, 18 Aug 2022 17:50:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mark Fulton <mfulton26@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Programmatic patches (transform commits)
Date:   Thu, 18 Aug 2022 17:48:19 +0200
References: <CAED_RJPh28o8bFsBEEzAYvp1DXhff2JWiTk3zHh3VbaHZephgg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAED_RJPh28o8bFsBEEzAYvp1DXhff2JWiTk3zHh3VbaHZephgg@mail.gmail.com>
Message-ID: <220818.86mtc18sb5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 18 2022, Mark Fulton wrote:

> Is there a way to commit a transform script that programmatically
> applies file changes rather than committing the file changes directly?
>
> e.g. Imagine in a large repository that a contributor wants to replace
> certain instances of "abc" with "xyz". A transform script might be
> like the following:
>
> ```sh
> #!/bin/sh
>
> sed -i 's/abc/xyz/g' $(find .)
> ```
>
> Applying such a "programmatic patch" will potentially edit many files.
> Doing a code review on such a change is error prone due to authors
> resolving merge conflicts manually, etc. while reviewing the patch in
> some circumstances is much easier (especially tools for specifically
> this type of file transformations are used to make it easy to parse
> code, traverse abstract syntax trees, make edits, etc.).
>
> Does anything like this exist today? Depending on the implementation I
> could see there being cross-platform support challenges but maybe
> there is something that already exists to assist with this which I can
> learn about.
>
> As an alternative to making this part of Git I can see tools like
> GitHub Actions being used to look for commits of "programmatic patch"
> files, pick those up, run them, and commit and push the change but
> having a solution for this as part of Git itself would make it
> independent of GitHub and more reusable, etc.

Yes, e.g. for C (and used by linux.git and this project):
https://www.kernel.org/doc/html/v4.14/dev-tools/coccinelle.html

Generally speaking I've made such ad-hoc commits in the past, where I've
e.g. included the needed script (or one-liner) in the commit message,
along with manually adding the diff to the commit message that *isn't*
the part changed by the script or one-liner.

But I don't think there's any sort of widespread standard for this sort
of thing, other than doing that, and the same (sometimes leading to
non-atomic commits) of having the manual part of the change applied
before or after in a separate commit.
