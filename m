Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F81EC64EC4
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 12:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjCDMTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 07:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDMTX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 07:19:23 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124C311671
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 04:19:21 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B0CE73200077;
        Sat,  4 Mar 2023 07:19:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 04 Mar 2023 07:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sebyte.me; h=cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1677932359; x=1678018759; bh=lg
        vZGfyCBuxtUnetW1MCmPjDlXT4GO03ZK4JoAnzHc0=; b=3q4z09krD6fTzrEPjO
        AF989FlB5z4MRzD5Yey5J0kyTwMw9hFUV+z4S6F9t0OttznXqASLyDV6BCN6pPhH
        U8E524Ph9wdO4Y3EGAmPq/Fa0sYxrxmH2gqZtXwAz06EOqXTqNmZcSY69lleFoy3
        c6oEBjh1GOJbXu9ZeDJylbQUeRFpwNM7vNdN/r+rtvQaFU1MDFNFPv+B7dEQcO9k
        P0W0V+TmgmB0mEpqgiaTAbwRnWPmSDaTZ3FutG8wnSJx8CfjT4ILiE5rkfZcPZJX
        SxsksPJhljg1WhUM+VdRPUcgJxtQcc8WjKMQ+1M/EpSKOnybK/uv29qiwiE4ro7Y
        8eQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677932359; x=1678018759; bh=lgvZGfyCBuxtU
        netW1MCmPjDlXT4GO03ZK4JoAnzHc0=; b=a7ohSFyeE2cChnHkj750Cr5AJIM9R
        8NgaRJEm+kT2t4mhrFKGXYJeZlgaYhkyf2FzXwDB49Nzf7Ii/LCDX+B3tqEs6CDZ
        IaN2k3z2JZqPBv4mjX7g3XC1QJ9RqY/aHOcGed3P+xjOBAOOrNGNLYFInBvdsY3x
        TZtS7YSgoihIMkGAFH+svPAMW5nAAfY2bMIPHY1xC1jH5l7e0IWXeHW/cnqWI/RE
        d6i7aOEYrQG2UkzGplWOPCm5E8v1PdX7pvmuGNAY3kyr7rL3OpPBFfhlDyW0MOsu
        IFC1RSLiO4ZhpxCzq+6dAnZveh+D8Xopl1xo7Thu2cmWh4/DksV+KsNMg==
X-ME-Sender: <xms:RzcDZJ78zEuTVcvb1-YqV868sIcBfB1mh5lZ1ZyqGsHNnoMOtSuYNw>
    <xme:RzcDZG6f257D8fjlHd9alNRobfJUfmuL-fW4Y7qrxQ2PgIe5voGm2QuQKTQoj0fi_
    e74aUwzuiAnpF1Wgw>
X-ME-Received: <xmr:RzcDZAcOiEmJwuB3Uh5aQiBXmcA4XkrBgrD5eGE0NEWIftCFnNVc9fLmOixmcHulmSQHKT4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtuddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgfgsehtqhertd
    dtreejnecuhfhrohhmpefuvggsrghsthhirghnucfvvghnnhgrnhhtuceoshguthesshgv
    sgihthgvrdhmvgeqnecuggftrfgrthhtvghrnhepkedvffelgfekgfeuiedtgeejiedtke
    elhfeivddvvdeltdeuudevheejteevtedunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepshgvsgihthgvodhrvghtuhhrnhdqphgrthhhsehfrg
    hsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:RzcDZCKv39AhF10D9Yu-CdL3b7CbqxaGU3FLbIq2SN06FdZRoodGUA>
    <xmx:RzcDZNLhMRLuT3PXxPslxBLkEgb0aKKV1L8fPLqqTrRApjVkeDHBeQ>
    <xmx:RzcDZLxunlr1sN_yiG-vPvUkbR6IBQpQKFnyz_Qn5mV43NX5bx2qMA>
    <xmx:RzcDZAkS_66KH4PL5GBrdGAq0Ch7AB3eU6_47el0Eee4orvWLwnsCg>
Feedback-ID: i9e78401f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Sat, 4 Mar 2023 07:19:19 -0500 (EST)
Received: from sebyte by balor with local (Exim 4.94.2)
        (envelope-from <sebyte@balor.gnukahvesi.net>)
        id 1pYQr7-0011Br-2y
        for git@vger.kernel.org; Sat, 04 Mar 2023 12:19:17 +0000
From:   Sebastian Tennant <sdt@sebyte.me>
To:     git@vger.kernel.org
Subject: How to mirror and augment a git repository
Date:   Sat, 04 Mar 2023 12:19:16 +0000
Message-ID: <87ilfgemkb.fsf@sebyte.me>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello list,

I wish to mirror _and augment_ an upstream git repository.

              .--------.
              |Upstream|
              '--------'
                   |
          .----------------.
          |Augmented mirror|
          '----------------'
           /       |       \
   .--------. .--------. .--------.
   |Client#1| |Client#2| |Client#3|
   '--------' '--------' '--------'

Clients of the augmented mirror must have access to everything
available from upstream but must also be able to collaborate on
additional development branches not available from upstream.

Initial approach:

 Augmented mirror:

   $ git clone --mirror <upstream> upstream
   $ cd upstream
   $ git remote update  # regular cron job

 Clients (bare repo & worktrees preferred):

   $ git clone --bare <mirror> mirror
   $ cd mirror
   $ git config remote.origin.fetch\
         "+refs/heads/*:refs/remotes/origin/*"
   $ git remote update


This arrangement worked fine until I decded to run:

   $ git remote prune origin

on the augmented mirror and lost all the additional development
branches the clients had added and shared amongst themselves.

I've tried running the augmented mirror as a plain bare repo, i.e.

   $ git config --unset remote.origin.fetch
   $ git config --unset remote.origin.mirror

but then the cron job (git remote update) is no longer sufficient in
making all upstream activity available downstream.

So, how best to run an augmented mirror such as this?

If my initial approach was correct, is there a way to protect the
additional branches so that =E2=80=98git remote prune origin=E2=80=99 may b=
e run
safely on the augmented mirror from time to time?

Any help/tips/pointers/suggestions much appreciated.

Sebastian
