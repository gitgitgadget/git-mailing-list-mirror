Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF784C77B7F
	for <git@archiver.kernel.org>; Sat, 20 May 2023 08:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjETIpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjETIpT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 04:45:19 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6BCBD
        for <git@vger.kernel.org>; Sat, 20 May 2023 01:45:17 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8EAD032007E8;
        Sat, 20 May 2023 04:45:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 20 May 2023 04:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1684572315; x=
        1684658715; bh=Cu7u4HJuSC/Qtwck/CIZTnu1185qcWr6LGtUi/ZLfaw=; b=B
        IXcqdTGhXj3KMRVy3DpM11bPIRm0Zp8IDqQGkFI6yeJXHgJALyMrw8BX6BkhHeo/
        dfbV+eOChIfhgorCgJye4j/ZzR3eYkJk9Z8SvmDaVIl2EWBnfkLFa3Fzv6XNQE69
        2wgufw4tuRgrJfwS/D+9ZtYrQfLBO6VFo4nUPuIgc4ytCc8mgMzqTTZ4xG6ar41t
        3W6uyYtrEC53zR7VCHmx6Wp8aXJcYqlcbOGUL+CJIFpakgVOA7Z9B6GIGeeqek3q
        q8qosng/NZbFiJcxNVmAaldJHFaKWmP7N+J5NTLvq3KQ2C0kEz2oHPfuggBE9vrU
        /cKN7L0LLxagvcF0eMT6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684572315; x=
        1684658715; bh=Cu7u4HJuSC/Qtwck/CIZTnu1185qcWr6LGtUi/ZLfaw=; b=y
        oNkL821KAflq2Ogun85ankLcBRjBmekSnnE5CwHCjosDZzbfkM50e8QBER96cGe8
        mOteSX6RkYkV5L775+Auj6+inCfbAAw33hbEFN02dB39nmgRREg+GvwLyYwEQFbP
        8ScXHwwVWFwf5MjkIl8hNExexqNu8FVWxipA05zlJBBgybS6/azrPiHdOUWdY6Mj
        liYawCq2/21lOMpnKbhbpfkLlwvZevRzBpaay84ShA6t0eLoYINVT3L5fmbat5Bf
        mLPWURVbRbgVwDpL3Xc7R3mQnipNKhAfurFraYOWrxiwyPpEUdFZloka2Q2WufRt
        uM2IiB5tz59VTbD80iJXw==
X-ME-Sender: <xms:m4hoZA4_ydCrHRKVIGwcnDhudS1udtgczJM3dit6D7WLh0znwEZtZIM>
    <xme:m4hoZB6JNEFWE62GiN9HWnxA-whTc59aSfP8KoceIh8EnfkozlcL3d0wQKLfHOAwU
    mP-NDL9IM2cDOWsiQ>
X-ME-Received: <xmr:m4hoZPetl1mRLPYZapmWBJfXnu72u_rNMNxIoZJgwdTIQZ_4CkUOiWXs68W1sDOsWw8OUQXOpAGMcFrNgmLrn5yzBukOX2jXPxr-aQYE9vELd_pMEjM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeijedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepteduie
    ehgedutdfgudevkefhveduieeiteejhfffteeitdegjeeihedthfejgfetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruh
    hgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:m4hoZFJoeEJFElo-oVNk0jXd3HNzsv8ogsri-2PMZW6AiwCjIPoYKA>
    <xmx:m4hoZELb2f7KXQYpIaT_xVN7wsS8DPQy-rJxCVOye3PrzsWbklDJaQ>
    <xmx:m4hoZGxDfhtGCSLspx8kNdGwNZ52jCaecJs0ge9u_5c2J0OE3I7ikQ>
    <xmx:m4hoZOhrgXfaBsNJneoGINIbwAxSaTQANHy85nkpDU4m08TL5nLWdw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 May 2023 04:45:14 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     minnie.shi@gmail.com, git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] doc: merge: fix mention of `ORIG_HEAD`
Date:   Sat, 20 May 2023 10:44:39 +0200
Message-ID: <c6337eba029bd5a53f76433c51bbe86c82faf507.1684571874.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0.rc1
In-Reply-To: <CAOQx3AYx+sSD4REfTdQ0muY2zRgzE2nR7RgG7cxNgXvwzYzixg@mail.gmail.com>
References: <CAOQx3AYx+sSD4REfTdQ0muY2zRgzE2nR7RgG7cxNgXvwzYzixg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`ORIG_HEAD` before the attempted merge points at the commit that you are
on (the tip of `master`), not the tip of the branch that you are trying
to merge in.

Reported-by: Minnie Shi <minnie.shi@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-merge.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 0aeff572a59..9019b6a1e50 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -38,7 +38,7 @@ Then "`git merge topic`" will replay the changes made on the
 its current commit (`C`) on top of `master`, and record the result
 in a new commit along with the names of the two parent commits and
 a log message from the user describing the changes. Before the operation,
-`ORIG_HEAD` is set to the tip of the current branch (`C`).
+`ORIG_HEAD` is set to the tip of the current branch (`G`).
 
 ------------
 	  A---B---C topic
-- 
2.41.0.rc1

