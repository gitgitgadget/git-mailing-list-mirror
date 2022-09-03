Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA67ECAAD4
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 18:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiICSsy convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 3 Sep 2022 14:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiICSsx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2022 14:48:53 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3CF5280A
        for <git@vger.kernel.org>; Sat,  3 Sep 2022 11:48:51 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 167C83C138F
        for <git@vger.kernel.org>; Sat,  3 Sep 2022 18:48:51 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2CE873C11AF
        for <git@vger.kernel.org>; Sat,  3 Sep 2022 18:48:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662230930; a=rsa-sha256;
        cv=none;
        b=3nE5Cm0rDfXUr7OjDjU+wUjourjwXU2rXtqYySVk71jk91qkMMWFRgC92DBRwh+rEof92A
        H+Ied+TJXpwXdyAUgURXEVn3tmoLiuAQ+DfE+2jFUl98Jv5xp3NfoH1gR4fUibM/3zPkuk
        Da21l4Jb5r3KbcSpi0unSScUZ34E5wrp38bGhfq51Hm9ziu8co/3o2+41VL0eNzOYKZHKP
        RniJKTYBSQfC4H2Y+DLXzmEhRQ1nPl1Xo1zArGiffdV3Nk/6jboxDKH7E0cBzzoLmkqTDB
        9jwj+uD6+bIC+bf8UMhJXfC/Puq+Y+qC7ruVjYNlyrROChR6PLKUa87xmQ/cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662230930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=S6wczgz7V901p95+tSyO+4E/3clXF2Hxj5Q/xaElmwI=;
        b=sk7tVJsdIm8wx3PY/+sGH+q8JDkIVfEFQYTrhe+o/pKdbRaluqNsB1S5hzFTukxluSUnAH
        IwNQUs+/aj1fg7mu8smJ2BECg8wiOX7CEPkMEuDnmKNOwWHwDsFYEwNE04t5uTmv2w5b73
        APD8pRcXg3Ni4gHS8HVQcNMGPqBVfRY0i+ClgXg8ymr4czqck7d/yWpOSpUeIVH/3xPbHi
        5o8nEc7BBZBozwXTS78+MNcCgq8Tgex6usNnk+TuUUmtrFefoPid3/t4Ks+WV/VQyVhLvw
        R089wUmUQgPjwFMzq/VC+wbo29jl7xNcBjVF3MyGvc2cvg0lQKKWZWu1bRnOFw==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-x2vss;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Plucky-Language: 1a84f3d64810ae17_1662230930652_2528070737
X-MC-Loop-Signature: 1662230930652:2412625365
X-MC-Ingress-Time: 1662230930652
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.103.147.32 (trex/6.7.1);
        Sat, 03 Sep 2022 18:48:50 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:57936 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oUYCE-0008Oi-R3
        for git@vger.kernel.org;
        Sat, 03 Sep 2022 18:48:48 +0000
Message-ID: <4e9ad5486e8a887f1e92cc4e401ca61be5f2bb9a.camel@scientia.org>
Subject: status on security of embedded repos?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     git@vger.kernel.org
Date:   Sat, 03 Sep 2022 20:48:43 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-1+b1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey.

A while ago there was this discussion about security issues with
respect to bare repos embedded in another repo[0][1].


I just wondered what's the status on this? Was that fixed in a way that
one can clone untrusted repos and navigate / use git commands within
them, without any risk… or is it still open?

Saw proposed patches like:
https://lore.kernel.org/git/pull.1261.git.git.1651861810633.gitgitgadget@gmail.com/#r

But it seems at least as of git 2.37.2, ther's no safe.barerepository
option, yet.


Also, couldn't the same happen for non-bare repos, too, or how is that
prevented for such?


Thanks,
Chris.


[0] https://lwn.net/ml/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com/
[1] https://lwn.net/Articles/892755/
