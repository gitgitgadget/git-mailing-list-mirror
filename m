Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9FCC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 15:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB3560F38
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 15:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243008AbhHJPYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbhHJPYa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 11:24:30 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9609AC0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 08:24:07 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:53652)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDTbp-0005L4-Ut
        for git@vger.kernel.org; Tue, 10 Aug 2021 11:24:05 -0400
Received: from auth2-smtp.messagingengine.com ([66.111.4.228]:36413)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDTbp-0002Ot-Rs
        for git@vger.kernel.org; Tue, 10 Aug 2021 11:24:05 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3475427C0060
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:24:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 10 Aug 2021 11:24:05 -0400
X-ME-Sender: <xms:FZoSYZIJYG6qfxGVMJp-Zj7w48un8_Iq12SQPbLk4D4km51KW4ZQfQ>
    <xme:FZoSYVJbC_5U0iOeLJY8wLCUwvsh45vYvq7J8Nt-R_OR-_nTtuZ6vzgjaXePI-h96
    3hZLsLuGf8dmA>
X-ME-Received: <xmr:FZoSYRvm2aF97G_dpPvH8GyHmLtFtCjYhVTKsmfWIVhUiLYdLW0g9N708ksInyrs0TmyZS9QpcLl8iQlQAQMow9sgumh8fY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeelgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvufffjgfkgggtsehttdertd
    dtredtnecuhfhrohhmpefvrghsshhilhhoucfjohhrnhcuoehtshguhhesghhnuhdrohhr
    gheqnecuggftrfgrthhtvghrnhepveevieekteekveeigfefffeivdetgeduvdffueeuud
    evgedttdehvdfhueevfffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepthhhohhrnhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqkeeijeefkeejkeegqdeifeehvdelkedqthhsughhpeepghhnuhdrohhrghesfhgrshht
    mhgrihhlrdhfmh
X-ME-Proxy: <xmx:FZoSYaanSn4n9pt3o0u4sCBEXX54hGcWsYnHQqBGUrrenFO_LBFb7A>
    <xmx:FZoSYQZKtJU-kvs0huhYOJ0SC5z2nudpH2_GrhX4kPx5jv7KXHEB8g>
    <xmx:FZoSYeCEs6qacXKHvb0EtZ5uI8ygfCOnUrcBSmak_e569NEEtWAVdg>
    <xmx:FZoSYW3mzF0th-lg5yeufTTaHJOy8TFJ8sUk1S_SQsSKucAsHnVJSA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Aug 2021 11:24:04 -0400 (EDT)
References: <20210810144358.235603-1-tsdh@gnu.org>
User-agent: mu4e 1.6.2; emacs 28.0.50
From:   Tassilo Horn <tsdh@gnu.org>
To:     git@vger.kernel.org
Subject: Re: [PATCH v3] userdiff: improve java regex for array, qualified,
 and generic return types
Date:   Tue, 10 Aug 2021 17:22:37 +0200
In-reply-to: <20210810144358.235603-1-tsdh@gnu.org>
Message-ID: <8735rhmigc.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gosh, I'm sorry.  I've just discovered yet another corner case that has
to be catered for (generic return types with wildcards).  Stay tuned for
patch version v4...

Bye,
Tassilo
