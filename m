Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2CA1F859
	for <e@80x24.org>; Tue,  6 Sep 2016 07:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932752AbcIFHZK (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 03:25:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:60320 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750721AbcIFHZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 03:25:09 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MaZWz-1bNZP91EXR-00KA2t; Tue, 06 Sep 2016 09:25:06
 +0200
Date:   Tue, 6 Sep 2016 09:25:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t6026-merge-attr: wait for process to release trash
 directory
In-Reply-To: <3fd38b71-26bd-bdb3-fe5c-e7038abf51e0@kdbg.org>
Message-ID: <alpine.DEB.2.20.1609060909420.129229@virtualbox>
References: <3fd38b71-26bd-bdb3-fe5c-e7038abf51e0@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MkTHAe8qW3WbbAIcZ74rid3naSrv+NBpIHq9Vx7+/prJ3eK5Xnj
 bApTWL3Ny+D24hma5bz/uldkMUtbG0HjRHAoQnsWLprSnFHwOVsVkNozuzewLSChc+lUJAu
 5zhHkkABaYH4U+FUPgngT7leDgYXwoCaaCN6kgSe4SnqmlHYQkkZYVXcUc08EzCGRRsf4x1
 8GCRBti35EYwZ8wbtaRUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iKwRCQps0pk=:QArE48SlO0N7/el6fpa0xt
 /G4tEsaQbmVveqbLs7gtSaY4jPdpbQjZNA96Um+6p10t0Y2SU028XGwENiqsRO1o+6HNDjofF
 Q5TC+NVdiMuUHbJJTocTP4v+LbKi0F9H/kZfw3nins9pb0N29HSWvQOgmqQfFtmkZhMNMG111
 SGz8i/LnuzlOSIej1YGwl1hOcPdJ6vUlDy5DHBMvyQlYfvzfGFJ5WhQNdtgdRERAT2U+8T2SI
 aIvJA7NziIk13tcs0VWAUsjH1E0XPkEw1/heuvCdt5Zx+cyeJEQB8EMnNvGiC9vzXTOl17UnE
 +xpeInruOwiXSBU+JuBFmqTWNWBL4dO7gST9q9D/ZQzoUHOIJYmvaoy6ImmJJVRBlY5g9qH62
 cwVqPq2OyPH/6LRJNALAcd2Q8C/VQbzm4tk+sGi4AMu4kqkH+Oa5SnFTT4ae1WXmuL4eRPm5l
 n5gHkWHdE7GTxc1AKBxhtCNk7iUKP+14K/I73bLl9jMWyDXj3PSTq6XSMoW0Ew0mC7tZzypqU
 eEJifuTF4FUs3x5Fh7qxumedGRg20AAsO6/yVf3nV1U6r0kuO7S+ST76AvhVbkM59QDGWwoDw
 N5mYObse9s3kn2UXr+ieueOl3xaK9VdI0WsMW81SCWxusEwC63/AHQWS7d/RNnnBfddQcjR4v
 R9Y8I24h9GRdJz7yx7mbpbDXsuxsJsNOMnfX+/hN+FSUy4wjQI2l6iaKs/sPt/K6uoTHp/9FX
 qcYUeUTiYDhN3qCmtvEaQ5rIr24/lNGsYZhJz42lT5k7BzMu4vAzgxfQYWB6D4qzKx7kaafYK
 /bH4+rH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Mon, 5 Sep 2016, Johannes Sixt wrote:

> The process spawned in the hook uses the test's trash directory as CWD.
> As long as it is alive, the directory cannot be removed on Windows.
> Although the test succeeds, the 'test_done' that follows produces an
> error message and leaves the trash directory around. Insert a delay to
> give the hook time to go away.

Maybe we should write a pid file in the sleep command instead, and kill it
in the end? Something like this, maybe?

-- snipsnap --
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index dd8f88d..2e2beb5 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -184,8 +184,10 @@ test_expect_success 'up-to-date merge without common
ancestor' '
 test_expect_success 'custom merge does not lock index' '
 	git reset --hard anchor &&
 	write_script sleep-one-second.sh <<-\EOF &&
-		sleep 1 &
+		sleep 10 &
+		echo $! >sleep.pid
 	EOF
+	test_when_finished "kill -9 \$(cat sleep.pid)" &&
 
 	test_write_lines >.gitattributes \
 		"* merge=ours" "text merge=sleep-one-second" &&

