Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52340C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 10:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiB1K7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 05:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiB1K7O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 05:59:14 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158A17461F
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 02:56:40 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id r13so23934960ejd.5
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 02:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=5M+MQNuwSm4a/mA3MVE5KHHVGUuTRcN5RmzRtbj8l5w=;
        b=XxW6hniA5Fn2tl8MNuX8wdsEUtrz3PEZsRrkur+hbrjatK+JYAWoKxtlK9qGDhTZmb
         OUMOPQ4UrovdJF342wJThRe+4dAd8xEoyJnlKBJcmDSWwsYxu6mlymb/Vbe1adW/ERNM
         VcxyCbnr8PKjshhd2cIPYShUokTXcIDNnh+XvNxsMi0/Y0aPBi2805JcQsRKaCyeasfP
         JWY6j9VX5P/VPgTB4+Pv4d5xIo7SzqVsHz+GhvYs4TEuERasoPtSm7Zo98p6XU4+gKQJ
         Md2SFNNedZgRmuIilWinKEWS63Z4cyO2mVbkS38rYTW0PIBdeJ1PTLnWqjpMz80fwnnB
         Mjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=5M+MQNuwSm4a/mA3MVE5KHHVGUuTRcN5RmzRtbj8l5w=;
        b=WPC6VLF4Sf2vjCT3tIS7iwTxGa+UsMQnL3gwa1q3HJjOvJaC/RvgDowkoyFHBpgEOl
         XRfcILI200CFVy6gwP13SN7zbbv98JALm3rGCf4XhMvx9tMWPvnP45nDXxBjNtVMerCv
         e8T5/jGirwOClBH4kyy2QLfAqknDlJdEhfvoQTiC1sOR6fCL7YvS9shoTA/GZgn0bpjH
         zC17zxVn409tpMKdTCKsLZIZyY0JJC6oNW7Di7pqb4FrQd0hhFZD3qs/fQ1YFWDBgf79
         dCBZLL0oLDhGnAKjYqB8+NfJZP7WD6K6KyXINcFN1iebriaPT3XtFKHi3nodIJHOcusy
         gGkQ==
X-Gm-Message-State: AOAM531FhMkM5pQnwAfLCFFc6ox1p8M9wRruhSpqD72qXKoBUTzHOEcC
        GwAC0mDhbOsBx0XSnx1DZhUqkWbj1OE=
X-Google-Smtp-Source: ABdhPJynXjDsmCCwchq/7LKOpDEMDh0DNYoF7FDbQZ7sdy++ocS3rU6xeHjwCloZC4j3nPT9VOnQCQ==
X-Received: by 2002:a17:906:1244:b0:6cf:118c:932f with SMTP id u4-20020a170906124400b006cf118c932fmr14658055eja.563.1646045798444;
        Mon, 28 Feb 2022 02:56:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7c995000000b00400506d388bsm5941015edt.48.2022.02.28.02.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 02:56:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOdhl-001IfV-Bi;
        Mon, 28 Feb 2022 11:56:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v3 1/2] merge: new autosetupmerge option 'simple' for
 matching branches
Date:   Mon, 28 Feb 2022 11:39:38 +0100
References: <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
 <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
 <0b5d47895120539d6a72a91398f33a0e33df7cd5.1646032466.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <0b5d47895120539d6a72a91398f33a0e33df7cd5.1646032466.git.gitgitgadget@gmail.com>
Message-ID: <220228.86k0df5key.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Tao Klerks via GitGitGadget wrote:

I think squashing 2/2 inot this would make this much easier to follow,
i.e. to have tests along with the new feature.

> +	/*
> +	 * This check does not apply to the BRANCH_TRACK_INHERIT
> +	 * option; you can inherit one or more tracking entries
> +	 * and the tracking.matches counter is not incremented.
> +	 */
>  	if (tracking.matches > 1)
>  		die(_("not tracking: ambiguous information for ref %s"),
>  		    orig_ref);

This function is the only user of find_tracked_branch(). For e.g. "git
checkout we emit";

    fatal: builtin/checkout.c:1246: 'foo' matched multiple (4) remote tracking branches

Perhaps we can do something similar here, and even with some advise()
emit information about what other branches conflicted.

> +	if (track == BRANCH_TRACK_SIMPLE) {
> +		/*
> +		 * Only track if remote branch name matches.
> +		 * Reaching into items[0].string is safe because
> +		 * we know there is at least one and not more than
> +		 * one entry (because not BRANCH_TRACK_INHERIT).
> +		 */
> +		const char *tracked_branch;
> +		if (!skip_prefix(tracking.srcs->items[0].string,
> +				 "refs/heads/", &tracked_branch) ||
> +		    strcmp(tracked_branch, new_ref))
> +			return;
> +	}
> +

I wondered when reading this if there isn't a way to merge this and the
"branch_get" call made in "inherit_tracking" earlier in this function in
the "track != BRANCH_TRACK_INHERIT" case.

But maybe not, and that whole API entry point is a bit messy in needing
to cover both the use-case of an existing branch & nonexisting
(i.e. initial creation).
