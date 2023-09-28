Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6C0CE7B05
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 08:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjI1IVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 04:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjI1IVq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 04:21:46 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE69AC
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 01:21:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 044965C01C1;
        Thu, 28 Sep 2023 04:21:42 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Thu, 28 Sep 2023 04:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1695889301; x=1695975701; bh=1wpuwcT6iosWr5eQVkB97Z8SG
        kAzGUmjmFdOXckEMq0=; b=N07XQi27zyU4kZub5aloUY2HljEQ9kWX1+WnDmGLi
        +of0vdLSSKZiZulKY/JXN4DEhKvp0MUFrb9uphS/aRKOiKjy45Y41KTjNtz3abG5
        lfu6YKjgjTmjxdGLlXQcN9rm/QVhl0irEj1BldaHkyz5eDOAalrp4Y+PLdFxXxBg
        ETv/KNZ5nyUbs/M/VOteOwOE4JKJE65wzCTHO/jVfh8FClbCYOwlIFz7W10dKczw
        lP1zXZLwD3hRDkIAoM8Vmd93HGeqNWeCnaTrO183jMZ+UxEZjaEVbyUF86fMMoGv
        mvKAVQCCTUZUgKCrIs3M5CGxdu1vii2oqyyEWsQeeezcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695889301; x=1695975701; bh=1wpuwcT6iosWr5eQVkB97Z8SGkAzGUmjmFd
        OXckEMq0=; b=imlmLDJhWNWZPQBhvqMMc2Mq6PGFOxKy5cYHEDIPTZ4bvxeAjFs
        b/zm+xWd8uotoIqUn2o8LiYPobp4xJUqIjEFqMq/moG6jGXf/uYh8AU9fg805Jxw
        CA672QGztaD+f6aGIPsKOJeMruHC81HlwEoIO5LnM+ADbKE8gv7x5Md/qL2c+H/5
        r3LgMEx8IU+qHvtnud9gC5C8HfOHzitsWwAqgH+4IvqjI95fEFeEb8ueMyc0TYjk
        fldEqYo3+FHYLTQKjYP9tZ8nBYwjsEy61j3hQAsYUuUEsRyefL35le5N8uKLH0/m
        FUU4iMfs9ZMCirD9Q3ch7UqpWgx0Q/u5GBQ==
X-ME-Sender: <xms:lTcVZfxE_StCpFKAHfVZmZX7oWLj74C-cj1mVcVdwqG1rCGgxGUkYsA>
    <xme:lTcVZXTjFq8fRrcCLLKQXmKQs2fX5CaGDRhPlr1Khw-9YvVZsY8iM4RqU-e-k8hxB
    SB6l3ru8UVLUcwneA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:lTcVZZVoaVuNcA0DwloF1UvzZ3j5Cp5CXPTJgYJf43SIfp20ItmK4g>
    <xmx:lTcVZZjRFoSN8SerHWRNdUDZNx0iEStsdkcNRnE5I8o6u-DcwpE7Kw>
    <xmx:lTcVZRCSaQJfXqUNRdwPIRGUYgu5CJcaWRxFSRFBvCW4t2xCub4lXw>
    <xmx:lTcVZc-QwCQ2kHCim_0IKzOzegxbvsp_vbZVIVkkV3F9VWkbaw74ig>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B9DB515A0091; Thu, 28 Sep 2023 04:21:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <8e315d35-7076-47e8-b3a5-6330587325e8@app.fastmail.com>
In-Reply-To: <CAJ-L=uAjXB67Zx1BPpdJYF_y1RS+UqwpyTMF1F4o3yO+1o76vg@mail.gmail.com>
References: <CAJ-L=uAjXB67Zx1BPpdJYF_y1RS+UqwpyTMF1F4o3yO+1o76vg@mail.gmail.com>
Date:   Thu, 28 Sep 2023 10:21:21 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Saurabh Sonar" <saurabh.sonar120@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature Request - Unique commits list
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 28, 2023, at 10:16, Saurabh Sonar wrote:
> The user should be aware that if he deletes the branch some list of
> commits are not merged or present in any other branch and he is going
> to lose them forever.

That already happens now, though? (Well, not =E2=80=9Cforever=E2=80=9D b=
ecause of GC and
whatnot.) You have to force the deletion with `-D` if the branch is not =
in
the =E2=80=9Cupstream=E2=80=9D branch.

--=20
Kristoffer Haugsbakk
