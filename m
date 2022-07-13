Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17660C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 21:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbiGMVdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbiGMVdq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 17:33:46 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B48BE23
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 14:33:44 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 657CF320096B;
        Wed, 13 Jul 2022 17:33:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 13 Jul 2022 17:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1657748022; x=1657834422; bh=t02bshwv8G
        /esnPy9tcE21m5aO8H9erS5Z1vascGnCM=; b=CPw43gMFIaS8D7mpcJoQg8uWiO
        eQT/ta/rm1YIdVGCbuph+aJnQMgsEu0uBkYp1lDqx1sCAh2RG8cfyN/i8z7zK0iB
        i6wVzzgjHsEVwYqF7Lg/LmrF06yWR1EVf3/ZNwB3ZYH4z9DJlIV5zEEJsYjIdYTR
        KcwXZZjRPNKs0UuSclYXkLB7tYTgs5WsHWu7Ne8uyLS9+b+LkRkfR7HYQu52793f
        mNbkKg7e3XDuPsYivCz+YAyQxq1I09PQNtRGXUGU+IZPabfv0WYAuV1O5sWwpmuB
        gek4q3OQIdJ3SnzDH0IzI2eEPs4D4d+S/NORORnz6oiLUqZUuf1zoqU8yhBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657748022; x=1657834422; bh=t02bshwv8G/esnPy9tcE21m5aO8H
        9erS5Z1vascGnCM=; b=p2jX3T1dORNr83Cu3SWR9LM4Z44i95nD5ND+RUjk3sn4
        znWCzt2e1eP3UIQUcMxefmHRAuNBCDcNNYu/57iwmJD4/tvYvgqvYYFnunUG9KhQ
        awSgR51CwFoAEHjvo73KIMzYABZrl+UmlllGaR3YzhVPHL1HsobCF95NJEGsTN1/
        ndfYSlTHXs6Tnj8rOuoJoZc4DYcPkbb5VeUFsAd+Tlwb2JmO8VfhAsMp51mvIBQb
        RtQQc0zI3Ass8Xf4y2AozyqX9DYOnVRPY8Y87tuI9qtWmQhWduXONPPVZ9ZVZS1B
        SO0F9nNGOtJHKJWLcJjrRze/xygb34mFHyYrZo7WRQ==
X-ME-Sender: <xms:NjrPYnToWPa6O9ueyCbhM_fE8zZXMy9fTD0wPrli_vK69taCvJ4uCQ>
    <xme:NjrPYoxNme8zBEzUfoozZBgAKnptO1sutGlqSypMKRQlhBVKmm4SRyrhEBhxm9VZ2
    Jl2YQoax0eLGQaDrA>
X-ME-Received: <xmr:NjrPYs0kYpyRFWg7zq9cilkCKB5LpT10_UA88bRCl8scg1Ot6jmJfKctk-kBXhzO0-EpmszC0qY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejjedgudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghr
    nhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrg
    htthgvrhhnpeffheevteefjeevieekheeujeeivefguedvieefleeuiefgtddtleelheev
    ledvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:NjrPYnBFubrQjMlJafkONXsssjx-gwHwwpPYO10ZcTEppUgx3xES7w>
    <xmx:NjrPYgj1yFQhvYHzQegg1fGWV05d4K-Xi4gOrtPo5f_Ou2TGLd7lNQ>
    <xmx:NjrPYrog_PkJtAhrfmzMB1cgsUIzlPMfJivCC2M5uhVOF9lvOh66XQ>
    <xmx:NjrPYjubCt2pWTfNTy7uVlzEh3F6Bbc7lF5AjKel67sIk5KMca0fOw>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Jul 2022 17:33:41 -0400 (EDT)
Date:   Wed, 13 Jul 2022 23:33:38 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mergetool(vimdiff): allow paths to contain spaces again
Message-ID: <Ys86MnwhembiXRxj@zacax395.localdomain>
References: <pull.1287.git.1657726969774.gitgitgadget@gmail.com>
 <xmqq7d4gbu10.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7d4gbu10.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/07/13 02:08PM, Junio C Hamano wrote:
> 
> I think s/1/true/ or something is in order, perhaps?
> 

Yes. I was just looking into that.

For one, as you said, "1" should be "true". That also changes the expected
output.

Then, in addition, the expected output needs to be re-adjusted once again if we
plan to apply this patch on top of the other one from two days ago (the one that
adds the "leftabove" keyword to split subcommands).

After these changes, this is how the original patch from Johannes needs to be
updated:


diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 56516ae271..3046dcd0dc 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -623,7 +623,7 @@ run_unit_tests () {
 		done
 	}
 
-	base_present=1
+	base_present=true
 	LOCAL='lo cal'
 	BASE='ba se'
 	REMOTE="' '"
@@ -635,10 +635,11 @@ run_unit_tests () {
 	cat >expect <<-\EOF
 	-f
 	-c
-	echo | split | vertical split | 1b | wincmd l | vertical split | quit | wincmd l | 2b | wincmd j | 3b | tabdo windo diffthis
+	echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis
 	-c
 	tabfirst
 	lo cal
+	ba se
 	' '
 	mer ged
 	EOF
-- 
2.37.0

