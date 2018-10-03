Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47231F453
	for <e@80x24.org>; Wed,  3 Oct 2018 18:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJDBrE (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 21:47:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34660 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeJDBrE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 21:47:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id q19-v6so6361916edr.1
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uLz7bMKWI7WmBNBCpcIT/Z6Vwvnzw5pPq65zc76SMBw=;
        b=kpJIsdnxPxdzu1bHbmVgYM9GlzvxwG9mc84Mk/Kag5q57+YAminqRZeYvFoUUIJ1Op
         hR2MmK1HUvBunFI9QBwWkZS4mtbcElYvnOVQR1YlIPit3klxzcMdRppeWQ0H+xrM1oAj
         kszREJVU3zj8H8KtHxV7sgFlOC8M4okVam7Eiynj842yXlA3d0G/+otWy6aFivOlELM5
         W7gPg5JQhOXarjLW5X/SBZlveiSsvjnI0hD1uwD+wOth4Ar6Ee4FACglFKcvyIleViNR
         uUhDl4H10myVeJVhecrNWNDdO2yL8S8ePrtDJr/b3RRBDFtnCblhmfa0KLQJL0fCqeRv
         3pYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uLz7bMKWI7WmBNBCpcIT/Z6Vwvnzw5pPq65zc76SMBw=;
        b=W7txoZmu1fBY31HIMsmb6arXFz+4vLvJWBlCItqnevKV80UODWzqLzMDgxJUw6r9pP
         VMUvZ7Ecu64Ff9DO/xDF46CHPlmeGC2tBsGk4q77ht1mhwAsNTwauKc6reYxkET1n9bt
         Pcenf0eLs9mh40wfLPlJdfPkBmIWSSz/XvyLmjkiC1Y5Ute2CxaSl/Ci2Vppa9mR6Ffb
         HE1NGpZXgG3C6DUHZSYIZNQkq9/Gh5dmjSEF/iy5FRNZ81/bbcn1touctXgVGqjd3kmr
         RXJGImXLt2IrCXgjsxfSYu2Ly5UhaAF5GqYZch2jcTwypfYxmMQryXP2VDyw+vKLa0DB
         i7dQ==
X-Gm-Message-State: ABuFfogdnZgwJYOgLnZsyFKvpGeGVk20HcaCHLcb1uHMUuSidePQ4oCJ
        7u/9Y9owBdzUMCoXU0kFKQ+dNnrCRGKO3sYUH+2fCg==
X-Google-Smtp-Source: ACcGV63365gOrPWb53Cke87BgGyovJ+39+J9HE3xCXB9QC3dYNWt3cnKIIUUsUVnJQCksh2G01+0c7NnRmryiUl8SjM=
X-Received: by 2002:aa7:c746:: with SMTP id c6-v6mr4134286eds.231.1538593044476;
 Wed, 03 Oct 2018 11:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180817073441.5247-1-mgorny@gentoo.org> <1538555376.1042.3.camel@gentoo.org>
In-Reply-To: <1538555376.1042.3.camel@gentoo.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 Oct 2018 11:57:13 -0700
Message-ID: <CAGZ79kZ97saPgp55mY8CPqrxQMo8cmQ+oB7moVTk3hgyRn7tZw@mail.gmail.com>
Subject: Re: [PATCH v2] gpg-interface.c: detect and reject multiple signatures
 on commits
To:     mgorny@gentoo.org
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 3, 2018 at 1:29 AM Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org> w=
rote:
>
> On Fri, 2018-08-17 at 09:34 +0200, Micha=C5=82 G=C3=B3rny wrote:
> > GnuPG supports creating signatures consisting of multiple signature
> > packets.  If such a signature is verified, it outputs all the status
> > messages for each signature separately.  However, git currently does no=
t
> > account for such scenario and gets terribly confused over getting
> > multiple *SIG statuses.
> >
> > For example, if a malicious party alters a signed commit and appends
> > a new untrusted signature, git is going to ignore the original bad
> > signature and report untrusted commit instead.  However, %GK and %GS
> > format strings may still expand to the data corresponding
> > to the original signature, potentially tricking the scripts into
> > trusting the malicious commit.
> >
> > Given that the use of multiple signatures is quite rare, git does not
> > support creating them without jumping through a few hoops, and finally
> > supporting them properly would require extensive API improvement, it
> > seems reasonable to just reject them at the moment.
> >
>
> Gentle ping.

I am not an expert on GPG, but the patch (design, code, test) looks
reasonable to me.
