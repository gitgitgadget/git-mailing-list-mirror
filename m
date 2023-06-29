Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8B7EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 21:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjF2VNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 17:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjF2VNV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 17:13:21 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C6530F6
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 14:13:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E9AE19964A;
        Thu, 29 Jun 2023 17:13:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KMj5aQlEVI/xJu3A6TsBwiflbeGyvb1kZMKF13
        n+OAk=; b=ajeJiI5unhPJVfD78pA74kpcRBUx2bX1vw6XARmcjLTbeSVaMmcFN8
        /oOB+/UaRY2kF5UTZsVeEvLIalHamKEd2QSyAHhk0G99kZ1CBdUojVOBUhjJqvTN
        FmWepUkls1n5VJ+3bl5I1h/ZDF3xaIeI+mxG3Yflm85bBEyW24tuE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46B75199649;
        Thu, 29 Jun 2023 17:13:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FE5F199648;
        Thu, 29 Jun 2023 17:13:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vinayak Dev <vinayakdev.sci@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     nasamuffin@google.com, git@vger.kernel.org
Subject: Re: [PATCH] docs: include "trace.h" in MyFirstObjectWalk.txt
References: <20230629185238.58961-1-vinayakdev.sci@gmail.com>
Date:   Thu, 29 Jun 2023 14:13:12 -0700
In-Reply-To: <20230629185238.58961-1-vinayakdev.sci@gmail.com> (Vinayak Dev's
        message of "Fri, 30 Jun 2023 00:22:38 +0530")
Message-ID: <xmqqjzvm7z13.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C51EE780-16C1-11EE-B2F9-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vinayak Dev <vinayakdev.sci@gmail.com> writes:

[jc: including Elijah, who owns a few topics of the recent past that
shuffled header files, to recipients].

> In Documentation/MyFirstObjectWalk.txt, the function
> trace_printf() is used to enable trace output.
> However, the file "trace.h" is not included, which
> produces an error when the code from the tutorial is
> compiled, with the compiler complaining that the 
> function is not defined before usage. Therefore, add
> an include for "trace.h" in the tutorial.
>
> Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>
> ---
>  Documentation/MyFirstObjectWalk.txt | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> index eee513e86f..c3a23eb100 100644
> --- a/Documentation/MyFirstObjectWalk.txt
> +++ b/Documentation/MyFirstObjectWalk.txt
> @@ -41,6 +41,7 @@ Open up a new file `builtin/walken.c` and set up the command handler:
>   */
>  
>  #include "builtin.h"
> +#include "trace.h"
>  
>  int cmd_walken(int argc, const char **argv, const char *prefix)
>  {

OK.

> @@ -49,12 +50,13 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
>  }
>  ----
>  
> -NOTE: `trace_printf()` differs from `printf()` in that it can be turned on or
> -off at runtime. For the purposes of this tutorial, we will write `walken` as
> -though it is intended for use as a "plumbing" command: that is, a command which
> -is used primarily in scripts, rather than interactively by humans (a "porcelain"
> -command). So we will send our debug output to `trace_printf()` instead. When
> -running, enable trace output by setting the environment variable `GIT_TRACE`.
> +NOTE: `trace_printf()`, defined in `trace.h`, differs from `printf()` in
> +that it can be turned on or off at runtime. For the purposes of this
> +tutorial, we will write `walken` as though it is intended for use as
> +a "plumbing" command: that is, a command which is used primarily in
> +scripts, rather than interactively by humans (a "porcelain" command).
> +So we will send our debug output to `trace_printf()` instead.
> +When running, enable trace output by setting the environment variable `GIT_TRACE`.

All of the above may be good currently, but as soon as somebody does
another round of header shuffling, we risk a very similar breakage.
It is a good time to think about ways to avoid that, while the pain
is fresh in our mind.

One "cop out" thing we can do to limit the damage may be to loosen
the text in the "NOTE:", so that it does *NOT* mention exact header
files the API functions appear and let the readers learn from the
source themselves, with "git grep" helping their way.  Or tone down
"defined in X" somehow to hint that these details may change.

More effective things that would involve higher implementation cost
(but will reduce maintenance cost) would be to actually make sure
that those who update the API will notice that they are breaking
these samples when they develop their series.  

In https://lore.kernel.org/git/xmqq1qhu9ifp.fsf@gitster.g/, I've
floated some strawman ideas but people may be able to invent better
ways.
