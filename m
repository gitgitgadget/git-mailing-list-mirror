Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CE792022A
	for <e@80x24.org>; Tue,  8 Nov 2016 16:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754030AbcKHQtp (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 11:49:45 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:46188 "EHLO
        mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753929AbcKHQtc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 11:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=jump-ing.de; h=subject:to
        :references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=k1; bh=p/IhqjSCKhcYjI
        4p7LIbt86+mOIBuqY+OHw4uOoklIQ=; b=vYRYgWdczeIshrA/w2g3hR9e07VUGu
        boXjWmyDPoj4e1CoBpgjjGl4r2h/TB6TNJckL/3UK5RfUoJNbiuKEicGImOECMGN
        hUzvy6qJJOVmFnTynQdotvMfhbJXFky41KshV79Pz6AoqITWq4Fc+iIkiFBsVUs8
        UmonMhfhkojJ8=
Received: (qmail 32517 invoked from network); 8 Nov 2016 17:49:27 +0100
Received: from hsi-kbw-37-209-119-31.hsi15.kabel-badenwuerttemberg.de (HELO ?10.0.0.102?) (ud03?291p1@37.209.119.31)
  by mail.ud03.udmedia.de with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted, authenticated); 8 Nov 2016 17:49:27 +0100
Subject: Re: Bug: git config does not respect read-only .gitconfig file
To:     Jonathan Word <argoday@argoday.com>, git@vger.kernel.org
References: <CAD9aWChH14eviop=0_Ma_2Pa-2OyWJp9KjimH8dyqy-XDn9Rhw@mail.gmail.com>
Cc:     jword@bloomberg.net
From:   Markus Hitter <mah@jump-ing.de>
Message-ID: <40608c85-f870-87f7-daee-7fa98f5d19c1@jump-ing.de>
Date:   Tue, 8 Nov 2016 17:49:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAD9aWChH14eviop=0_Ma_2Pa-2OyWJp9KjimH8dyqy-XDn9Rhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.11.2016 um 16:22 schrieb Jonathan Word:
> Proposal:
> 
> Part 1) Add a .gitconfig variable to respect a read-only gitconfig
> file and optional "--force" override option for the `git config`
> command
> 
> Such a gitconfig variable could be defined as:
> config.respectFileMode: [ "never", "allow-override", "always" ]
> [...]
> Thoughts?

I'd consider disrespecting file permissions to be a bug. Only very few tools allow to do so ('rm' is the only other one coming to mind right now), for good reason. If they do, only with additional parameters or by additional user interaction. Git should follow this strategy.

Which means: respect file permissions, no additional config variable and only if there's very substantial reason, add a --force. KISS.

That said, disrespecting permissions requires additional code, so it'd be interesting to know why this code was added. The relevant commit in the git.git repo should tell.


Markus

-- 
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/
