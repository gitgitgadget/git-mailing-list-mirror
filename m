Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F131B1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 21:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfGKVOm (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 17:14:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36589 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfGKVOm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 17:14:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so3329073pfl.3
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 14:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QIObtfdC/IfQWorPRReLOEgDOUKLaxWde0hheFAwN3Q=;
        b=u9xxAziAPxFKM+/Odvca3vQAGb7o+qZkYKn17AGOl/m+QnlM3MVpyDe++veBzYd6/H
         g3LWJ84G2reV6f5DGu1cBe5nNFW7LIudRUdnfjcyuyclAtwPTfARRHqMrX4XHrWDMPmg
         F9Pidt35mpR+25rG1wUp4dhs12/UwoITEm/jLFr9Qehuxj8zdH4qCGpm69NuLWSeDg2C
         isynXlM/CXQpVrJlQPA+VEWUYFzpAyXCRseLqTvpQ5Uibp2iuhwBi1t982mlvX+pCumW
         GxHt5oR7jSGaCv3/dbIvB+TlN+erjpTWPuGPTHkONUMWvl8hjmcTRC3QZGhhjfaI9LKG
         0SwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QIObtfdC/IfQWorPRReLOEgDOUKLaxWde0hheFAwN3Q=;
        b=t3Msz5m5Ju3cAgsX+UADpw98UDVgV9jSOUKckzlYE4Dwq18/knxLHpSOKsy8e5NT4J
         D1a7k3TwpJnAD2CjOYNTzEvHsVYEFoU3d/lxSeRCjSft+P0wukJ7E8I3W3Bg1IBFiOJU
         xAjWG8p1y0xDEztRnjs2fMblANG9OEmYxzQWLH8zGxloU+8g96Z04DP4Lz/wzrEayQjo
         d8fY4QroirLUuayZJpkSUyHea0Yg31FLU3Oh2gpeQefhe6vSi+9A0qaX1zXFbF/1EfaJ
         09xjmMvE+EhX+KoSAneFqi0vvx+F2QYLBJ01XRZj8mHSL7/njzNogau+jWG2TrJPGrqz
         Xgcg==
X-Gm-Message-State: APjAAAXTMOAZTaBJmIhEw3lBZ5wDGDFBDz08un5OUzmzaCsajiqANmhf
        f11coh/8WSAI52zl/Wn0GOWuFEjq27qsxg==
X-Google-Smtp-Source: APXvYqwLPNvsNkOBAtuTti/pGqWcAEV90nn46iqeQKtPC1VeHG1qZIqcgjjBq/hSGS8HRDMggoLJ4A==
X-Received: by 2002:a17:90a:a613:: with SMTP id c19mr7325267pjq.17.1562879681355;
        Thu, 11 Jul 2019 14:14:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id i126sm6550374pfb.32.2019.07.11.14.14.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 14:14:40 -0700 (PDT)
Date:   Thu, 11 Jul 2019 14:14:36 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in
 push_refs_with_push
Message-ID: <20190711211436.GE113966@google.com>
References: <20190709211043.48597-1-emilyshaffer@google.com>
 <xmqqpnmhu6mh.fsf@gitster-ct.c.googlers.com>
 <xmqqims9u679.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqims9u679.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 10, 2019 at 10:53:30AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> +	# the new branch should not have been created upstream
> >> +	test_must_fail git -C "$d" rev-parse refs/heads/atomic &&
> >
> > The new branch should not have been created; if this rev-parse
> > succeeded, it would be a bug.
> 
> One thing I forgot.  If refs/heads/atomic did not exist, but say
> refs/tags/refs/heads/atomic did, the rev-parse would succeed, which
> is a rather unfortunate source of confusion.
> 
> Of course, we know we have never touched "$d" to cause such a funny
> tag, so rev-parse is good enough in practice, but
> 
>     git -C "$d" show-ref --verify refs/heads/atomic
> 
> would not dwim (its --verify mode was invented specifically for
> rectifying this issue with rev-parse, if I recall correctly), and is
> more appropriate best-practice version to write here, especially if
> we anticipate that future developers and Git users would treat this
> line as an example to mimic.
> 
> > Up to point, I have no possible improvements to offer ;-)
> > Very well done.
> 
> So, I lied, but still the tests looked quite well done.


Oh, that's very interesting! Thanks for pointing it out. :)

Reroll coming in a few. Thanks, Junio.

 - Emily
