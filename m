Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D038F1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964956AbeB1XUi (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:20:38 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43350 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964818AbeB1XUh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:20:37 -0500
Received: by mail-wr0-f195.google.com with SMTP id u49so4175393wrc.10
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=r3iQba0r5HnADjiz3gDwYqdDgz0/NsoBfjV1WPxkKqU=;
        b=J/Av/vB40rk8hhIL2mlWK0wUUjr9ToWw7OnSmSW3QQN8nviNgUu2JPoncCpzP7cU/X
         ELPdnc5EEOCjLnY1diamzRGBL/nYYSyIZuvUn/ZW61plU5+GXkSFq4k//jbtaQYJaL7Z
         nFRYgtQqm7RjBnKKdqGnY4w7kW4gU1+/I+Ir67hUpipfmryc0WEmofXbgtq0rQLQPThD
         z+8YWD9erf+r0QLb0GKLdt1oVpvHRWJJ72SCQbJMGW1sDFI8TxLBTAbgqS5+Olur46uJ
         ufCx8q7bz41htSa3C3s+Gc0gK++xQB8ZrCNTcqTAeeBRX0vxyCq4z/k9T9eEZInIi7PG
         KmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=r3iQba0r5HnADjiz3gDwYqdDgz0/NsoBfjV1WPxkKqU=;
        b=tajjm6dgfHzIYTZQy9UhKoIfwiCJlQDpMmexAHJopwjnk0QLJh4Ap9u38rJopuNt9o
         /1H7f97x3lOXRhPjZkrvaO0OC6jm0p+8xFnTDigE43p1k7Kx4y1aZ0neDSrfPJQ9aUvc
         /5bxIb7+hLAXH5s4WoYnfVp16PuFT2kRi0hXiVD+R91iZCApV7ERaD6SBh/THq0Gv7sp
         kfo+3VFSIVxzfU2kdYb0u5Qh3pdRTgfJab2OMgU+hSFi5zRkTCKb3RZuXB40oLVHu8Wf
         RI7ONDrzrSn5MxWcTs37HjPUud5NZ8EBwG2dToZ5Hd9vFXw+l86jwts0iSP9/WYli3ND
         ZOIQ==
X-Gm-Message-State: APf1xPAJH6831O46BBnT7wBNrBthFeNHVWfoFAktJIMGEDRu4Gkwjf90
        9otCiWYny78q8KO8OSU6UlU8N/Wi
X-Google-Smtp-Source: AH8x227ZbmDGe/DJSQjAm+zp1P2jua+o4z6/86xYTFdnM5g6zPXlqEeG7tZtF3Y1f2/a0xsKsGf01Q==
X-Received: by 10.223.184.147 with SMTP id i19mr16876104wrf.102.1519860035828;
        Wed, 28 Feb 2018 15:20:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e67sm8241855wmf.7.2018.02.28.15.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 15:20:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] roll back locks in various code paths
References: <cover.1519843916.git.martin.agren@gmail.com>
        <20180228195809.9145-1-martin.agren@gmail.com>
Date:   Wed, 28 Feb 2018 15:20:34 -0800
In-Reply-To: <20180228195809.9145-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Wed, 28 Feb 2018 20:58:09 +0100")
Message-ID: <xmqqr2p4itvh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> A further upshot of this patch is that `active_cache_changed`, which is
> defined as `the_index.cache_changed`, now only has a few users left.

I am undecided if this is a *good* thing.  In a few codepaths where
we make a speculative update to the on-disk index file, I find that
the explicit mention of active_cache_changed clarifies what is going
on.  Perhaps once my (and other old timers') eyes get used to this
new SKIP_IF_UNCHANGED symbol, it would start serving the same
purpose ;-)

> We could have made the new flag behave the other way round
> ("FORCE_WRITE"), but that could break existing users behind their backs.

Yes, that would break topics in flight that add new calls to
write_locked_index(); they want to write out the index even when
active_cache_changed says there is no update.

Looking at a typical pre/post image of this change like this place:

>  	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
>  	refresh_cache(REFRESH_QUIET);
> -	if (active_cache_changed &&
> -	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
> +	if (write_locked_index(&the_index, &lock,
> +			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
>  		return error(_("Unable to write index."));
> -	rollback_lock_file(&lock);

this certainly simplifies what the caller needs to do.

> @@ -638,6 +639,9 @@ extern int read_index_unmerged(struct index_state *);
>   * With `COMMIT_LOCK`, the lock is always committed or rolled back.
>   * Without it, the lock is closed, but neither committed nor rolled
>   * back.
> + *
> + * If `SKIP_IF_UNCHANGED` is given and the index is unchanged, nothing
> + * is written (and the lock is rolled back if `COMMIT_LOCK` is given).
>   */
>  extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);

Good.
