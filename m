From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 0/4] Re: Rewriting git-repack.sh in C
Date: Wed,  7 Aug 2013 16:00:45 +0200
Message-ID: <1375884049-14961-1-git-send-email-stefanbeller@googlemail.com>
References: <CACsJy8A-xo97MC-vBmqCrvvSDMWKd_MxnRrTBSeSqcQ1HifzJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: pclouds@gmail.com, iveqy@iveqy.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 07 16:01:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V74IU-0003Uo-AV
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 16:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461Ab3HGOBB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Aug 2013 10:01:01 -0400
Received: from mail-ea0-f171.google.com ([209.85.215.171]:46394 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab3HGOBA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 10:01:00 -0400
Received: by mail-ea0-f171.google.com with SMTP id n15so855856ead.16
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cm/HiEMuLYlhLuyLyjlmDRNPSTkwEiZaIoOa0WzQZXY=;
        b=L1a2KO7PQGMryZJOiuQbEk+nfuItP0RsFKjOpHA/uCf8By1bdsg7HGtpTyedN+3eq1
         z1bdr57pjyQQb5WanL3YQdjpzY/si3XNsAY18Usa4zABL/N1o6bLjOHy2XO9Q2bIHQ8s
         gwaPoY2k5j7MJ0jTYvzQyCuNggQLcGaQrh602obyRJaUV6euqAW3nBHsMmVMR7kPDJks
         ZBLNx4152YShIBULMeNnj9Kc0CMSmGP6Hv0BAnkzRvPaofU3iEj5h/m5V6Ilwxl34bPD
         H5f/LVWrOd7OocrLroZZfj/JKBChLcCHwj7wrjPGblYQ54UDtzaglYpFU8ZjhO4pAs+m
         hAIQ==
X-Received: by 10.14.203.196 with SMTP id f44mr3200820eeo.141.1375884052820;
        Wed, 07 Aug 2013 07:00:52 -0700 (PDT)
Received: from localhost (eduroam-69-67.uni-paderborn.de. [131.234.69.67])
        by mx.google.com with ESMTPSA id m54sm9926261eex.2.2013.08.07.07.00.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 07:00:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.25.g2793d0a
In-Reply-To: <CACsJy8A-xo97MC-vBmqCrvvSDMWKd_MxnRrTBSeSqcQ1HifzJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231823>

Hi Duy,

I applied your patch on the current master and added 3 patches,=20
so git compiles and the testsuite works without additional breakages.

The functionality is obviously not yet completed as the backup_file
function is still empty. What do you intend that function will do?

Stefan

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  Build in git-repack

Stefan Beller (3):
  backup_file dummy function
  pack-objects: do not print usage when repacking
  repack: add unpack-unreachable

 Makefile                       |   2 +-
 builtin.h                      |   1 +
 builtin/pack-objects.c         | 284 +++++++++++++++++++++++++++++++++=
+++++++-
 bulk-checkin.c                 |   2 +-
 contrib/examples/git-repack.sh | 194 ++++++++++++++++++++++++++++
 git-repack.sh                  | 194 ----------------------------
 git.c                          |   1 +
 pack-write.c                   |  18 ++-
 pack.h                         |   4 +-
 9 files changed, 497 insertions(+), 203 deletions(-)
 create mode 100755 contrib/examples/git-repack.sh
 delete mode 100755 git-repack.sh

--=20
1.8.4.rc1.25.g2793d0a
