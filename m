Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759FF1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 23:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJRH2A (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 03:28:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40653 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeJRH2A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 03:28:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id r1-v6so26515201edd.7
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 16:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eNqLDB+bX475bLgVUmfPBOm5SdDbLryUnbioUoF0MK8=;
        b=dxzRJrIXR0Z3WgzBJ8xEw+B+iD1xXEt1sPNHVkZBpxQ4xgiBONKNsvxmeHCu+df6Tf
         HnHzKIHVdlsjvaa3W/mBuUZcF/MAAEAr75PNqfpBQTXssDeJg9kP/FAg35ovSub8I4jF
         fuIQXLdwjOjLErO32a8ARjqX/stKtIWwTCm88quSmBFIauY++pjTp0jyBOVFTh4Z8yve
         U7LhcHKy+5N6dgHqd/3SURo8/nKKKQ/kxtJ3rLLC92kVVxPTv2m90/7i6NakTDUZQ4g6
         TveSqnlHzQhAptVlpZ/oswExPD07g+9B4NzLomCniB+8nVxULRraQD6LNVfXoOv1EWdw
         WExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eNqLDB+bX475bLgVUmfPBOm5SdDbLryUnbioUoF0MK8=;
        b=cvLdgjFxhnk8XWGGll56W1JyKfFIm3AdBw/ZxpwqIzKyXmeia0zdBaCXGFGXCbCgJ5
         nE4V50iotxiv9/dsgo0LWY09HGoEJ4jku5/OV9tVT4RFonSjMz9zV9pqtGDQXkGpcGfw
         c8KdWcWo/A7DtthD4Gd9fWlzDmZtHuaWs1Sf33+g9MlVTFE9nlWGR/EwiLrpoWFRkMY4
         xFoBKzhcFs3EOjMtAayGwJqdORnhepfGYBev3/yip3Q9gppuUTgng9hiRKUcPnfLkyWm
         h15iS0/zVhD1mI0O7OlvuAvmZLCsA9vaXeqguvnp4qr6z8iGDLxNkL2W170l3INuqOxM
         BwSQ==
X-Gm-Message-State: ABuFfohGwwhG2B0C0DszqKGuGpwxPBidFeoeZaOYwNgVndcbSJgMATjw
        K/lGG0eZMf55fb31N4LwoBw=
X-Google-Smtp-Source: ACcGV63ro0ifWet2QX0qaH1hePnOtkdQeZje9TsmN+101yoyM3iErYHCw+/Dq3nJNZ+4Ylzrp6hICg==
X-Received: by 2002:a50:862e:: with SMTP id o43-v6mr1765803edo.209.1539818996141;
        Wed, 17 Oct 2018 16:29:56 -0700 (PDT)
Received: from szeder.dev (x4db11ffa.dyn.telefonica.de. [77.177.31.250])
        by smtp.gmail.com with ESMTPSA id o13-v6sm3845809ejb.34.2018.10.17.16.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 16:29:55 -0700 (PDT)
Date:   Thu, 18 Oct 2018 01:29:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 09/13] git-p4: use `test_atexit` to kill the daemon
Message-ID: <20181017232952.GT19800@szeder.dev>
References: <pull.31.git.gitgitgadget@gmail.com>
 <pull.31.v2.git.gitgitgadget@gmail.com>
 <3e2193a73de0b68d5a38f1792642c828f4aed1db.1539598316.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e2193a73de0b68d5a38f1792642c828f4aed1db.1539598316.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 03:12:11AM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This should be more reliable than the current method, and prepares the
> test suite for a consistent way to clean up before re-running the tests
> with different options.

This patch makes the test suite hang in all four Travis CI build jobs
with P4 installed without any of the P4 tests finishing.

Reverting this patch from the whole patch series makes it work again.

I've also tried to revert only this first hunk of the patch below,
because based on the comment I thought it's worth a try, but it didn't
really help.  It did make a difference: the 300s watchdog timer
eventually kicked in, and then the test scripts could finish
successfully...  but there are a lot of P4 test scripts, and with each
taking 300s the build job still timeouted.

All this may (or may not) be related to and be a different symptom of
the leftover p4d processes Luke mentioned.  I couldn't reproduce any
of this on my machine so far.

> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index c27599474c..f4f5d7d296 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -74,15 +74,6 @@ cli="$TRASH_DIRECTORY/cli"
>  git="$TRASH_DIRECTORY/git"
>  pidfile="$TRASH_DIRECTORY/p4d.pid"
>  
> -# Sometimes "prove" seems to hang on exit because p4d is still running
> -cleanup () {
> -	if test -f "$pidfile"
> -	then
> -		kill -9 $(cat "$pidfile") 2>/dev/null && exit 255
> -	fi
> -}
> -trap cleanup EXIT
> -
>  # git p4 submit generates a temp file, which will
>  # not get cleaned up if the submission fails.  Don't
>  # clutter up /tmp on the test machine.
