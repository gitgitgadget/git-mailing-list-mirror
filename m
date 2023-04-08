Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEB1C76196
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 00:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDHAD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 20:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDHAD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 20:03:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE189BBBE
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 17:03:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so166244pjb.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 17:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680912234; x=1683504234;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdyKiKCyF4IKSEYK9b2Rz2JVIj1N40sjzYWoYYEQbuI=;
        b=mIxKNSdqt/qTgksohgmm+HkG/bDkcVjsxGqSj7JcUXueEAtE3TzMXUnIv3jHklHmW6
         vJF5SFCzNnahaZRliXSx8Z6yQMoYXvLGlkmWuzw1IJL7dOcjK0c160zh8theljdzBvF3
         l646FMpSqlzX+s/VhoPjrMGabWU8tJkjMUHEU5qJrqmhqD4xs9cZZV8tgkTKmdTddV15
         CpKO6oWKs9w3EG2pMdHDpN9s2LyeuRuMlr+OrodP2eDrnscu0GXiPnbm/Gzcg1tCTuHu
         RFV0op2IaUIs20L1CaRvEk0CPT1dYtDSHcpVovi7x5XLF8TyXWFTPj3HSWye8mM0Th8q
         dzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680912234; x=1683504234;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IdyKiKCyF4IKSEYK9b2Rz2JVIj1N40sjzYWoYYEQbuI=;
        b=ZXhi0v5i9Zzg/TLakFZBBDM5UvZFNAiTrtmBCBj1fyYKfnM3TsQMI1+0rd0ugtSuEo
         rVvEj9xAIGnNAkQQxf1pwDpDMlDNbUR0E7GNY8hg/P/4ZR05hopapiHLKhnAQq/2ZaKz
         +gZNlvY91UR1llt4vg1HjPv0TrsGgwbLJAhw74ave8yBUHUQG/hsNPSye8XKVHlb8uI0
         0iLBB7/z15t1CjRJtDXPX4Mm4XDn/2wov/5KbDgyXO83b6NBZz6lTJDfwZ5xPERuen4m
         kLPYAZkx/0FTx2YO6iRQlUFKNeCfqW+4p2rgOupmI90q0Ec3XrJt53NdqrIzZ8gFcZD1
         QRRg==
X-Gm-Message-State: AAQBX9cyBQjqdRT7UkyupgrWxn+ZWE8dIUmSWDiVuGa29d4aW7mXvJHb
        vlB5JdcLEH5nC3PUQC8Cxxk=
X-Google-Smtp-Source: AKy350bAnnyVEj2x8LQa0Dz3auUfCy/1trwFtN/JSUqZ3QU0OcRaDgOW1MoZFlbyrhO+t/SkEsbVMQ==
X-Received: by 2002:a17:90b:4b87:b0:234:656d:235a with SMTP id lr7-20020a17090b4b8700b00234656d235amr4281151pjb.43.1680912234326;
        Fri, 07 Apr 2023 17:03:54 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id jx20-20020a17090b46d400b0023f355a0bb5sm3302942pjb.14.2023.04.07.17.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 17:03:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] usage: clarify --recurse-submodules as a boolean
References: <ZDCWrl4GhgYKYFYG@google.com> <xmqqcz4fi7bd.fsf@gitster.g>
Date:   Fri, 07 Apr 2023 17:03:51 -0700
In-Reply-To: <xmqqcz4fi7bd.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        07 Apr 2023 16:47:02 -0700")
Message-ID: <xmqqy1n3gryw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do agree with you that "git checkout -h" and "git reset -h" that
> list
>
> 	--recurse-submodules[=<checkout>]
> 	--recurse-submodules[=<reset>]
>
> are being unnecessarily confusing by not saying anything about what
> these placeholders are to be filled with.  
>
> This however is a breaking change....

With your patch, the callback becomes like this:

int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
						     const char *arg, int unset)
{
	if (unset)
		config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
	else
		config_update_recurse_submodules = RECURSE_SUBMODULES_ON;
	return 0;
}

but this makes me wonder if it makes it better by turning it around
180 degrees and going in the opposite direction.

With Devil's advocate hat on, what if we declare that *any* option
that sets a boolean variable can be spelled in any of the following
ways?

    [enables "frotz" option]
    --frotz             # naturally
    --frotz=yes         # usual synonyms yes/true/1/... are accepted

    [disables "frotz" option]
    --no-frotz          # naturally
    --frotz=no          # usual synonyms no/false/0/... are accepted

It would be just the matter of updating OPT_BOOL()'s implementation.

Then the patches to builtin/checkout.c and friends would look like:

 static struct option *add_common_options(struct checkout_opts *opts,
 					 struct option *prevopts)
 {
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
-		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
-			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
+		OPT_BOOL(0, "recurse-submodules", &config_update_recurse_submodules,
+			N_("control recursive updating of submodules")),
 		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),

and we no longer need the callback function.

We will not break any existing users, and then suddenly people can
now say

	--progress
        --no-progress
        --progress=yes
        --progress=no

just like --recurse-submodules=yes has silently been allowed all
these years.

Hmm?
