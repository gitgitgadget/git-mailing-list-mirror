Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8169F20D0A
	for <e@80x24.org>; Fri,  2 Jun 2017 00:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbdFBAPU (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 20:15:20 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36150 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFBAPT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 20:15:19 -0400
Received: by mail-pf0-f174.google.com with SMTP id m17so40808093pfg.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 17:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tzuVEFDSqEGdU+S82JabAPn9GKqpqtX3/2b4blN6/mk=;
        b=RKMeTYt3rc0ZoUH9Xm/Rcrid5uYr/3ScCdq49kZNMezycATSLpNuGkmkjmVfdKqlZ0
         5+8sTiSBA7dAamuUkWQyKPcBzcZqvTUk6J3nXgI3lrCVT+SyAB+PNvQJjBsilzXVryzH
         D7SWF0lb1jFc3f03FQ0fp0JzygDRJMifo5q+Eoaz/z+PNW2pDxoU136BvDgfw50wPy0l
         bpUXqaYa+LZHa008bcefDaUXewOZMydgjJq5DzxsrGLrThPeVsJip7Urltlfxyji39fC
         KAdgwizfJIkCs7tOOc6yzYRiLpZUkzbCsC9AyfEOWmIa6Jae2FuYzNgRLlGOkVNpxcU7
         oI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tzuVEFDSqEGdU+S82JabAPn9GKqpqtX3/2b4blN6/mk=;
        b=Zz3KEQiPGVz4Ow3zVuWTZz628fmRkZECL966mTi9t6361RQ+60uV4t1Bi27JAZqeel
         7XYyTP/F0Cu/71lKq6xIHO4sr/7qdxpsQqlq+PU+4WL0nDR524eAcmUJbjYWm0Ih1Nap
         aog+XMPttI3r3JAHh0ZdR4K3S3+zYm/tfiyK9BCMh8Ml6/mUDzN40LF7CRzfLXkrgR5R
         dXVnqN7iCbgE5UUBsda6Te6IMldWflkJxYDKUEIAvUCsgSomauJcyw2Lenb97MjILsy3
         JZkAqsd12uRGc7S0+g8f97kHvy5J384RpSfUYYwx4jw6WrBk/WbY0JmGiGPjufcDC2XU
         2CVA==
X-Gm-Message-State: AODbwcCMJ/VAHLPirrFzAxN5eHq0gor3IjDOfjcaKGvieCC9e+751/Tb
        XI3nJBLvkg+b+Q==
X-Received: by 10.98.43.206 with SMTP id r197mr3717854pfr.202.1496362518655;
        Thu, 01 Jun 2017 17:15:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id z3sm37939937pfk.99.2017.06.01.17.15.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 17:15:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: Unaligned accesses in sha1dc
References: <mvm4lw0un5n.fsf@suse.de>
        <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
        <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com>
        <mvmmv9st3yv.fsf@suse.de>
        <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
        <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
        <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
        <CAN0heSp9DpW4_0QL57_oAHGu+os8k6yd=Z5+0MJnaL6iXTa-qQ@mail.gmail.com>
Date:   Fri, 02 Jun 2017 09:15:17 +0900
In-Reply-To: <CAN0heSp9DpW4_0QL57_oAHGu+os8k6yd=Z5+0MJnaL6iXTa-qQ@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 1 Jun 2017 17:57:48
 +0200")
Message-ID: <xmqq37bj454a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> I looked into this some more. It turns out it is possible to trigger
> undefined behavior on "next". Here's what I did:
> ...
>
> This "fixes" the problem:
> ...
> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> index 3dff80a..d6f4c44 100644
> --- a/sha1dc/sha1.c
> +++ b/sha1dc/sha1.c
> @@ -66,9 +66,9 @@
> ...
> With this diff, various tests which seem relevant for SHA-1 pass,
> including t0013, and the UBSan-error is gone. The second diff is just
> a monkey-patch. I have no reason to believe I will be able to come up
> with a proper and complete patch for sha1dc. And I guess such a thing
> would not really be Git's patch to carry, either. But at least Git
> could consider whether to keep relying on undefined behavior or not.
>
> There's a fair chance I've mangled the whitespace. I'm using gmail's
> web interface... Sorry about that.

Thanks.  I see Marc Stevens is CC'ed in the thread, so I'd expect
that the final "fix" would come from his sha1collisiondetection
repository via Ævar.

In the meantime, I am wondering if it makes sense to merge the
earlier update with #ifdef ALLOW_UNALIGNED_ACCESS and #ifdef
SHA1DC_FORCE_LITTLEENDIAN for the v2.13.x maintenance track, which
would at least unblock those on platforms v2.13.0 did not work
correctly at all.

Ævar, thoughts?
