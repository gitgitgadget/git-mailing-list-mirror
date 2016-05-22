From: larsxschneider@gmail.com
Subject: [PATCH v1 0/3] travis-ci: run Git bisect on failed tests
Date: Sun, 22 May 2016 13:00:53 +0200
Message-ID: <1463914856-64745-1-git-send-email-larsxschneider@gmail.com>
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 13:01:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4R8G-0001yu-PU
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 13:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbcEVLBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 07:01:01 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35893 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbcEVLBA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 07:01:00 -0400
Received: by mail-wm0-f45.google.com with SMTP id n129so38610669wmn.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 04:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NIsslgUBIKW6NDuM7mk+Vpt/irmpNyDbbHuf/jN49A4=;
        b=s/rU98RyFLB51ItYVBVm0TjKVQ2ITR2+lVQt4n8Kne6N59QLNauD0jXhI150YpZje8
         MQu5raP7J9QwOatdMhmuRae1l1DP41kndLJr7AMR1cOLFng9SVq/6CMq80cWqxBW40dT
         HitRg90n9oQiTYHO7AEkVClVs8yFrnfpHC/egIzfq6O/j8KCU3tXAj7NO7oCgU/YlbNW
         CA8P4anNUt8aKKH2Ybangchx85vRrYCXDTDd4RNRl8Lzh+zVidWXjdesXGTy7sqtr14+
         cd3D4+TTUR1FOMb9t0oNtLdx/fCLlqebHzOKENnbo3r17YkpOWBjf54L92ydboANh3Gz
         8NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NIsslgUBIKW6NDuM7mk+Vpt/irmpNyDbbHuf/jN49A4=;
        b=Ypas6V2+lFtcSH3HCqV2ElONU5vsNAlIi3WoSKdy/H/Mo0hp9HuwI4YAVDNSzEAGSv
         h0I/GeoKRscqd8cODzwuSUcP/xfi1ZEoxoQLQFGlv7csSGLiD7a5SK+OBdHlc05AczHR
         D+JNdffXZ46mrnMZqwu6pU8fwBFtKFbShEMNP/cTdA3QGOwW1v7+ng3eN5vRkIiHZ0VG
         0Fqvp7y4f/K4N5av/Z32nlJl9AR5cw5ATrhZsdwnmXys67dYv+b79hU0Y8WIgLe/yfcG
         f4yXjCxoqxtOt30Ej9H8GUqxYUxm1aaw+ouiwzqU98UIeW3SXyV6rcRfFUdyGcF6yTLm
         YXxA==
X-Gm-Message-State: AOPr4FVQQvy9a68juflqgpePm7aehwo7/vywZganQ7D+CSaUIJIAIwwPXIC/HLVjsWiFRw==
X-Received: by 10.28.230.137 with SMTP id e9mr12721768wmi.0.1463914858611;
        Sun, 22 May 2016 04:00:58 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB5ECD.dip0.t-ipconnect.de. [93.219.94.205])
        by smtp.gmail.com with ESMTPSA id u4sm29343478wjz.4.2016.05.22.04.00.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 May 2016 04:00:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295277>

From: Lars Schneider <larsxschneider@gmail.com>

This patch series run Git bisect on failing tests on Travis CI.

Example output on Travis CI:
https://travis-ci.org/larsxschneider/git/jobs/132049871

Plaintext example output:
https://s3.amazonaws.com/archive.travis-ci.org/jobs/132049871/log.txt

Please scroll all the way down to see the bisect output.

Cheers,
Lars


Lars Schneider (3):
  travis-ci: move "after_failure" code to dedicated file in /ci
  travis-ci: disable verbose test output
  travis-ci: run Git bisect on failed tests

 .travis.yml       | 14 ++--------
 ci/test-report.sh | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 12 deletions(-)
 create mode 100755 ci/test-report.sh

--
2.5.1
