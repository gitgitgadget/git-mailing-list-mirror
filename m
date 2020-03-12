Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B17C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A52206F7
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="inck9jzP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O1JKWXFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCLEQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:16:09 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34135 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726377AbgCLEQJ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 00:16:09 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 17EA321F48
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:16:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 12 Mar 2020 00:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=3JtBMOVBTv2UbX3AQXePzOOrvOTalOg6dkZ6YNvk3pI=; b=inck9jzP5kHJ
        KdFiyqDTN+TglDGubOY1ed3uIGsi9bL2XP+NMf7CVuYxDZSvD+ioVgjwdo1d6xOo
        /TmYDXjZu1keBnrNpUPkjkYbHNpB6BvUsOAmFClHc+ETvrz26cO6IL33f30jzuba
        /m4d6fvONcKsvCT4CmET+ZmvxmFaSE8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=3JtBMOVBTv2UbX3AQXePzOOrvOTalOg6dkZ6YNvk3
        pI=; b=O1JKWXFwVAjSODvv8JS4mEWUPCEebknuOo+IECSaryBy7+boypXu+VMtP
        nvNyGB8jYFxQVLycHvYzUI3SsXOniXwHJM21CKEP3vVicfFGXc7CJY+FWrTjm3l8
        1eOfzlAyrvoc5/FDdC7GZCD68mmySjtG5rukVwRV5/lg44zA6LkEtJwF+QMI7mWU
        BkBuBUHUf3noJ519D9wTjYYF9YUywoFiMeZDCuG4DmcKk6i/XZPArZKBBqYWC7Bu
        TPbLvmZBXU4lTqBuqRIcAxgU/l4VWSzuI1FcMEdx4ZNORRPoK/7AJPVTOFknM5Kk
        vJgaigRuBO1CKS5ca8Ki0tb3ECClA==
X-ME-Sender: <xms:h7dpXmFyBPcSat5cMlqxF95LJhzh7RgbyNCjIF6Oe3u4lNMy_XCHJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:h7dpXnjPXO9jOa3DazR1WAz4YGgCo7D2R620ol8UIECplGp_kVNm0A>
    <xmx:h7dpXh9vZMdgh4MV5ZHGW-BPaKCxjTABwB7Djgl9M_Cwlpai2V8hBA>
    <xmx:h7dpXuqn813XXbOx55nK5mCuwgyju-ezXrxdp4sXVSAri1KXjKo-Rw>
    <xmx:iLdpXjwbS7oGj-sg-wb6UJHsgIdqBlHMVmtxfACUsDEkxXeeGWVujg>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 47C2F328005D
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:16:06 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 17/17] Security
Date:   Thu, 12 Mar 2020 15:16:04 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <A982100B-A7EB-400F-83EA-75F14D7260AF@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Demtr: what are people doing to prevent security issues? For example, 
not allowing things into trees that would be problematic for various 
filesystems.

2. Jonathan N: transfer fsck objects by default, to validate at the 
trust boundary (in case some code paths at use time are missing some 
validation)

3. Peff: we have had buffer overflows, most are logic errors, and mostly 
paths related. Recently we’ve tightened up which paths are allowed. 
Forbidding things that might be valid on Linux, but problems on Windows. 
Can’t catch everything though, because Windows is so so complex

4. Stolee: I am fearful, and do not know all the rules.

5. Peff: I don’t think it is possible.

6. Demetr: only latin chars, numbers and a few other characters. Do not 
allow any special symbols.

7. Brian: that’s going to break lots of existing projects. Some 
projects have never been on Windows, and therefore people have no 
concern about Windows. People checking files that are strange to 
deliberately test strange files in their own software. If Windows has an 
API to test filepath, there is not much we can do to protect it. 
Compatibility is important.

8. Peff: probably some cleanup needed, maybe can’t clone git.git. Some 
paths that are innocuous, are a problem in strange situations.

9. Jonathan N: what in Git's design scares the crap out of you?

10. ZJ: GitLab shells out for everything. We had injections. Now we have 
a DSL to verify things. Looking at --end-of-options.

11. Peff: C is terrifying. Rust rewrite please. Still have integer 
overflow risks. Tried to deal with it a few years ago, and found some 
more a few months back. A happy story: OID array uses signed integer, 
because no-one has more than 2billion objects. Someone had 3billion 
objects. Just the SHA1s are 60GB. Found it because it triggered overflow 
in st_add. As soon as they wrapped around, it crashed, preventing under 
allocation

12. Jeff H: communication between processes

13. <musical interlude>

14. Peff: I feel good about where we read and write strings to each 
other. Maybe if we were using JSON encode/decode it might be easier to 
handle obscure cases
