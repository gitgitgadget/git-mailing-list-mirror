From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH v3 0/3] diff: Add diff.orderfile configuration variable
Date: Sat, 14 Dec 2013 17:18:38 -0500
Message-ID: <1387059521-23616-1-git-send-email-naesten@gmail.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>,
	Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 23:19:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrxYT-0002Sh-Cd
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 23:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258Ab3LNWTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 17:19:19 -0500
Received: from mail-qa0-f41.google.com ([209.85.216.41]:36712 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab3LNWTR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 17:19:17 -0500
Received: by mail-qa0-f41.google.com with SMTP id j5so544328qaq.7
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 14:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9mpkdjGNN2pLkAo+1gcNxiiNt4G9JRDFY01cRE2mYxQ=;
        b=m7HjWf0f9SmQI3Fv2Uoxz3VJ89+ron/QliA0MfnGTj6Wu4xVktmz7VLm3V3+PyFtgZ
         eTCpb84ay3SdTTQSEI/JmARIPrCh3BSQvRyU1RmFVZNySyEDgzzDHT8ZDgkJD6wqqwRi
         yEun5Au9COHhpj+lC5x0tmik1P5MPjzcmMEJwH8TwhcBlhh91VOqDJksQhWrN6+xmrfi
         pnw7dWtWn3MmOTw4jGu+wL7wFjJKmIuOT5dlUsv70DIIna40n9moOf97BKB7aqJ7jpUn
         KmrgJ70HWlAPJ65SLS3XzRBLihNDvGImoocpLGJQxYcu2yLBPaBpDnydxOyHi0dkr6AI
         /V4g==
X-Received: by 10.224.138.4 with SMTP id y4mr18032215qat.65.1387059556463;
        Sat, 14 Dec 2013 14:19:16 -0800 (PST)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id o10sm24627192qaa.6.2013.12.14.14.19.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 14:19:15 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.80)
	(envelope-from <naesten@gmail.com>)
	id 1VrxYH-00069d-GR; Sat, 14 Dec 2013 17:19:13 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239317>

The original purpose of this patch [series] was to allow specifying
the "-O" option for "git diff" in the config, but I need help with the
relative path handling [RFC 3].

It also added tests for "git diff -O", which I have split out because
they are independantly useful [PATCH 1].

I also noticed that -O had terrible error handling and could only read
mmappable files, so I fixed that [PATCH 2].

Samuel Bronson (3):
  diff: Tests for "git diff -O"
  diff: Let "git diff -O" read orderfile from any file, failing when
    appropriate
  diff: Add diff.orderfile configuration variable

 Documentation/diff-config.txt  |   5 ++
 Documentation/diff-options.txt |   3 ++
 diff.c                         |   5 ++
 diffcore-order.c               |  23 ++++-----
 t/t4056-diff-order.sh          | 105 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 15 deletions(-)
 create mode 100755 t/t4056-diff-order.sh

-- 
1.8.4.3
