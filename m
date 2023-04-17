Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E09C77B70
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 08:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjDQIfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 04:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjDQIfV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 04:35:21 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9255258
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 01:35:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id EF4E75C01DD;
        Mon, 17 Apr 2023 04:35:12 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 17 Apr 2023 04:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1681720512; x=1681806912; bh=haGH1Ny7dtwdhn6Yb3YpK5+uW
        NcSHgv9D1QnuZAlw7M=; b=XXQ6WIRuyj0aHZhJeLQZs8ABPATggjC54taWHwAhb
        PCkhw0NBLRjVpvTqkb5d45i27GHV5yTDvEHTvFTOkXh4j14+sAAjg/fBYod0+Tfd
        Rs+J1Hz5powxM6BPOolyaQNiQvWVB/IFywLeghwXA0YzX+n/RocbwTTY5PcDJe2z
        v4HA4ezWR4iaut/hGSSWxF3rVFlsKp+Rn7Tilc4MShDKm8Q1dlxfGqYc1VgWVcUG
        ERFyC/X735yx91d2kr97OQjiw7EBJNSW06zgNAVk+hOQsyCbnAitYf2NhRAOeJGR
        xFiTsrg+VrH3EkLFpsN7hESYkWQjl5No7zqZonbqxQ/HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681720512; x=1681806912; bh=haGH1Ny7dtwdhn6Yb3YpK5+uWNcSHgv9D1Q
        nuZAlw7M=; b=L+aq/qz8zfatBDY0vTRJ63T8BcP5+hNM/2RpQ784zRVoA8XYXyv
        MaA+BTrKMJDN6ytTz9ly9NCPBnB24ju7BJ4AvFt3Ip3zb4x41eJ5kax9vurJudyb
        NW/eG5P8jLAt9Sv/QzUqJuZwwwQSQyOUBRP0mkwOjnOoD5QoyMDgXxyS5HsA1hLw
        p5ClUjCG4PHO0jI6gGjRSr9JNobZsveQcY+JJIF6AGIZO4PyEC2WrwwT9uudFcJc
        r9582vAYKCbNtSkFFJqRaL0JDX1s1wbYmLbrUd8WioxgTOCeFQJGhRqJAEOsjV4a
        MrTQvzVF/GoOvE5kmG/Q6F0r5P6wguaKSrA==
X-ME-Sender: <xms:wAQ9ZK0j25M979MDphDRFJzeEDtne0LiqYuYZwo_FJbMy4Qr8dgLjDs>
    <xme:wAQ9ZNG6zQdT0MuR7QS5JTbEVeik6Om1IIhroPhj-skqMFaxrsFj5uOvOSj8aAzCr
    iw0eEh9KOIG4jIE0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:wAQ9ZC6pfJYyh3CGgsop653aZoxs8gwSvO25qak1nYRzPfSRSiWdeA>
    <xmx:wAQ9ZL3IXjJOAtSXgkJ0olblA0Dz-Vd09FA6vSLgzaNDMoEnkXDDPg>
    <xmx:wAQ9ZNEKNctSZQnw2tXYoudc5rmsZ0NBQlvgsCJOsltw5ao8n5wmQw>
    <xmx:wAQ9ZCRBjj-NUXe1r4H5K5ZiFFsAfRY773Qrim5Z-xiD3WR3-jyUfA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ABD0A15A008E; Mon, 17 Apr 2023 04:35:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <d3895d9b-b45a-449d-a5e6-b8b8c5e6c4b8@app.fastmail.com>
In-Reply-To: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
Date:   Mon, 17 Apr 2023 10:34:22 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Stefan Haller" <lists@haller-berlin.de>
Cc:     "Derrick Stolee" <derrickstolee@github.com>,
        ", Elijah Newren" <newren@gmail.com>,
        ", Phillip Wood" <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Mon, Apr 17, 2023, at 10:21, Stefan Haller wrote:
> 2. I have a topic branch, and I want to make a copy of it to make some
> heavy history rewriting experiments. Again, my interactive rebases wou=
ld
> always rebase both branches in the same way, not what I want. In this
> case I could work around it by doing the experiments on the original
> branch, creating a tag beforehand that I could reset back to if the
> experiments fail. But maybe I do want to keep both branches around for=
 a
> while for some reason.

I would use a lightweight tag, too, since this option doesn=E2=80=99t to=
uch tags.[1]

Why do you want to keep both branches around? I would keep the tag
around and then branch off of that if I want to make another divergent
history in the future.

This is interesting to me since copying branches indeed does not seem to
*gel* with this git-rebase(1) option. But I never really understood the
use-case for copying branches rather than using lightweight tags.

=E2=80=A0 1: I wonder why it wasn=E2=80=99t called `--update-branches`. =
On the one hand,
    the option ignores refs other than branches. On the other hand, the
    command in the todo list *will* update tags if you tell it to, and
    even refs like `/refs/notes/*`. But `--update-branches` seems like a
    better name, at least outside the todo editor.

--=20
Kristoffer Haugsbakk
