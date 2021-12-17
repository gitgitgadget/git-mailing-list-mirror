Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A303C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 16:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbhLQQN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 11:13:29 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42155 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231298AbhLQQN2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Dec 2021 11:13:28 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 757955C0174;
        Fri, 17 Dec 2021 11:13:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 17 Dec 2021 11:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=5udqMt16DRZ4s
        kB/Z+7/6zPBgeA8HRxniTupwdaaFyc=; b=D34SZjOCfLCu6tsYeEfmGXqL2/BnV
        1qGmcMyYcmq3mOGbc4iTQ4eWoioLKNw9JQJaOrmd+n9SriBnVL7BHM08ARJYx7N1
        s3xUk3p0kTNA1n3Rho11/6TxkGCyJAZEV8QzzfBFe5Eo5nQnKky0y5oz01JfGtfO
        HPDhEJDTqal2bTJsjYpZr0bGC/LBa+DBJoO2+6j6mYKyp0OMvwtNMt0MYhUzpmrh
        voPqMnSRphKq6VMezEgD+8JrZ6hk6d0m6gcMYdNRvRY9odO3sp1ruc89YyV+BCSZ
        LqA4ZrE0uf7jQigBpMPHlBOpQqo9hC8ila/yH5UfTmnF0MOJTBhD+8X5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=5udqMt16DRZ4skB/Z+7/6zPBgeA8HRxniTupwdaaFyc=; b=hVDQ4uJq
        Ql+fshpFkKiEMFLUbtDpw8dqOcG91/11ccsWQV5FXINwONL2kwKoOHs/39xa3Ek/
        Qa60dHyC148LSPqIWh05xZ/Xe5Q2kzoI/ckxVinX85Adkww35wwUcbt9UCJBXQE8
        KPc6tGA/U6HMrJ8DkKVgL8uotJ9V0SXm85dVKlPDQZBquFBRDQT8vKpw4zllGmhv
        mc1FFkjM8cmEfOGxRYf2/Y7h38ArbrwZvdhbhwOPh2poE5xTboA0llb5OSNSN9RM
        sYdzJsnWiwGJFGaVWEjg71VcN8k8DRFPWRO5gxdeGjemy9JnB/SHUNfd6vty62iN
        NlRiNxWQbDPq7g==
X-ME-Sender: <xms:KLe8YcjXGbgCko2B_8lTanBsdBI1C94yp40UBHv51e39lWnXvdDqCA>
    <xme:KLe8YVCsND_RFr-Kz5GCTMH_0cVMbdnUD-mdcE1yta7yZEXBOLOdFSFZEwiz1LUdU
    92s59aiS-O5Wm6GDac>
X-ME-Received: <xmr:KLe8YUGWXW0ynlZCXSNjtlZe5wWuC7axuRLzT__KOnr3sic_dklDx56i4OGPv5UdHmEAmMa8NlFT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeigdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepifhrvghgucfj
    uhhrrhgvlhhluceoghhrvghgsehhuhhrrhgvlhhlrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeutedvieffudeggeehudehtddufeeljeehtddttedvteefhfevkeeuudelhedtfeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgh
    eshhhurhhrvghllhdrnhgvth
X-ME-Proxy: <xmx:KLe8YdTLpszFb-KoqtlqlIVx9I5zobYkPey99f5K_EtslbWw9C5ijQ>
    <xmx:KLe8YZwF2fkieQnST0DAUXJWGTLivo0daAoOsx2FQEIlMrL3Tf9zGg>
    <xmx:KLe8Yb4nKFE1YWg_VVNvv7-eXI4LGDRKrxXZL01C4aLy4aX7CkjGXg>
    <xmx:KLe8YXbaFHi72qluf2N1ULSbXsK4JNLX7WPjieKxLJulYGqCJbqQBw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Dec 2021 11:13:27 -0500 (EST)
From:   Greg Hurrell <greg@hurrell.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] docs: add missing colon to Documentation/config/gpg.txt
Date:   Fri, 17 Dec 2021 17:13:19 +0100
Message-Id: <20211217161320.15311-1-greg@hurrell.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAPig+cTfL3e28geHMG6aga-1zSSYSgXknQKO-62msn3LO=+iZA@mail.gmail.com>
References: <CAPig+cTfL3e28geHMG6aga-1zSSYSgXknQKO-62msn3LO=+iZA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just added a Signed-off-by and reworded the commit message
as suggested by Eric Sunshine. There are other fixes that could
be applied to other places in this documentation (eg. backticks,
capitalization fixes etc) but my intent here was just to fix the
most jarring problem.

