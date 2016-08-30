Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4B2F1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 14:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbcH3OTq (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 10:19:46 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37492 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752184AbcH3OTp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Aug 2016 10:19:45 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9FCAF203C4;
        Tue, 30 Aug 2016 10:19:44 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 30 Aug 2016 10:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=CO8ciUBNaSABnItYyIMVRmGISPM=; b=SVkLij
        BScsfEknj7KizPSYZHJuvn6YbcvMfQ7QN8jxqq47dp2KaH/s/TYOfxMg0ymlPlAQ
        5sjUzaI3Ioq2X5d2lOx7sSlHZe+0HfZZW9xyW/oo/mU0ZLCIuPdbom9s7X8n31mS
        d9CK7tSojmp4p5yLUDt1Ux6GSyV6/8PIgJwsc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=CO8ciUBNaSABnIt
        YyIMVRmGISPM=; b=ky0roFzBVhdzH09jgtzNnhx3xPMUGx23Qe10IjJSmKWx2Sj
        0c7sGCNDSTp067Z2JEodSOZPEumcBh4rUgh16Q55ScuFV6XlCKtMwsSuU80grbvF
        s4tSq6w9nlnuC8YtkP0dtKaBCpTWNVbbi3YhTPmjq1cS2nxyarnE9lXqH5RQ=
X-Sasl-enc: G3jLaiqQIjOf6wrdcQFY8Eeyx3awIxNu2a+kYNaZhKAl 1472566784
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F9D0CCDB8;
        Tue, 30 Aug 2016 10:19:44 -0400 (EDT)
Subject: Re: how to showing a merge graph?
To:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CACsJy8CP+Jb=B5zvhJqtR3mZY3snP=o8Zi-df8bMOJTM_3z3Zg@mail.gmail.com>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <e1156f36-51f0-17da-dcdb-36e6459fb178@drmicha.warpmail.net>
Date:   Tue, 30 Aug 2016 16:19:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CP+Jb=B5zvhJqtR3mZY3snP=o8Zi-df8bMOJTM_3z3Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen venit, vidit, dixit 30.08.2016 15:10:
> I want to see a "git log --oneline --graph" with all non-merge commits
> removed, but history is rewritten so that the merge commits represent
> the entire topics and are shown to have all the parents of the base
> commits. e.g. if the full graph is
> 
> *   8118403 Merge commit 'bbb2437'
> |\
> | * bbb2437 3p
> | * dfde6b9 2p
> * | 9c0aeb2 2
> |/
> * 8db1c06 1
> 
> I just want to see
> 
> *   8118403 Merge commit 'bbb2437'
> |\
> | |
> |/
> * 8db1c06 1
> 
> I had a quick look of rev-list-options.txt but couldn't find anything
> that does that (--simplify-merges looks different), and revision.c is
> not that familiar to me to figure this out by myself. Help?

I don't think anything (we have) would give you two lines connecting the
same two commits directly, i.e. a double edge in the graph as you
indicate above.

Michael

