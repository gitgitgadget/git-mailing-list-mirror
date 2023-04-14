Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBC1C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 09:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDNJ06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 05:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjDNJ04 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 05:26:56 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFBA5FDB
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 02:26:54 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9FBC632009C3;
        Fri, 14 Apr 2023 05:26:51 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Fri, 14 Apr 2023 05:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1681464411; x=
        1681550811; bh=+TqavneGOKcsPMud45hWx6bG4ENJMLusOJ5hv4J7gjI=; b=g
        bsroWsLmSJLKbbicFWnP+kE5Rpieb5cLu0s7ntZVjU96lBhuMbgaDRHYi0/CLvRh
        Nyr4thUI9U5OxonrAaYaEk52wOaoESH5+chEfNVo50MnPmFooC+7yjBvRNLuCICa
        2/Fzu9Kc1E6p2VuFa3MZbNwN/9zXryAlD10SvRFKAedcMSkBVjw6R5GK688nBEf3
        AFYGHZyn/BDXrB8sQUTDERc+aciiVCj3B+qFa6x0qiR0h3fW5dR/DikXIzQ45GyA
        ITKXQzLrgiryjzzOnBCbZTi54kytRPpz0sAUwNigiYvmRiKH1XI1xaoQogeiP/Mz
        MDhrmDpnZU9MkfEffwKxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681464411; x=1681550811; bh=+TqavneGOKcsP
        Mud45hWx6bG4ENJMLusOJ5hv4J7gjI=; b=OefVT+kVdIuE3G59AwZSYHxHk3U8u
        0j/+Ju5Akj94nptuknoVpvZBhXw7kCaE8dll7sC/waXhvi2Yqik4RfhHC3CLZVsF
        iOg/uYaP2DeSHrD4ib9bFd4E8hzrbqspTOApMjUbGs/IMSoG6j5vStdkn1J9+CYQ
        NUcVsqMIfdTtpZWiNd76s9k3reAA5RakVEPspTk6jGvfYhunxKzQYpe1aQ2yC69c
        Wnl67hY/SjhqBYufTcYCGm9Uidlq1C4gK5a/GihsNKqP+PgGyyECRei3Co9ALJTS
        OgqjVENDidxgDOQLe2MVtK3B8WnoVm4fRP8XyQwnYstZ3lhzKhi9fJnSw==
X-ME-Sender: <xms:Wxw5ZNssZLDxNSZ5btDwZBn_HjgRoAqW8k8W6kMEK9NF7Udv0VzYZu0>
    <xme:Wxw5ZGf3zaYzpXU3WTMI8Aaj_vr0qJsK6f0iStvy3MVW1ytoIUPFnHDCRCv1ML0AW
    -oblL-9bk7O9ij5nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhephfekffejhedtiefgudektdehvedvheet
    tdevkefgteffhefgieeguddutefgkeehnecuffhomhgrihhnpehsthgrtghkohhvvghrfh
    hlohifrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:Wxw5ZAw5TW42ranuA4VZtnncSgTpMbvSKqNZSd1aCy3_PIN-D55Zhg>
    <xmx:Wxw5ZEN-FZwVF2QQbvMR9qpgttEGYBoAAYXZqWgCMqH8xgj2ieNUsg>
    <xmx:Wxw5ZN-4noBI-ZQwkWoe2wkwUYsJhb11InrOt-qwxtg-Wuvg4bjHTw>
    <xmx:Wxw5ZCIQ3ZfTLRJgqB5ybN2n35gX2mbSrmhdQCI0iqclSL97fuM3pA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0DD0015A0091; Fri, 14 Apr 2023 05:26:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <fe75dd24-344b-4c9b-b08f-af12f3beff11@app.fastmail.com>
In-Reply-To: <CAJN3DWqbR-9sNGT=Njei5PNSGKVKSOgrY4K=FXVjUKEFQ27bWg@mail.gmail.com>
References: <CAJN3DWqbR-9sNGT=Njei5PNSGKVKSOgrY4K=FXVjUKEFQ27bWg@mail.gmail.com>
Date:   Fri, 14 Apr 2023 11:26:30 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Gabriel Furstenheim Milerud" <furstenheim@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git bug.
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023, at 10:29, Gabriel Furstenheim Milerud wrote:
> Hi,
> Sorry if this is not the right address to report bugs. I'm following
> https://stackoverflow.com/questions/10728104/where-can-i-report-a-git-bug/10733251#10733251

LGTM.

VonC has amazing Git answers on SO, but I feel that this changelog-type
answer is *too much* for a procedure which is just (based on the bug
reports from the last month or so):

1. Run `git bugreport`
2. Edit the file by filling out the blanks and removing irrelevant stuff
   (follow the instructions)
3. Post the report as an inline plaintext email

So basically the sibling answer https://stackoverflow.com/a/70175922/1725151

-- 
Kristoffer Haugsbakk
