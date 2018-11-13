Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E8A21F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 22:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeKNIPn (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 03:15:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32892 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeKNIPn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 03:15:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id v68-v6so6790203pfk.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 14:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZH0kHWdjozJOSUR6ZTIFk5dSb6g/sJGzhJycbBb0RH4=;
        b=WJp3GIkL+vz5TCGD9d5X/Ct4e4C+eqyzwlNLnBU0rflth75Xz15bN2fK2+Biq8IAdO
         AVfey6K5k7EwJnNQQg+OMMyOiNwKaTtLd5Nf3MCumMwpD/mK6xW0OwttoX3DH148ZYXF
         TzTnS0NP0lQMXV4GkI30mdGwXLyWCVRcQsoPKuEWMMTJhSrtHEQ23NlxeF/OOon77udE
         ud/OQjlRh3w6PagQpRufK9uhgPKYUX2hqo3mBn4j3ruMGAV+4ovJya8T6EcMW4/N+/KZ
         Vqf6uGQOea8kyXYIkVF7b/o43BSCgUNj2Drlhg6g8ip0X+9a1kdFqjtToc4tB58K+Ve2
         rk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ZH0kHWdjozJOSUR6ZTIFk5dSb6g/sJGzhJycbBb0RH4=;
        b=YRe0UVOsSiCHTMgU3cj8Nbzv/dIkvG0DwNGAk7z4RjI4wO+BfgjDISlijcjJdCOnVI
         +DDNuSnMalb2oeJvaFkkTTOFHTIxVRkZX6J/5ExRflg4cqB2i5k1T+tVeLBJJHnRpT9z
         917OHfKZ2HdMiFjNY0w8c/WOI97XUfU4Qa+Z7pCOhXDMgdP/tdpyTpotvDsni3OB1cjS
         bWVgluMth9S9Z4o+7vDCVPgnEjsdFEAqppwzM1HqdI52ugYkwNr8d1tWRuq2aiWj4ZSo
         RmtvhzoD+Hev2mEpUtFB39IKBTBGOFG8LgEMKacb8REo8RTVoKeLQbN7CAzoLaH84WQn
         OenQ==
X-Gm-Message-State: AGRZ1gKSmDYfRgl2K+Cs5BzbtF9GCTDc1uBPiVzFxsXGhONTwLMUQCfd
        Gedn5ZXKCStlltuLYoEt8GMJ8gbxY2WROQ==
X-Google-Smtp-Source: AJdET5f5IAtm5I0j4vLya5nDvlrF52Y+708wZz3dLFGlCMkAgYUCeULA1UxH+SgP8ulla+CLcONx8g==
X-Received: by 2002:a62:b24a:: with SMTP id x71mr5294824pfe.148.1542147330053;
        Tue, 13 Nov 2018 14:15:30 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id 5-v6sm25998145pfg.141.2018.11.13.14.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 14:15:28 -0800 (PST)
Date:   Tue, 13 Nov 2018 14:15:22 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: die on server-side errors
Message-ID: <20181113221522.GD126896@google.com>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
 <xmqq7ehhy91z.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7ehhy91z.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.13 12:02, Junio C Hamano wrote:
> steadmon@google.com writes:
> 
> > When a smart HTTP server sends an error message via pkt-line,
> > remote-curl will fail to detect the error (which usually results in
> > incorrectly falling back to dumb-HTTP mode).
> >
> > This patch adds a check in discover_refs() for server-side error
> > messages, as well as a test case for this issue.
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> 
> Forgot to mention one procedural comment.
> 
> As you can see in the To: line of this reply, your MUA is placing
> only the e-mail address without name on your From: line.
> 
> Preferrably I'd like to see the same string as your sign-off on the
> "From:" line in your messages for a bit of human touch ;-) Can you
> tweak your MUA to make that happen?
> 
> The second preference is to add an in-body header (i.e. as the first
> line of the body of the message) so that the body of the message
> starts like this:
> 
>     From: Josh Steadmon <steadmon@google.com>
> 
>     When a smart HTTP server sends an error message via pkt-line,
>     remote-curl will fail to detect the error (which usually results in
>     incorrectly falling back to dumb-HTTP mode).
> 
>     This patch adds a check in discover_refs() for server-side error
>     messages, as well as a test case for this issue.
> 
>     Signed-off-by: Josh Steadmon <steadmon@google.com>
>     ---
>      remote-curl.c                   | 4 +++-
>      t/lib-httpd.sh                  | 1 +
>      t/lib-httpd/apache.conf         | 4 ++++
> 
> Either way would make sure that the resulting patch's author line
> will be attributed correctly to the same identity as who is signing
> it off first as the author.
> 
> Thanks.

This should be fixed for future patch submissions. Thanks for the
heads-up.
