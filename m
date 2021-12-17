Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16C6C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 16:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbhLQQRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 11:17:31 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48945 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231334AbhLQQRb (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Dec 2021 11:17:31 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8C9745C0040;
        Fri, 17 Dec 2021 11:17:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 17 Dec 2021 11:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=5udqMt16DRZ4s
        kB/Z+7/6zPBgeA8HRxniTupwdaaFyc=; b=Z1PybqoY9EpKvBTv7ioJl8HWrDhEs
        Jw+vtAZLm4nhNCcUSkv/R0V4hKlVvY6MwGoxG5eb2EjEb8XQOTUhUb2NBIFewEBb
        KZlr5tqiOI5+2mN3NgUzM7lG6jV/t80AJiwKbv15cBQLy1wvjyU5GAXOHfoUvcx/
        I5RfBcXNDe7kA/ux3yzTxtAYiVaXB7E7u+o8LD2INHxW4e5c5PhnMgxDvlSn1f3g
        7ESfPcW+uFLyIt3jlMBLnqZ1aFN1dOxNJ/DFILW8Wc6JrsCCxDbduhZriRQG1409
        aSTyG6snd2t3D9F6CTNJQ6NP9abhkBig5t1TD8ClbuaM3S87vQgGwIvjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=5udqMt16DRZ4skB/Z+7/6zPBgeA8HRxniTupwdaaFyc=; b=hVFXOsj3
        t2sImYt17OjfwcRnDuGdDPw759WX1YsDoBujNK2ZgZIdF6LgTDjxCsuqa2P+F6I9
        FQbFj4eGTU39x8u43JrrQgPqirUgXprltU8zhNUIaHgLwRjjB+GVWt8JxM80MDqz
        GgC08QHarrtTi3irYutaGJroWPeZZqGKqcImylLlonf5V57xBJx+KoeoVJC3fhCE
        muHpiDZzTGAs/p6eX15GFuCNgcapJhAU1isBCAEtS3LVB67qdwIIKNXD0uVRD9Ko
        ahXKWkLHZO1F7f6OQMKZT4fTI3I+MByNiHtLsbtGVhhejGaYyeQuMe1UvQRTbBiw
        kvm3Vjht74UErA==
X-ME-Sender: <xms:Gri8YVXtcsQYwGgWLiNi9rjpSUVzY56HNg6ZRhLrqtT8k2KZkeyHsA>
    <xme:Gri8YVmHe66-UIMOjP1ewstISkbCLb7rpiAiDQFRdL4bkHKqJNBvi94Lh8_zpdv99
    6U8gWA47YnPqiIY0pk>
X-ME-Received: <xmr:Gri8YRbvnjFxMsYyowr1hJvnTtSlwN71F5VeYfPioW-TFo71Lnm-Dra2oqxfYaB1ljmVBUdPP-Yk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeigdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepifhrvghgucfj
    uhhrrhgvlhhluceoghhrvghgsehhuhhrrhgvlhhlrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeutedvieffudeggeehudehtddufeeljeehtddttedvteefhfevkeeuudelhedtfeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgh
    eshhhurhhrvghllhdrnhgvth
X-ME-Proxy: <xmx:Gri8YYX8pKw1B6zBAlpFNS62RxsKyB7FSbro7HUPH1xQGjVspg07nA>
    <xmx:Gri8YfnG_hkUTcMr1WcYT5TIs6zYCP2Q6iCyV3CtcH-MpfIVZ6-4Ww>
    <xmx:Gri8YVcKsdQGlbQi1Q4A3x0ktRn6EW5NBx1skU8ytX2fKrRieALZ5A>
    <xmx:Gri8YeuYdnzhq17a3poPwXkrype38rmcaUSunESFf5uFMxu0_mmf_g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Dec 2021 11:17:29 -0500 (EST)
From:   Greg Hurrell <greg@hurrell.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] docs: add missing colon to Documentation/config/gpg.txt
Date:   Fri, 17 Dec 2021 17:17:17 +0100
Message-Id: <20211217161718.15767-1-greg@hurrell.net>
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

