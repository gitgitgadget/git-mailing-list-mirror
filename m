Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EABC433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 12:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383773AbiAYMkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 07:40:00 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51813 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1383584AbiAYMh1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Jan 2022 07:37:27 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8294C5C00F2
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 07:37:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 25 Jan 2022 07:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=23L0VRZxeoQ703c1FvYDIc37u1hKGQMYZ+jnVkw7YdY=; b=LKfEB
        wLnPxYQxaoCsZbvO5+vJwMPnPDZqAQxT5xm6MKwEUNKVX1Dh1CEiR8loNauM5HiE
        1eNxns5w8MugUW/zCa55JIGx2Zd8OfXvWRSaL5KVXn/ANeyEO223AAqwOzVhbZKW
        1zubjV0miMvHaT8aGdnjwRw4/kkdlWiDPVssaLN+RzybaMblDbogIenz3ZzW9FOE
        XuZ2L+o9nqewNuXDDONGWG5LhIntYRzEOnrQ2+bPksjE4P77EDOxhUrTPodpUBw5
        CvWwSdVSSrX60heLCOgt98t4rI0CKmOqPzKwLsyWQ0WhI0zOGw0vbzlLRylYYitm
        ZsBY67JyuZ5T6ShvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=23L0VRZxeoQ703c1FvYDIc37u1hKG
        QMYZ+jnVkw7YdY=; b=eVbRHQatiPBy616VVVaS556qh2IeFe306tva4DYLBdKHj
        bjoyonN3GECOTs8GbKZP/ra9UUHxD1oH9PeqZTF+NyexsNBoMtG7nXdCslJuqRZd
        5u/L61+6/nRP42vnHFFhDkUaAy6m7wSd2Zqu1C00QTvgerGasg5aG0Ilfw+mmOT7
        G1fenJfV6lPlbgpjfgJFt+mStUyqWwFZoKHBkZjo09bh2oX9f3SWS9ES8VJgP3Tj
        1aK3iuxCbv5E/C4I0kMLPqNFWn7EUxMkygjN6JofeE/vbHDQf9FLORA9QB0IaI8I
        rhT9kNQhPLK/WGsGZJdjHXj4XjY0fh30icHG6HuFw==
X-ME-Sender: <xms:Be_vYe2Y76i-Ss2_WVgDrmy2USs0yixnzmcCWR-kyLSVJtmf33jdnw>
    <xme:Be_vYREn2_nQ0rKV7BRNhDQEUQ_djBG1wB15HiI8X0OBZillpkry0R8_Enlm9fWUP
    HXuy-kBlQpvd8-vxkQ>
X-ME-Received: <xmr:Be_vYW5AdQCeWSmyVMzFs3OeQUJZMrfqb9ui41KVEeSVLbk44VKDpn1fBP4W02OxZZPAMmsAa4aPWHFI3d38CSt0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdelgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefirhgvghcujfhurhhrvghllhcuoehgrhgvgheshhhurhhrvghllhdr
    nhgvtheqnecuggftrfgrthhtvghrnhepudfhfedtvdelkeeuvddutdffgeeufedvfeeuge
    elhfehhfevkeffhfdvlefgtdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepghhrvghgsehhuhhrrhgvlhhlrdhnvght
X-ME-Proxy: <xmx:Be_vYf2uGphIL2pRkvgmcWdqkOpYMc7rj_63X3w4K9SDkOklMRx3oQ>
    <xmx:Be_vYRGUE7Bp8pHyc46uaSBvJ2BbbtXP3EnnnDI2rq56BlQzoxsomg>
    <xmx:Be_vYY_t7009cDl1FACFYqHrUgCtcrmG76oQmi_oc413qLgul5DnTA>
    <xmx:Be_vYQzLvPY2NM-l3241kAlYZ_KybOqLwLguFmKYBDqQ_eEh0Zu8eA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Jan 2022 07:37:24 -0500 (EST)
From:   Greg Hurrell <greg@hurrell.net>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/2] docs: apply minor fixes to Documentation/config/pgp.txt
Date:   Tue, 25 Jan 2022 13:37:14 +0100
Message-Id: <20220125123716.66991-1-greg@hurrell.net>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two little fixes to the docs, adding a missing apostrophe and fixing a
mid-sentence tab to a space, respectively.

 Documentation/config/gpg.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


