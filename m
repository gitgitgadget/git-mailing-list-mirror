Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDB581F516
	for <e@80x24.org>; Mon,  2 Jul 2018 18:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeGBS12 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 14:27:28 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:39221 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753158AbeGBS11 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 14:27:27 -0400
Received: by mail-yw0-f194.google.com with SMTP id 81-v6so6997832ywb.6
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1gYFKRMaTPzsnWagn1cZDQgHvlSKoMoIoqqZys5DJU=;
        b=VjU5jfKqPdYgymFpMEWB3lcWfPwMYu15slYY1JyQ7IcxRmRoXMXqo8laRDirzBHi/o
         tVuXpHmFa4MMkgeUIzIYQv0+zV1b6OjjKBCp1wl96opOq7Bp5IfnTtq52QxERzBZgDCk
         CIb5Rh77oUmuGQsin1xsmGWhGhrug/YgC7Pd/5wWoy4135VOywaidzjBq6tmrFbwm8Xr
         pyrQ7BvEnrQZ7DGrYLv2OyUy9Rbwnm++nLokDj7VTjJw+sfBeePhbWCX33n+31iSl2LA
         O8uonJbyXzZA3DjH86OtcULWAbMNBCiYzssB380TFU4XJLNiCVelJC0PCA08teA7KKdR
         J2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1gYFKRMaTPzsnWagn1cZDQgHvlSKoMoIoqqZys5DJU=;
        b=Fe0eJVhzpjvJswNydq7V4+wh9su9IVMVE+Big3Zo3kXBy2CpKMTyVIpUPtmzX+KEs/
         9K3AoyXE8hS+wpdJmotR4PRHf2pXlVkP72FeZjbX3ujUFlyMYRY4vMDjy4kR+EHIKrll
         OJbnsI6iB9NNXXuOBwnJTCh7bOoBi+C1fqcMVcoAGPbTJnZSyCbD/CwkU8MJcPz47a0b
         u1X4wEbEhD+4sCIWRqfmnIhL58DxEBC3wVLdICQ18MC51eI9NNrdfXErfoOHt9irLwPR
         Bzk+5E/t0MbHDeIeYuiW/drV04wLZUEXyYGdc9VdFA/dAuEQqovd5pg+enGFLloPHDM6
         l+nw==
X-Gm-Message-State: APt69E3GKYaefDEei7eQm02oKZoYPFud/vSrXQ6piJrW97es7vS+whY2
        OLYOoD3ZBwX8Besi9DhTrv9DVHzhNbvQTQ29UUHPjw==
X-Google-Smtp-Source: AAOMgpdnz8A9zF3Tas2Gy1VhRvDLT7BJk4NdVDFz8mQgHiB/+0Mtnxd1FSyyDZh8NtSZc8bQNEIMnABH/GusRjpLvSQ=
X-Received: by 2002:a81:b283:: with SMTP id q125-v6mr13166339ywh.414.1530556046234;
 Mon, 02 Jul 2018 11:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180702002405.3042-1-sunshine@sunshineco.com>
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Jul 2018 11:27:14 -0700
Message-ID: <CAGZ79kZXhZyhDL_+cFK6BzL-RL7Ac0zKeKux97v9shc+qm+nOA@mail.gmail.com>
Subject: Re: [PATCH 00/25] fix buggy tests, modernize tests, fix broken &&-chains
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 1, 2018 at 5:24 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> This series fixes several buggy tests which went undetected due to
> broken &&-chains in subshells, modernizes some tests to take advantage
> of test functions (test_might_fail(), test_write_lines(), etc.), and
> fixes a lot of broken &&-chains in subshells. It applies atop
> 'master'. Happily, there are no broken &&-chains in subshells in any
> in-flight topic.
>
> It is split out from an earlier series[1] which additionally extended
> --chain-lint to work within subshells. I decided to make this an
> independent series because these (hopefully) non-controversial changes
> all stand on their own merit, and because I don't want to flood the list
> repeatedly with this lengthy series as I re-roll the "extend
> --chain-lint to work in subshells" functionality from [1].
>
> To ease review burden, I largely avoided noisy modernizations and
> cleanups, and limited changes to merely adding "&&" even when some other
> transformation would have made the fix nicer overall. (For example, I
> resisted the urge to replace a series of 'echo' statements with a simple
> here-doc.)
>
> Changes since [1]:
>
> * Found and fixed more &&-chain breakage, and converted a couple more
>   'unset' instances (which were hidden behind a MINGW prerequisite) to
>   sane_unset().
>
> * Rewrote commit messages to sell changes on their own merit rather than
>   leaning on --chain-lint as a crutch. (junio, jrnieder)
>
> * Changed a modernization/cleanup to use "! non-git-command" rather than
>   test_must_fail(), moving it to its own patch in the process. (j6t)
>
> * Changed "printf '%s\n'" idiom to test_write_lines(). (junio)
>
> * Incorporated Stefan's fix[2] for a broken 't/lib-submodule-update'
>   test since my interpretation of the problem was incorrect.
>
> * Converted a subshell 'echo' sequence to write_script().
>
> * Dropped patches which existed primarily to pacify --chain-lint; they
>   are no longer needed since I re-wrote the "linter" to detect &&-chain
>   breakage itself (by pure textual inspection) rather than by
>   incorporating subshell bodies into the main &&-chain:
>
>   t0001: use "{...}" block around "||" expression rather than subshell
>   t3303: use standard here-doc tag "EOF" to avoid fooling --chain-lint
>   t9104: use "{...}" block around "||" expression rather than subshell
>   t9401: drop unnecessary nested subshell
>
> * Dropped a patch which pretty much duplicated Junio's 037714252f
>   (tests: clean after SANITY tests, 2018-06-15), which graduated to
>   'master':
>
>   t7508: use test_when_finished() instead of managing exit code manually
>
> An interdiff against [1] is below, although I stripped out all the noisy
> "printf '%s\n'" to test_write_lines() differences, of which there were a
> lot, since they drowned out the other more significant changes.
>
> Thanks to Elijah, Hannes, Jonathan Nieder, Jonathan Tan, Junio, Luke,
> Peff, and Stefan for comments on [1].

Thanks for this series,
I think it is good to include it as is and build on top if needed. I had some
comments on the earlier part of the series, but that is really just the cherry
on top of the cake.

Thanks,
Stefan
