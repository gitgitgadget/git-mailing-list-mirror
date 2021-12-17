Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734F9C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 09:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhLQJGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 04:06:05 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:41957 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229712AbhLQJGE (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Dec 2021 04:06:04 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E24353201E94
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 04:06:03 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Fri, 17 Dec 2021 04:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm1; bh=D2NX7jpcPBCT7A5eHBwFnNREaMNr9BuulC8Uu3xLS6g=; b=UnP/eqn4
        Y1ndaRYk0XPAJMvBV5QL4f5MmKAgRO4rlSnguUeup9c44H6K2FNFdcXfrh4IR7Q2
        UZYJrHR7PO2oHfyWHizy0ggLoDCCRGIkHW5Il2FGnAH8EnuzattP8lf9mkQx0/3M
        +FzcWV9fqba5gSSyiL8btOGJzMfU7jM9j440vX932EZnmJhYRyJOcXbBQs8gp2op
        arontKfTLX9E7JSwcBFb9O1330xCdv0pNry+IsXBYh1yFNJanrQtuU/OOrYLqJsO
        8WD6hup6yGy7O4H9W9IUAIjP4KBYdYsBaSaR5bEGVVlhcUbyqfmeTPbbvcsO6LKZ
        eXdHKQjTr1Qv8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=D2NX7jpcPBCT7A5eHBwFnNREaMNr9
        BuulC8Uu3xLS6g=; b=QRFKlqq+ie3/2AaSA3Dx1oTRnErHOXO3vq+J++HClHShJ
        ADNBcpOr8ffX8kkNpWR9P/0LjYoOMzo57sGwd1g+gWaXCLnMCmxl48mmfN+KtDIl
        wFxSrGMfbKgL9Qw/oXrVNXK1V2mYZZKtW27tcClFe3m4/9Wht65BkwZham2WHe+H
        LRSzN2l7gBm6yPxizN8wuP6m13U2oYIO5514SG0BeUAC9awoCyrMeMqx8Ag0quww
        6V3sqTyW2oVOJPtdX2EAzVF0GwzrtNf0k5J3lPwfjADOsDpwAkdLj72PECV5SnyL
        yyRKrwbhvHlPONOj4jXJ9OfbmbsERiToyUYn10okw==
X-ME-Sender: <xms:-lK8YekCMoAbTZLwTehxil8N_NFR6eawl3GAjqFIZoUM1BgAKwuScw>
    <xme:-lK8YV2vqohIH4nCDta3WgX794oWBfk4ovc28UcqAbOr1kwCBApieLR2y2xK4y7ls
    NM3l2xsUU4S1M9CbGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleehgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfifhrvghgucfjuhhrrhgvlhhlfdcuoehgrhgvgheshhhurhhr
    vghllhdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffjeffheffleffteetleeivefhve
    euvdeiffeugfffffefleelvedtgfetueelnecuffhomhgrihhnpehgihhtqdhstghmrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvghgsehhuhhrrhgvlhhlrdhnvght
X-ME-Proxy: <xmx:-lK8YcqQVtEwDj9ikFc0PtgjIJgGT8DnR5r6NuTKZZZrICHnVEn2nA>
    <xmx:-lK8YSmODNP4kU4XjtaYgl_LjLhJ6mbWBsiQZHhn4mCRIQo80zVFcw>
    <xmx:-lK8Yc0hIfy7KxEO3XPEWTIpK4wdlm-So6bB810Ki6RRlxse-wZijQ>
    <xmx:-lK8YdCBPkVkiY8eeGT2C7oIRmWBdNqOA1fMeaiSaDVUAOq1UH1Vmg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 124211EE007B; Fri, 17 Dec 2021 04:06:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4524-g5e5d2efdba-fm-20211214.001-g5e5d2efd
Mime-Version: 1.0
Message-Id: <1e5dba11-fa01-44e1-b341-9d69bbdbbd39@www.fastmail.com>
Date:   Fri, 17 Dec 2021 10:05:41 +0100
From:   "Greg Hurrell" <greg@hurrell.net>
To:     git@vger.kernel.org
Subject: [PATCH] docs: add missing colon to Documentation/config/gpg.txt
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The missing colon here caused the docs to misrender in places such as:

    https://git-scm.com/docs/git-config

where, the `gpg.ssh.defaultKeyCommand` option lacked bold styling and
didn't get an anchor link like its neighbors have; eg:

    https://git-scm.com/docs/git-config#Documentation/git-config.txt-gpgsshallowedSignersFile
---
 Documentation/config/gpg.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 4f30c7dbdd..94eba373cc 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -34,7 +34,7 @@ gpg.minTrustLevel::
 * `fully`
 * `ultimate`
 
-gpg.ssh.defaultKeyCommand:
+gpg.ssh.defaultKeyCommand::
 	This command that will be run when user.signingkey is not set and a ssh
 	signature is requested. On successful exit a valid ssh public key is
 	expected in the	first line of its output. To automatically use the first
-- 
2.33.0

