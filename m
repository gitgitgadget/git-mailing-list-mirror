Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492F9C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 12:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiDFMIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiDFMIK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 08:08:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EA4507179
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 00:50:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b24so1570903edu.10
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 00:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=MTAGmvqfNba+7ugaksbleUxvWi6PCK3UpkJIqRRQ0L8=;
        b=F2ll97FlONBzwOQtOVIvJZ/lwCZwLTf9YUEq/Obhy7OZqWVyKVFmsOpGRXaTM79mv0
         WTAcnzT4y79awsHjeZg4DGipHv7UNu2nNp8tmvcZVal49Gjp9S7Lkn5ha/rSm2WHg/Ip
         5BBDDULKa5tJ+CIML6o26igc2Jer0mEUcN2SZngpCDIXuzKH119mMr27vbjrG8bhOtMp
         jlmlbR8GY9aAall3+/1VbTs5k+5LFV2sRo1ternTZ5nw4Ys7tbxhXsgG82uEWujm7ZOx
         FX9hTzeKUjNbBW9NWM2ouid5hUA/wWOcMdItRE/Tr2cMbDq12KhIpLwy/Y1xCzNFNCRj
         Hpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=MTAGmvqfNba+7ugaksbleUxvWi6PCK3UpkJIqRRQ0L8=;
        b=OPQ8DVsGzteGwM7tKYkLrc8Ockz54he2Tf5mOu2zD/NDKRtMmEEq94x5NR+5uJ6jWr
         txHjcEaYeUk0xKgS3i+i9s8MsmZ7uKGgAquvXuI2FfodlOKw/0eLVcLo1H1IK+zxd0VX
         nDb4RJJOiwqhwzAy/fy806K00JN6j8BzAXPsVgoVyufXuQzI/RIZCggyQX6ENRLfx40l
         6Ti8gU8f4dk6YVXCp5YBsSxbk9JXlGsfBh1ujffD/JVJTarq1IPjmQaK7j7DnMGgKEkn
         1p4Zod3f6mOJSqJCtkneZ3lDUUiSQpfeeGAOOHw/LRc8DOWE6YdV02WFUROfsP8sUB6u
         dS7g==
X-Gm-Message-State: AOAM532vl4w9P9GFh1V/H+7+07p3BkqI0BF6PtB2csMxAZrIMog4qTMG
        BEKEvspXfDWDVB0AhUdfVXk=
X-Google-Smtp-Source: ABdhPJwon1n42wdhYiShnkP63qQ6+wKEp/G07j+Nbz3h/BAsdV83f6/ZnHO1kPauKm9m3MxZKwVvHw==
X-Received: by 2002:a05:6402:5cb:b0:419:14d8:4106 with SMTP id n11-20020a05640205cb00b0041914d84106mr7517624edx.140.1649231415638;
        Wed, 06 Apr 2022 00:50:15 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c13-20020a17090654cd00b006e0db351d01sm6333788ejp.124.2022.04.06.00.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 00:50:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nc0Qg-000YiW-Ae;
        Wed, 06 Apr 2022 09:50:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Garrit Franke <garrit@slashdev.space>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/4] contrib: add iwyu script
Date:   Wed, 06 Apr 2022 09:40:17 +0200
References: <20220331194436.58005-1-garrit@slashdev.space>
 <20220405114505.24389-2-garrit@slashdev.space>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220405114505.24389-2-garrit@slashdev.space>
Message-ID: <220406.86ee2afy6h.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 05 2022, Garrit Franke wrote:

