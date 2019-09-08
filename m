Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 241D21F461
	for <e@80x24.org>; Sun,  8 Sep 2019 17:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfIHR65 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 13:58:57 -0400
Received: from mout.web.de ([212.227.15.3]:53469 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730561AbfIHR64 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 13:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567965524;
        bh=SqH7A+iScGS6JOCLx4L2PQmkiov2Pse6dNpzLJiBrkk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sYVCPLl1PPgN0/nZlA2oKzp2FdBLSww42aNrWd1Gsy0UtsGaxX6ueP3kwqqFvYPjP
         VpAr1MXRInfkhArQbogyuT86wFYFSimA0lquUB3Wgo+NFlyknURaojxv6JcYPAu3bl
         ry2IY/pwQr3jBhnYSvFAcsZUKSLEhmcoJstFwgwA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lba5z-1ia4tT2Wc7-00lH1y; Sun, 08
 Sep 2019 19:58:44 +0200
Subject: [PATCH 1/2] log: test --decorate-refs-exclude with
 --simplify-by-decoration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?=c3=89tienne_SERVAIS?= <etienne.servais@voucoux.fr>,
        git@vger.kernel.org,
        =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>
References: <D941A96E-E5A8-4C86-A200-0BECA30216D1@voucoux.fr>
 <37283d4e-3f79-a6b1-425a-f90704fbcce2@web.de>
 <xmqq36ijl6qu.fsf@gitster-ct.c.googlers.com>
 <5de287e9-a8e8-780a-7d39-2229b61914ca@web.de>
 <xmqqh86zjmcg.fsf@gitster-ct.c.googlers.com>
 <64bc5556-b098-7991-b7c2-3483277bb73c@web.de>
 <xmqqwofuia0x.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ea3fed37-a465-6a26-1035-6885015261b7@web.de>
Date:   Sun, 8 Sep 2019 19:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqwofuia0x.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vIb7Vn1vDPRe6qZHruw2RWutkrjqI2CTilkEsOUE4yJ/vqQGnIb
 BPVMZz3wjqQQigZSLZIYcZjMfhS+xvzEx5UT3thP9Zcl/ZCRrx0kCobHQIVRZshsXl22DRz
 OsCXdz9vVcx1PDU78nWS0an1PCqwXQwvOJnfkmGqlU1/hdKTg1rFzqSiHA+1W6F6VveCH+V
 O5efXuRoMWUZvq9ymasVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bA6yjr+t9UA=:KrfK23P26XZMGQgpwnet3E
 P5kJeyeiBPgtVdD1/evQaHZ40ml8mxcWRplWTXF8PAcQRrAc4JMT87WKbIuKA7kmlMhkA3KeP
 vFhK0dqpkl4lrJAPIhux5ESuPfTgwKAK4LBz7Aojo87Os6nxLn08Lq6GzDYZfpJJQUCgR2MPR
 6oNJVa0Vn/0RIoKcMMNoyqTm4JvezYh28uIQrsZxeRmSlfiyBe2+s9B8iIzejAHzdv4TYFa1v
 eM5rqRKxkNJ27Fw3C68RYKsJ2qiANHMHUn9SW0f7Z4SLw6W7MFzGIsDXez6oBQxvyGvQOViDE
 SRrTU6MeUcVOrYg/s/CdKyVUGBLMfnnpXK7KT1ZmfTZWfDjjnVvUetCdSqeWZXfuiLeyN/hil
 AsB7+D+t7yvznBsywwzf1IrpxNjnc+mY1u3CNpoQFNWDkkVSz72IHqm44k9mm02sFYLXDgHOU
 OYRokZsLu9U+uuDxN1dK+a15VzE+p5f+9hwG83A4ehzBkqRErqQ+7Q6o+Jhznkpm8wSI6hGdH
 QkhSKCj/gHSQoeVep7G2DxRodK6LpmWnD2ihR+mHwsyKJOnMPRDt9pFAW1nhhQiVsgMOYbTdv
 0aow8glLap3EIJComW/DcXgqJKy8N0sa9tdA8fD2fl0bQve6Gbc4SAJWh+RkO8RvK+32vw2oa
 eaC74uJXScl26fqGRdU2rDjbAN0ckms3UCrypTcdxRy8hvfKexH/tcZgS662LhYJ08ehhRH+m
 VW9KX9HEcpHBuND9yL6lXs8aRYiucQDqLbB2KD2zxrpKODUjZsuXy2vri3Kdo6ftSsdd3YFRN
 KuGzmSX7irU13y/ygmB24I+M2d549icdpAkv0gdHjX5or8qvh8yn7OR314PpunYTEI9BvPvRg
 GiZjK6WjzCI+KW1vPBdQmjWHKI5z/CbQtHlyJwMS8sAnqWg4s5858nZJ46/jkGlezqskWj6aR
 86XYT7zJxIpwDQZvkqhJ5DtFFtkDm51xLJnVApV1cQdzp2j27PaCUMNEqKQM+GUB5xKtFHaZ+
 3KwkpCWdICXD+2HOLvNP1oOvnVC8VmNB3vc2VHkBOpOWWmPyTkmpWNSvPyiROe+7Zrg/sMXa5
 K5Hb4AfL7F0ObrLtFU+Q0oJPysgoEU6HPij1nBNUuCTV03gPZjiQDlIyHY1oGrOYvK6OQYA+T
 bFabONFpFgoD7/Kd/gk+VeyueFHRSCd7uFI8+WbfE3CZzgNoRd/OwQkGT9thr4gDMdL/Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Demonstrate that a decoration filter given with --decorate-refs-exclude
is inadvertently overruled by --simplify-by-decoration.

Reported-by: =C3=89tienne SERVAIS <etienne.servais@voucoux.fr>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t4202-log.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index c20209324c..01c95d1375 100755
=2D-- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -837,6 +837,21 @@ test_expect_success 'decorate-refs and decorate-refs-=
exclude' '
 	test_cmp expect.decorate actual
 '

+test_expect_failure 'decorate-refs-exclude and simplify-by-decoration' '
+	cat >expect.decorate <<-\EOF &&
+	Merge-tag-reach (HEAD -> master)
+	reach (tag: reach, reach)
+	seventh (tag: seventh)
+	Merge-branch-tangle
+	Merge-branch-side-early-part-into-tangle (tangle)
+	tangle-a (tag: tangle-a)
+	EOF
+	git log -n6 --decorate=3Dshort --pretty=3D"tformat:%f%d" \
+		--decorate-refs-exclude=3D"*octopus*" \
+		--simplify-by-decoration >actual &&
+	test_cmp expect.decorate actual
+'
+
 test_expect_success 'log.decorate config parsing' '
 	git log --oneline --decorate=3Dfull >expect.full &&
 	git log --oneline --decorate=3Dshort >expect.short &&
=2D-
2.23.0
