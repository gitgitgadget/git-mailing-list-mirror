From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 0/3] add strnncmp() function
Date: Mon, 16 Jun 2014 12:13:55 -0700
Message-ID: <cover.1402945507.git.jmmahler@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 21:14:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwcMF-0000dW-Ih
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 21:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbaFPTOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 15:14:16 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38067 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbaFPTOP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 15:14:15 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so4795375pac.19
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=p08tYXoir6CiUgRvgigflfAnQ0ruyTnKB+fInE4oBLo=;
        b=eHeSGxwQdBKii41KrS3e7pVnSWgfcxbvkZ7ujW5c4+4N10saMYpemmH5km87q1nDO1
         UF1lG6F0iQbUhJH+x6Ec02nQH25P+QfOlCBTOBLLZChFCmkITXpEuPWXq8gZvhw8kgE8
         oC3zg4pYgOf4kvx5ShiqJYv35A4vfdgXFCY3HalWs2tYdRJNokNYvZZU0ZE3t9CXllte
         3Gvm5cNKaZMe2YOU17PPQBBVfgHfTcu/BtB1RW2e/R95Ux1XC6o684vR3+xIjRjHWjxJ
         vYYjcLFUMM4HabGHT0ibrZh9uTXR3OVLtbzXARGf6At29kSSAN2xOJW0bYLtqrs9ZKyS
         hOSA==
X-Received: by 10.66.66.225 with SMTP id i1mr26859108pat.0.1402946054971;
        Mon, 16 Jun 2014 12:14:14 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id pu5sm20145840pbb.4.2014.06.16.12.14.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jun 2014 12:14:13 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251800>

Add a strnncmp() function which behaves like strncmp() except it uses
the length of both strings instead of just one.

Then simplify tree-walk.c and unpack-trees.c using this new function.
Replace all occurances of name_compare() with strnncmp().  Remove
name_compare(), which they both had identical copies of.

Jeremiah Mahler (3):
  add strnncmp() function
  tree-walk: simplify via strnncmp()
  unpack-trees: simplify via strnncmp()

 strbuf.c       |  6 ++++++
 strbuf.h       |  2 ++
 tree-walk.c    | 16 +++-------------
 unpack-trees.c | 13 +------------
 4 files changed, 12 insertions(+), 25 deletions(-)

-- 
2.0.0