> add include-what-you-use helper.
>
> Signed-off-by: Garrit Franke <garrit@slashdev.space>
> ---
>  contrib/iwyu/README  | 33 +++++++++++++++++++++++++++++++++
>  contrib/iwyu/iwyu.sh |  2 ++
>  2 files changed, 35 insertions(+)
>  create mode 100644 contrib/iwyu/README
>  create mode 100755 contrib/iwyu/iwyu.sh
>
> diff --git a/contrib/iwyu/README b/contrib/iwyu/README
> new file mode 100644
> index 0000000000..5e2d218602
> --- /dev/null
> +++ b/contrib/iwyu/README
> @@ -0,0 +1,33 @@
> +Include What You Use
> +====================
> +
> +Include what you use (iwyu) [1] is a tool that points out which headers a file
> +should include. Moreover, it can point out includes that are not used by a file,
> +which makes it especially handy for cleanup tasks.
> +
> +To run this script, you will need iwyu to be installed on your system.
> +
> +The "iwyu.sh" script runs iwyu on a given object and omits mandatory headers
> +defined in "Documentation/CodingGuidelines".
> +
> +Example usage:
> +
> +    ./contrib/iwyu/iwyu.sh diff.o
> +
> +This yields:
> +
> +    diff.c should remove these lines:
> +    - #include "attr.h"  // lines 13-13
> +    - #include "submodule-config.h"  // lines 18-18
> +
> +In its current form, this script should not be used to auto-generate patches,
> +since there are still some false-positives that only a human can resolve. It is
> +meant as a starting point for further cleanups. It could be nice to integrate
> +this as a step in our CI, but we're not quite there yet.
> +
> +The inspiration for this script came from this [2] email-thread.
> +
> +Garrit Franke <garrit@slashdev.space>
> +
> +[1]: https://github.com/include-what-you-use/include-what-you-use
> +[2]: https://lore.kernel.org/all/220401.8635ixp3f4.gmgdl@evledraar.gmail.com/#t
> \ No newline at end of file

Note the "No newline at end of file" warnings, new files should have \n
at the end.

> diff --git a/contrib/iwyu/iwyu.sh b/contrib/iwyu/iwyu.sh
> new file mode 100755
> index 0000000000..3ef8639eae
> --- /dev/null
> +++ b/contrib/iwyu/iwyu.sh
> @@ -0,0 +1,2 @@
> +make $1 CC=include-what-you-use CFLAGS="-Xiwyu --verbose=1" 2>&1 \
> +| grep -v -E -e '^#include <' -e '^#include "(cache|git-compat-util|gettext)\.h"' 
> \ No newline at end of file

So that's just my one-line hack as-is (well, bisect.co replaced with $1)
:)

I think if we integrate some IWYU spport support that this is a rather
dead end to pursue.

A much better way would be to just do ("REAL_CC" is already understood
by sparse):

	REAL_CC=gcc make CC=contrib/iwyu.sh 

I.e. we shouldn't run make and then parse its output, but to have make
run a CC which wraps our REAL_CC.

Then you could either have it "really" compile, as e.g. the "sparse"
wrapper can do (note: note our sparse target but cgcc), or run whatever
"make" target, and then only having to parse the output of iwyu, not
iwyu+make.

Also, it looks like iwyu is a nicely API'd python library, so trying to
parse its output is probably a dead end too, can't we just ship a
trivial API-using script for it that gets all this as nicely
machine-readable data?

Or, if you look at iwyu.git its own source tree has a fix_includes.py
which seems to do that, *and* be able to "fix" the includes for you.

All of that is just stuff I didn't have time to poke at when posting a
quick reply in the original thread, but hopefully someone turning this
into a series of patches will :)
	
	$ python3 fix_includes.py -h
	Usage: fix_includes.py [options] [filename] ... < <output from include-what-you-use script>
	    OR fix_includes.py -s [other options] <filename> ...
	
	fix_includes.py reads the output from the include-what-you-use
	script on stdin -- run with --v=1 (default) verbose or above -- and,
	unless --sort_only or --dry_run is specified,
	modifies the files mentioned in the output, removing their old
	#include lines and replacing them with the lines given by the
	include_what_you_use script.  It also sorts the #include and
	forward-declare lines.
	
