Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D22DC1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 12:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJQUyJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 16:54:09 -0400
Received: from smtpbg299.qq.com ([184.105.67.99]:57582 "EHLO smtpbg299.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbeJQUyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 16:54:09 -0400
X-QQ-mid: Xesmtp5t1539781100tkpje0fed
Received: from localhost.localdomain (unknown [101.88.191.6])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 17 Oct 2018 20:58:19 +0800 (CST)
X-QQ-SSF: 01000000000000F0F5100700000000Z
X-QQ-FEAT: bNuxihfphIJFhEdRBxw25jq+n+0BXJNV/RfLvZkclTcfPXjCoBxQTZZLHleRP
        r2M99b5UrohiuYSq4NKiwasHAno4xaNr4CYa/pIeiFsB/gSsOeCUd8KkJtG7nABx1ST6qHK
        +CoFQQynzdq85bj/U6h+VO1pw0ljSmGcByhERYHQi6NsDoHG2e9f3agY9EMYvHj6xDsjtAQ
        mExQaTdtxfz6p6ftlyjAorwNwzO2P8nUkTnaaNwP5/KcB14Rj5sz/cj7/Q/Gl5PK05mieuy
        NK2XG+FLm3yLpS
X-QQ-GoodBg: 0
From:   Tao Qingyun <taoqy@ls-a.me>
To:     peff@peff.net
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] builtin/branch.c: remove useless branch_get
Date:   Wed, 17 Oct 2018 20:58:18 +0800
Message-Id: <20181017125818.1872-1-taoqy@ls-a.me>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181017083906.GC31932@sigill.intra.peff.net>
References: <20181017083906.GC31932@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
X-QQ-FName: 11615ACF54D148FE9BCB9664EEF12A4B
X-QQ-LocalIP: 10.198.131.167
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > branch_get sometimes returns current_branch, which can be NULL (e.g., if
> > you're on a detached HEAD). Try:
> > 
> >   $ git branch HEAD
> >   fatal: no such branch 'HEAD'
> > 
> >   $ git branch ''
> >   fatal: no such branch ''
> > 
> > However, it seems weird that we'd check those cases here (and provide
> > such lousy messages). And indeed, dropping that and letting us
> > eventually hit create_branch() gives a much better message:
> > 
> >   $ git branch HEAD
> >   fatal: 'HEAD' is not a valid branch name.
> > 
> >   $ git branch ''
> >   fatal: '' is not a valid branch name.
> 
> This explanation is perfect, of course. ;)
> 
> I still wondered if you had another motivation hinted at in your
> original mail, though (some weirdness with running branch_get early).
> It's OK if there isn't one, but I just want to make sure we capture all
> of the details.
> 

Yes, this explanation is perfect. ;)

> Other than that question, the patch looks good to me.
> 
> -Peff

