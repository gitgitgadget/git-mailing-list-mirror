Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F81E1FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 16:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbdFHQdl (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 12:33:41 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36334 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751614AbdFHQdk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 12:33:40 -0400
Received: by mail-pf0-f173.google.com with SMTP id x63so18909285pff.3
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yqQ+Bm1Ocfz0kifWlsnNkCpevcawZcvBsOqx/o2R9cE=;
        b=VVRHfE9Q1zv8ythwuEpWzXShL/VnyU8J33skDS976FQ6ZaIy1/SIh3Ttyi2qm6LJ5a
         mwQ98rpZBTNeaP9xmk28EeUHNHhMHkqOg/hAZB1np5Q+gdDLputs7qrveQFn6otAJhJN
         J74lQ9jdBzRyKxdaBKXkDvxx9T5jawKxvkmHlkPxbXxaZMOtEfu8XWH8jGjMmMrVS0Xz
         cPRt/thVHs7Oc1JAU+B3nk+Cqul7Ya2gWjT8QIO9zIEIxsRwZi6syQF1C0uvvam9bmz0
         dn5ZXwxcoB5agdw1H8cvXEgKyJazYkFynMKygHXaO+M4cRvZBLswYnpvP/0w9mt+XfAW
         KpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yqQ+Bm1Ocfz0kifWlsnNkCpevcawZcvBsOqx/o2R9cE=;
        b=s6jX5tqbt+qoYrvyZG+a1dq+vK9O1IfZpsBO3gWnzac0FUFvhpWibNA/BF/VDMHdcx
         1P34DSqLOPVyxWUzGaNSObbmaIsmlJ4ul304MJNj7IoUA0yIgcH76GyDXCKfKM85Iqj1
         J5fkZyH7yZJyxYTbtAQCKt6DV/j8MYPLi0qtpG0NvynGH1WrWxOugy5YRsVikIfHJiKA
         aUdW5IvOsH86rz+Z3Vm4JAR+Am7VuGrx3H9Yn8zS5/Lubn72zI/W0j3cFi6MFkdJCZlh
         aT8SgApOrpdgBRMlHNuBSBF7knEmdEBsPCM4QQEbToAQGjytpdM/4WJucGZrpSRvGUlE
         LB3A==
X-Gm-Message-State: AODbwcASzXJePS8LNALGEfnE6xN6HiaqsNpRqvoszziiYs8Ib6zxlrMe
        6tLzwCLmE88D1QMIXL616A==
X-Received: by 10.101.70.129 with SMTP id h1mr39296211pgr.50.1496939619353;
        Thu, 08 Jun 2017 09:33:39 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:4d0d:6f3d:27f:3a24])
        by smtp.gmail.com with ESMTPSA id p4sm12031677pfj.104.2017.06.08.09.33.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 09:33:36 -0700 (PDT)
Date:   Thu, 8 Jun 2017 09:33:34 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] Avoid problem where git_dir is set after alias
 expansion
Message-ID: <20170608163334.GL110638@google.com>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
 <20170607183008.GG110638@google.com>
 <alpine.DEB.2.21.1.1706081225450.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706081225450.171564@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Wed, 7 Jun 2017, Brandon Williams wrote:
> 
> > Looks good, I don't have any major issues with the series, just some
> > comments for clarity mostly.
> 
> Thank you for the review!

Of course!  I've been poking around the setup logic so this was
interesting to me :)

> 
> I will wait a couple of hours to see whether anybody else sees anything
> that needs to be changed, before sending out v2.
> 
> > And relevant to this series, you may be interested in looking at patch
> > 03/31 in my repository object series as that may have an impact on the
> > early config stuff.
> 
> Thanks for the prod. I will have a specific look at this patch right after
> sending this mail.
> 
> Ciao,
> Dscho

-- 
Brandon Williams
