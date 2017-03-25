Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A9620958
	for <e@80x24.org>; Sat, 25 Mar 2017 10:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbdCYKq3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 06:46:29 -0400
Received: from mout.web.de ([212.227.15.14]:53676 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750766AbdCYKq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 06:46:28 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVtqS-1cghgm3UbY-00X2H9; Sat, 25
 Mar 2017 11:46:24 +0100
To:     Git Mailing List <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: t1503 broken ?
Message-ID: <fad6ea92-0a44-de30-48e8-09e7c567cd4d@web.de>
Date:   Sat, 25 Mar 2017 11:46:23 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:xRSnInr0ThXCuZlmhaOqCQbHRg0T/APjshBtUoYVh3AgxkFtvEH
 i9uHj+e7N3VrP7hkkJJJKJDXvm1+Sy6CnRIpqzCoNOprVSJ+boI6/CHyPNf/6z61hQw0fF2
 kv06d5UlrFoJd1OJmF1+b7rJ1B0gKMnu/D2RzimM2ViOFftl81aJklkCq+CGb4rsqjofmhd
 Zj4ffc3FCOJAOzqsLEoXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xpTT2ig+dT8=:j+EAFHabktR6cRRwIy6n1l
 GiT4mEpi0jiTEAjZMW4QzaFrSVbrnr1h6rkCLmnMD8c5XlrgFx4ybtcrPIM7qfntJAGeukeBG
 YFIn1KLsNBUlU8kkArs5fW5tEZi6iHA58wqYb3EnegujF+eQTBi2zP0AEFsuqVmGFwi6RZ2p3
 ZzuxrBhsKPi4jjNUQRaZbsidR4BQMimguj0INj/ywlVRZIaNlRTlfdoObzRRly8gRHVj9Muw1
 GJlGE1xPbA9MsdsY/enYNqHrm7O7MOgiCO3ySmcAlDjjKczUk45gQ+94MqqF11NEOSm8XR5r/
 A2sAOb66/zFqKNyoBvMyiPVSlEgTs0kRhZSO4urNH6LbAztNaz7gIIGm/QTqVBDxTQsCZlqUM
 agQxWzIlGY/w6dV7uPJHPaALgQurL6S7TY7XyinbwafVFxLT5unYBEawJSvpsTrHjwWqHd1o1
 k/k/jZnl27eLmNxbAFSXPeErN68sgxyIk1QfHS0s6D07Vuer3+PXeGpg6EBzZUh4fcTwwtaKA
 fpSgGykHqQF/Gqw4uklPj8g9k2GT3V7uT6GITbew6DgRd5ZEHoojuQ+A5Fzg60P2bZPx5ikfB
 650qoTVc5cjbLOmsfK9IlmZAHefJfCqY2FtZFvun3LCGam3Nc9jm2WkDUbYngIoz7iZrFwMn0
 2ef9g3hpkrtioYw0IRRQLiJeIrudD8VnBft6Qo2qG0wGfQCYPH+3JuYl1Yon0wWElxoh40g+7
 ZD4ffwpVyZ4QHkWXfvI+lTkh+3nUee0m2mqs5+Eqp5j0FZSgzkFLxctJOwBFUxn9m5AXM3XCX
 JRdYIWm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

./t1305-config-include.sh
seems to be broken:
not ok 19 - conditional include, $HOME expansion
not ok 21 - conditional include, relative path

Both Mac and Linux.

The problem seems to be the line

git config test.two >actual &&
and
git config test.four >actual &&

In both cases the config "test.two or test.four" is not found,
at least that is what my debugging shows.
After adding an
exit 0
before the test_done gives this:

 find trash\ directory.t1305-config-include/ -name "bar*"
trash directory.t1305-config-include/foo/.git/bar
trash directory.t1305-config-include/foo/.git/bar3
trash directory.t1305-config-include/foo/.git/bar5
trash directory.t1305-config-include/foo/.git/bar2
trash directory.t1305-config-include/bar4

Where should bar2 and bar4 be ?

