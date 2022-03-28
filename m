Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87049C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 22:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiC1WcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiC1WcN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 18:32:13 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C86447AF6
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 15:30:32 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 731DE32020C1;
        Mon, 28 Mar 2022 18:30:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 28 Mar 2022 18:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=Xzui5rsaW1vv/ampjOQkbmT4wzzlMs
        y7x1WClz7l+HA=; b=XnoWK9Pdj+Fq7OUyMkuuCsg2vG148n/fxQPMK6zdJg69Tv
        dTerq2LH3k61vlnEdor6c9fuhE8+tXBuqbgbYA//PZHsym9LcXgX+N2PlrWzdab0
        ibhMFo+ZzSGDyJ2jI+Vz6AnQc6fWLxhOUj78EmToPpa+1L6Z4SBYwYSa9hm8pRLd
        1gdq4gc87sptVwmpLA4lTVAjNzS3d7Y8v+u3wUPK/8zYBEHzjFAztmSZQZP0o3gJ
        YorI7TFoQR6FZrEn/GKOWQFpDTvOZS8C2sjqunCrM8XPhwXD+18aFaIxjLc5ZNlo
        J26CUS+xnLwfzpvVoFs39rET1ecxqqa+nXpKRzQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Xzui5r
        saW1vv/ampjOQkbmT4wzzlMsy7x1WClz7l+HA=; b=Sh7Ls/T8oF8CTDemN9Rrle
        VOTJtKH+h1ENPNu8Frz+9DmJGmiOWGW9bO2LJBrfc0U8UBg8MDftZMWKoeX3y6wF
        LNTH1T0A808cjhCQvLFM2rWL7HlSWj6k4kfkDGC4bcaxfYN7HAoNmXAyaaTJQ4hl
        oOyRglR/JOd0lgmok3FEgRIlitXmIzlRcZNIoxNY62G8zNlmf1rPJc3tXlXKFldK
        J9xSUiqL2h32vRqPhj8JlKReNVwYraLwnQ1KDxQ5tifIAmlPhwPQelSRbQoOZnKI
        eKvh5BN6NwMyvx4CoFWN6yX3TaqEwIUJSBWx7FR8WAKdKJiGwdGgm4pU0FTgv09Q
        ==
X-ME-Sender: <xms:BjdCYgvKbWED0Vw04Xw-yL8WH0dFuY6c8Dn6aHz1k1KuU4tMyRdIdA>
    <xme:BjdCYtcEXzMPpa3XSpeCUzcUWZpidJAj2XBA0YXQT00nFVGR6O7g-npWOKZ_VgblM
    _zMuTe6Gtmy1MJlFw>
X-ME-Received: <xmr:BjdCYryRYh3YU7xTOhs26PHM0lAyk8H42AqW2JqOOtPIXFSIYbDoDfAZOJHlymCZV8AWnmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepkeelkeejtdehjeehkeefgfegvedvgf
    eugeffueevudfhheeugeekieejvddvjeefnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:BjdCYjNhGrgtSxgzGAmSUDE0CXxAbuaV-dAyoYWlh_O7XWQHwn3zpw>
    <xmx:BjdCYg_51iehqDg-2oHhiVJqZ4ipKg3pgIapODxeF4WcU2ngb3UFrA>
    <xmx:BjdCYrUhBjeB3AWkMasARHlt_qOIkD6wp9Gd3t6q-1Shoa6Ci0kAcg>
    <xmx:BzdCYgzI3fA3DnGJVwmPUNNWz10kVgqp0iKIWikrSuNuOVm-gFDv5w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Mar 2022 18:30:29 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com
Subject: [PATCH v7 2/4] vimdiff: integrate layout tests in the unit tests framework ('t' folder)
Date:   Tue, 29 Mar 2022 00:30:17 +0200
Message-Id: <20220328223019.271270-3-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328223019.271270-1-greenfoo@u92.eu>
References: <20220328223019.271270-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new test case file for the different available merge tools.
Right now it only tests the 'mergetool.vimdiff.layout' option. Other
merge tools might be interested in adding their own tests here too.

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 t/t7609-mergetool--lib.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100755 t/t7609-mergetool--lib.sh

diff --git a/t/t7609-mergetool--lib.sh b/t/t7609-mergetool--lib.sh
new file mode 100755
index 0000000000..d848fe6442
--- /dev/null
+++ b/t/t7609-mergetool--lib.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+
+test_description='git mergetool
+
+Testing basic merge tools options'
+
+. ./test-lib.sh
+
+test_expect_success 'mergetool --tool=vimdiff creates the expected layout' '
+	. $GIT_BUILD_DIR/mergetools/vimdiff &&
+	run_unit_tests
+'
+
+test_done
-- 
2.35.1

