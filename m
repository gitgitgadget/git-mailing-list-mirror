Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A80341F453
	for <e@80x24.org>; Wed, 19 Sep 2018 17:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbeISX3r (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 19:29:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:53344 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727371AbeISX3r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 19:29:47 -0400
Received: (qmail 5941 invoked by uid 109); 19 Sep 2018 17:50:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Sep 2018 17:50:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19700 invoked by uid 111); 19 Sep 2018 17:50:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Sep 2018 13:50:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2018 13:50:45 -0400
Date:   Wed, 19 Sep 2018 13:50:45 -0400
From:   Jeff King <peff@peff.net>
To:     Leonardo Bozzi <leonardobozzi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Access Git ssh on port 8822 ?
Message-ID: <20180919175045.GA10005@sigill.intra.peff.net>
References: <CACrY0PAM=Ek5T_3oYkT0zMoAsULDfu9JAYm3xJdEqaxvxpQiwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACrY0PAM=Ek5T_3oYkT0zMoAsULDfu9JAYm3xJdEqaxvxpQiwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 02:47:09PM -0300, Leonardo Bozzi wrote:

> Good afternoon, I'm trying to set up a git server, but I want to use
> ssh access to connect clients on my server, but because of a
> limitation in my internet provider it blocks access from outside on
> port 22, so I changed the same from ssh to 8822. But when I give the
> command:
> 
> $git remote add origin bozzi@bozzi.net:/opt/gitcurso
> 
> The server blocks me because I would have to access via port 8822. How
> do I make the connection correctly?

You have two options:

  1. You can use the more verbose ssh URL syntax, which allows a port
     number:

       git clone ssh://bozzi@bozzi.net:8822/opt/gitcurso

  2. You can use a host block in your ~/.ssh/config to set the default
     port for that host.

       {
         echo "Host bozzi.net"
	 echo "Port 8822"
       } >>$HOME/.ssh/config

-Peff
