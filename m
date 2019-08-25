Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AD311F461
	for <e@80x24.org>; Sun, 25 Aug 2019 13:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfHYN0z (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 09:26:55 -0400
Received: from mout.web.de ([212.227.15.14]:38235 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbfHYN0y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 09:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566739601;
        bh=6x6rjqJ2PY1WWWs2GvkEaSBNIEbcs3KD0r+olWFBU7g=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=jijIS3/JMySU+R8w5Ug1oq6kcv5lIfSvC16zM4IroGsPfdTiNfEike19rF4cjLd/C
         EVIB4s5gINE2D7G2Pul7CB+pHaRvfYCMOEWZRUtkMT/+xO4CB2YLb/FFhbIBsziXZE
         lQLItzQlxUABF3hbxG6v+nP9dx2PUY/+A+Eq1jvA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LiCrz-1iWJoQ1Uwt-00nN7U; Sun, 25
 Aug 2019 15:26:41 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] grep: use return value of strbuf_detach()
Message-ID: <caf49742-65ee-7b2a-0179-ee11822b2350@web.de>
Date:   Sun, 25 Aug 2019 15:26:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t2JjVEOo+EseDXX8My3bOLTKyNNs8QrYeJkgO1BHWLpUX79rlwF
 CeWZ2EBlNQ+qbr2i67ycFpwb2jttNBo15raeaCZ33FWhPkbxxYqMa9KaR8XL78Wx2wGIhuR
 XzMlwkvx0aOgJFzyJw+wn8Ogipnt8BLAkC9k7gWBrGMAdrEVxB3UOBvk8m66EmziRBIm9AB
 eQYZiRf4yy2nK88LD6g0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C/kZaPnUEi0=:66M57W233AaNFLUnb3eUIY
 csoRToRTX3NNS8Cq7ZMASm753OnFcYv7wMfOeSTs/UDqENBCeFSP5op/1+Mw49/c5HAQ1ZlOA
 9KbO83gTw6D9G3wEQxI9AL3i8ebITGJEf7F3rjm63WVSQmA+8VWpG3zQHWpvYG2Su8Bf4JUi+
 7jLtSdtixctKOIG0sy8J7HWxATQXMHqS0LoFCvxHbQpXi/tIIRiTglmLI88y5wH+/uJMKFq2g
 2YGuC7zuSYB7sVKbKkCsERIgXulrEWyt/CqKv6iWXEa8CYmTYkxI933jYAYkw2rHgBeGpet0B
 cQqdLbgk46OQ3TPALmXKhvyOk8NYuiunXolpbGW9okK/Dfc45xxNuWtFfTkuf1CVCKhZoQ9yk
 l0vg2Gn6zvAgNS82KgRumCQXBkIQK62SD8UN7WTUwRvNK2W/XLD0oMfet2DBNtsZ/jhtnxiu/
 o25Gd6zzY4I1pvzanb/RooTj7QlttxSons6Dum2Wces2q5A2xJ2zTP91QY7somTTCFrnyF+ZN
 xcrix9GvdL5qRED1r+gCMJcxrgssTn43QKu27lSRbeWRJAuPCSKViKUDrXcptepWf8t0R8Z9a
 uz6lCXoS3Rle/cxsfvyDM+fRYw1jqFruU0QKOIfV8cnvrkI0eJ1aljMCo323vkkFxemzlFaXI
 pvj6BrHgKqZNNqh+UgHb06iPAMs4P/GSe+BIr571Nrm4nFhbY+wwiIvL4ohby5WG9GaXoQYPk
 gYkGBcDhsMlHTPYkKrc/08ynKoS/VpyC37FUQoxGGo1HGZEhupRzZqKbOg47i+MCl9gnlhNE2
 pWxAPq6dAf4neOqdmXnDd6dVxJ7ym+JxANDeZCWhrmSJhMf/5fXDx/NuMV+FP7hmyQAXTxozu
 Ffkped5+Y3QxSz5CIgNWUJZSE2D3JwknOMbrPrWZcjnxiI9VF1chHtfKNeduDADvyYBOzxyJK
 th8BXR3BC182fbyFGnwzX5SEa40LSFSBfyqMBKyMn0ru9on2PMg93vntXIag8ue/CENB7t9xK
 KFJXxM6+0B3t82fPDQaOJfICfZFFM1hf/L5BuMpacdVp/84w1nh2/SZKY6OClvY1r+Nof6vo3
 ssrQk/LigflwFDypTyMnPKUwZiW+aOrvFeA1kbY2dTiA0LNiNtUKUOm13Fzbb9KKoX8fr1lro
 nepeU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Append the strbuf buffer only after detaching it.  There is no practical
difference here, as the strbuf is not empty and no strbuf_ function is
called between storing the pointer to the still attached buffer and
calling strbuf_detach(), so that pointer is valid, but make sure to
follow the standard sequence anyway for consistency.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2699001fbd..69ac053acc 100644
=2D-- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1110,8 +1110,8 @@ int cmd_grep(int argc, const char **argv, const char=
 *prefix)
 			strbuf_addf(&buf, "+/%s%s",
 					strcmp("less", pager) ? "" : "*",
 					opt.pattern_list->pattern);
-			string_list_append(&path_list, buf.buf);
-			strbuf_detach(&buf, NULL);
+			string_list_append(&path_list,
+					   strbuf_detach(&buf, NULL));
 		}
 	}

=2D-
2.23.0
