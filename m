Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD741C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 03:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242783AbiFODeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 23:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242442AbiFODe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 23:34:29 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C184326AE4
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 20:34:28 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t24-20020a170902b21800b00168e27c3c2aso3894175plr.18
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 20:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=fU/nyKw/TdmxWmXnVtUIHzIDZXI/vY1qlXwnOCXnEuE=;
        b=b8lra30Xv3oio+K+mOTjdOyfVv58OfGOwu7NcRCFE1hVwgWHhy7ZYmrkbDDexdaQnr
         n8/ydYKmNVeKtNLBwsaoVyut6wr7rDM/gLtP5chJcmXQjTeUtpVLu6RusXlsxja5pK36
         G08it6Kjwh6dSxjKKKRf9w2qxDcpvIXtZhrBWb16H9GmVU8kfIlJSyBytRzvDn1H7Jzm
         exOLVX+hqBeoqtcYiJssrQFdGQcHKluRVoShFtjwN1K6AlMB4xqa+0lUuaBz3dBuUtqe
         tfXgO/KvBLIgeNiGvvCUKGYz1Zm61MTxGkt78o58K4QfHY6hIxfMAURmsz10b7r3+iO4
         BTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=fU/nyKw/TdmxWmXnVtUIHzIDZXI/vY1qlXwnOCXnEuE=;
        b=C212PNBPKt3Qd3TTDz91UZ0dblleeTw0mpaU8GV71vM6Sy7Hx8xA6Rg/AjkH5rm66h
         RyPpe3KvaYUfZyEKk/RGxzgWx0USYgZ3GyQrUH8vZU5AwASemKQhOC2iSibju0BufLHI
         UHzhCNeK/5/w2oQbsyvtZcCeVN8J/+uBCfNSZuLaZPamXPuoWyOqdbbl6rWrWU84L3C+
         4I93uwGhmDN7cy4NwEzEP6WhI2pvjUoovUEAFajGitR2brAXhcB8MOT8wShLjLo/xHac
         hhsRNLhlvYROLYxw/qJI8J7lZq9PpneLkh7OdWtb4ugCtEAmPFUnpF+w0IUBms4tbBKK
         ALtw==
X-Gm-Message-State: AJIora/WJFzU7L0+z1rocTGEIBWHqwdbBXJShI/xADzX7Htvvko5UuL1
        rVoZhKI2YrJcYW0UuLXuQWL9wIpDBvc6fg==
X-Google-Smtp-Source: AGRyM1udib+C77ujt7T6CNdEKQw2wOvVbokopCnyN0cpiN5HglWdh/itKARFujz4s0YydrvZPnLFGu02JNiV7A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:df91:b0:1e3:4dc8:46e7 with SMTP
 id p17-20020a17090adf9100b001e34dc846e7mr7840322pjv.106.1655264068234; Tue,
 14 Jun 2022 20:34:28 -0700 (PDT)
Date:   Tue, 14 Jun 2022 20:34:20 -0700
In-Reply-To: <patch-v2-08.12-99ac52d810f-20220613T220150Z-avarab@gmail.com>
Message-Id: <kl6lfsk661mr.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <patch-v2-08.12-99ac52d810f-20220613T220150Z-avarab@gmail.com>
Subject: Re: [PATCH v2 08/12] submodule--helper: report "submodule" as our
 name in "-h" output
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Change the rest of the usage output for "git submodule--helper" so
> that it will pretend to be named "git submodule", which it already did
> e.g. in the case of "status", "deinit" and "update".
>
> This will allow us to eventually dispatch further into "git
> submodule--helper" from git-submodule.sh, while emitting the correct
> usage output.
>
> This does make the usage output of "git submodule--helper" itself
> "incorrect", but since nothing user-facing invokes it directly it
> makes sense to continue to elide that difference entirely. A user
> isn't served by us exposing this internal implementation detail.

Everything up to here makes sense. I agree that "git submodule--helper"
should have been pretending to be "git submodule" wherever possible.

Before now, it probably didn't matter much because it's quite hard to
get "git submodule--helper" to print usage without being first
intercepted by "git submodule", but we'll need it now. Which brings us
to..

> This fixes a bug that's been there ever since "git submodule
> absorbgitdirs" was added in f6f85861400 (submodule: add absorb-git-dir
> function, 2016-12-12). Before this we'd emit e.g. this on invalid
> usage:
>
> 	$ git submodule absorbgitdirs --blah
> 	error: unknown option `blah'
> 	usage: git submodule--helper absorbgitdirs [<options>] [<path>...]

We actually used to output the internal-only name of the
submodule--helper subcommand, i.e.

  git submodule--helper absorb-git-dirs

with the dashes.

> Now we'll emit the same, except that the usage line is now referring
> to the correct command run by the user:
>
> 	usage: git submodule absorbgitdirs [<options>] [<path>...]
> 	[.. same usage output ...]

I initially wondered why "absorbgitdirs" deserved a special shoutout
when we are changing several other subcommands in the same patch, but
it turns out that this usage string bug probably is
"absorbgitdirs"-specific.

"absorbgitdirs" is the only subcommand that doesn't have an options
parsing loop that catches invalid options, it's just:

  cmd_absorbgitdirs()
  {
    git submodule--helper absorb-git-dirs --prefix "$wt_prefix" "$@"
  }

whereas in other subcommands, invalid usage would be caught by by the
options parsing loop and we never invoke "git submodule--helper blah".
As a result, "git submodule--helper absorb-git-dirs" is probably the
only subcommand that prints its usage string (instead of the generic
"git submodule" usage string.)

It might be worth highlighting how absorbgitdirs is special in the
commit message, but I don't feel strongly either way.
