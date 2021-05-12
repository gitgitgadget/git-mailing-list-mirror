Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B86C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59DA6611AD
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhELDT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 23:19:58 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39521 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhELDT5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 May 2021 23:19:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DC39C5C0185;
        Tue, 11 May 2021 23:18:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 11 May 2021 23:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm3; bh=QFB3E+26jvE4/HRFsJjQpBl1ANMmBA4GVzy1uUonZ8s=; b=wiDPs
        /BSiS+tLv94tnWTFqSGVTUj9+GzHwj3qoCOmncdzTGjYumC/h2TYvTu9D+CkM/gT
        uDFeRMRupmMsjIksQQdMNT+rzHrf1oeIPj5foL2hPcvpZAhg6jvVKxPL+5Auh2DS
        66B3myGue7v0QR3u2EkxH57NwqUVQDHK72Xu+XDhEu53wVYboR+mbR44/S6/hD21
        OtkIVT5DIh03xvI0/eofIlPQSLD786kycNMQsm2cWvy+ZzO3uKx5o4qMF+sHo4ue
        HY9tOQCG+3ZYlPBzuRg7v4wfX0iebo7hTU8PGWvyX4GGPnewa6EvqaxxvkLeYdcn
        h+C3dY9I3jhvYnoHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=QFB3E+26jvE4/HRFsJjQpBl1ANMmBA4GVzy1uUonZ8s=; b=BHiVUu24
        /Zq4NYf9Wmh+Zgc051RcJKVrH/sctAZkuV1gZqvPnv4wLQSt0ClnPptZf/owaIw1
        onEedFIeRtX171O9FdH360+iiPBH8Uq5KNZaKKeID1kxzsf7HTFDrWRlaMf4Ybck
        /L8gM4y9OCf+dioL5O4O2O9tyjFxZw+Y+HBNU/Z3Za6V1kZ7RCLGgRAP63idXlAt
        VYl/jKNJfzaunFjbXzjpQcEbY/ylNtnqCM//np11gHMB++ocb/Q4XEELwVAu+aGa
        fTECtlkDk4aULIrP9TZ81xQhvYgJt0/ApeBgJlNnEt/OIzMATSR5G+kZxT0joXIx
        8ciffMDDU0Fd/A==
X-ME-Sender: <xms:GUmbYCS8iSzbWEqlDbMFaPO1lLVzMdeOtRpLV2Hq1_Hfsfras7emUQ>
    <xme:GUmbYHyP06YZiGFdTt0I_QCQ-nKXRP7MiqpqPuWQx99810iwhOdKWDN4cXWDnXWBH
    DvUGaOH6JWJa6LP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehuddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucfgmhhpthihuchsuhgsjhgvtghtucdluddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrvhgvucfj
    uhhsvggshicuoegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhgqeenucggtf
    frrghtthgvrhhnpeejheegiefhhfdukeeitefgvdevieeigffgfefhleejvdefheekfeeh
    ffdvgfdvhfenucfkphepudejgedrhedvrdduhedrfeejnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepugifhheslhhinhhugihprhhoghhrrghm
    mhgvrhdrohhrgh
X-ME-Proxy: <xmx:GUmbYP3XreDBhJssLek8PlwR3kdl9mULjoSObA3TOuQjKy8vZ_DqfQ>
    <xmx:GUmbYOCwMaKP5z9uIHpN-qa-Dx0KkM-fJFNomKKn7SnZTQdrEAdg4w>
    <xmx:GUmbYLhT1T58tIOPACcwCR7H56WTMFndaomuEl8RMpOTfUgaCMF-hQ>
    <xmx:GUmbYDb4-ZAB_Xz-jOqOM2SI2gviNc7uBR9PUp2j-PBXPEMGHPlbKA>
Received: from linuxprogrammer.org (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 11 May 2021 23:18:48 -0400 (EDT)
From:   Dave Huseby <dwh@linuxprogrammer.org>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, felipe.contreras@gmail.com,
        gitster@pobox.com, stefanmoch@mail.de
Subject: 
Date:   Tue, 11 May 2021 20:18:20 -0700
Message-Id: <20210512031821.6498-1-dwh@linuxprogrammer.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512025447.6068-1-dwh@linuxprogrammer.org>
References: <20210512025447.6068-1-dwh@linuxprogrammer.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Aaaand I forgot to Cc all of the relevant people from the previous
thread. I also messed up a name and email in the previous commit
messages. Both are fixed. It's been a long day :)

Cheers!
Dave

