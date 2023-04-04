Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAA5C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 10:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjDDKqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 06:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjDDKqD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 06:46:03 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB17A1BE6
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 03:46:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 51DAE32001AB;
        Tue,  4 Apr 2023 06:46:01 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 06:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680605160; x=
        1680691560; bh=2P5FvtMKYugSM5gn20wigYaOch6SZ9qp0Xzx8A19mts=; b=T
        PgV+COGAsckZfm4tNqqReuUrfiLQy1CjPidx55apQQGifi4B/1sp6hAzrLR+m1Q3
        Lqy4eSDxM+vwBC5b39DQh6x+ucMr+wSAT9T3sJiDy6VmWLAdqppAo43YxHIq0GPl
        V/cbboYBmGzP887askUkfJHT67HOyMUajEh0IxpDuWFcliJrkGiYPyvj5eGl9+eO
        CZvv9Nj6JiKMNtw2pJH+hDoEM0kUYWy6CnUd/xmhZZom2TG40mgtc1UPYUGGDEO/
        N1C9iHcde06EltHS+xEn0PHyaN/ThEZx7iSNP8cSQoZDRecdWQ2NzhIdh/DvK4kM
        Y8HhQRv+Z622mZ2Tqcpbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680605160; x=1680691560; bh=2P5FvtMKYugSM
        5gn20wigYaOch6SZ9qp0Xzx8A19mts=; b=bwX0LNOrdd5OmnGyA2DSThjN7zvOo
        UDvbKWtQZPk0an2J2OWQFK1ArFTy24GAFoy4J2mUd9TsMZsF+DzYYCQSpxrJVS67
        yANQ1M+MDUAQ3k1fyexzVj4eXRrpAUWyKah02uKWi/EbW0zsUsKorNotaHip8wQp
        sIWWQPT8g5d131XJ0jZrLvUXzsd0iSXcgItE14tz+VGI0ybFAPnARzWR9Qx9JoG+
        feA73KeS1m9wRBR0nmmTuTvwa8FhbcB65Ndyq8Egzy5n4iVZoYctFGjge6RS7blR
        stejuP+WE/7+1wCPh1HuGJpzHBHxdxnqXNmO/pNRl/JuIp8KqRWxefI9A==
X-ME-Sender: <xms:6P8rZNNq8dDvuKJIvoJNwptwvGgI5gQx4x50YtMQfQmF6JBg4l56504>
    <xme:6P8rZP8pPpnP1fWrHCtCpDdWXXrwToEvZBC721SrpPjnHpjpQQg8HdGXjE4EnYeEv
    necmN64yhETnqB4gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dtkedtjeeiffelteffheeiheeufffgheelueeftdejkeeufffgiefhgeekffffueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:6P8rZMRTp-lCytdwyvrk12QK8solnA1FRD8mXFJoOh-ojL6ylc6-vg>
    <xmx:6P8rZJsuFEegi4DV-P5klByhUC9PkVEQ8RwM2NKW1yTGTLVP9VUsRg>
    <xmx:6P8rZFfengJw14nIHKwM28GxEzO4LqndwUxpw1sjJEIpj7c_Npc_qw>
    <xmx:6P8rZLr9tz9uodxrjrPK3MnaapIGV7wwmc2b0BnJfATtkCI9iHCuqw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B1F3015A00A1; Tue,  4 Apr 2023 06:46:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <4e5ac983-a45d-4459-b398-4d092ca2f1c8@app.fastmail.com>
In-Reply-To: <2349908.kWcu0K8Tai@earendil>
References: <3473764.PTxrJRyG3s@earendil>
 <8135fc7b-1953-4702-a9c4-b0f847e69887@app.fastmail.com>
 <2349908.kWcu0K8Tai@earendil>
Date:   Tue, 04 Apr 2023 12:45:35 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Thorsten Otto" <admin@tho-otto.de>
Cc:     git@vger.kernel.org
Subject: Re: "git diff" does not show a diff for newly added, binary files
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023, at 12:39, Thorsten Otto wrote:
> I would expect "git diff" to output the same information. I don't see a reason 
> why it outputs the diff for a new text file, but not for a binary file?

Has it done that before? As in, has git(1) behaved like the way you expect 
it to behave on this point before? Because `git diff` has never diffed
binary files for me unless I instructed it to do it via some `.gitattributes`
configuration.

-- 
Kristoffer Haugsbakk
