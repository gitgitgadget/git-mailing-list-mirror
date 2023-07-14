Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FA3C001DE
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 22:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjGNWCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 18:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjGNWCo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 18:02:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7FF1BC9
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 15:02:43 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3728F5C0085;
        Fri, 14 Jul 2023 18:02:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 14 Jul 2023 18:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imap.cc; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1689372160; x=1689458560; bh=eJ2EE5vZWsWp5NnOb3oqFaXyRb2JKy7Mf3v
        WfT4G3OU=; b=azs8d4MxHXz+Z2y4bOZGLmzxCNV2rfeXJfVqjzGIH5VvPzQGPyQ
        eLvIQxyVqcEOUMYfgSORwlRsMbKM1gcGUVuprJ2HhL1Yez1QATVnlap3B9ISIzk6
        tRRXMO04bwZC+SSoYifm1MUoLRPWQ/V+aQbJr7aY4B3ih45fQlx+lldjwsv+tJHX
        vc3aDkrYp9ymi6yALDzoo5rWcEE6dUeKgQeSYplfgt6YQGDGufrZUjcf93jJ2TjY
        E/Xl3l8xa9NsRprSgxuGNt6tOgFFRq3WtLRzOob0+xTvQkq9BI/zfSwVpJJLgtQy
        Ej+C8Z2wNSAfhd3EKKmpkTa6RQPXOO8k41w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689372160; x=1689458560; bh=eJ2EE5vZWsWp5NnOb3oqFaXyRb2JKy7Mf3v
        WfT4G3OU=; b=a64Wpo45ln0ChuMklCOrqKktgnNipOY/cGgJHatQX0+dX8677EU
        O0rkPJtL0PV14M6+esAXR0CFdQfi7LuEQ7jAyHNUDq39MRY6F8ORSIKzyt29iVgn
        W496Ck2fNPINzuwEeWLQRmgl5cjMBDFgKP2ryToaaKxtUAeWC1oK6KEW7x9tdPG5
        RUucywc8gOw/0C72SICIf1GTPVWn9c4d6CRNtgtSIrfS5ipENQgRXzpFU/qL3lWJ
        7SCz06MPMp7reqT2Low2PYZFaA1jKTTBvT9MAw4OHWCOZbppLmrPUQWIdAybXe3J
        0WzqdVIPiys6vUp39/PCnDInNTLkbIXnAPg==
X-ME-Sender: <xms:_8WxZKaG_rIUG50Yji8bbbgz3N2r4ekBQ8oqeJQLSJv8RCtXKLSeMA>
    <xme:_8WxZNaUVkCePeVaGHVuNFO2pRMujm-V_gj-QjS3-gyBCq1_-agWt8OsKSbxbqJXI
    C1GUHr4J3CDfAb7MA>
X-ME-Received: <xmr:_8WxZE_7Pe-erGaA4GIBiC-aR3dLSgsQayJDFvjBrzgxPvX4UYd-MNz5_ebrUND57MELY4DP55lINerLx96DIuq-dqTZWIBhSK4D8GW88g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeejgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdduhedmnecujfgurhepkfffgg
    gfuffvfhfhvegjtgfgsehtjeertddtfeejnecuhfhrohhmpefrvghtrghrucgguhhtohhv
    uceophhvuhhtohhvsehimhgrphdrtggtqeenucggtffrrghtthgvrhhnpeekkedvjefggf
    etkedvgefffeeuledtfeeutdejfedtgeduveduteelfeeffeetkeenucffohhmrghinhep
    shhtrggtkhhovhgvrhhflhhofidrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpvhhuthhovhesihhmrghprdgttg
X-ME-Proxy: <xmx:_8WxZMpm5ACzMQ5zi2I1JmwFo_1ivdDT6nPbndmZrIuqVoIOPZI0sA>
    <xmx:_8WxZFoEFcAxRdX8VaOFmMKbgG18Ot-n5va36vTu8yNNm2GjKP4Bwg>
    <xmx:_8WxZKRSujpBWuQwYktW3BAoMn-Sf5Dht32grX_fjSHoaDnb3WVngg>
    <xmx:AMaxZESTy-HMX9tDm7Gv6EXveuBbx41KNyqeSHkUFFKQoYt1YP-vKg>
