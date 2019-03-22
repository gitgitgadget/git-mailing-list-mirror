Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55B6202BB
	for <e@80x24.org>; Fri, 22 Mar 2019 20:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCVUf0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 16:35:26 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46902 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfCVUf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 16:35:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E683220248;
        Fri, 22 Mar 2019 20:35:25 +0000 (UTC)
Date:   Fri, 22 Mar 2019 20:35:25 +0000
From:   Eric Wong <e@80x24.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Jeff King <peff@peff.net>, Wolfgang Denk <wd@denx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [BUG] Cloning with git HEAD fails for some repositories
Message-ID: <20190322203525.nw54axh63zq7lfek@dcvr>
References: <7e4a2f1d-2b3a-eb83-d3f1-9ac63d68991b@gmx.de>
 <20190322005107.GL9937@linaro.org>
 <017964a9-bd75-5e36-0de7-57d4467d6a7e@gmx.de>
 <20190322071231.GA26114@sigill.intra.peff.net>
 <20190322082114.BC19924013C@gemini.denx.de>
 <20190322093132.GA17498@sigill.intra.peff.net>
 <20190322165034.GA23124@dcvr>
 <3d8e8de3-9ae6-94be-7739-cb8ea79b228e@gmx.de>
 <20190322180922.nghzdmvqz7wsxcb3@dcvr>
 <78963dea-9ac8-8fd3-c3cc-6237eee6f974@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78963dea-9ac8-8fd3-c3cc-6237eee6f974@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> Yes, git HEAD + said patch works with this command:
> git -c http.followRedirects=true clone http://git.denx.de/u-boot-efi.git
> 
> http.followRedirects is documented in man 1 git-config.
> 
> Why would git prior to  17966c0a63d25b1cc2dd1e98d30873e643bd581f~1 work
> without this redirect parameter?
> 
> That following redirects is not secure is already described in
> https://github.com/git/git/blob/master/Documentation/RelNotes/2.12.3.txt

17966c0a63d25b1cc2dd1e98d30873e643bd581f predates the
requirement to enable http.followRedirects for http-alternates:
cb4d2d35c4622ec2513c1c352d30ff8f9f9cdb9e
("http: treat http-alternates like redirects")
