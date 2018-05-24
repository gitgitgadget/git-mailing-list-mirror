Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FDC9200B9
	for <e@80x24.org>; Thu, 24 May 2018 20:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969261AbeEXUsY (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 16:48:24 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:52490 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966945AbeEXUsX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 May 2018 16:48:23 -0400
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1fLx9p-0002ny-K6; Thu, 24 May 2018 22:48:21 +0200
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: BUG: No way to set fsck.<msg-id> when cloning
To:     GIT Mailing-list <git@vger.kernel.org>
References: <87vabd6pp2.fsf@evledraar.gmail.com>
Message-ID: <3e4f0b82-b67a-24d2-c89e-efbe9ee45dd4@virtuell-zuhause.de>
Date:   Thu, 24 May 2018 22:48:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87vabd6pp2.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1527194903;ff3f6e31;
X-HE-SMSGID: 1fLx9p-0002ny-K6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.05.2018 um 17:25 schrieb Ævar Arnfjörð Bjarmason:
> When I do:
> 
>     git -c fetch.fsckObjects=true clone git@github.com:robbyrussell/oh-my-zsh.git
> 
> I get:
> 
>     error: object 2b7227859263b6aabcc28355b0b994995b7148b6: zeroPaddedFilemode: contains zero-padded file modes
>     fatal: Error in object
>     fatal: index-pack failed
>
> [...]

Doing

git clone --config transfer.fsckobjects=false --config
receive.fsckobjects=false --config fetch.fsckobjects=false
git@github.com:robbyrussell/oh-my-zsh.git

does the trick here (stolen from [1]).

$ git --version
git version 2.17.0.windows.1

I don't know why though.

[1]:
https://github.com/michaeljones/breathe/issues/340#issuecomment-390775142
