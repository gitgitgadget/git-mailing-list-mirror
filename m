Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2481C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 09:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiKCJR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiKCJR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 05:17:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B764DE0E1
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 02:16:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sc25so3440772ejc.12
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 02:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ve1u1epsLraretnhryWvwXC2BVfk59kQ6BsX6yy4yU=;
        b=IKVk8GQpKlwoK7rVkGyWRHw9kDzX8C3ll+3ou/cQ+Hwi+WxXKzj8NPN+Z7JI/5BlBo
         aGhungtGh9ntHLvpnYEXeDDLLUnUaxGPH6P3q2g6mDy8LLmJtCEioD+AzocBIS+iZ1f6
         xDT/8B8ZztdHMmW8FiB+PMfUnxLpdq9cZlPtd60cZUwX1vixh+GP2MfCcfVMA1yOvVGA
         VYAiccfpOpo9twvtvO5tGk/xZJi3tHYal1yye8OpXaNdw2mFbIQIdX749Ixr1o+YSUcr
         z64CuqByzgKsXmItzZLLfdmWiWfxP6o52PF6xT91jQkXH0Tmthfzn7Ae2O+c78y7pJkE
         21ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ve1u1epsLraretnhryWvwXC2BVfk59kQ6BsX6yy4yU=;
        b=1TO1XDZ0cjj2JKVZBAgD0F+cVHLw+Ry+9Ms+9x8lsSbvwc943cFvfXbDaeQORzlixz
         l3qW7fJFeQnLKyDf/SbKRCHkkZPLLFnfksOWwbDI2u2SbzxHPAib0/OkIgki29JpAht2
         YNj6n0R30hFE6mF7FW00YOBR5G3OeA3hazg7vii2lBx5h5Ye+UzxMRr1teSoZZEfXWtv
         WhphUJz/2ljEwcCqjJk9Pxn25pZ9+VwDABsvmiCkt7JyGXxLLGURXFH4VQK3USCOhWk+
         Tq7ngloQ5go7Fi7Kgfb4TFNzjxW5QH4dIyeljXVmmgkIFJRMn9kWKFT9B0a7J30lALeK
         mUbQ==
X-Gm-Message-State: ACrzQf1l4po16XbBW30WL68NKiKn1jZwtFOXGNKk4hoR4Z6MXZzzR2P6
        MneJLhNcPdOD5QdWeVBdCEI=
X-Google-Smtp-Source: AMsMyM73A3NRvlEyEObtdCXY/7fuzC9HnzE81QK+HEiesUw7a/0CxB+XWolqsw/emg4WL7+isgcUmQ==
X-Received: by 2002:a17:906:fe45:b0:791:9624:9e9f with SMTP id wz5-20020a170906fe4500b0079196249e9fmr28346477ejb.86.1667467003121;
        Thu, 03 Nov 2022 02:16:43 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 23-20020a508757000000b004614fd33789sm258086edv.18.2022.11.03.02.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:16:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqWL3-00CLTx-31;
        Thu, 03 Nov 2022 10:16:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC/PoC 3/5] test-lib: add GIT_BUNDLE_DIR setup
Date:   Thu, 03 Nov 2022 10:14:36 +0100
References: <20221102224843.2104-1-philipoakley@iee.email>
 <20221102224843.2104-4-philipoakley@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221102224843.2104-4-philipoakley@iee.email>
Message-ID: <221103.86v8nw1jpi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 02 2022, Philip Oakley wrote:

> The test system may output a number of documentation bundles containing
> test repositories of interest to users, including those explicitly
> documented.
>
> Provide a default location for holding those bundles.
> As build artefact's this location, along with `.bndl` files, was
> ignored in an earlier commit.
>
> This may need further refinement.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>  t/test-lib.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 4e45bc7c4f..b18cd8a34e 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -56,6 +56,20 @@ then
>  	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
>  	exit 1
>  fi
> +if test -z "$GIT_BUNDLE_DIR"
> +then
> +	# Similarly, override this to store the documentation bundles subdir
> +	# elsewhere
> +	GIT_BUNDLE_DIR=$TEST_DIRECTORY/GIT_BUNDLE_DIR
> +	if test ! -d "$GIT_BUNDLE_DIR"
> +	then
> +		mkdir -p "$GIT_BUNDLE_DIR"

Okey, so "mkdir -p", not "mkdir" once one thinks about it for a second:
Because we might be testing in parallel, so this will be racy.

> +	fi
> +elif test ! -d "$GIT_BUNDLE_DIR"
> +then
> +	echo "PANIC: Your "$GIT_BUNDLE_DIR" doesn't exist!" >&2
> +	exit 1
> +fi

I think it's better just to put these in the "test-results" dir.

For leak testing I have local patches to e.g. create test-results/<test
number>.leak, and then after a run I slurp that up and process it.

So, same idea, you could just add stuff there, and afterwards grab it
there. No need for specifying the dir etc., you just need a test-lib.sh
flag to say "yes, write these out".
