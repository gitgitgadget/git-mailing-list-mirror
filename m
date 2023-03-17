Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2EFC6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 16:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCQQrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 12:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjCQQrN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 12:47:13 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401589AFFC
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 09:46:51 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 643D03200920;
        Fri, 17 Mar 2023 12:46:48 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute6.internal (MEProxy); Fri, 17 Mar 2023 12:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679071608; x=1679158008; bh=S3
        zntSBY67IV1X+vfHfL1qIyryVpR3h9NrLMhqpkx4A=; b=kiCmCTv4/neP9R00S4
        SJKrvjMmR5o0YNcZdsLdTkP7/qz1gjivaQIawbu1CisApXGO5mVSqYCWhrfGChzr
        XPA3PSkL0wrpvix1ioP3rayW4avTjTWJm9k5N2X7rv92l2wLtbSmEKM5fKXOzvUt
        WF2kuJTKKKSO1rf6/XyZYWlufD7oaHaHvMsOq7eEOS1ABCCno0P/e24kM31mDHx/
        QVodxoHU4/9j5ilhb0eoVDruT282ZO36YWCkijhWIfLfMlpgFvJEMvl27ANmjZ3L
        Xaxpm+Z9oyqjov0cDi9MuGIjOC+lR2lMbXdTBs/EX0cQ54cPVYa9MW4rkIco7tVq
        518w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679071608; x=1679158008; bh=S3zntSBY67IV1
        X+vfHfL1qIyryVpR3h9NrLMhqpkx4A=; b=hC7jQx62Ctb7UwdQk06TOLdjQPK2Y
        S7MIf9RO/cUthpP+60VDbyrSQOB61YfDEO+hnG3TUvwdqNeQKNCJP6KghZgSVGb0
        i1ckbp7EGHcUCplPiiscwnih6lRYDkjDqMzUX185Yjy5Gaj+nl19oreJWLUWTaH5
        gTFEDNSYw/vitCGjf8HbnxNL30akbssTNmkX9CojkAIY/uCDFoySoS8q1gnEbQxA
        vzntjqN6qSXfQRoA8a83e72wQXc63iokHSjDtmHNHzbFK1eLVqzdbgHHOze5ZIzZ
        bJZ3682WoRnBJVKkn+XbLeh8M0x5Q4Rv4acETMIcsWYUqLT0IESCgkcyg==
X-ME-Sender: <xms:d5kUZD4-hXKUWwFjz9erb3Kus7Xla7gj2W0kIy8hyN_l1jazNMHj4g>
    <xme:d5kUZI5QxeU1M_FhidO881CeVCya8zJxeodP40GF2UQ8fJO_wVLncOAhZ2O4Yqwn-
    HHNuNRJMJO4F7dSSnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdforghtthhhvgifucffvgggohhrvgdfuceomhgrthhv
    ohhrvgesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepgefgueelveejfedvie
    fgvdetteehhfeuuefhffettdegkeffgfeuleevhfehgffgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrthhvohhrvgesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:d5kUZKc4q3ktF0n-V9p9E7mq-Qp_jBgtsbdCla5FWmzdiauJbF4SBA>
    <xmx:d5kUZEKVpPNk7LHR3JUdYnm-Vu5uqJoQQUVv6fjQvdtb3PS9bbhDmQ>
    <xmx:d5kUZHKdSKwERayBHJK3nIm2MKqpRA3YDPmMWSmFYZJyV6oVoO6FLA>
    <xmx:eJkUZCnHwXHh3IMTkIkOHQncbYgDBn5ppPWZCNCwgbyri5Ow5i9xZQ>
Feedback-ID: iba91467a:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CF2BB2A20080; Fri, 17 Mar 2023 12:46:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <ae193764-daf2-4fff-89cf-39396f420cb3@app.fastmail.com>
In-Reply-To: <ZBH7Uiv7fH9UnB4v@coredump.intra.peff.net>
References: <4c02cd71-8bfc-4b6e-9ec0-3d98598a695a@app.fastmail.com>
 <ZBH7Uiv7fH9UnB4v@coredump.intra.peff.net>
Date:   Fri, 17 Mar 2023 11:46:26 -0500
From:   "Matthew DeVore" <matvore@pobox.com>
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Buggy `git log -- path` behavior
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2023, at 12:07, Jeff King wrote:
> I think what you're seeing is the correct output, though, due to history
> simplification. Along the first-parent history, for example,
> Documentation/vm/pagemap.rst never existed.  And so since it does not
> exist now, we prune any side branches where it did (because they did not
> lead to the current state; the other side of the merge resolution did).
> 
> Tracking down the exact sequence of merges is tricky ("git log --graph"
> is unreadably huge here). But it looks like the file was added by
> ad56b738c5dd (docs/vm: rename documentation files to .rst, 2018-03-21).
> That was merged into docs-next via 24844fd33945 (Merge branch 'mm-rst'
> into docs-next, 2018-04-16), which then eventually moved it in
> 1ad1335dc586 (docs/admin-guide/mm: start moving here files from
> Documentation/vm, 2018-04-18).

This was thought-provoking. ad56b738c5dd is a side-branch. I expected a
path filter to find changes since git log would show this commit when
invoked with no other args.

But the only reason git follows the side branch in the filterless or
'pagemap.*' case is because git sees pagemap.txt (matching the glob) in
the first-parent line being removed when the side branch is merged into
this first-parent line.

As I usually use --name-status as a default in my workflow, I was
surprised git log couldn't find something that grep could :)

Thank you for the thorough explanation despite my terse complaint.
