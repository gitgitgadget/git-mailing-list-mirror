Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BF201FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 18:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbdBISLW (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 13:11:22 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:35824 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbdBISKd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 13:10:33 -0500
Received: by mail-io0-f181.google.com with SMTP id j18so23538487ioe.2
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 10:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1Xg3Jacd6OhXntxqOT7FJfDoeTVfG+zff9xMNDtfvQ4=;
        b=BrjyhQIIWL/i09Ql8fNCbj7yd9o6V0xidDeVNgJNTu9Xy0QKG/LKjhGQzQrwAR7aeR
         IrASJwPdUWE4WKISK5tcMkJlbYt/2g80ru89YNDIgBcIIxlFOAy4GPG9eLmMvirKiU7C
         tdNW3SE2DNyyeY9X9cVwqtbsfUkvl8GtdnQcknjjGkqlh6wy4hGaAKZbTxG8BMdzpNQY
         WCpFFV/sscxfPVNIuRz8gs+kRp2RBg5EUMnmUravFSIk/TijKfBOF7Eex6/gwtrh6LjE
         /ELtMbGsCiHE1+zU+HSs1JjL5019muChmpImWv4/MP1p1Go2ge3TrCYWMW8ReeV3E3Gb
         aP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1Xg3Jacd6OhXntxqOT7FJfDoeTVfG+zff9xMNDtfvQ4=;
        b=TPyuMZKEVyAitsH8nzvYeSa76lDg/sjbsBbKGDU5MFtfkLJR9NrTQUceVWSsyB8jSr
         jxmqv/DbYetckUwo9pVF+kDrIgGGWzIp1lpvCNy32bc5chJqaKWM0N1OmEND2L6f9Qsh
         +Jdl8YNmvRO+DqerFeCm57FRxJU2GXh9gMU9tl7YrePLf9crVDhXDRYcGdqPc/EkjPT8
         UhNTHeWi27f+5QuGgqoOP9MPLDYYFKUX2RWWEmf9IutyHpdZkZWHMNhABtSB+v+DNrK1
         upCRLMyuZ3mpl6NSEwHChCqeWplil29MjUEjUmoc1HqWVcwLAQtBsso3o77jv4ONVQwM
         PHdw==
X-Gm-Message-State: AMke39lIXkliE8UySLICDUxwA9H2+sD6dB/hWJ09Y6DseHYZ+6eSRtVjgdbNTshFJKKOpS8n4XRQhk/JW65fjaR9
X-Received: by 10.107.3.160 with SMTP id e32mr4423805ioi.52.1486661982862;
 Thu, 09 Feb 2017 09:39:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 9 Feb 2017 09:39:42 -0800 (PST)
In-Reply-To: <024d6b2e5ca1ffa876c2911e6d9d0bb4f6091730.1486629195.git.mhagger@alum.mit.edu>
References: <cover.1486629195.git.mhagger@alum.mit.edu> <024d6b2e5ca1ffa876c2911e6d9d0bb4f6091730.1486629195.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Feb 2017 09:39:42 -0800
Message-ID: <CAGZ79kaitf2NddaKK2WQQMnU-aCEOGNGBnTjufWs9iUWwbeX4g@mail.gmail.com>
Subject: Re: [PATCH 5/5] read_loose_refs(): read refs using resolve_ref_recursively()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 5:27 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> There is no need to call read_ref_full() or resolve_gitlink_ref() from
> read_loose_refs(), because we already have a ref_store object in hand.
> So we can call resolve_ref_recursively() ourselves. Happily, this
> unifies the code for the submodule vs. non-submodule cases.
>
> This requires resolve_ref_recursively() to be exposed to the refs
> subsystem, though not to non-refs code.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Looks good,
Stefan
