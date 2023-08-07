Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47380EB64DD
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 05:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjHGF2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 01:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHGF2r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 01:28:47 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6482C10EB
        for <git@vger.kernel.org>; Sun,  6 Aug 2023 22:28:46 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bc734b2146so1449145ad.1
        for <git@vger.kernel.org>; Sun, 06 Aug 2023 22:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691386126; x=1691990926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MXdkUw0Z5onBqsftvS/5sjSx6slyxv8oQ/mgtxroEIY=;
        b=BgfPk3IA5Ge6tzqY4uCsOykh7qIweFnH7wtKxDbdaKSf76zYB72wG9HtMn92Ss1LgH
         OpnQ//iiYY9fZPoK/q5bVSp+3TCSenMLnepJpbyh5vevoxJ2wAwgY7GNFxb6SRMvXm2L
         +pzEbO4OSynHeaOwbR7/s7cBlbot2yGbgk3dGnLBKrtBPbKjhzG1i3e4lt4AMen8vUFW
         FJWKzz0dbFycEBaU3yrWaqT5k96o9InLdT2XmteeNb0INjQRkjRkaebXGdCl3jTdj9UM
         cWrbG/cK19DCmnNOsEWbvHCPDaZ9mUOX1NhMo/qFLohBq2qvFng3ZnSsnvIxxTjkPWnl
         RfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691386126; x=1691990926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXdkUw0Z5onBqsftvS/5sjSx6slyxv8oQ/mgtxroEIY=;
        b=g/L76wlw0GGAW7zoJQIz4a2lueM2X4pU6BCqW8aDYtDMtC1ZyBxwUayGVOzEakensm
         Tr6BX1gNr7KyNxIoIT8EDWnJptQt+f9gIYI+tTcgqqMg3Ve0hgUKY8FrNRB1WbF5KEsS
         9Wa5WZp34mleGbd56L/3gw0teOPUhYJsf52KMo2y5kL5h87avGPDO8eDvX/zpRn/o+uH
         bq/OiuVaTCA0xgqBmLf95KCq5ZDWy9XU4f6nHiQa5+LKI730lbWJEU8tXtuPk/nZkJPz
         0tiVnrw0x40Vlj5t8flgCczOGWwFBPnP03Wup1oVgkSubOeyVq/aiKyVP/VLcarwnkAg
         hpHg==
X-Gm-Message-State: AOJu0Yz+4MfRUGhWHAPP3FGS6TVbwDG6qjd8np3Jf81DgDmbdwXpMtuZ
        M40MsUHSYSo4w2BIIq4Kzm0TNYwUa9I=
X-Google-Smtp-Source: AGHT+IEUJe/WT/imPPTpfMS7retkN/LhAXLwXiZ+RWvJ2rBSFRl8aIi/0JpExv71qbx18D4edxzxQH9Lnuc=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:d4c3:b0:1bb:c7c6:3462 with SMTP id
 o3-20020a170902d4c300b001bbc7c63462mr31232plg.8.1691386125810; Sun, 06 Aug
 2023 22:28:45 -0700 (PDT)
Date:   Sun, 06 Aug 2023 22:28:43 -0700
In-Reply-To: <xmqqjzu7irhw.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
 <6b427b4b1e82b1f01640f1f49fe8d1c2fd02111e.1691210737.git.gitgitgadget@gmail.com>
 <xmqqjzu7irhw.fsf@gitster.g>
Message-ID: <owlyfs4vbeus.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 3/5] trailer: add tests to check defaulting behavior with
 --no-* flags
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> @@ -114,8 +114,10 @@ OPTIONS
>>  	Specify where all new trailers will be added.  A setting
>>  	provided with '--where' overrides all configuration variables
>
> Obviously this is not a new issue, but "all configuration variables"
> is misleading (the same comment applies to the description of the
> "--[no-]if-exists" and the "--[no-]if-missing" options).

Agreed.

> If I am reading the code correctly, --where=value overrides the
> trailer.where variable and nothing else, and --no-where stops the
> overriding of the trailer.where variable.  Ditto for the other two
> with their relevant configuration variables.

That is also my understanding. Will update to remove the "all" wording.

On a separate note, I've realized there are more fixes to be done in
this area (as I get more familiar with the codebase). For example, we
have the following language in builtin/interpret-trailers.c inside
cmd_interpret_trailers():

    OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply config rules")),

which should be fixed in similar style to what you suggested above,
probably with:

    OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply trailer.* configuration variables")),

When I reroll, I will include these additional fixes so expect the patch
series to grow (probably ~12 patches instead of the ~5).

One more thing. I think the documentation
(Documentation/git-interpret-trailers.txt) uses the word "<token>" in
two different ways. For example, if we have in the input

    subject line

    body text

    Acked-by: Foo

the docs treat the word "Acked-by:" as the <token>. However, it defines
the relevant configuration section like this:

    trailer.<token>.key::
            This `key` will be used instead of <token> in the trailer. At
            the end of this key, a separator can appear and then some
            space characters. By default the only valid separator is ':',
            but this can be changed using the `trailer.separators` config
            variable.
    +
    If there is a separator, then the key will be used instead of both the
    <token> and the default separator when adding the trailer.

So if I configure this like

   git config trailer.ack.key "Acked-by" &&

the <token> is both the longer-form "Acked-by:" (per the meaning so far
in the doc) but also the shorter string "ack" per the
"trailer.<token>.key" configuration section syntax. This secondary
meaning is repeated again in the very start of the doc when we define
the --trailer option syntax as

    SYNOPSIS
    --------
    [verse]
    'git interpret-trailers' [--in-place] [--trim-empty]
                [(--trailer <token>[(=|:)<value>])...]
                [--parse] [<file>...]

because the <token> here could be (using the example above) either
"Acked-by" (as in "--trailer=Acked-by:...") if we did not configure
"trailer.ack.key", or just "ack" (as in "--trailer=ack:...") if we did
configure it. These two scenarios would give identical "Acked-by: ..."
output.

This is confusing and I don't like how we overload this "token" word
(not to mention we already have the word "key" which we don't really use
much in the docs).

I am inclined to replace most uses of the word "<token>" with "<key>"
while leaving the "trailer.<token>.key" configuration syntax intact.
This will result in a large diff but I think the removal of the double
meaning is worth it, and will include this fix also in the next reroll.

The main reason I bring this up is because this means also having to
update our funciton names like "token_len_without_separator" in
trailer.c, to be "key_len_without_separator" if we want the nomenclature
in the trailer.c internals to be consistent with the (updated)
user-facing docs. I am not sure whether we want to do this as part of
the same reroll, or if we should leave it as #leftoverbits for a future
series.
