Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51233201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 19:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbdB1Tgu (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 14:36:50 -0500
Received: from mout.gmx.net ([212.227.15.15]:55709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751769AbdB1Tfn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 14:35:43 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lj1Xa-1cB65H1uqU-00dERn; Tue, 28
 Feb 2017 20:17:29 +0100
Date:   Tue, 28 Feb 2017 20:17:28 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH] Travis: also test on 32-bit Linux
Message-ID: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Pa1fdTPUOCzipMuvV8VTzS9mppB1a4nl3QhOUmEGf5yspFgpi2O
 EyFbFEJTjS+q/+YfC16MbWsAZQAZjFzdElAOttURNI+tIpdwVow9aVClo2xbNBsK2gTUiJJ
 WViDpi3LCXfgdVrIlQ6Akyqu6/Hl4/qMK9SqB6Cf9rJxYI7USOxxhToGxRcmxzm4xS8KIP4
 zEJvmdWpSWpdRu7nuigog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HwXSBx61Kio=:fWI1pjanypOthygBPLQVLX
 vfH7JDPiW1H1x121VqT0g54X/EHEe9FEW9SqS/tmQJWUIIoUpYcs0gmy2ZC+DTgjEPj+QxR/J
 OIzDF2Kd2AxCdcY7SI/tcT4czVTKw6bejr6Wykw1wH/v2R662uGFP6LfQm4lMPZmW8Lv6UFum
 QpPNqvi/VVXakhTZL044/H/jAeS+wD5DiAA5JyMTZjuPoU9fH4y0HI6aaeQfQvUYrx+8GMprV
 TXBdXVphGjpwyqFdlSfCGBzZJhbF0uA4Mr//1ZZXk23h0lZxK2kGGEk21SB5XiDp0Dyov0hmu
 4r5P9PA1hN9t1xfgaCJJRwwAmk/ttVI55M+p28OAZFiXr+w8ka25T69qJGsUZy9LiNkNwVaPs
 Wc933ny6AbJn3BWZgJ5aQXzcUg1l7jKMidaidoZXoUMav5oLSSEhYYAgEr0WxYik564Gx82ZI
 4ylx5RQ54mWVTYqqJ+JtJZxjWWng/sOrFncX7goG1OqLbT40smbcx4Z2TDz6yBWBEfUh1gYYJ
 QO9QtMIwZgPmGcERRN2w/Nr/ZAN+pC2OuyJBu/MnDMmHWd7g1068iLOY8hMwA+M9tS1e16IyH
 fZbUrezjqfHxnamnJYmxu+5aehC7qAyAWFR/3mAUp/4PA5yYgYv5hXoJA1oJ2Q6gOGOJg2x+0
 We4ovdDqxgQGRulzbMBf1CaUei0ce548VWGkDCuBxwsJuVntMxkvVsBOQXBEweT27DhBJp8up
 tXfGq4gqyXu1lJEqVxfm2qZewVjrjrIecqlpvq3e/u8OO+yjX886MDJ1p91ZfWrHwnNa3OXnp
 eiy3FOhDncizgiEVH38qTBbFZN42w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When Git v2.9.1 was released, it had a bug that showed only on Windows
and on 32-bit systems: our assumption that `unsigned long` can hold
64-bit values turned out to be wrong.

This could have been caught earlier if we had a Continuous Testing
set up that includes a build and test run on 32-bit Linux.

Let's do this (and take care of the Windows build later). This patch
asks Travis CI to install a Docker image with 32-bit libraries and then
goes on to build and test Git using this 32-bit setup.

A big thank you to Lars Schneider without whose help this patch would
not have happened.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/travis-32-bit-v1
Fetch-It-Via: git fetch https://github.com/dscho/git travis-32-bit-v1

 .travis.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 9c63c8c3f68..87d9e9051a6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,6 +39,17 @@ env:
 
 matrix:
   include:
+    - env: Linux32
+      os: linux
+      compiler: clang
+      sudo: required
+      services:
+        - docker
+      before_install:
+        - docker pull daald/ubuntu32:xenial
+      before_script:
+      script:
+        - "sudo docker run -i -v \"${PWD}:/usr/src/git\" daald/ubuntu32:xenial /bin/bash -c \"linux32 --32bit i386 sh -c 'apt update && apt install -y build-essential libcurl4-openssl-dev libssl-dev libexpat-dev gettext python && cd /usr/src/git && DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS=\\\"--timer --jobs 3 --state=failed,slow,save\\\" GIT_TEST_OPTS=--verbose-log GIT_TEST_CLONE_2GB=YesPlease make -j2 test'\""
     - env: Documentation
       os: linux
       compiler: clang

base-commit: 3bc53220cb2dcf709f7a027a3f526befd021d858
-- 
2.12.0.windows.1.3.g8a117c48243
