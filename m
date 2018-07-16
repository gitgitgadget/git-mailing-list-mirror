Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2B71F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbeGPVhy (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:37:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36121 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbeGPVhy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:37:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id s14-v6so17245205wmc.1
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7ALmc5MoWS0qA/m9wCp7+MKoq01QY0+NTySxNpbohgY=;
        b=PpPzpWlNc+fOB+ko3PFbQVwUs7teO8EvhyFGiXp+9wL0JR61YQVFtRFZVl+bB/T5xf
         p0E71ICZw/45z8I3O2fOFpamvzfxh63RIClIFVsT3Wd2qdNAAt97OJmivkSqKXo0Vf5c
         x6y850Eq7naDlNQrj4p4HOEmbH0GOLnjly6eMZmnoocd+7906G1W+H2r7wzEX0hPCxRG
         F4UzBt2Ps2N3ua7CXInFE67mFK8dHOCf/gVJdk/sWDGx6t3ZLPOlRnLJWso2SRlVRAys
         Eq9fhoWdQcDcfUVhIMd+y8teJ78P8LCpZHXSBPbuWuAfwlnECjlkuRiQZ9y14ucSN/jY
         hS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7ALmc5MoWS0qA/m9wCp7+MKoq01QY0+NTySxNpbohgY=;
        b=rvZLDoEV2+ifRoeUwwknWa0CDjRstJULiWBUxpYk/1pWPU5x2lURDdr9gIJdv2PPvf
         hviiy+s8Q17dx4j93aiJZVQ3tl32VA0blIAz6YupxozYSfT1Q/VrRunCHysmlFqimC2N
         3x9+c/aIuz+4sS7ALGClXTi/nraiBuVsbpJ5LTFc1HsR9p9ba13RIRWUuXByL+eKJW5Y
         K17abjNUz6Tuz8hL2MYo7CdppsR+sTkLxYi6udBRweIksVSoEzlL0R65NsmG2+qhfhAR
         wMZVwzAEbajNygmOGhGiwXcF9W8tEIRKGvYR0aH1zejNqt7ERiqoHCfgZjJ3Jni624/o
         FDWA==
X-Gm-Message-State: AOUpUlG+NVUAp8/paQh8amfvY30xsHg3F3WYynKl5v6bXfFLVYW7pmdH
        zcttezNt4tJf8gmmrEsWbQc=
X-Google-Smtp-Source: AAOMgpfTwF/PPs5iSQGnXPDZj91vSvLnm1tkMZCuzG2wYhawuioslckeWiPEbxtfsyhnxcc8ZE80tQ==
X-Received: by 2002:a1c:8406:: with SMTP id g6-v6mr10130703wmd.18.1531775321843;
        Mon, 16 Jul 2018 14:08:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v15-v6sm13137871wmc.16.2018.07.16.14.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:08:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] fsck: downgrade gitmodulesParse default to "info"
References: <20180713193759.GB10354@sigill.intra.peff.net>
        <20180713193958.GB12162@sigill.intra.peff.net>
        <xmqqwotvt5uz.fsf@gitster-ct.c.googlers.com>
        <20180716183033.GA22298@sigill.intra.peff.net>
Date:   Mon, 16 Jul 2018 14:08:40 -0700
In-Reply-To: <20180716183033.GA22298@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 16 Jul 2018 14:30:34 -0400")
Message-ID: <xmqqin5esxbb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think you missed it. In the paragraph above the one you
> quoted, I said:
>
>    The cgit repository, for example, has a file named
>    .gitmodules from a pre-submodule attempt at sharing code,
>    but does not actually have any gitlinks.

Indeed.

> So I'm curious if you found the argument in my commit
> message compelling. :)
> ...
>  - I think your main concern was that there be a way for the
>    user to loosen/tighten, which there is.

Yeah, I think the solution looks good.
