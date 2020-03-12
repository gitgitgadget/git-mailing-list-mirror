Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CE6C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 03:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D2C206E2
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 03:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="pcO4RIxH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uWA3lNSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgCLD4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 23:56:15 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41963 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387687AbgCLD4P (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Mar 2020 23:56:15 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 57EA0221B6
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 23:56:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 11 Mar 2020 23:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=sTXcWUIq20AfJXEeMM5wi537M+mZjxv87dRHzlWGbWQ=; b=pcO4RIxHGwz5
        dt9Qo+uKqYIOxIbft9J2SAqGpyFG5GKP3nbtz0WF0YgdaiIxY7k6YYAzVTtY3tYW
        GQN5LYahX4IOyV3fWh5bmwLOz5UpzdA4imTutDjeLmLJeeHdp3XjvrlLbBn41FJv
        +fiKORG0juhSDKNXsZwg3frBujDsoqo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=sTXcWUIq20AfJXEeMM5wi537M+mZjxv87dRHzlWGb
        WQ=; b=uWA3lNSK1ffd+EjF/diCV+qPTjCZ1QlIW9qJiFv7nR+77n8cit+bL2JM+
        ndc5bIdNeto0f0mH9twFdxbD8cQzPttUeR+9a+0u++pmFw8qJkVeHzA8vN9nyvfk
        VKxzYCvC5dXTfLaBMww7mmugEHQydNa2rFFvFmt9Mpag8B3zOr6zzsmuhMWYfTeY
        bjbyDRwwYqoHptUtOuRjlso2oJkfGtDzkKoxwceaolgW9XiEecSJO9SNyW9hpIav
        DrvRrML2ouv/+R/Tr4d8tvGJSqso7zRqdveyhUXWVTzyljijKvnXjjJ+ZujL4jEY
        ZLnjccci2QH4Ov3UCvgXsqXmCO0SQ==
X-ME-Sender: <xms:3rJpXt_W0il6a2CNKw7klQpOiMLdiTX88392divQoO3eANc3hdT3-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:3rJpXpiSttE-WHTw8cf0vuZa1SThG6E0XsscIs1CUHtU2nOK5T9VJg>
    <xmx:3rJpXmaT1bC_1dMItXfYpemWnOgZKLQfYwfZYr3Txd1MRF9dmuEnHw>
    <xmx:3rJpXrS-Ka4aQsSY3HWX2ywsaHU5KDaj5S6wPTrCJjzeKAoavhHR2A>
    <xmx:3rJpXvmEdSky796sqo1Tat11DN-5yNy1c0LXqo8CooIuXo9nL7yngg>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9646C30611FB
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 23:56:13 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 1/17] Reftable
Date:   Thu, 12 Mar 2020 14:56:10 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <1B71B54C-E000-4CEB-8AC6-3DB86E96E31A@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. In case you’re not aware what it is. It was introduced in JGit. 
???Prefix table??

2. Gerrit team likes to get this in cgit

3. From the Stump the Experts yesterday, the question was “If you 
could go back and change anything what would it be?”: Loose refs can 
cause difficulties. So it would be nice to make reftables a first-class 
citizen. There are issues with OSes with case-insensitive filesystems. 
Reftables can help with this.

4. Stolee: contributing an entire copy of the source of a library 
elsewhere as one patch makes it hard to review, and doesn’t feel like 
a contribution to Git.

5. Brian: agree. Is it an external library that needs to be pulled in 
every time a new version added in JGit.

6. Edward: having it as external library moves the maintenance burden

7. Jonathan N: example of xdiff, we have a copy, Mercurial has a copy, 
and they have been patched in different ways. Can we separate these 
concerns? One: patches that can be reviewed separately. Two: licensing. 
Three: ongoing maintenance approach.

8. Peff: benefits of external library are clear. What is the maintenance 
burden of not maintaining this in the core git tree. More concerned 
about niceties in Git that aren’t in other libraries, like strbufs and 
data structures. Lowest common denominator isn’t ideal. Can this cost 
be mitigated?

9. Ed: I have the same concerns. We also have strbufs, but they are not 
the same. We also might run into licensing issues.

10. Stolee: also cross platform compatibility… It might not perform 
well on different platforms.
Peff: It feels to me there are a lot of hairy filesystem details 
reftables need to do.

11. Brian: Atomic renames have issues on Windows.

12. Jonathan N: Han-Wen wanted a more substantial review, and we just 
provided one (actionable for

13. Jonathan: write a summary email to Han-Wen)

14. Brian: (inaudible) Having a reftable library would be interesting to 
test SHA256 changes.

15. Stolee: would be nice to have tests regarding case-sensitivity & 
directory/file conflicts

16. Ed: wait, are we loosening the restriction?

17. Peff: no, for backwards-compatibility we cannot. Would love to get 
rid of that restriction, though.

18. Jonathan N: Immediate benefit wrt D/F conflicts is being able to 
keep reflogs for deleted branches
