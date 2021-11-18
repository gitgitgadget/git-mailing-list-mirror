Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD378C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 11:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B202D61B64
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 11:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343577AbhKRLH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 06:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245322AbhKRLHX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 06:07:23 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5217C061570
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 03:04:23 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y13so25052522edd.13
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 03:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ChkNIVoN3qfClfsp53xDVLXRdnpg5ZIWgozOmM2/isY=;
        b=QPkQzEb+jbYoLpOjDE8PI5KxwprHt1qywJ0HSXEQqc7+JLnt7hVbUXqZUna1mjGHQw
         6CdYf60JxTlCmmzih4/+FSnmGNs6MTJbjdmq00MH/9TCnkulcen7ddrBXT89QohwFKcM
         YumgMvmCGDhdxo3SmCrASKITiY/r+J7/x41XLbNnsa/1vWUg/TqZMlGvILFSd7ityN1K
         GC+VW1gnROis28MvJ3kCmiWnRV4Fnz1MvUabFxfXbjTRJw8Bha9JK4wGmNlnP1ik11mF
         2YV3xP8o5oStVv6l8m6k1tr+zMcZ77wU55vBuiEaKEm+knx/OcP6TRzO3fVsdelifRma
         cYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ChkNIVoN3qfClfsp53xDVLXRdnpg5ZIWgozOmM2/isY=;
        b=XvvXdUzRgPksJhsDVMylV2g3+IRT5kT1O6FNAN0hv31GPYsKJkesLcMW7CjxAJ/obp
         WIYmA8vJXhJd4D3ghIq9TI0gctCTWvFFRJv4SfGfrojTI/IE15QWOiSia5BIoiqFmy0S
         M2E6JJx/U4elWkh/c/ZloUVaN2pgqvt5MUWRju+I1l9eamHuJM67eZmLycLNmb977G0x
         VYks/AErUkQxoeeIGA9PFeLFyKhQ9RyB7TBOHo6XSKDDjsS4VmPMBca3oWfLP2V5DP9x
         W5srwfrmLpoBxc6wP2WfGSx5CzxvIPjDG/trgJlAcM2uKINusX4WCikHo1QEPQxmyLyD
         B8Pw==
X-Gm-Message-State: AOAM532mfj+slHdO+/VdPO31Zrwfuuh1HX/EjmrEOII2cIdTXNHLF6C5
        K64HfskOfFIb+PKDU+UHQcbTPLHUMxKitA==
X-Google-Smtp-Source: ABdhPJzTz0s71fl/4q9kawgCDkS30hPnkkOgOZJIPi/7OkIK+lwxKecuy4vlTq4nqWvMVSkKSRFO8w==
X-Received: by 2002:a17:907:6ea8:: with SMTP id sh40mr31537630ejc.53.1637233462140;
        Thu, 18 Nov 2021 03:04:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id go17sm1118752ejc.76.2021.11.18.03.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:04:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnfDJ-000QC8-6q;
        Thu, 18 Nov 2021 12:04:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 1/3] ls-tree.c: support `--oid-only` option for
 "git-ls-tree"
Date:   Thu, 18 Nov 2021 12:00:23 +0100
References: <211115.86r1bhsb8x.gmgdl@evledraar.gmail.com>
 <20211118092803.78395-1-dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211118092803.78395-1-dyroneteng@gmail.com>
Message-ID: <211118.86czmx67yi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 18 2021, Teng Long wrote:

>> If you make these an OPT_CMDMODE you get this behavior for free. See
>> e.g. my
>> https://lore.kernel.org/git/patch-v2-06.10-d945fc94774-20211112T221506Z-avarab@gmail.com/	   
>
> Thank you very much for providing this input.
>
> So I try to read this patch your mentioned and try to repeat the idea in my understanding.
>
> First, OPT_CMDMODE() can be used for:
>
>        1. Easy for checking the combined command options, such as "mutually exclusive" conditions.
>
>        2. Die and output the error message consistently when the incompatible options are found.
>
>        3. Brings better extensibilites, no need to change a lot of if/elses.
>
> Then, you suggest to consider about to use OPT_CMDMODE instead of the current implementations.
>
> Did I understand your suggestion right and comprehensive?

Yes, all of that is correct.

It's a way of defining N options, --foo, --bar, --baz, where combining
any of them is an error.

We usually use it for a "command mode" (hence the name), but it can be
used when the command has flags that are mutually exclusive.

I think (but am not sure, and didn't check) that you can even use it for
--foo AND --bar that are exclusive, and --other --flags that are also
mutually exclusive (but could be combined with one of --foo or --bar),
you just need to provide another variable for it to set.

But I haven't tested that or used it like that, maybe it doesn't work
for some reason I'm forgetting...
