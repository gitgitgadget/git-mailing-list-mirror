Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E18C433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 18:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA9E20C09
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 18:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="DfB8JHaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgIGSvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:51:07 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:47574 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbgIGSvG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 14:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1599504664; bh=3LzqYOEjEBNw0E+a/MDvNwK6M3b7HvMlrQSt20tsvN8=;
        h=Cc:Subject:From:To:Date:In-Reply-To;
        b=DfB8JHaADiAxBmcuk9Ep2h2b3U+qcKDFO2ffKZIu79KKtGLCBbi7SFLuMyAQNZFYL
         QVtRYh50YPLO8YEMW4BMcsO39mwwxzXpVxJ5cinJJHLntJ2pVg48YZbejHwATTp5qd
         ag4XC8a/KGQnyG0Y9wEhkFEiHByT0jr3ivbV1UaU=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "git" <git@vger.kernel.org>
Subject: Re: Proposal: server-advertised config options
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Christian Couder" <christian.couder@gmail.com>
Date:   Mon, 07 Sep 2020 14:49:46 -0400
Message-Id: <C5HD1Z4AEVWJ.2QPVVNIQGBAM7@homura>
In-Reply-To: <CAP8UFD1wS9GDhek0Rbo=E+csf_u32D+22EsLom=AFu5D1pAYYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Sep 7, 2020 at 2:49 PM EDT, Christian Couder wrote:
> > Upon cloning, each recommended config option would be displayed to the
> > user, and they would be prompted ([Y/n]) to agree to set that value in
> > the config file for that repository.
>
> Maybe the default should be "N" instead of "Y" for more security. Also
> when not using a terminal, it should do nothing by default too.

Ack, ack.

> > Additionally, there would be a config option which white-lists a
> > list of config options which are automatically agreed to without
> > prompting,
>
> This might be dangerous if this option can also be proposed by the
> server, as it could first propose a big list of white listed options
> to the client.

Aye, I think we'd prevent the server from advertising that option
period, as a hard-coded restriction.

> My opinion is that you might not want to start working on all the
> above at once. It might be better to start small and safe while
> leaving the door open to further improvements.

While this work could easily be (and ought to be) broken up into small
commits which introduce it one piece at a time, I'm not sure that any
subset of the pieces is *shippable*. Do you have a suggestion for how it
could be broken up into small, shippable pieces?
