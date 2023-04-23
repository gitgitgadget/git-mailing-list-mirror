Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBD9C6FD18
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 21:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjDWVBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Apr 2023 17:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWVBt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2023 17:01:49 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79D9F7
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 14:01:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 35F913200902;
        Sun, 23 Apr 2023 17:01:46 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Sun, 23 Apr 2023 17:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1682283705; x=1682370105; bh=axZyQ1KfG+Zw25v0mm1snCEWU
        h1A8GbCWOs3pBgLXr4=; b=p3Pu/VxS1UimcAgFj2DgePFOzCyX+qcLWrP01AugL
        6nlfKFHVpj0B3YG15hoGNrJO7QFsZp7OYoG7YRPT0PGq3cHb75PaDlotqUF2lusw
        Tz6vQ2GyRAlNEk+Fujbcb1lnwI0mgAnnsOOCHiVHEm9mil28e/6H9Ilq17shXREV
        /6VWzuF0HIUEkzcQSlfZV5OGSMIX3X4R91fAa9AkfNrunw4ngKgHr+bw1v7GWRVu
        koZvE5u3MdX+AhPPktYq1qFl6bBnscLfv43D4GZ+WT9fcI73KxnX23UQxCTkzsJE
        WWa+EjSrXeEcsFxAPscGXmChzGjVfID2V7b7AViHFxgqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682283705; x=1682370105; bh=axZyQ1KfG+Zw25v0mm1snCEWUh1A8GbCWOs
        3pBgLXr4=; b=cQLbM6OxI23wPCB5peNh9MC7RcHMKNFGHxOzTMm3mZq0ocaUqaS
        /ZHO2Bezim91Oe4XTS0SqWgckhh7WNFkdVjgtK/fKbpl/OWFc52IWywgje/gOoxZ
        /ih5Ks29ddbre9/9UJGhjjgAD7qZwWo92H+qDIeX5S237dFFk2ycVV8XNklNrKZn
        /8UDCFOUvoD5D51mjk2e8UXcGtJ4zUf20Gkig54rMmDut4VPHms7iCFZ+PAdci3E
        RWzeQ/ovNPb5dnQygrLlTuT5GLFNNEsFFSUWNSxhDZMTGL1WREB8Gfmtd37H9h0p
        0BCUL3tTGZRpwWJ33eUugnuSWQT1J/0RIRw==
X-ME-Sender: <xms:uZxFZGAvH2mMQaCK7cIiRdzONPp4mqwhM1_ht0nRoiYOiL8O0PJTb6k>
    <xme:uZxFZAiITftKo0UbI2ZUlHrowBhtOPevTm1xhVop0m2mdxjzJoRiIYYtPcWtt37pX
    PEQILV7Cj8aZK3yrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtkedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgf
    esthhqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghk
    khdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrh
    hnpedvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:uZxFZJlz-vb5ae-BwyaZd59QWjm4uV-lTfiDRdj4Ggy8gVkNeTLfdg>
    <xmx:uZxFZEwabrCdPQOyIpWZ4WYmWBCfii7UXUbvL5wAsskNZyRXpeQiEQ>
    <xmx:uZxFZLQ-1WxGW2t3juZZDsR7Tid_FoAgYNgU8rq-jJRTPzqBJXnhhw>
    <xmx:uZxFZOOzZ50KQBhwEPD4QAVqmpHUXGzz2rAcD9bUzmEGqLU_3uVAuw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8F03515A008E; Sun, 23 Apr 2023 17:01:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <f249ec0f-f2f0-43d8-bb70-5a4a7c91c608@app.fastmail.com>
In-Reply-To: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
Date:   Sun, 23 Apr 2023 23:01:25 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Jeremy Morton" <admin@game-point.net>
Cc:     git@vger.kernel.org
Subject: Re: Proposal: tell git a file has been renamed
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 22, 2023, at 20:01, Jeremy Morton wrote:
> Could a command be added to git that means you tell Git that counts as
> a file rename?  Git would add a marker to the staging area that the
> file has been renamed, and upon commit, would first generate an
> additional commit for each rename before generating the main commit,
> ensuring the rename operation counts as an actual rename, and the
> content's history is maintained.

I don=E2=80=99t see the (conceptual) problem with a modification of this=
 as a
history rewriting tool:

=E2=80=A2 Given a series of commits:
=E2=80=A2 Tool X modifies all the commits so that the default similarity=
 index
  for tools like git-log(1) is triggered on intended file renames
=E2=80=A2 The user will be probably be prompted with a list of initial p=
otential
  renames and then will
  =E2=80=A2 Keep the intended renames
  =E2=80=A2 Remove the not-intended renames
  =E2=80=A2 Add the additional renames

But this looks like something that a third-party tool could implement.

--=20
Kristoffer Haugsbakk
