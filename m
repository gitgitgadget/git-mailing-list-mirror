Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12169C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 13:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D7E206B2
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 13:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="JHrmcaJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgHLNp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:45:56 -0400
Received: from mout.web.de ([212.227.17.12]:36903 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgHLNp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 09:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597239952;
        bh=wGQN78wLTB0V22zD8IoTsj9kiVwYFDxCu9VNVAHb4xA=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=JHrmcaJ2YugdLFQuc/MAm6t2Hv81KWrOP8IQaq/RBE9uoxlj8feubJYO/iVgzjsKQ
         rRhYWlGypRNzR9ecgp38wHHCmMeZNnZIs0OG0pYYDrunpUsHoav6oLC4bCrfZUr+1N
         n1vzKDDM95FYjIk5tavZl9cYkPQblNiMYi0O+X0s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyNwk-1kvLCO0Ehw-00yu8n; Wed, 12
 Aug 2020 15:45:52 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] rebase: remove unused function reschedule_last_action
Message-ID: <80744078-c0a9-5b55-0578-d6b62af6673b@web.de>
Date:   Wed, 12 Aug 2020 15:45:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kMpXkKEiOsX/Shx2tCaSaf9lTMDZ6rfgvqs5mWidwJ4cyEQgOXm
 PzGAmC1vZMO6u1Uu2jTa0y6z0r54xWriE5II/83BbLj1WsYITCk5U6hjf7kJU7H8KYyN8nd
 sLDgEEkH+xyoSbEbYbRAYrnLLZCZtawCgRlEnjG2o1UmbQF+DkDDkZakJpBo5KuDFiggGg0
 ZcXbuGBDrJeKKN8VDFnFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:604HQquLoWs=:yhYvyv6X6RoyDvMmmc2CCg
 d208hwlfkix2j3uPYcjUyr26YKozn9LDoPStd39ur/C40SlFjCTgG117bCnymmCcImMu9vhVs
 cTgRzUL2FcWqGiFlg+Ea98bT+drttz+iUcxtYyy8JbHlwnEduaiEEWa0iBzPo90AxVMk92wsC
 80yQxY9JQNZWzhG7LIKa8fXkdOgTU6LFEC+Ygf8LXNz1PtfYAnbbsd43ZJTUiflYrQDy6wGKg
 QRsH8HZZ+61pk0pAFTtK1b4cr5rzdXpe1CzBeHuyyK9/CbqGOAMRxy41tBAr3UlUA5FIDeToX
 bItfEAMM6yjpclsN2WIEn3YobVXhn0Y9PzNrJS8DH67aAkj76e4LotOqwv0gNsNwQgMqu7Z+C
 X4b2oAMXP79W4qTj77DEy7RO6p5WFHEwQrnuiqruKsBsHNELds12E0S0D9oCiczaeZv8P3Ipn
 oEhEtk6wnAgxbEl/vadolotvqK9iBv1jKOR4b7hfSZkCsObKIQaKE/PTDfhR3Zff+KYTpafzr
 7G/wWam+dMRV7ZGPClMWPwfh1csnZ93mJUdNMireWuMi6U2GTrGlfdjgjK78WLIGmVOz01b6d
 iCvDGFW3rJAtFWktMS6smUs0ePL7vMPxrVY7RE1b5i3Xnlwfv2KcI4sboRMr8gkkyGhOAycXB
 HnzQjMsmcXTT7KR5nfbJOemqIGCBVSNC/gvsHDYIv7XoCrrVa4MtWFUO/lH62teZ+ESijjVBz
 rDBjndhCys6uuyjGanj7oIZzyyczSngXkBrtUshWnhfotzAFr/5KJSeojiwlY6HhaM81qq4eR
 P3sII+wh9LF9lrOg1i6Qbm/MNJoFGrb0jj6R+qOP8SdIdZdddia+rZ+272MhgoaQGMbTLBDOL
 vMO8Ht2QFrVZSmbuLQWoMzyynoj8fu7kLKJQ/rB3c7tX72SEYu/zxkVPz5CMuFxLC5ZjNEbTN
 agC0Ge8689K/9c1cD4olJnCQVYP5cH5LbfAgVgDqdvBofaO7ulScYgx9KkzGpzQdYxrv4dOJI
 F2zecM2c/ojN3OiCrjVvIL0scuxxAPX2nU+37CdiajoGJt55K+ImYWJug4fxYhu/Mj1/yAu/t
 62vLVXDvwz5BmOANQtBJ6fVpz42L1MwqJSC6X+pBwdaOVEpI90cFoQJO6cy4pkGquIhcgvyxz
 9toh7LiQDKPRqW13qmslibnktu+ms6s8qPExm7IOz2GvIABhFMU6WXm6sExjznvqmbr6eweIN
 O9DNGH/klZLqnUOrq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only caller of reschedule_last_action was removed by ef64bb328df
(rebase: strip unused code in git-rebase--preserve-merges.sh,
2018-05-28); remove this unused shell function as well.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 git-rebase--preserve-merges.sh | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.=
sh
index dec90e9af67..b9c71d2a71b 100644
=2D-- a/git-rebase--preserve-merges.sh
+++ b/git-rebase--preserve-merges.sh
@@ -193,16 +193,6 @@ mark_action_done () {
 	fi
 }

-# Put the last action marked done at the beginning of the todo list
-# again. If there has not been an action marked done yet, leave the list =
of
-# items on the todo list unchanged.
-reschedule_last_action () {
-	tail -n 1 "$done" | cat - "$todo" >"$todo".new
-	sed -e \$d <"$done" >"$done".new
-	mv -f "$todo".new "$todo"
-	mv -f "$done".new "$done"
-}
-
 append_todo_help () {
 	gettext "
 Commands:
=2D-
2.28.0
