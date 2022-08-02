Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA716C00144
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 03:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiHBDID (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 23:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiHBDH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 23:07:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF70E1EAC6
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 20:06:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id tk8so23662920ejc.7
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 20:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=R0GWGPPAVbgKLBZi1VXLOgZCAg+J4KyKmsltWNXbBYM=;
        b=oewbvEJ7pBeLTBuaQh5G5RPR2aq1E+QDKW1yr0KEeyRPcdPv97yjQlZbVZTDfyt4DO
         EaMIk/56vfJuz6969NxZ0OcILx1QJE7vonetUA/PEwvZx8Q9AyZMT33s1ZQtNt2t6OqE
         9gZzpzT+JbEHiwkmHLRsKG9RL49N0orLmvGc8+cgcquM7Ew5E1OXR81ciyeLmWjIG5yq
         p4V958i7PASa9Ezc0jsuyPjh404a0MOAU4zF3DSkoijXP5NzXVDeuMZprPOX6fDkULm7
         1kzQ2IbAxFE8iQJXQ99GTty0O3HBPWqdu0ajH8vD8eUOcsAP78FoO5fbyf2WsbqPTnBb
         lcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=R0GWGPPAVbgKLBZi1VXLOgZCAg+J4KyKmsltWNXbBYM=;
        b=3ok5w79z/kqnD2MdSkRwbjA8lgl2gTEBBwIC1j8W1iFyYbLPK6VBKZ6NSbImXbs2BO
         CjODU2O7CNznHjMKlSlTLx9UG0B0LyBeDPJtly0nOFa8mrcjJEphZz5Uf5tnLtJLwy47
         ESNisd/It2rDuJjXHp4Zm0a84O3hQDBqKbprufYhRreT1CUujfCQinWoFY2nbDvmhM4O
         oK4KMKC7r5sCdEvuSBOlBL7EI+a9SsHk02lxXVKFC8m08ibyOuxN2joDxXZqhu0C7ikc
         rxFPKlL7kEwE6A3FUff5c+IXuEKoYubQaSUveKZI2XdhLk8IXzLSrSl4Cd050vIUtwtS
         CNVQ==
X-Gm-Message-State: ACgBeo3Ka5SwDXsp7cuU6GcvjS2yAgi+44JklD0KcmfNoamv53obE1DU
        MUzbOUwRaJF+XUOnOp/ngkc=
X-Google-Smtp-Source: AA6agR7910jJYlqe3TZfvHUVZgv+fmphnIYN1AodjvnttqwzLvit7aA1J2x+cYHcPm8RpZXqvfdl2w==
X-Received: by 2002:a17:907:6daa:b0:730:8ef6:9c6b with SMTP id sb42-20020a1709076daa00b007308ef69c6bmr4581492ejc.6.1659409594229;
        Mon, 01 Aug 2022 20:06:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v22-20020aa7dbd6000000b0043d06d80d27sm6955545edt.86.2022.08.01.20.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 20:06:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oIiEq-009Bs6-2p;
        Tue, 02 Aug 2022 05:06:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/7] Generalize 'scalar diagnose' into 'git bugreport
 --diagnose'
Date:   Tue, 02 Aug 2022 04:49:15 +0200
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
Message-ID: <220802.867d3rgx8n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 01 2022, Victoria Dye via GitGitGadget wrote:

> [...] I didn't see a major UX benefit of 'git diagnose' vs 'git
> bugreport --diagnose', so I went with the latter, simpler approach.

I really wanted to like this, but I find the end result here really
confusing from a UX perspective.

You can now run "git bugreport --diagnose", which creates a giant *.zip
file to go along with your *.txt, but your *.txt makes no reference to
it.

Should you ... attach it to your bug report to this mailing list, do
something else?

The documentation doesn't offer much in the way of hints, other than
suggesting (with --no-report) that this --diagnose is for something
entirely different (and that's how "scalar" uses it).

I know what it's really for after reading this series, but for "git
bugreport" in particular we should be really careful about not making
the UX confusing.

The generated *.zip contains some really deep info about your repo (and
not just metadata, e.g. copies of the index, various logs etc.), someone
e.g. in a proprietary setting really doesn't want to be sharing that
info.

So I would like to see real integration into "git bugreport", i.e. for
us to smartly report more repository metrics, e.g. approx number of
loose objects, the sort of state "__git_ps1" might report, etc.

But I think the end-state here makes things much more confusing for
users.

> An alternative implementation considered was creating a new 'git diagnose'
> builtin, but the new command would end up duplicating much of
> 'builtin/bugreport.c'.

It seems we always "return" from cmd_bugreport() quite quickly, and we
basically only share the code to create the output directory. Just
duplicating or sharing that seems like a much better approach for now
than creating the above UX confusion.

Note that you can also share code between multiple built-ins, even in
the same file (see e.g. builtin/{checkout,log}.c). So we could even
share something like the safe_create_leading_directories() calling code
in bugreport.c without libifying it.

> Finally, despite 'scalar diagnose' now being nothing more than a wrapper for
> 'git bugreport --diagnose', it is not being deprecated in this series.
> Although deprecation -> removal could be a future cleanup effort, 'scalar
> diagnose' is kept around for now as an alias for users already accustomed to
> using it in 'scalar'.

We don't have a "make install" to get a "scalar" onto user's systems
yet, do we really need to worry about those users?

Or is this a reference to the out-of-tree version of "scalar", not
git.git's?

