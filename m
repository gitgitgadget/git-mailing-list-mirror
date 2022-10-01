Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18CFC433FE
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 18:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiJAS7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 14:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiJAS7w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 14:59:52 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C3615A06
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 11:59:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d10so6954160pfh.6
        for <git@vger.kernel.org>; Sat, 01 Oct 2022 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=sGNG9pA/72pUnQ3qhfgXwhkWlvSoBZKYwhctiV6TLeQ=;
        b=EQ3mrmzVw+8kRKftNegbVOcVWDLBd1l+14em8O3sHsB8R7KWb8h10tZ7NyCmfWH3f9
         mWbVrjAcKzdEHWRM8SbQAfA5QoCxOXexExv70IS3cWpEb8pi2VLnck8oepm6MIutHrJn
         GGlKrsJ8EXJLAQJC/vgeHVqlNTSVCC4oNHYh+wYSIIcmiBtnxUyGm1ilEXmX3XjgEnBH
         MWzD6H+rb2jt1txkGxJ907lfzMbpoRIBqPtPVISWTxqcBvFgTuGxm0eBZMYuaQ6bkupK
         xnbINMi9F3N9/sDZakh47hW1SfP0aiqRORrCy3AmKKCy5ye9LFQjSAgATT2jn2RAr12Z
         uscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sGNG9pA/72pUnQ3qhfgXwhkWlvSoBZKYwhctiV6TLeQ=;
        b=yXdu0Y8uik1/EzIgmkhAzGqHit42JwRH4PlAbTeXpp0VhJjib2f/XND0XLX0dJ5K1B
         LDo/guHRIXUYHO/BjJtuQ81i1Z4bEfo3Ev448O5/4QGgzznAqo/ogU4347XYXy5N6iRx
         ltbCFfLcwxAtv6EuhfswGZ4Ejgh/SJhk5iNrb2ZzvJh/oO0Pf1txD7cp6z+iDPzPJzXE
         k1HKind8JSHD4hXmZhayALitl+S2nfuNBQCzhLLIdaZt/4KbGkPpLnb5c1bsDc6enTn/
         hPBnHJYPzhHXFaOMvwuugsLQOfN997v7rEvLhQ1/0ipt2IZCePhZwU22oPPNGuQaNCF8
         pvDA==
X-Gm-Message-State: ACrzQf3aXefktM7u4CKqLXHM0Jkgh+CC1Day4qp8AotjGc8OQivGp7vq
        s3B64sCoT2YKNtLKo2l3M4E=
X-Google-Smtp-Source: AMsMyM6S0MApF3I6PFsIcdzrX5XBToKaW7tkf3TLhuEsJslQnjGeooR9R6cwvB1Pi5Cma27F1LPKZQ==
X-Received: by 2002:a63:3158:0:b0:44b:3b86:8e1d with SMTP id x85-20020a633158000000b0044b3b868e1dmr1557316pgx.233.1664650789014;
        Sat, 01 Oct 2022 11:59:49 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902ea1000b0017cc29a5536sm3405037plg.17.2022.10.01.11.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 11:59:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 25/36] doc txt & -h consistency: use "git foo" form,
 not "git-foo"
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-25.36-ab109f73264-20220930T180415Z-avarab@gmail.com>
Date:   Sat, 01 Oct 2022 11:59:47 -0700
In-Reply-To: <patch-v3-25.36-ab109f73264-20220930T180415Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Sep
 2022 20:07:48
        +0200")
Message-ID: <xmqq7d1j2wv0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Use the "git cmd" form instead of "git-cmd" for both "git
> receive-pack" and "git credential-cache--daemon".
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/git-receive-pack.txt | 2 +-
>  builtin/credential-cache--daemon.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
> index eec1268b10f..92452334ac4 100644
> --- a/Documentation/git-receive-pack.txt
> +++ b/Documentation/git-receive-pack.txt
> @@ -9,7 +9,7 @@ git-receive-pack - Receive what is pushed into the repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git-receive-pack' <git-dir>
> +'git receive-pack' <git-dir>

I think this, together with git-upload-pack, was very much
intentional, at least when it was written, because it is the way we
invoked the command on the other side of the connection that goes
over the wire.  I suspect git-upload-archive falls into the same
category, even though it seems to lack the dash there.

> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c

This one is reasonable, on the other hand.  That is how
credential-cache.c::spawn_daemon() runs it.
