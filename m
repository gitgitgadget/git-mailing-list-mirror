Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999B8C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E719611EE
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhEQTHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 15:07:01 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:50883 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhEQTGx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 May 2021 15:06:53 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 39CD7ED7;
        Mon, 17 May 2021 15:05:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 17 May 2021 15:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm3; bh=m7Q
        SIdzo4XBVmEdkSaqc/9A4+al13pMDo2hpyU1Me6Q=; b=gyXeK63Xkclwg2ly+pb
        Oq0PW2wkMrYV+6bRy9b8bJSycvW0Y2JHC5QBlgEhnmKkT+rSmUaZpQaJ8NeveXW3
        JnFnBgFl5CL8trMnnfHZ3v7Q5JuR+eI0FSlq3DIw40ZP52JovmaepPfnsTKf67dN
        foN7CbxklWEOFoGAgBzN+390qvHCe06lSxV0/gC3wYar1ZDnUlkeWaWk0Fkh+u8Z
        QBZhAH5FatCKE4deRb/i4VqkyacyvCOHk0DGY6w/vMgrW/ZN2RDAVWxXLKgMUp3N
        ayBEPfDblfjW8zR3stTwxh4uDgfcPmCPYNv15RIpnHr2xTKl7+uiO3V8AQcF7fxD
        9Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=m7QSId
        zo4XBVmEdkSaqc/9A4+al13pMDo2hpyU1Me6Q=; b=hJu2FOwpfp52WJB1QnsMgV
        cDHp1CZKyMMlPZJvokg+DBiICst8hTu1T4BQTei/4GdZKCQUS5TRphFKof5rU4ts
        43JSDOJaUKD8hkOBaZKoRk8DDIYfLcH1WYYRGvI8TEhvz+KBm4TnQO+kB454kbFq
        EgYCVwldNAmV69g+MbIiXgmMgjr1cKJJa9Kv0G5/RRviZYZRzUG9GX6k4PHWnmsn
        oX+AHPLGhv5wcxVPONdLfJXQcgiE+sSXQ19Ak3QqBRno20oqZAZ4+kOcdjddErHN
        0DLwKaB3jTKzDkw/wya3nt7yB0KJito6TQDhSLLG2KHSauw919nkM4X/rxbc+qRg
        ==
X-ME-Sender: <xms:fr6iYLFXhPTJv4sfDr4XwrqGw9sPcvm7Jl7GgK2o9ZdaO7XBM2T3Bw>
    <xme:fr6iYIV4RKBYeJQQWnMVHmwLG9y-BzoLe8KuuGrjqcDzPceO9XSmOnWkXqS98QmlV
    D9as6Ac4jqMgxss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeihedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtreejnecuhfhrohhmpeffrghv
    vgcujfhushgvsgihuceougifhheslhhinhhugihprhhoghhrrghmmhgvrhdrohhrgheqne
    cuggftrfgrthhtvghrnhepjedtueejhefhtefgieduudekgfektefgvdevfffhieehveet
    kefgtdetffeflefgnecuffhomhgrihhnpehnohhtmhhutghhmhgrihhlrdhorhhgpdhgih
    hthhhusgdrtghomhdphihouhhtuhgsvgdrtghomhenucfkphepieekrddvvdegrdeikedr
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegufi
    hhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhg
X-ME-Proxy: <xmx:fr6iYNImaynutxkoeazN8BmCtnif2v31LM0qTfNOtJ88cjdXxx_-fQ>
    <xmx:fr6iYJGf-xH1KXO6etdWzGq4IOxbI7wMWgO2YsbUR5JNTB9VtyRq-Q>
    <xmx:fr6iYBX7bs2GLfQMbGKoWACYO0PmXedmRToVfZz6kpPixSbVBm4A3w>
    <xmx:fr6iYOh1FHsCq3VoSbrCwj3iFYq7IbUZDydjUC1A9k8aA0lTZq3fSA>
Received: from localhost (ip68-224-68-5.lv.lv.cox.net [68.224.68.5])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 17 May 2021 15:05:34 -0400 (EDT)
Date:   Mon, 17 May 2021 12:05:32 -0700
From:   Dave Huseby <dwh@linuxprogrammer.org>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 3/3] SubmittingPatches: remove pine-specific hints from
 MUA hints
Message-ID: <20210517190532.GA1011@localhost>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
 <patch-3.3-9da5bc4a0c-20210512T084137Z-avarab@gmail.com>
 <20210512235136.GB10785@localhost>
 <609cc953e0ade_329320811@natae.notmuch>
 <20210513144550.GB11882@localhost>
 <609d875881c7c_80a2208e7@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <609d875881c7c_80a2208e7@natae.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.05.2021 15:08, Felipe Contreras wrote:
>Cheers.
>
>[1] https://notmuchmail.org/getting-started/
>[2] https://github.com/felipec/notmuch-vim
>[3] https://www.youtube.com/watch?v=JGD7IbZmnIs

Oh wow. As a fellow vim user this looks amazing. I had no idea this
existed. Thank you for sharing.

Cheers!
Dave
