Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32782ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 19:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiHaT4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 15:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiHaT4E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 15:56:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D53659C4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 12:56:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m1so19812356edb.7
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 12:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=qIzj7wtQjjhViZ9sJHLglRCVc4g7WDrNKBvmroqqxs0=;
        b=WHy+pB7o700KVroyZWN12IOMACM8dtyIPGQpX/TZfvo9KWvABeTzcfG1osjyhyH2Et
         G1iaXvSh1XaJjNngmzE0UmJEJ67WbllyKijG04cOVGMm8hV5qJFo5aH2s3QbqfPEaYXz
         qoCn7epbp1sk4hmO5OXAwrsQ31C/62KvJRUXjjGR76s2vcIFCFUgfQjrxv/S5ZSdGgRy
         tui+KH1+RA7sweMhWbgDaOV6ItIhBoeQ21P2JWUEmOxDm+lV+ChtoV6+de0axi1nGNuZ
         lMKkiBjHRfhWUhKHfz1Rw51/FKjd6SGbaaj4pk2EcuEu862fQNVaKAM6VADJIOJJRe/s
         uAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qIzj7wtQjjhViZ9sJHLglRCVc4g7WDrNKBvmroqqxs0=;
        b=L5PhS0Po0ZSoXh3AUHn/B9mMZ/Nk/7uC98iV+mXp9kmHmmKcS4mu8sY8crzo0cIbkY
         ZWryLjjs0qVJl8ELEBZGvSOMpy+t/h9JpD8kHJ2EurzR5x8JfVzm8y5lqfPINLjbhbnS
         bsXuScHqFS3Wjv0cQ3FBje3yUUXgt6iGoT2o6//PrKHk85ND8Na8y9/c9FS3rIuaz0zE
         FSLVZleSCTrwG1NGZaP9sb/X3UwumDwMQBCHKIZ0YbEUDGeFA984gM3ct2hYsPu4agwd
         57zo+ezuWcMYCUnZofZQ+z+cay96zq8H5lZcKtVoeihqEulIhZt1LVUioaCNyRaJrhEF
         YCRw==
X-Gm-Message-State: ACgBeo1Xy7/qI10p8hMpTVLE/PwvPLR2VUlCkIIPbM2dPXMif8HUhp8p
        2nONfIlipYi6H0ZB07lkay4=
X-Google-Smtp-Source: AA6agR4VDYMBAku9AecPkoHCKqbiPOUHHJNx5pfKuJ3x04CmfOuGWD7TP7IVUJyKi9vQAiV4zwak2w==
X-Received: by 2002:a05:6402:25c6:b0:43b:7797:d953 with SMTP id x6-20020a05640225c600b0043b7797d953mr26298813edb.254.1661975759823;
        Wed, 31 Aug 2022 12:55:59 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906538b00b0072b85a735afsm7547659ejo.113.2022.08.31.12.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 12:55:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTToc-000SMU-2G;
        Wed, 31 Aug 2022 21:55:58 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v4 2/4] fsmonitor: generate unique Unix socket file name
 in the desired location
Date:   Wed, 31 Aug 2022 21:49:24 +0200
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
 <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
 <2cb026a631704b004b06e4a944c79a434df08440.1661962145.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <2cb026a631704b004b06e4a944c79a434df08440.1661962145.git.gitgitgadget@gmail.com>
Message-ID: <220831.86czcg89wx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 31 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> Based on the values of fsmonitor.allowRemote and fsmonitor.socketDir
> locate the Unix domain socket file in the desired location (either
> the .git directory, $HOME, or fsmonitor.socketDir). If the location
> is other than the .git directory, generate a unique file name based
> on the SHA1 has of the path to the .git directory.

Per:

	fsmonitor-ipc.h- * Returns the pathname to the IPC named pipe or Unix domain socket
	fsmonitor-ipc.h- * where a `git-fsmonitor--daemon` process will listen.  This is a
	fsmonitor-ipc.h- * per-worktree value.

> +	git_dir = get_git_dir();
> +	sock_dir = fsm_settings__get_socket_dir(the_repository);
> +
> +	SHA1_Init(&sha1ctx);
> +	SHA1_Update(&sha1ctx, git_dir, strlen(git_dir));
> +	SHA1_Final(hash, &sha1ctx);
> +
> +	if (sock_dir && *sock_dir)
> +		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
> +					sock_dir, hash_to_hex(hash));
> +	else

But here we (from eyeballing this, maybe I've missed something):

 1. Get the path to the git dir
 2. SHA-1 hash that path, presumably to make it fixed size & get rid of
    slashes etc.
 3. Make that the IPC filename

Per the "per worktree" can't we just check if:

 * We have a .git/worktree/? If so derive the name from that.
 * We don't? Then we just have one? Stick it in in there? I.e. isn't the
   hash_to_hex() here redundant?

...

> +		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));

... but not here, so is it just for this "else", but got carried over
above?

I think if we're creating a new global cookie file, and presumably
potentially a *lot* of them in the user's ~ we should at least
prominently document that somewhere.

But more generally couldn't this?:

 * Play nice with $HOME/.config/git/ etc, as is the usual convention these days on *nix
 * We would have to the equivalent of a "mkdir -p", but if we stick it
   in .config/git/fsmonitor-sockets or something we could have a nested
   path there that mirrors the path to the repo.

The latter can really help with debugging, you have this random
.git-fsmonitor-XXXXX file, where the XXXX is totally mysterious, until
you eventually find this code & discover it's a SHA-1 hash of some other
path...
