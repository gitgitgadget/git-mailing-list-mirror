Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13288C6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 10:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjCYKkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 06:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYKkI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 06:40:08 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDCE15C86
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 03:40:06 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 50B655C00BF;
        Sat, 25 Mar 2023 06:40:06 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Sat, 25 Mar 2023 06:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1679740806; x=
        1679827206; bh=jL+gNUwFJhCd3nSlQG+N3v2ARBx3bkeWQh0+UZ5U5uo=; b=G
        gq2UkZK5c4UPOykcaJInJWrHsf4nlAu8crGtgM0kI4A5zEl32eu5GQhORxxogZCp
        fkqlA9KfdlC2YONsTJhk5jyehDeN+whsUu4wREgAFZIaLUWVLaaewaH5rctkIPo7
        C6mRmnhvBaaeuNUPEgJlEPJ1munUWeLlAPWMa+pmC6CUI4u7T/aUZYsQNrAJIVv1
        SqTqsJ97tfrac4UXVlTvA53TmKJt44Eg5RZgK0881wa1xOXN+l+P9d/+CKIYzNXF
        LMqcSkAZDSjY1iOmm6SzLiqr4QE2F1LCSAopdHppHK954iwe0z59rWMNdXj9lKCy
        liSXEuBP7WVgC8XUyrVXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679740806; x=1679827206; bh=jL+gNUwFJhCd3
        nSlQG+N3v2ARBx3bkeWQh0+UZ5U5uo=; b=gghK7Tnih5tWTjqoWd1QyD8v3sFSH
        +idbckoG8+YbDKv+ei6saXo1iOCSOqv4CA7qDIY4Szq2zy5RekF5Xo55FMaYfH3Q
        DnN0atqBqsCcy8nO8qCjFsZbDCldtgOXviJ9ebMSZnBbEyFmZdENpRSC1U961s5V
        CXKS69qrpn5DQATSD8oEE9sCfPzt8F5h5IdFha6jbATAPxznnIefay70FGrPRdYi
        j0qoNOrKZsxuf57iyjouqAVnHVtAmNN5mvw8px/e2kU6XH0Qm7IawkwLucFlVlkF
        /4rxu+AJIxO0K7TynIjcL/zuW0rQ2+fA1HRBcbsasl8ZBEESCB6HXdPlQ==
X-ME-Sender: <xms:hs8eZNkq85H8QXD-neQibfK0A_GSwAgpEIXdETtX80RN1ie1PKPi7cc>
    <xme:hs8eZI1QCpN8-OcFx0CGffQqw-hTXNgzwaRG9liCUBb8BumxBxUt8iWFKY9eguORg
    uO2rU5E1cNc61cRAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegkedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:hs8eZDpSH19WMaLStNmmaUYNSJWx1Z085tGifZKM2QKwrIgwf1a-Cw>
    <xmx:hs8eZNmKkQJJS_2O2HjZSDnzsU1F68-6Ukwa48Shi3VW0AP6Vo8zxw>
    <xmx:hs8eZL3YBkVghf6YmNltpsgCNmEIJYo8RUgSvcJ-cV75Ko7oUhw4Ow>
    <xmx:hs8eZAgogQPEj1iGNBpJO5xHOtGWAbdyAgbWHbLei0X9ENNMGLrZ4A>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 27B2815A008E; Sat, 25 Mar 2023 06:40:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <210376fb-f830-4883-b576-2936dabc09cc@app.fastmail.com>
In-Reply-To: <20230323162234.995465-1-oswald.buddenhagen@gmx.de>
References: <20230323162234.995465-1-oswald.buddenhagen@gmx.de>
Date:   Sat, 25 Mar 2023 11:39:43 +0100
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Oswald Buddenhagen" <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sequencer: beautify subject of reverts of reverts
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023, at 17:22, Oswald Buddenhagen wrote:
> Instead of generating a silly-looking `Revert "Revert "foo""`, make it
> `Reapply "foo"`.

Nice addition.

    $ echo change >> README.md
    $ ./bin-wrappers/git add README.md
    $ ./bin-wrappers/git commit -m 'A change'
    $ ./bin-wrappers/git revert --no-edit @
    $ ./bin-wrappers/git revert --no-edit @
    $ ./bin-wrappers/git log --oneline master..
    adfce56c6a (HEAD -> reapply) Reapply "A change"
    395894c2ce Revert "A change"
    a01e3d6b3d A change
    058643b69f sequencer: beautify subject of reverts of reverts

-- 
Kristoffer Haugsbakk
