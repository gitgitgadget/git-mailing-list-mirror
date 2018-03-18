Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D041F404
	for <e@80x24.org>; Sun, 18 Mar 2018 13:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeCRNZO (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 09:25:14 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38294 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbeCRNZN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 09:25:13 -0400
Received: by mail-wm0-f44.google.com with SMTP id l16so1376840wmh.3
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=WUiZn6NoiOXqTTuYJkmMZk3E/2SuN3IUt0woMmgqyWE=;
        b=D4lZI3vm22NP48qIbKpoczigjNC2V3UYS1LoxMRXmF1YzaDSCMqoL2qzbvPn+9Frkl
         UMZvf6jjo+MCd1hoxxxgEZTgBSom4rxF+vYb8FvZvkxCW3Xl1dhSrmjfjj/7tKyUhINu
         bxCDTbgJnAeFmvMoCpcuVXg9AAFxHqxHdg1JYIWZTmzHjEBjkco+Nd7ylg818jojEVYt
         CS5f3VL7BruIkkWaZBDBJuM51XAJB+fFxBknA+IS1WRyI6Gw9PWCpmi+QTlv7co1UvnI
         65TjD11JVX2RxN9B915P934i0D5DzrR4w1iD5t9h8gs+2ry2IzipnkeOad0zorz2dcF1
         +npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=WUiZn6NoiOXqTTuYJkmMZk3E/2SuN3IUt0woMmgqyWE=;
        b=D6Sg2+Fuaszx3Q+taB3u2BrCHorAU7fFF6brM9BusPbIPkspt+/UGETfuy+8uemU2g
         /D9WEc/g3OPJlE1Ju87Q381NUuqi1IyItdaEnTqtRpkN7qE+9awsJfUDyKU8SK6qDWqO
         ndaEKALHPDutmNqI3r0Q/rVgWxf8GjFuU+vLweyot8HFFPYsB3HPu3VCTqkOCt/4SyLb
         KFSHo/rrv4PA0gOuIa4Q3CXPo/2bAWPJW8PH7LP17NvX6yyE//7KJies/adVxMsULbXe
         JiNlP3chQFcymITSIkb+dDXy/9e6t5KBvvP3ltEO162d3nyf+k1AJizyqmauzVx4o4Fh
         M32A==
X-Gm-Message-State: AElRT7EijFyDJ+C89zxifb6RGhJmo4M1VaYOUdGFSZByjwCTlG9fx6xl
        9bm201bk1YCa3u2zE/NfY1cjSB2d
X-Google-Smtp-Source: AG47ELtusb365F17DextETwS3X51vAcGLufrx7KkcnHmjivXVujCuXr5hmLhX5cMGGmoSaINXKR8RQ==
X-Received: by 10.80.137.245 with SMTP id h50mr9995029edh.39.1521379512079;
        Sun, 18 Mar 2018 06:25:12 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id s56sm7570503edd.96.2018.03.18.06.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Mar 2018 06:25:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 07/14] commit-graph: implement 'git-commit-graph write'
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com> <20180314192736.70602-1-dstolee@microsoft.com> <20180314192736.70602-8-dstolee@microsoft.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180314192736.70602-8-dstolee@microsoft.com>
Date:   Sun, 18 Mar 2018 14:25:09 +0100
Message-ID: <87bmflcy8a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 14 2018, Derrick Stolee jotted:

> +'git commit-graph write' <options> [--object-dir <dir>]
> +
> +
> +DESCRIPTION
> +-----------
> +
> +Manage the serialized commit graph file.
> +
> +
> +OPTIONS
> +-------
> +--object-dir::
> +	Use given directory for the location of packfiles and commit graph
> +	file. The commit graph file is expected to be at <dir>/info/commit-graph
> +	and the packfiles are expected to be in <dir>/pack.

Maybe this was covered in a previous round, this series is a little hard
to follow since each version isn't In-Reply-To the version before it,
but why is this option needed, i.e. why would you do:

    git commit-graph write --object-dir=/some/path/.git/objects

As opposed to just pigging-backing on what we already have with both of:

    git --git-dir=/some/path/.git commit-graph write
    git -C /some/path commit-graph write

Is there some use-case where you have *just* the objects dir and not the
rest of the .git folder?
