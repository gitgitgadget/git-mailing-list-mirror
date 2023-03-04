Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282EDC6FA8E
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 08:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCDIgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 03:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCDIgy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 03:36:54 -0500
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103861C5B5
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 00:36:51 -0800 (PST)
Received: from [192.168.42.163] (127-98-142-46.pool.kielnet.net [46.142.98.127])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 353A13C4386;
        Sat,  4 Mar 2023 09:36:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1677919008;
        bh=Xk3dbSkcn8lIjO8qYNB71NNwVz0Uo4BFAVovTyqHQdk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H7cJkJLxA+U+k8U5CV79qLA3m+RsoUO2D/BrmWvMhURgxvqUSmMj4XpEvrZ/LVu3P
         1llohQheFg7M7gF7dT6+KPMTxeJW1DAsMSqQW0teqHV30YVTRBWBZBLPqAVhsGUcvS
         461a8gmEHhR9IHeiwdEEsYXTsGssBhQo2nSa6n2lVhlllNjsfVuYYxCrQtBDod+ULs
         0yatdeYZCPmR4mp6CcKFuf+S5cFOPsztmGzsRkNnzZ2ieyRmUN4N7zOth/3mhw97Nl
         7xeOsAb+ogDH3V0jdATF1vevP8qxbwj2UQ/3QakjcyZA0iF33+283zigrqBjVfZvV7
         9kiaCLQLNgo8Q==
Message-ID: <347052f1-dd7d-dc72-6171-a858eea94747@haller-berlin.de>
Date:   Sat, 4 Mar 2023 09:36:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: en-US
To:     Chris Torek <chris.torek@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
 <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
 <c237c1e3-5cd0-503d-ff4b-96f645a659f3@haller-berlin.de>
 <CAPx1Gvdik+QhTw8U1vd0cW1yZ9GbgDpmW7apxnXdY=E0okLpTQ@mail.gmail.com>
From:   Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <CAPx1Gvdik+QhTw8U1vd0cW1yZ9GbgDpmW7apxnXdY=E0okLpTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.03.23 22:25, Chris Torek wrote:
> On Fri, Mar 3, 2023 at 3:04 AM Stefan Haller <lists@haller-berlin.de> wrote:
>> It seems that I can get close by checking whether the file
>> .git/rebase-merge/amend exists.
> 
> The location and existence of this file depends on Git version and
> whether you're using added working trees, so that's not generally
> the right directionA to go.

From what I can see, the current behavior of the .git/rebase-merge/amend
file was done in 2.12, that would be more than good enough for me. Did I
miss any changes to the behavior since then?

I'm surprised to hear that worktrees play a role in this. Do you have
more details about this?

> It would be best if `git status`
> reported all of this information directly: perhaps --porcelain=v2
> can be augmented to provide this, or there might even be a
> --porcelain=v3 if necessary.

Yes, that would be nice, but based on what state would it provide this
information? Are you suggesting that some new file should be added to
.git/rebase-merge/ to keep track of it (more reliably than the amend
file does today), or could the information be derived somehow from what
exists already? And if it's the latter, then why shouldn't I be able to
do that myself in the same way for the time being?

-Stefan