Feedback-ID: iccdf4031:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jul 2023 18:02:39 -0400 (EDT)
Message-ID: <0d29ac42-4e8f-71b6-b85f-00de182e2957@imap.cc>
Date:   Sat, 15 Jul 2023 00:03:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/1] docs: highlight that .gitmodules does not support
 !command
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
References: <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
 <20230713193342.1053968-1-pvutov@imap.cc>
 <a8bde495-57fc-6a70-e325-6e2a52f40552@imap.cc> <xmqqwmz3oacg.fsf@gitster.g>
 <9de918bc-6913-0486-02dd-5b4028a7fe1b@imap.cc> <xmqqa5vzo7jy.fsf@gitster.g>
 <xmqqv8enmr21.fsf@gitster.g>
From:   Petar Vutov <pvutov@imap.cc>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqv8enmr21.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/23 23:37, Junio C Hamano wrote:
> So, here is another round, this time the primary change is to stop
> talking about `.gitmodules` in the "update" section, but explain how
> `.gitmodules` file is used in the "init" section.

Looks good to me.

I applied your patch and then made some additions, which I'll append at 
the end of this message. Summary:

* Added your rewrite from yesterday. I like that it's more precise than 
the current docs, but I struggle with the complexity of the first 
sentence. I wanted to make it easier to follow by splitting it in two 
somehow. Instead I ended up with an introductory sentence summarizing 
the functionality with small words.

* In gitmodules.txt, moved the security disclaimer so people are more 
likely to see it before they follow the link to git-submodule.txt.

* Explicitly called out `none` and `custom command` as being unusable on 
the command line (and in .gitmodules). I expect that you won't want that 
.gitmodules mention anymore, but I left it in for now, up to you.

By the way, I ran into an SO question where some people were discussing 
the same issue: https://stackoverflow.com/q/65744067/876832

The diff below is based on top of your patch from yesterday, since I 
assume that you don't want to look at a mishmash of both patches.

---
  Documentation/git-submodule.txt | 19 ++++++++++++-------
  Documentation/gitmodules.txt    |  6 +++---
  2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-submodule.txt 
b/Documentation/git-submodule.txt
index 5248840b18..695730609a 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -165,13 +165,18 @@ checked out in the submodule.
  	merge;; the commit recorded in the superproject will be merged
  	    into the current branch in the submodule.

-	custom command;; arbitrary shell command that takes a single
-	    argument (the sha1 of the commit recorded in the
-	    superproject) is executed. When `submodule.<name>.update`
-	    is set to '!command', the remainder after the exclamation mark
-	    is the custom command.
-
-	none;; the submodule is not updated.
+The following update procedures have additional limitations:
+
+	custom command;; mechanism for running arbitrary commands with the
+	    commit ID as an argument. Specifically, if the
+	    `submodule.<name>.update` configuration variable is set to
+	    `!custom command`, the object name of the commit recorded in the
+	    superproject for the submodule is appended to the `custom command`
+	    string and executed. Note that this mechanism is not supported in
+	    the `.gitmodules` file or on the command line.
+
+	none;; the submodule is not updated. This update procedure is not
+	    allowed on the command line.

  If the submodule is not yet initialized, and you just want to use the
  setting as stored in `.gitmodules`, you can automatically initialize the
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index dcee09b500..d9bec8b187 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -43,9 +43,9 @@ submodule.<name>.update::
  	command in the superproject. This is only used by `git
  	submodule init` to initialize the configuration variable of
  	the same name. Allowed values here are 'checkout', 'rebase',
-	'merge' or 'none'. See description of 'update' command in
-	linkgit:git-submodule[1] for their meaning. For security
-	reasons, the '!command' form is not accepted here.
+	'merge' or 'none', but not '!command' (for security reasons).
+	See the description of the 'update' command in
+	linkgit:git-submodule[1] for more details.

  submodule.<name>.branch::
  	A remote branch name for tracking updates in the upstream submodule.
-- 
2.41.0

