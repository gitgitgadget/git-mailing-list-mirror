From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v7 0/3] Begin replacing OpenSSL with CommonCrypto
Date: Fri, 17 May 2013 20:32:35 -0400
Message-ID: <1368837158-13915-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 02:33:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdV5O-0006St-Tr
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 02:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab3ERAdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 20:33:17 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:46329 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316Ab3ERAdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 20:33:16 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so10736550iee.27
        for <git@vger.kernel.org>; Fri, 17 May 2013 17:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=eUn48YMEcH96AyFXhIyCOQSbootAJuVObNs+A2j6Ke4=;
        b=DyqFmdq3K1yuJ1svRT5qPvZayRKpw489tTVBSZoFExhTW7cgzE/b9MZhh0rzgc7Aiy
         oEo27da5WjzPyL6CXeaBD8Ehx+qBHTXDAfBoWz7H3v7BfmXgFFzHSUv8JYGdtZevrdLo
         w1ijmUSG8B/8qCdVxKMBmrIlsfki/i32VjWxO5kGn8FeRx/yyqCbmFZcvMpiWPXF8gk8
         7hCHrUvgaE3DkKKBe/IjkbwaQKDucwdzOjvWuBpgVdxDiCJ06u8BG2nnO9Ohzy6xs5NS
         iZqRYDoS8qHfTjmUao0R9MZ9+Hd91Vy8LbfTYtKgighxVuxvmaHSaf+KLEuobVyD9CfP
         7KfA==
X-Received: by 10.50.27.65 with SMTP id r1mr347439igg.84.1368837196029;
        Fri, 17 May 2013 17:33:16 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ua6sm9203igb.0.2013.05.17.17.33.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 17:33:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224744>

This is a re-roll of David Aguilar's patch series which eliminates some
of the OpenSSL deprecation warnings on Mac OS X.

Patch 1 is new. It extracts the CommonCrypto-related Makefile
boilerplate, from his SHA-1-related patch, into a distinct introductory
patch which can then be referenced by subsequent patches.

Patch 2, SHA-1 warning elimination, is effectively unchanged.

Patch 3, HMAC warning elimination, no longer abuses
COMMON_DIGEST_FOR_OPENSSL, which is an implementation detail of
patch 2. Instead, it checks for NO_APPLE_COMMON_CRYPTO introduced in
patch 1.

David Aguilar (3):
  Makefile: add support for Apple CommonCrypto facility
  cache.h: eliminate SHA-1 deprecation warnings on Mac OS X
  imap-send: eliminate HMAC deprecation warnings on Mac OS X

 Makefile    | 15 +++++++++++++++
 imap-send.c | 10 ++++++++++
 2 files changed, 25 insertions(+)

-- 
1.8.2.3
