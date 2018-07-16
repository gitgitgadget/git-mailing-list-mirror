Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C1F1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeGPXbw (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:31:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33144 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeGPXbw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:31:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so11117000wma.0
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 16:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6QPhz+qOhEbuxzRrvi0Ao/aRZmFLq/ZxP0EKL+TBgQ4=;
        b=YzZt889r5flLbtgn0Ug5LAn7AbpQ8QETADeVNIyWJ1FwVUDMCAllKifi8Y7r5e1QFr
         LtNxsB+zvwUberrojeyQBI4dL1pgGaWJF4bP6WrnDKyCJpJxiaRcLGFA1meiInGI2PGb
         rUa1Fovoytc+D6LMkNZdVonJFstgzBads8worRrSXhr/pd0KQdoqVIGZfqAVQ6rNwzkY
         twl05LZvzypPtSzhklMl10cAISBx+1MBnl60rO550N8KKzmTZaQV7jh/o/lCel44hr+1
         9nD0Pq0tIxCAkgqlLXrS3SNNCMW3XEu18nNZWjHBzL6TGmkst77xOl+6O90fGDH7Q2i5
         u4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6QPhz+qOhEbuxzRrvi0Ao/aRZmFLq/ZxP0EKL+TBgQ4=;
        b=PvbvTTGI33Ga0bPB4xK6wzW+tIT/hU7v4rgW92FnUYkFNGPX2I81VwYQFUFVwfVRfL
         uleuKSEOC/v2YC33kENni5N7D3yX13aRfKDDxQmWPRqD6DqNKlIHNQ+6pbt1SNvpEBrn
         A4e5xR/tfvGTYHrmr1gGp94GTJLOc54+9JuOjlgdh0at3D934Bgh3HZKKYGsnCQT5N3p
         ubLORlqKeR065lJVknzNkmr7lq4M0tlWALW+z1TXw4XYYQn95rQwQ9sok2csU0RNuGBe
         hC9gJqxI7EGa22JdGtfCJbdiDDjDMLPtkPrI4rftNvfPnOsdwfQTcbphjg4re3LAEU9+
         HoPw==
X-Gm-Message-State: AOUpUlFsxE6PCm9YaSqwqhjqzuLVKVxo5ymKoSrknInROpVGjnrvp00Q
        PqJ9dPN3zjlsaGhMNpITBBg=
X-Google-Smtp-Source: AAOMgpdjlmyc2vX8N+V//FjAgpD9S5qAZ3fwmN1C2rJOdIUunfPFvovsNK2EoCCzNzymsFRnJBscIg==
X-Received: by 2002:a1c:a8d6:: with SMTP id r205-v6mr10519181wme.6.1531782136897;
        Mon, 16 Jul 2018 16:02:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v15-v6sm13280884wmc.16.2018.07.16.16.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 16:02:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] negotiator/skipping: skip commits during fetch
References: <20180716184401.168576-1-jonathantanmy@google.com>
Date:   Mon, 16 Jul 2018 16:02:15 -0700
In-Reply-To: <20180716184401.168576-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 16 Jul 2018 11:44:01 -0700")
Message-ID: <xmqqsh4irdhk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Introduce a new negotiation algorithm used during fetch that skips
> commits in an effort to find common ancestors faster. The skips grow
> similarly to the Fibonacci sequence as the commit walk proceeds further
> away from the tips. The skips may cause unnecessary commits to be
> included in the packfile, but the negotiation step typically ends more
> quickly.
>
> Usage of this algorithm is guarded behind the configuration flag
> fetch.negotiationAlgorithm.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This is on jt/fetch-pack-negotiator, but also applies cleanly on
> jt/fetch-nego-tip.

Sounds sensible.

Unfortunately, this one is among many others that get hurt by
needless semantic conflicts caused by reusing the old function name
and changing the function signature to pass the_repository thru some
codepaths, without adding transition macros.  I am running out of
time today as I need some post-office-move clean-ups before getting
organized enough, so I expect I won't be able to clean it up and
push it out on 'pu' by the end of day today.

Thanks.

