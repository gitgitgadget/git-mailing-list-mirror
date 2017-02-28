Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B36201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 19:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbdB1S74 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 13:59:56 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33294 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdB1SmY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 13:42:24 -0500
Received: by mail-pg0-f65.google.com with SMTP id x17so2525016pgi.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 10:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pOEfDHCczvHK5xgr6UvDeN7Yoan1xf7IIK6Nv1d1BBE=;
        b=gfdK8x7EJxbQUUDVx1T0Dnchxai9JVqX4dBo87hCljsdhTIYsczGD1YhO2cK44FzLA
         dqNWvMscpgbmsOQbTPTAqIxisEdXB02BRHQZdiDyz8nbnQkGQXDNnPfgw2C3RmSLAROy
         rL4OCBrbFY88qtxQBcO/Xg/z8ZcKDe0qk8wKnj/eWLkN+BGjCCBHMAgsrzSKayGKKS19
         McEkKifw0O/UAqfJwyWtydBQuA8Ak/nFT8YfO6TD/LtBm44qEuAgXWVMuYPndWsQJ2lb
         CWkYY6jFKNgZQToawk+GkOfWIUI3Kjzl0aM0eBc/0GO+OmpxQPt1m7NQK7SGdNRUEXPN
         fABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pOEfDHCczvHK5xgr6UvDeN7Yoan1xf7IIK6Nv1d1BBE=;
        b=OVrmXS6qJDqxdRt9N5xBuJwKcLMkcLdsubFzTclCvN0LeIP0drjSnDOeV/DVv9midZ
         GILpgUaYKAQn8QJgYQ//E7fgq9pHCkuqH/oxOqS6jExON7opPZgjO2GxuxFuGXz4yYwT
         Lo+vNtImwUfOzX4aiBXjKuW5zVvvFVeCKjMIBj6gyoyhRL4PKMgcVW8QRq2axCctzLdg
         ginWcnlEbCtT8ctk17S+V66tjcBbHT2kBQBo58b+Zmswcjj+/PW0eKvxxiSnmx3NIlZT
         PkAciOxSoptRKA1cOOpLGiYz3A7PUT+xKDIYAaU6F+yYv37IKb4vY5XcyOLis+WIOB1F
         wS3g==
X-Gm-Message-State: AMke39lOX5r7LEvdO/udMGKbJQ95MbZqpGCuBLqgEeV2WsMQMNdEQNUkAdn3Zg0bTaKzLg==
X-Received: by 10.99.147.68 with SMTP id w4mr4153253pgm.32.1488307313913;
        Tue, 28 Feb 2017 10:41:53 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id d2sm5674997pgf.35.2017.02.28.10.41.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 10:41:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
References: <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
        <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
        <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
        <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
        <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
        <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net>
        <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
        <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net>
        <alpine.LFD.2.20.1702231428540.30435@i7.lan>
        <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net>
        <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
Date:   Tue, 28 Feb 2017 10:41:52 -0800
In-Reply-To: <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 23 Feb 2017 18:05:07 -0500")
Message-ID: <xmqqefyikvin.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The first one is 98K. Mail headers may bump it over vger's 100K barrier.
> It's actually the _least_ interesting patch of the 3, because it just
> imports the code wholesale from the other project. But if it doesn't
> make it, you can fetch the whole series from:
>
>   https://github.com/peff/git jk/sha1dc
>
> (By the way, I don't see your version on the list, Linus, which probably
> means it was eaten by the 100K filter).
>
>   [1/3]: add collision-detecting sha1 implementation
>   [2/3]: sha1dc: adjust header includes for git
>   [3/3]: Makefile: add USE_SHA1DC knob

I was lazy so I fetched the above and then added this on top before
I start to play with it.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 28 Feb 2017 10:39:25 -0800
Subject: [PATCH] sha1dc: resurrect LICENSE file

The upstream releases the contents under the MIT license; the
initial import accidentally omitted its license file.  

Add it back.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1dc/LICENSE | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 sha1dc/LICENSE

diff --git a/sha1dc/LICENSE b/sha1dc/LICENSE
new file mode 100644
index 0000000000..4a3e6a1b15
--- /dev/null
+++ b/sha1dc/LICENSE
@@ -0,0 +1,30 @@
+MIT License
+
+Copyright (c) 2017:
+    Marc Stevens
+    Cryptology Group
+    Centrum Wiskunde & Informatica
+    P.O. Box 94079, 1090 GB Amsterdam, Netherlands
+    marc@marc-stevens.nl
+
+    Dan Shumow
+    Microsoft Research
+    danshu@microsoft.com
+
+Permission is hereby granted, free of charge, to any person obtaining a copy
+of this software and associated documentation files (the "Software"), to deal
+in the Software without restriction, including without limitation the rights
+to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+copies of the Software, and to permit persons to whom the Software is
+furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in all
+copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+SOFTWARE.
-- 
2.12.0-310-g733d1cbbe2

