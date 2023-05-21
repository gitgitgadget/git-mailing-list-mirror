Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16B9C7EE23
	for <git@archiver.kernel.org>; Sun, 21 May 2023 11:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjEUK4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 May 2023 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjEUKuI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2023 06:50:08 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869491703
        for <git@vger.kernel.org>; Sun, 21 May 2023 03:49:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 52C0632004E7;
        Sun, 21 May 2023 06:49:51 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Sun, 21 May 2023 06:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1684666190; x=1684752590; bh=L+beVc5/ep+sLjxOwWnOLIHW4
        S8+VMO7MYqO1QgRIWI=; b=ATDcASEfhTV3mssrRuiIVsTgwI1lj7tR4xfPCzW3K
        fzWFtjKYsPsI49t3qGX6y/CAwX0PLBHEpiNiCTYW6fUPcuK1Y55rw6leyQTKIBZD
        eXQkuZouusLBHsXr+pfsOq7Ie785pAPad9+dHxF5vd20/uLvuHCogssMIFRsmDIS
        l4oJ+vav7z0zD3qIleVVjLC/F3pC6MBAH3q0SCnA0cRMO8lErAq805Bxk7+lBUv5
        cGb1+Og5xXJcJirgP22kHkQMU15BcebrTtwsBJ6y1UxL5n4VeuEM1O+JLIs+jIin
        xZSGm3QeXb+mamti0OO0mYrQ5YrNwhCckEn8ryZNkti9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684666190; x=1684752590; bh=L+beVc5/ep+sLjxOwWnOLIHW4S8+VMO7MYq
        O1QgRIWI=; b=DA6LjaimGTE+r0BhzJpjWYoNKyU8w3QSk83DL++0ABQrGgI82xG
        FC7bd9atrqMXdVlpPJFkDAZqz/3rp44yun9B5BbLD/k0h1pubQYRRPs5ITzOENRg
        F525ZBPO7Mjc2yl+lSCKhYLegI7VLL7J6iASj5V3urt4EdaA8RczrFadNgIIWDuV
        SYlKXgShI0bpkSSfIfISFGThR0LhqzBc1J0XyvxdXF0EUlbCnsE1TCf5KEgJRSeD
        gdrHr8a6Q5BL5TeO/yH2cl1yxBvj+tmwpmZ+62kuxmwAle3rJ+ODHMrzHPqRZhUZ
        FynYzvGeMrpXxCjnjDELDtlQ8moD6Qrfkiw==
X-ME-Sender: <xms:TvdpZITRIc4iFzImfXGtPFjfQ8JPsG6ryNX1oFKNKq4TnJR9kVRuXlY>
    <xme:TvdpZFzpSAwnVjlVgipxryi2hWhl1qa8TbSrVtsKxVyx35G1WJuwtkgjTRFQA9939
    4r9zdcTACEZTN6hPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiledgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:TvdpZF1c5JwGoTs5ILTZyVlLHOkkKh-IThdScMhiCIMuW7I-s37DdA>
    <xmx:TvdpZMBN1ggScPH2rr3pKGdnhGmWwAq5Jxg-zzUU9iYJ98W7lGbQnA>
    <xmx:TvdpZBhfXbbWH8kiVSkz2KFfrqtSfY6-3PJaAOeryd7wcU5BJcIugQ>
    <xmx:TvdpZBLIi1P_3vC22_qHdGCWu82W8i_V53asLKCFMJqqhEsTskfdhQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A603E15A008E; Sun, 21 May 2023 06:49:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <948e8a46-4257-45f6-8486-7cd1481779f2@app.fastmail.com>
In-Reply-To: <xmqq353qk59y.fsf@gitster.g>
References: <CAOQx3AYx+sSD4REfTdQ0muY2zRgzE2nR7RgG7cxNgXvwzYzixg@mail.gmail.com>
 <xmqq353qk59y.fsf@gitster.g>
Date:   Sun, 21 May 2023 12:49:30 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Minnie Shi" <minnie.shi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: I think there is error in merge documents - current branch
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 21, 2023, at 00:27, Junio C Hamano wrote:
> My reading also hiccupped with "replay"; the first sentence to
> explain the command says "incorporate the changes", and that may be
> a less confusing expression; "replay" somehow makes me imagine that
> the changes are cherry-picked one by one---it may be only me, so I
> left it as-is in the suggestion above.

Yeah, it made me think of cherry-picks, essentially (specifically a
rebase). =E2=80=9CReplaying=E2=80=9D doesn=E2=80=99t seem relevant in th=
is context, but that=E2=80=99s
just based on my layman conceptualization of how git-merge works.

=E2=80=9Cwill replay the changes made on the=E2=80=9D comes from b40bb37=
4a61
(Documentation: merge: add an overview, 2010-01-23), which expanded the
first paragraph of Description and added the two examples.

--=20
Kristoffer Haugsbakk
