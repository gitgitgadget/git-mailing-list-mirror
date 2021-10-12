Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE66C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 20:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8021D60EFE
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 20:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhJLUYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 16:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhJLUYg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 16:24:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BA7C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 13:22:34 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w14so870119edv.11
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 13:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SM+raZxUZpGoQ1ILFVl+Rt26orVsgwxwbgwpqGF0ZWM=;
        b=bhlh9OtqeNLyk6cjzthWp2BW+REB3r6zOyNbXfToKoGlayfdCUsO2wTxwQ0LyQVGoO
         0EMC0YojeratgDaaENvGAGciovex0jDzO8oEOa3/w7gz/el1N3WjU65EZHsuqI1GPRTI
         EiiRAx8O1cigp6bHYg0q77tjBBfp5DJlpdJgARG/g5Cs6aX8ZIHlcNariZ4DTpPKIbb3
         klv+g5Sl5k8P74yjItJY9Wl0trm+0O7GlpjOEatmL4UoYtDfmsq9tkt09ZnpzHCW67N1
         e+NfWghVhQu7mpq0AnJ50gfPhpXYbQWn5P52nwZUbXF0EaeGZpNbtjOjsQ7/fkDuRseH
         AGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SM+raZxUZpGoQ1ILFVl+Rt26orVsgwxwbgwpqGF0ZWM=;
        b=Gt0nzkxXw2i0/UM8YYlxT55+ZkJMgbOTyLXJEjpcT8iL5309dYmxvoaxc14jrP1hjj
         33I7T7sK1VfwWKgwAdGQl1hIaJcE6s4qmTP9xFr3y99TfTdQWw2araD0LojBnZ6rzpJ0
         zMYagXuVl/Zh7UpxstpjPfPPKCr37m/+mROxSIaQYdV/VWwyZyy+4i8Yg1k/gQDVDvpL
         z+46wkyzcVs2q68FmPKro3bFM33LK2cPwWsnxJHxb7YMtrOuAoXOm4wcyy/BSoud/enh
         IOsFpEI+qvR2h+gHgBhKipeRbKTiNgz7RzqL0NGPBfMeE/99TAX/TdJ/m2lSCSBpIm/G
         ENJg==
X-Gm-Message-State: AOAM531RkVxODtABxRXCuDiFcNUXkc9b7c+ySKpub4+vWLUSWgz+2UXL
        Rdcc3mEC5TW25d0yj5kKNKIyrK4sejno7g==
X-Google-Smtp-Source: ABdhPJw3LvA1pBrX7v4RvvF33jGtDUWnaAx9fTAIicgfNQjKxbDu2XHSTpiQJzRLST9JtvkfdydPrQ==
X-Received: by 2002:a17:906:9b46:: with SMTP id ep6mr34975987ejc.226.1634070153296;
        Tue, 12 Oct 2021 13:22:33 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p26sm2358959edu.57.2021.10.12.13.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 13:22:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git.mexon@spamgourmet.com, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: don't write objects with --dry-run
Date:   Tue, 12 Oct 2021 22:17:06 +0200
References: <a2c0deed-fff3-6c1c-633f-af9dffea1e02@exon.name>
 <0131d21f-dabd-3da5-34bd-a570e990f9e0@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <0131d21f-dabd-3da5-34bd-a570e990f9e0@web.de>
Message-ID: <871r4qj8mw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 12 2021, Ren=C3=A9 Scharfe wrote:

> When the option --dry-run/-n is given, "git add" doesn't change the
> index, but still writes out new object files.  Only hash the latter
> without writing instead to make the run as dry as possible.
>
> Use this opportunity to also make the hash_flags variable unsigned,
> to match the index_path() parameter it is used as.
>
> Reported-by: git.mexon@spamgourmet.com
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Am I missing something?  Do we sometimes rely on the written objects
> within the "git add --dry-run" command?

Probably not, here's a semi-related patch of mine that never got
integrated. E.g. you'll probably find that even if you're not writing
objects we're still doing things like zlib compression here too (or not,
I haven't looked):
https://lore.kernel.org/git/20190520222932.22843-1-avarab@gmail.com/

I think the "git fetch --dry-run" command behaves like this too,
i.e. doesn't update refs, but fetches and writes objects.

For the patch I hacked up I think it's easy to argue that it shouldn't
do compression etc.

For this sort of thing and "fetch" I'm not so sure. Do we really know
that there aren't people who rely on this for say the performance of
seeing what an operation would do, and then not pay as much for the
"real one" that updates the index/refs/etc. later? Is that subsequent
"fetch" cheaper because of the --dry-run?

Maybe not, but it seems like something to look into.
