Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F48C433FE
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 18:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350063AbiC3Si3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352644AbiC3Sfr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 14:35:47 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC6442A11
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 11:34:00 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D48813201F96;
        Wed, 30 Mar 2022 14:33:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 30 Mar 2022 14:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=tyDy5dUKDnZ3So7w56RsS90EIlOY4Ty1FF4wFo
        Pk7Wg=; b=vzFfI9/F3AK50JfKnhHwZnwGeOq3u5CxXlCPyQZLtc5HZkeCv9Av2T
        K/qGO1HAbFq7yUCqJ26JzWtni3zuAWC6gPcWz7/AMAmMUSRlfHXbL5B4PC5EUSVN
        Xe2o1uiI6iKbee95EiHVp5iWsW73sqTupP8OUldCJpXTn/WmU1NBtSdNaqs9wJKQ
        U3qukJVxv1xrMvQCSubd583ys0mK3yXe0jKeI5pvqafguSZlro3yJVyxbDnFd6rl
        tReYTg9PkeZYl3PzJFBH7bZZZevhcy+Cl4twS6VdPA6eCIcwmP/uwvv6H/S5BvPv
        4BuYd3YdiVkScAG92tT3JyjAQ5EP2Arw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=tyDy5dUKDnZ3So7w5
        6RsS90EIlOY4Ty1FF4wFoPk7Wg=; b=VrRs/D+cyVnUzaQ8YxF4y95A3xKZAt/sK
        ngKtfyEYKNPDSY4n9HoKvb2VLE5fv/UM9aLmWpSzB+fkiNUy2qEFuYP/VbI9JXtL
        9wK3XDMmZKpD4ET4eAmnNoBkj3pgBitGlvUeldboPlzy261Wet/gRKUY9RWjdGQa
        2Tbk9xRJdSOOD+ON4w0IpWuRhiOzHx0XTCFz252NLw8ACgkERMBJFzuyNxchOv2C
        kRJm3gU5s2N4Oh56FxzXlwq5Aicsr5gkHt7Yyqmn0QV1rWWKFuz2xAvEUSXx/+5b
        rjCjgy+C0yc2oon+RqoPYg45VWIEPNnZyUChfsVMjHdsjyFh46urg==
X-ME-Sender: <xms:laJEYlidQcqyE31EZbLrrrmm6894Q1yQbrasDLYxNXvbSOI8nYJcSA>
    <xme:laJEYqAqY7ZMrSYCSTitJ4YNCXR6UZHQhXhJmmrO0_lHgzPf4Usv7zCJjD4YW62Ic
    s1toEyC-S6v8meQ-Q>
X-ME-Received: <xmr:laJEYlE-ZcNQBk2Ce9eXzrDefrMh3jDl3GNFb6mjHP-km0NpMxL3Djx_iQ-o524LI7UaKGvQ_tc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeivddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephfgvrhhn
    rghnughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrth
    htvghrnhepleeuvefgfffggeffvddvteeiuefhkeduieekiefgjeevieeuffefvdevueev
    ffejnecuffhomhgrihhnpeihohhuthhusggvrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:laJEYqS6px1O0EBHK4s9AXyzvqZyCx5VZoqJoGvbA1Z-p2NOqmq8-Q>
    <xmx:laJEYiyUjdVCMfSsHX0KXZSklS3hD8gO-snOVIiHU3fX8G94ZuXLzg>
    <xmx:laJEYg473mGPxemhih6T4wpsskCtVMn-5Y_gaBN6zWja4TK_PKlkLg>
    <xmx:laJEYtycbFjekFfe96pbR2ZTZ93x49jbMaIA7P5njjQ8HNaGw2FzWg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Mar 2022 14:33:54 -0400 (EDT)
Date:   Wed, 30 Mar 2022 20:33:51 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com,
        sunshine@sunshineco.com, seth@eseth.com, rogi@skylittlesystem.org,
        bagasdotme@gmail.com, greenfoo@u92.eu
Subject: Re: [PATCH v8 5/5] mergetools: add tools description to `git help
 config`
Message-ID: <YkSij31hyi29g7v2@zacax395.localdomain>
References: <20220328223019.271270-1-greenfoo@u92.eu>
 <20220329224439.290948-1-greenfoo@u92.eu>
 <20220329224439.290948-6-greenfoo@u92.eu>
 <da6472b4-65e6-a3ca-8d8b-892afb6f0fac@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da6472b4-65e6-a3ca-8d8b-892afb6f0fac@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This commit is authored by you but is missing your sign off.
> Also, I did not give my sign-off on this patch (that can't be assumed,
> it always has to be expressively given).

I see, sorry. As this patch is a verbatim copy of the one you provided in the
last message I thought it was not appropriate to put my name on it (as it does
not contain any line created by me)... but now I know that in these cases the
right thing to do is to squash into the commit being commented on and add a
"Helped-by:" note. Right?

I'll fix this in v9.

Just to double check, please confirm this is what you want me to do:

  1. Squash 5/5 into  3/5

  2. Update the commit message to:

     2.1 Explain that the description is also added to the output of `git help
         config`

     2.2 Remove your name from "Signed-off-by:"

     2.3 Keep you name in "Helped-by:"

Thanks!


PS: I must confess this whole process of sending patches to the git mailing
list brings me back memories from "Asterix: The 12 Tasks" [1] :) :) :)

[1] https://www.youtube.com/watch?v=ZHRGjfEQpy4
