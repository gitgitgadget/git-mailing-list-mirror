Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A9851F404
	for <e@80x24.org>; Wed, 24 Jan 2018 20:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932307AbeAXUyW (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 15:54:22 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40105 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932114AbeAXUyV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 15:54:21 -0500
Received: by mail-pg0-f68.google.com with SMTP id g16so3551834pgn.7
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 12:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VwtNg4vUrrrgx+6H4Vi4jRropVpIaSZtjIJbUXJia34=;
        b=IURPRD3RTm2uVEksgAR6HIfLOiBM/sVxeSVhxfNoK/to5tH07s/T20bLdCMO0pHWdA
         2poWKtbBPYpyzUPmCVZBcrKGbXRk93wJZOtkSYVy8KdLpENRaOiwoWaaGgZpQzNxcE6t
         iiBO1KdxPtedVcQKT3BYzsOnRG4Qh+19NxHRFHRtccFGMx4a5t9sgwYMsSGmZFT8k5aX
         HOi5opaI/WXBc/nrlA26M0pbNPD1rw1x2kvpJoj4DHk9KjqZOt2bcyV82gy8BOZapt7X
         0K4Ho0EPjNjYXP/C9gtrV3dxJkknD3mbmzFTV3ArwZ4K33N81RA3gj5yw12JI/FazAW4
         ODVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VwtNg4vUrrrgx+6H4Vi4jRropVpIaSZtjIJbUXJia34=;
        b=UWSB4dcd0S4oc7Ood4dzkZg+6ifOzJZiACIleNwCNBj8tNwSvd2C+GcHRfhsOEQ81W
         C8o0/8pJZuWteD09k0qIhgaBuSW2nqPzGTjSXztQsRzi1sNjN4kMI9iSluUaZjJxrw5s
         SXuZ9G9bV8qPNpLQYyLsS0RpWv22esJpQTK9f939M3RvTQqk9njAmBZsKtdbzG7J8XdU
         qVfEO4I4heH9olpV35TVl6LmI458EnkiPeKTu2SmqC56/NHdSAYH2Cg63gb8N1SEDAWM
         ujr9J30J7aw6MPLwF1rAG2/IXVoL+Bgtxjw8KQrqvyXduDTJlIoMJchSuqj+GrxgZPuN
         nnWg==
X-Gm-Message-State: AKwxyteQ/vE9VxTfKJr1cDgT1PSUQ3YPSBWBLU2y/neZeIyP/smGPOJT
        cOpZUJfUcvpnmEcmdN8qnVM=
X-Google-Smtp-Source: AH8x224pCfLSWC2iBv//LNMfwRVhTSE/KMGzK5xFNXqy2I2NIEJHWhDSqLNvj8ZxvoApyEOz1camyw==
X-Received: by 2002:a17:902:768b:: with SMTP id m11-v6mr8928298pll.50.1516827260237;
        Wed, 24 Jan 2018 12:54:20 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id f5sm1675838pgn.13.2018.01.24.12.54.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 12:54:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/6] Yet another approach to handling empty snapshots
References: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
        <cover.1516791909.git.mhagger@alum.mit.edu>
Date:   Wed, 24 Jan 2018 12:54:18 -0800
In-Reply-To: <cover.1516791909.git.mhagger@alum.mit.edu> (Michael Haggerty's
        message of "Wed, 24 Jan 2018 12:14:10 +0100")
Message-ID: <xmqqfu6vc70l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This patch series fixes the handling of empty packed-refs snapshots
> (i.e., those with `snapshot->buf` and friends equal to `NULL`), partly
> by changing `snapshot` to store a pointer to the start of the
> post-header `packed-refs` content instead of `header_len`. It makes a
> couple of other improvements as well.
>
> I'm not sure whether I like this approach better than the alternative
> of always setting `snapshot->buf` to a non-NULL value, by allocating a
> length-1 bit of RAM if necessary. The latter is less intrusive, though
> even if that approach is taken, I think patches 01, 02, and 04 from
> this patch series would be worthwhile improvements.

I do not have a strong preference either way, but somehow feel that
this is more "coherent" ;-)  That is certainly subjective, though.

Thanks.
