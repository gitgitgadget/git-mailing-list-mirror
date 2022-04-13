Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A94C43217
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 15:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbiDMPdG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbiDMPdE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 11:33:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702FF37A8F
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:30:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z99so2846737ede.5
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hYVdUUH8sqyXKuka0iwe1jPEIeoiZR0Kq7gC3B5hslQ=;
        b=TRUFggw3TrmRN+epfu5cd92nGzTpqSz2ycc3/twDqnGdwxDt8VaJWkdV50wr/+QWiS
         it9SCNsxfI/VXkYv/dEFy6+s+TvBYk2sYM6SZx8quV4ZA28LGR0pI1bC7w0R8BCgZFSr
         t4sZe6nulriv/sjjEExBzH+v9DTG4J+tsWvEn+tVeLDrOrtVDzEnRBjfq5u9JtnGN1bA
         GaHuAGYy1LG0XCBHfMYJKRRs/HGXfbgHUPIRuj9xiuRycWNGlG38w0MfhIzfbT00JqXG
         Iht7fFxBxpGZA7sFBOgPNN2cIZ5z81SkZtU/8LiFIkaYSLH6/5fRym1LnzwS0/N8QkTl
         pfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hYVdUUH8sqyXKuka0iwe1jPEIeoiZR0Kq7gC3B5hslQ=;
        b=id30kWFGYl9bTsoIyKAiOuBYkiWHpCN3qZh6aAqKeGA4FgIPUqshmhk0P+Q4MywY5t
         Yvm5+RZNTzD8rluOlSIgw5/FMLLVKHB5pmQf9XRmW34bNeGueZmWgqJgRp2btcsWms1t
         OA97YbGoa5yu++1pd8sKySMLPz/AwjqHRzB2UCaQcdz/ccDGUfo/N0ek5BzBvnJJXmS5
         6u+sNamRQk4jqsx/nScTWEA1rUVXfdE1fVupGKM0vP8srVTDNZpehzppfLfFfF4RNd46
         K2/6vhF1UTPUix3UfGysWIEuxzQFslcAhViY0fm5pfHMksnj7/teFkNTPruo02kYB70r
         T64Q==
X-Gm-Message-State: AOAM530R9CfHxBLDQR1cRFmomgxPk4Bpuk87s8aviK81nkciHi6stP0v
        V9GgK3hpIbGAvO0ToXm8RC8=
X-Google-Smtp-Source: ABdhPJxaah+tgA08D+HhwV9ySAvLUBv1wNkr089LtPl4XmM2thrrDGjjafNbun9B0tPszBCqVDpN2A==
X-Received: by 2002:a05:6402:4247:b0:419:3c6e:b0bf with SMTP id g7-20020a056402424700b004193c6eb0bfmr43567083edb.374.1649863841754;
        Wed, 13 Apr 2022 08:30:41 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d13-20020a50c88d000000b0041d8c0440ebsm1289181edh.95.2022.04.13.08.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:30:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neex6-0057IG-Ao;
        Wed, 13 Apr 2022 17:30:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 3/4] builtin/stash: provide a way to export stashes
 to a ref
Date:   Wed, 13 Apr 2022 17:29:38 +0200
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220407215352.3491567-1-sandals@crustytoothpaste.net>
 <20220407215352.3491567-4-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220407215352.3491567-4-sandals@crustytoothpaste.net>
Message-ID: <220413.86ilrdf1b3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 07 2022, brian m. carlson wrote:

> +'git stash' export ( --print | --to-ref <ref> ) [<stash>...]

This has whitespace-padding around "(" and ")" but the C code verison
you added doesn't, i.e.:

> +static const char * const git_stash_export_usage[] = {
> +	N_("git stash export (--print | --to-ref <ref>) [<stash>...]"),
> +	NULL
> +};

The *.txt version should be made the same as the C one.

(Spotted with an automated local check I have for finding these
differences in *.txt v.s. code).
