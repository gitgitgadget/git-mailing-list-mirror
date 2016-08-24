Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1961F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 16:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754754AbcHXQAQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:00:16 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33623 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754291AbcHXQAQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Aug 2016 12:00:16 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C2C67204F5;
        Wed, 24 Aug 2016 12:00:12 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 24 Aug 2016 12:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=/M61+342/+vl/PJyFniBG2S6B9Q=; b=iKkBRx
        0YERvtYStFMZXlClzkZYFqQPZ2qbY+1GeW8UV2nxX9QKT//HBSIGMYs1bVjzzOAE
        aPqGNbikEE9ZQh64nx7LZmTHJ5GqN5ixkOwgoFH8lZDMfZMoB0cyPhaACzUXZFN+
        Xrx047Ok/DOEUsVXat80zk37IgwSEpRy5pluc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=/M61+342/+vl/PJ
        yFniBG2S6B9Q=; b=gtEjmmAvzHAMd3iX2gkfsRQTB6qRDx5Vclw7WhMNmnQTnDp
        z63hrCgleayweF3px1wEExgkldvGsdiCUq6F60ZG0Ts+/bw0hYNeVgHByLqiImbi
        ttHcnHlXMwTxEsKhCeKwiy1TgMWcofOxZdopSKnEXlLwXueLYf/2UhM6fSuU=
X-Sasl-enc: LeNBJ0OjjBAtNJuLKrRFFqSGe+pGbCtCWLfbOprM30Ho 1472054412
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4D40FCCE70;
        Wed, 24 Aug 2016 12:00:12 -0400 (EDT)
Subject: Re: diff <commit> using 3-dot behavior
To:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
References: <CAHd499DL2WiTgnk5A--qihUh-jF9m7aXDzHAQuW=bLRVW4Bniw@mail.gmail.com>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <9efbdfbb-4c82-1355-1f89-5edca7135179@drmicha.warpmail.net>
Date:   Wed, 24 Aug 2016 18:00:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAHd499DL2WiTgnk5A--qihUh-jF9m7aXDzHAQuW=bLRVW4Bniw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey venit, vidit, dixit 24.08.2016 16:28:
> I want to view the complete diff of my branch (topic) relative to its
> parent branch (master). This should include cached/staged files and
> unstaged working tree changes.
> 
> If I do this:
> 
> $ git diff master
> 
> This will include changes on master *since* my last merge, which I do
> not want (I don't want to see changes on master, only on topic). I
> tried this:
> 
> $ git diff master --not master
> 
> This didn't give me any output. If I do this:
> 
> $ git diff master...topic
> 
> This shows me only committed changes on topic, but excludes staged &
> unstaged changes.
> 
> How can I get the results I want?

The 3-dot notation means:

Show the difference between the merge-base of master and topic, and topic.

I'm not completely sure, but I guess what you want is:

Show the difference between the merge-base of master and topic, and the
worktree.

You can accomplish this with:

git diff $(git merge-base master topic)

I guess a shorter notation for that could come in handy. OTOH, I usually
diff against HEAD in a situation like that.

Cheers,
Michael
