Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0634E1F424
	for <e@80x24.org>; Thu, 21 Dec 2017 19:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbdLUTaC (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 14:30:02 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:45620 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752522AbdLUTaC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 14:30:02 -0500
Received: by mail-pf0-f182.google.com with SMTP id u19so14328495pfa.12
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 11:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=hQ7Aoc3X6KSBZ1/gRoEYwuXQVa3XOi/3o3BiIqaDFVE=;
        b=yqLvTQl98LugfZ3dO5Qx4c34Ji1pP3csAgjD7wHMnA2dQyTjGSRL0+CL+lWYyeNNYF
         xXRm23zbRL02gyAocKykyigfOUU4mFGXd4AleMoYmciteEdme7/HjFIVmQ+d9Em0jasR
         kQ8sliJjNTISyz8v51zCYjs9VCgWPiHo4H77g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=hQ7Aoc3X6KSBZ1/gRoEYwuXQVa3XOi/3o3BiIqaDFVE=;
        b=VUiUKI6yYRFNRoeutd7dLzFv9UIAM3wwC+qI6S/nzdZuTW4ytKgER14eyoVREIU+m+
         vjLqaGjykRvEnYrCNQKjQpaiE9PSb/Vvc0un42aT/pEOjimGJvI5XXq+3WxKhJwioyYj
         6lnHH4yVMMpA2irXGwCb4FcDQav0kCdYqKC3mddk7RHMR/uhVGrB84yhUDliulymlxTD
         0aOf7YuALlOhODb/IcUh4Bu5FRCHfRTcuShr3lMj+MG1uPyXXF1ja7IOhvjrCd+Ca2+r
         tHiE0fPyBlWoHLsRFxBru9f2YOlB/F8QE0pbNA/4B3u3gbj3wRFmq5mgdUpXNbKomqOb
         ajqA==
X-Gm-Message-State: AKGB3mI4G+vhLkLF3jvzl30k/85g01eFaqSLivTs4IG9Y4UeVm2Qz5A/
        hwWIxCXtFh0bzGjg6nKhBqqH6Q==
X-Google-Smtp-Source: ACJfBosj1b/3hEgJwCzCVnvcAF1TH21JIHanh0EtLCXJwbcsZKUM4EiFbjGRNdIeo3SfOmgolge7Rg==
X-Received: by 10.99.36.195 with SMTP id k186mr10162892pgk.171.1513884601409;
        Thu, 21 Dec 2017 11:30:01 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id l14sm34194238pgn.9.2017.12.21.11.30.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Dec 2017 11:30:00 -0800 (PST)
Date:   Thu, 21 Dec 2017 11:29:46 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>
Subject: Re: [PATCH] Makefile: replace perl/Makefile.PL with simple make
 rules
In-Reply-To: <20171130213105.GA8861@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.10.1712211126470.4980@alexmv-linux>
References: <20171129153436.24471-1-avarab@gmail.com> <20171129195430.10069-1-avarab@gmail.com> <20171130213105.GA8861@sigill.intra.peff.net>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-723938442-1513884587=:4980"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-723938442-1513884587=:4980
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 30 Nov 2017, Jeff King wrote:
> On Wed, Nov 29, 2017 at 07:54:30PM +0000, Ævar Arnfjörð Bjarmason wrote:
> 
> > Replace the perl/Makefile.PL and the fallback perl/Makefile used under
> > NO_PERL_MAKEMAKER=NoThanks with a much simpler implementation heavily
> > inspired by how the i18n infrastructure's build process works[1].
> 
> I'm very happy to see the recursive make invocation go away. The perl
> makefile generation was one of the few places where parallel make could
> racily get confused (though I haven't seen that for a while, so maybe it
> was fixed alongside some of the other .stamp work you did).

As a datapoint, I've seen it fairly regularly with -j8 in 2.15.1
builds from a clean tree that I've been doing recently.  I'm looking
forward to not having to make the choice between "maybe run it twice"
or "compile slower" -- this looks great!
- Alex
--8323329-723938442-1513884587=:4980--
